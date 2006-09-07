From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 7 Sep 2006 16:41:20 -0400
Message-ID: <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <edpuut$dns$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 22:41:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLQgl-0006I3-59
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 22:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWIGUlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWIGUlX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 16:41:23 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:52982 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751855AbWIGUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 16:41:22 -0400
Received: by py-out-1112.google.com with SMTP id n25so487879pyg
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 13:41:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P5eE/f3he43v6D1PW9M9upmwvo7Y2UlQBLOTqAdUdJYv1qiZqgffRiZfG3IHmqg22PYHVqvfoQG80qxcF5nCF1bLbxp/lSc16866Hi2S2J7J5uqlFsckcYayNY+MGct64+XLv4DCl20296NFl0Olw7yebCCTiUY7tMwSVBFDDug=
Received: by 10.35.9.15 with SMTP id m15mr1402079pyi;
        Thu, 07 Sep 2006 13:41:20 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 13:41:20 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <edpuut$dns$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26656>

On 9/7/06, Jakub Narebski <jnareb@gmail.com> wrote:
> I don't understand. Git is _not_ patchset based (like GNU Arch, or

I meant change set to refer to a commit plus trees plus blobs that
make it up. These may be present in full or delta form.

> Mercurial, or CVS). It is snapshot based. So if you want to download
> "skip", you need only for the local part of doenloader to make appropriate
> grafts, like below
>
>
>  *--*--*--*--*--*--*--*--*--*--*--HEAD    (server)
>
>  *--*--*...........*--*--*--*--*--HEAD    (shallow/sparse clone)
>
> But the part you were talking about is _easy_ part; the hard part is
> merges including merging branch which was split off the trunk before
> cutoff-point, history rewriting (c.f. 'pu' branch, and rebases), etc.

Does an average user do these things? The shallow clone is there to
address the casual user who gags at a five hour download to get an
initial check out Mozilla when they want to make a five line change or
just browse the source for a few minutes.

I would expect advanced users to have a full tree present.

I was going to have the dangling references from the shallow clone
point to 'not-present' objects. When you try to do any of the more
complex operations you would hit these objects and fault down more of
the tree.

There would also be a command to bring down all of the objects to
fully populate a sparse tree. You could do the shallow clone to begin
with and then do the full tree populate overnight or in the
background.

Maybe the answer is to build a shallow clone tool for casual use, and
then if you try to run anything too complex on it git just tells you
that you have to download the entire tree.

-- 
Jon Smirl
jonsmirl@gmail.com
