From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: git mergetool vs stash apply
Date: Tue, 20 May 2008 15:16:47 +0400
Message-ID: <c6c947f60805200416s61b0cc1eqd6d6c804abd15b4@mail.gmail.com>
References: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
	 <20080520090258.GB31703@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 13:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyPqh-0006ko-Me
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 13:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984AbYETLQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 07:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbYETLQv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 07:16:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:4988 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbYETLQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 07:16:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2312341waf.23
        for <git@vger.kernel.org>; Tue, 20 May 2008 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bQK9kRtTbM6vagQlM3hx/27k3mYp+Tdu7hp7eC1hSW0=;
        b=qEQ8bgqsSjtHjtUAgLc83k37xyemt5a6yFxbHVhitp5aSnd+xf3QYeOGhO831Nx84ex3LOVuFa0RWuj4cjrtaz8h+hrHI6W4glwjHClvyO+dW38eQuKc7bZT/HPUSeoRynQelB9/SSGRm3Cme+xul63aAGkyzwTCy4bHOILbb1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SXGU0NHcfdfQFD3zUsVq68oPYBBh71YjV4EDC234CVFSr0yc3WM+CWXKSbizQzj1/VpBfzVy938FzwS0pkf9RROM2Tw/6WLf8JFnC28jjxSGsNMGc84VkIh5ymn4NhSMEFYAkUwOOXmzQWgwW6ppoOh4oi7KG7GI/MGvE5kMxtU=
Received: by 10.114.190.6 with SMTP id n6mr8724118waf.131.1211282207937;
        Tue, 20 May 2008 04:16:47 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Tue, 20 May 2008 04:16:47 -0700 (PDT)
In-Reply-To: <20080520090258.GB31703@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82477>

On Tue, May 20, 2008 at 1:02 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 20, 2008 at 12:02:44PM +0400, Alexander Gladysh wrote:
>
>> The git mergetool ignores conflicts by git stash apply:
>>
>> $ git stash apply
>> Auto-merged path/file.ext
>> CONFLICT (content): Merge conflict in path/file.ext
>>
>> $ git mergetool
>> merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff
>> opendiff emerge vimdiff
>> No files need merging
>>
>> While path/file.ext do contain merge conflict.
>
> I think there is something else going on, because it _does_ generally
> work. This simple test case should confirm:
>
>  mkdir repo && cd repo && git init
>  echo content >file && git add . && git commit -m one
>  echo changes >>file && git commit -a -m two
>  echo more >>file && git stash
>  git checkout -b other HEAD^
>  echo different changes >>file && git commit -a -m three
>  git stash apply
>  git mergetool
>
> I get:
>  Normal merge conflict for 'file':
>    {local}: modified
>    {remote}: modified
>  Hit return to start merge resolution tool (xxdiff):

Yes, I get the that output on clean repo. And I get that output also
if I use actual conflict data (that is, three snapshots of conflicted
file) instead.

> So there is perhaps something specific about your setup or your conflict
> that is causing mergetool not to work as expected.

Most likely so.

> Can you give us a test case that fails?

No, unfortunately I can not. I was unable to produce a minimal test
case, and I can not share the whole repo.

Alexander.
