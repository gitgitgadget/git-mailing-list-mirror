From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: FIX/COMMENT: git remote manual page
Date: Sat, 25 Dec 2010 17:48:58 +0700
Message-ID: <AANLkTim_pHYEZ+7-Rm5N4Ycw2MTHD8AhvZrZqNhttkck@mail.gmail.com>
References: <20101222021546.4b24c4e9@eana.kheb.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michel Briand <michelbriand@free.fr>
X-From: git-owner@vger.kernel.org Sat Dec 25 12:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWRrA-0004W9-Mx
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 12:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978Ab0LYKtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 05:49:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56008 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab0LYKta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Dec 2010 05:49:30 -0500
Received: by wyb28 with SMTP id 28so7437426wyb.19
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aE3mnRROBFoGTc77IrWeCX1UwERHPNcmsBZAn+fMdcc=;
        b=D+U/jNaAoYO4/HedpCvGKne8WSmx/QJZNRCw4dWYrUbXtgUl/6mUEBXByHz3tqrmmY
         /c1jwa+Ly2gUBwVUUSpfNhuLA5S577HcMFEKD5OcAiCxlUbV6mAIEOtGeAQw0ml9ARcl
         RcT323mrlZo3NCncpd7SZDvcuyJZJy6pZGdMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uPIQzf08r9fwZfAKDkXQj3f9XPbxyGNEljzcKLPy6djgmW+OrlaLin8zNDjC04iHDr
         wv9usw5598n7Fev4qG0UQzgzWvJy4P5rWthPOOy3ZKADKkGqT4rGx9eHBhiDlpRdrn1i
         OUDoYEMxr8viBsS34E7ekBntXeQtPq7Nv9RdA=
Received: by 10.216.51.67 with SMTP id a45mr3933073wec.19.1293274168243; Sat,
 25 Dec 2010 02:49:28 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sat, 25 Dec 2010 02:48:58 -0800 (PST)
In-Reply-To: <20101222021546.4b24c4e9@eana.kheb.homelinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164170>

On Wed, Dec 22, 2010 at 8:15 AM, Michel Briand <michelbriand@free.fr> w=
rote:
> Hello,
>
> I tried the example given at the bottom if the manual page of git
> remote.
>
> =C2=B7 =C2=A0 Imitate git clone but track only selected branches
>
> $ mkdir project.git
> $ cd project.git
> $ git init
> $ git remote add -f -t master -m master origin git://example.com/git.=
git/
> $ git merge origin
>
> It works like it is written.
>
> But it seems this does not work with my special setup:
> - I use GIT_DIR and GIT_WORK_TREE to specify another location for my
> =C2=A0repository, and to work from another directory,
> - I name my remote with a custom name (not origin).

So you set GIT_DIR and GIT_WORK_TREE before running "git remote add"?

> It fails at the last command :
>
> =C2=A0 =C2=A0fatal: <my name> - not something we can merge

It fails to see "<my name>" points to a commit. Maybe it fails to read
remote information from config..

> But if I try the command :
>
> =C2=A0 =C2=A0git merge <my name>/master
>
> the error message is different :
>
> =C2=A0 =C2=A0fatal: This operation must be run in a work tree
> =C2=A0 =C2=A0fatal: read-tree failed
>
> I cd to the work tree and issue the same last command.
> Then it works.

What git version are use using? I did

GIT_DIR=3Dgit/.git GIT_WORK_TREE=3Dgit git/git merge origin # or a spec=
ific branch

and it worked fine here (recent master). That message means work-tree
settings are not propagated to git-read-tree (run by git-merge).
--=20
Duy
