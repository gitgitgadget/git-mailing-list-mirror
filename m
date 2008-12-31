From: "David Aguilar" <davvid@gmail.com>
Subject: Re: git has modified files after clean checkout
Date: Wed, 31 Dec 2008 15:41:36 -0800
Message-ID: <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com>
References: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Caleb Cushing" <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 00:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIAiX-0001dY-TP
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 00:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYLaXlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 18:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYLaXli
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 18:41:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:47083 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYLaXlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 18:41:37 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5457040rvb.1
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S3fayDzk2ntnf+xF22k+mnhoZY/ZL4wkWL1lKUeGrSs=;
        b=GwrhRWYaH4tpyZVycEN1nYtQtLLaEqm6uus+uHxcHdwSFFmbKHAnhp4xHISkUWTt8B
         +VHdzhvwFmPgZth1aWNgQ0OuPjudPqGLIErLVptdqI2jFeRRy/aoBF1rRYkuAhW532B1
         iEZPFTPlu4zgbLDPMWd6t/+N5Ks2VnrIsoeDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NSAnX7eDHMANevyXQLyN7gABM104OBJsBDa4nerpFIeJSeK9o8+CKAIzVkSMRDQHw5
         /yqHQuHewWDwJONc11IbxBzMaJKUdCV4wWkjZ5VggLwMVmVvTjBzbYLWNoXS6Ua6QZve
         hWlkHJCWMIs3TkXOIY0OxlzYP+Sq/SP/mQK8I=
Received: by 10.142.207.8 with SMTP id e8mr4396778wfg.88.1230766896045;
        Wed, 31 Dec 2008 15:41:36 -0800 (PST)
Received: by 10.142.241.20 with HTTP; Wed, 31 Dec 2008 15:41:36 -0800 (PST)
In-Reply-To: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104286>

On Wed, Dec 31, 2008 at 12:23 PM, Caleb Cushing <xenoterracide@gmail.com> wrote:
> here's what I did
>
> rm -r portage
> git clone git@github.com:xenoterracide/portage.git


Here's the anonymous clone URL (the one you provided is private)
    $ git clone git://github.com/xenoterracide/portage.git

Read on below...

> cd portage
> git checkout origin/regen2 -b regen2
> git status
>
> # On branch regen2
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:
> x11-themes/metacity-themes/files/metacity-themes-1.0-gentoo.diff
> #       modified:
> x11-themes/metacity-themes/files/metacity-themes-1.2-gentoo.diff
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> why are there files claiming to be modified? this is a clean clone.
> I've had this before I usually end up doing a git reset --hard HEAD,
> but I'm thinking it's a bug, since I've seen it vary on the same clone
> and sometimes even disappear.
>
> git version 1.6.0.6
> --
> Caleb Cushing
>
> http://xenoterracide.blogspot.com

I followed the steps above and did not run into any such issues.

$ git status
# On branch regen2
nothing to commit (working directory clean)

$ git version
git version 1.6.1.28.gc32f76
(Junio's latest master at the moment)

Here's my quick guess based on what I'm seeing --

The files you mention contain CRLF.  Do you have core.autocrlf set
globally somewhere, perhaps in your ~/.gitconfig?

It's possible that the autocrlf stuff is messing with those files.
They seem to be a mix of both unix LF and CRLF (the CRLF stuff doesn't
start until line 104 of
x11-themes/metacity-themes/files/metacity-themes-1.0-gentoo.diff, for
example, which is kinda odd but maybe be intentional?)

Check your autocrlf settings.
The following commands print out nothing for me:

    $ git config core.autocrlf
    $ git config --global core.autocrlf

Anyways.. like I said -- I couldn't reproduce your problem so this is
pure speculation on my part =)

Good luck,

-- 
    David
