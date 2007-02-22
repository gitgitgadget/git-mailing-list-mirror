From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 11:38:51 +0100
Message-ID: <38b2ab8a0702220238l14628f54s3165f050f6af5447@mail.gmail.com>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	 <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 11:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKBLq-0006JQ-Q1
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 11:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbXBVKi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 05:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933015AbXBVKi5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 05:38:57 -0500
Received: from qb-out-0506.google.com ([72.14.204.226]:2154 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbXBVKiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 05:38:55 -0500
Received: by qb-out-0506.google.com with SMTP id z8so62759qbc
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 02:38:53 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZ7Kdt+dwQnwqcBg5C8nsQGD9Q6M4Eg39hdC4unRaw4Ze8t4i4gTWp2erOl7Maf6ROBEHCeYHhIRQ03Tj1aguzHHHnAxPLw/uznCrL2wRU7TiUFlCNXdB1jhGHq9Y3YCKtao+9oa3wObGuag6Q3mLBBbv25VSIvF+9p9+yTKpc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmBJNNcxLW0bo6GBulgrR5JUi4h85c5KT2b9P2NLvpEiUjCk85Xfrps/CxuEr9/3Ug9rT7QOiRqYWJLQXDObttPVC4u+dfxFFLALH9KpgIZ4tJe6bwzMoN4VYZSrKfMcCvj+2DE8DV+MxGabZhVgFIOWcsSPIuNaxxqpof/k7o4=
Received: by 10.114.131.2 with SMTP id e2mr180758wad.1172140731477;
        Thu, 22 Feb 2007 02:38:51 -0800 (PST)
Received: by 10.115.47.14 with HTTP; Thu, 22 Feb 2007 02:38:51 -0800 (PST)
In-Reply-To: <7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40346>

Hi,

Junio C Hamano wrote:
> "git-am" deserves a section in the user-manual on its own.
> Perhaps the following can be massaged into JBF's User Manual,
> but probably with copyediting and spellfixes.
>

yes it's definitly something useful for me. Thanks for writing it !

> First, the basics.
> ------------------
>
> When "git am ./mbox" stops in the middle, you will find
> these files in the .dotest/ directory:
>

[snip]

> There are two strategies to resume an "am" that stopped because
> a patch does not apply.
>
> One is to fix the patch into applicable shape in whatever way
> you can think of, and attempt to apply it again, with "git am".
>
> The other is to update your index to the desired state after
> applying the given patch in whatever way you can think of, and
> continue with "git am --resolved".
>
> You can also choose not to continue, but skip one patch.  You
> can say:
>
> 	$ git reset --hard
>         $ git am --skip
>
> to skip that particular patch.  This advances 'next' and
> continues with the remainder.
>
> [jc: I think that is not what you want in your RFH, but I am
> spelling it out for inclusion in the User Manual -- this comment
> itself should be removed if somebody wants to include this
> message to the manual.]
>

nope, and this is quite well explained in the man page.

> Now, let's go on to "whatever way you can think of".
>
>
> Fixing patch text
> -----------------
>
> Linus's way is to visit the ./mbox file in the editor, remove
> the messages that have already been applied cleanly, edit the
> offending patch text to make it applicable.  Then:
>
> 	$ git reset --hard
>         $ rm -fr .dotest
>         $ git am edited-mailbox-file
>
> A variant of this approach is to edit .dotest/patch to make it
> applicable, and then say (without removing .dotest/ directory,
> of course):
>
> 	$ git am
>
> But these are probably reserved for people who are comfortable
> editing the patch text.
>

definitely not my case...

>
> Applying by hand
> ----------------
>
> If you (as most people) are not comfortable editing the patch
> text you can update your working tree to pretend that the patch
> applied cleanly.  You can do number of things:
>
>  * Use "git apply --index -C<n> .dotest/patch" to attempt
>    applying the patch with reduced context.
>
>  * Use "git apply --reject .dotest/patch" to get apply only
>    hunks that apply cleanly, while getting *.rej files.
>
>  * Use "GNU patch" with less strict options, perhaps like
>
> 	$ patch -p1 --fuzz=<n> --ignore-whitespace
>

why using 'patch' ? couldn't this be done by using 'git-apply' ?

Maybe these several choices could be proposed to the user when using
the interactive mode ?

>
>
> Letting git work harder
> -----------------------
>

[snip]

> This "3-way" is in fact a variant of "Applying by hand"
> strategy, and your goal is still to update the index into the
> shape the original patch should have made into.  After you
> resolve the conflict, you do "git add" the resolved path (or if
> the patch is about removing a path and if you do want to remove
> that path, then "git rm").  Make sure that "git diff --cached
> HEAD" output matches what you think .dotest/patch should have
> contained.  Then:
>
> 	$ git am --resolved
>
> to continue.
>

This part is really interesting.
-- 
Francis
