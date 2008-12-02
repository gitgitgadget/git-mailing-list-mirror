From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Mon, 1 Dec 2008 21:38:07 -0500
Message-ID: <81bfc67a0812011838m68100020v727da1c06f0bcee4@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LAe-0006Pg-4N
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYLBCiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYLBCiJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:38:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:5193 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbYLBCiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:38:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2745388rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=b3vhEBoPNNq6TXH3rY87M+eh+0ZbzBKEWfyZ+++yrFc=;
        b=i8HHyOR3ddC4FrWwkQ8uV7mLGsHO6xZf8LsLoM2S2XQ0xzxAlz3kO9JqFY7kP05G9V
         RI6U0zA5OZaDDmVYjxMA6QRlosJ2c22/sBxh7vAQsXiThWFhV/30IbWjO2ldoGiG2KGT
         IuTUiTMDQWv+/BFx+yjlL+dQ69tyCg0FGd0WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FEU98Fkm+ZUKiSS2s3xp96IoI6wN9esTuStoU4dseiAx2k1pOlpmDllvTiOmbdb9a/
         nVfD13yrgKnZIosYJnc4zc10oXdT6Z6W8GuT0oyttevZNNHDSWgnKdhiLddxZoQkCPG8
         NGWc2SF58h1tKOyAYMpOCds4GR13TpZm5Zy20=
Received: by 10.141.87.13 with SMTP id p13mr5534217rvl.81.1228185487988;
        Mon, 01 Dec 2008 18:38:07 -0800 (PST)
Received: by 10.141.145.7 with HTTP; Mon, 1 Dec 2008 18:38:07 -0800 (PST)
In-Reply-To: <4933AC03.6050300@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102110>

>  If you could come up with use-cases where each would be useful, I
>  think you'd have a much easier time to gain acceptance for your
>  suggestions. Right now, you're saying "I want a red button" but
>  you're not explaining what it's for.

conflict: when auto-merging isn't merging the way you want it too, but
you still want to see the diffs and handle them by hand. no commit
won't do this, it just doesn't commit. I've had 2 situations now where
git's fast-forward has overwritten changes in a branch I didn't want
it to, it would have been better if I could handle them by hand
without having to have 1 terminal open to the diff and the other open
to the editor to fix it. and yes git was right by it's perspective,
but the code it created was wrong by what I wanted and needed. I'm not
really sure what more of a use case is needed for this.

no-overwrite: it's basically my way of saying that even though git
thinks it's changes are newer and better than the ones in my branch I
know they aren't. I only want the new stuff from the other branch. In
the second situation mentioned above I have 2 branches that I like to
merge back and forth, each needing a specific set of changes to
certain files however most changes are shared. when I merge them I
often have to change those specific changes back, if it didn't
ovewrite them I wouldn't have a problem.

for example I'm tracking my dot files with git, in my main user
account I set umask 077 however in my web development account I need
umask 027 so apache can read the files I create. when I create a
change in webdev and need to merge it back into master it overwrites
the 077 umask which I then change back. when I create a change in
master that I want in webdev it then changes webdev's umask. very
annoying.

the other problem I had was where I'd overwritten a file in another
branch just for the point of merging it into the master branch so I
could see the differences, and handle them properly (as I see it)
unfortunately git felt that this file was newer and simply overwrote
the changes in master. this was incorrect they were simply different
versions of the same type of file, like comparing an httpd.conf from a
gentoo and another from a fedora system. I was merely trying to figure
the best of both files to get the results I wanted.

technically the conflict strategy I propose would be adequate for both
but the no-overwrite seems like a good idea as well.






-- 
Caleb Cushing
