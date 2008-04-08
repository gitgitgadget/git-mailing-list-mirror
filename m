From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git bisect on multiple cores
Date: Tue, 8 Apr 2008 22:50:34 +1000
Message-ID: <ee77f5c20804080550h251918d6n73d73a1de8ec6c09@mail.gmail.com>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "A B" <gentosaker@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 14:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjDIL-0007oR-Qs
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 14:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYDHMuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 08:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbYDHMuj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 08:50:39 -0400
Received: from rv-out-0708.google.com ([209.85.198.251]:13385 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbYDHMui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 08:50:38 -0400
Received: by rv-out-0506.google.com with SMTP id k29so3524rvb.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pVdQRruujR1S18tf4QvC1Efq7lVR3VtmvzNlzEAgA4U=;
        b=FbvwsjTb/2AHS2HGBx+E6MRD7f7iB2KF6nopuR+TzL1zWCvaLB7eOlZRzBnckoM95GfLhgsP6Lk4KgzxCcmaoINlP54z7/8p00JOv2VIMXiBA70J4DACcFZ1F98z1iCChVCzFuCX7sOP4IBlBB70/Ijx9H4noKbgxSNHjvlZ3zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RuTGAXgS1U4ookUQhd8Kv29ehYA5bNfHConOhEOifMjzNG9FuwvJ9EsPBKhTdZIFiDQRj6kArpEYa5mtmkFeT+eZjexrA+2XMJv3l4Elf4nTbIoY03iWERGHwZZUj6m0yR6f5XjYsBYKFFA97YNka+GUMHytgb8qiGDttLlq9iw=
Received: by 10.141.180.5 with SMTP id h5mr1982376rvp.240.1207659034037;
        Tue, 08 Apr 2008 05:50:34 -0700 (PDT)
Received: by 10.140.135.17 with HTTP; Tue, 8 Apr 2008 05:50:34 -0700 (PDT)
In-Reply-To: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78996>

On Tue, Apr 8, 2008 at 8:58 PM, A B <gentosaker@gmail.com> wrote:

> git bisect is really cool. I use it for the first time.
>  Just a thought, if you have a multiple core computer, can't you make
>  git build new versions in the background while testing the previuos
>  version? Alright, if you build 2 versions, one of them will never be
>  tested, but you will perhaps save some time by letting it build in the
>  background?

Git is used to track more than just source code that can be "built",
and git bisect can be used for more than just tracking down bugs.

I'm not convinced the considerable extra complexity would be
worthwhile. You'd have to have git bisect do checkouts to new
temporary directories, track them and clean them up.

It might be interesting if you approached it as a tri-section or a
general N-section where you try to divide the interval into N parts
and concurrently test N-1 commits. But really, do you find git bisect
all that slow in practice? You probably have a reasonable guess as to
where a regression has come in, and so even 1000 revisions needs at
most 10 bisections to find the culprit.


Dave.
