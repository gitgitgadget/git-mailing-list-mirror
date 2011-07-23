From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: git svn v1 migration, avoid re-clone whole repo
Date: Sat, 23 Jul 2011 19:03:51 +0200
Message-ID: <CAEcj5uXUbJGj0Gjji-dRcsQuoQ3kP-LXcXGjtwFiZLFP5c-R6g@mail.gmail.com>
References: <CAJs9aZ-h8J_WYC1cXy9HojwArO8EqWSZnoZ1=LdrqHxeJxz_BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rupert THURNER <rupert.thurner@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 19:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkfcM-0008L9-3d
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 19:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab1GWRDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jul 2011 13:03:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47738 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab1GWRDv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2011 13:03:51 -0400
Received: by iyb12 with SMTP id 12so2937109iyb.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ug9zXEw7fc3Ro125MXSkrCi41KIvZaB9uaQpzEy01CM=;
        b=OQbdbUGk94DydHGEf6Tw5YmTQxlKgibHlmpzaZlMFeEPhHCS1+qggnhUyUyjIKjpbs
         GZqs9EVM7LtK5MTy5JfT53RvDCKhd5Fq0mGbRo70/6fPHnTqEZfWMtUnUKbW/xoZIM4p
         tKiAUnrTO2Hkbm1U/sbEMMHexQS4RQllI/9J0=
Received: by 10.231.112.98 with SMTP id v34mr2571478ibp.85.1311440631154; Sat,
 23 Jul 2011 10:03:51 -0700 (PDT)
Received: by 10.231.114.204 with HTTP; Sat, 23 Jul 2011 10:03:51 -0700 (PDT)
In-Reply-To: <CAJs9aZ-h8J_WYC1cXy9HojwArO8EqWSZnoZ1=LdrqHxeJxz_BQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177697>

Hi Rupert,

> is there any other means of upgrading to the new svn layout but
> cloning the repository afresh again? the error message i get is:
>
> $ git svn rebase
> Migrating from a git-svn v1 layout...
> Data from a previous version of git-svn exists, but
> =A0 =A0 =A0 =A0.git/svn
> =A0 =A0 =A0 =A0(required for this version (1.7.5.4) of git-svn) does =
not exist.
> Done migrating from a git-svn v1 layout
> Unable to determine upstream SVN information from working tree histor=
y
>

Can you say in more concrete steps how you created the repository
where this happens?

I've seen this error message in repositories that are clones of
git-svn repositories. They are "simple" git repositories with no link
established to the SVN repository (no notion of svn in the
=2Egit/config). If this is the case, read on:

I usually fix this by initializing git svn in the repo:

> git svn init [same params as the initial git svn clone] [svn url]

And then you have to update the latest git-svn ref to point at the
last git-svn commit. Usually this goes something like:

> git update-ref refs/remotes/git-svn refs/remotes/origin/master

=2E.. assuming that the git-svn repo you cloned from is a remote repo
with the name "origin".

Note that in a git svn clone with branches the above git-svn reference
will be probably be branch name instead.

Hope this helps,

-Thomas
