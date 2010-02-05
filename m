From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Fri, 5 Feb 2010 09:40:43 +0700
Message-ID: <fcaeb9bf1002041840l4d8e8ac9k3ad5e9e8761aa1b@mail.gmail.com>
References: <4B69BD7C.4010608@lsrfire.ath.cx> <4B6A0BDE.2050908@lsrfire.ath.cx> 
	<4B6B653A.8060909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:03:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2O-0003Bj-9P
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933630Ab0BEClH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 21:41:07 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:36210 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933263Ab0BEClF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 21:41:05 -0500
Received: by pzk28 with SMTP id 28so65750pzk.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 18:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BKl72HatyVthaI3gpDqRkfg7riOi2E38m7Q1p1FixAE=;
        b=PTZOzeb04WIeOeKtMs0Nx+iXBDid0JHH6f3UmJ377F4zYYDgFJv6M2FwG08CR+rq9B
         kiTh0brnRRQ9Mi3C/HH0hKPzyPU1RxRJnqcastmhSBjqY5GNaJ3THiigAcjoViFXm9T6
         BKrnquhWKHQYf53+C6+EhfsrbK/s2mD9TvhTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cn/Z0K19EnG29BxQCQVhiDaQd9V+H+UYBOzT9u687nb48b9jz/rxDl/piCO8UKLKWm
         YpErbXCRibg1ZazAWDn/4JAXM47JXzXefciQNYGM/9gtl/Zlxjj+PvvzDCWy+BGaWZRv
         l+SAOL2LkPM+rWg5SkwHBV7gAxwczeTmldikQ=
Received: by 10.115.86.36 with SMTP id o36mr1320693wal.142.1265337663055; Thu, 
	04 Feb 2010 18:41:03 -0800 (PST)
In-Reply-To: <4B6B653A.8060909@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139024>

On Fri, Feb 5, 2010 at 7:24 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> OK, I have to admit defeat: I can't come up with a test script. =C2=A0=
But
> the issue is reproducible: git grep in a bare repository fails when
> run with a pager.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ mkdir /tmp/a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd /tmp/a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git init
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Initialized empty Git repository in /tmp/a=
/.git/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ echo a >a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit -m.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[master (root-commit) e11f955] .
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 files changed, 1 insertions(+), 0 delet=
ions(-)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 create mode 100644 a
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git clone --bare . ../b
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Initialized empty Git repository in /tmp/b=
/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd /tmp/b
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep a HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: This operation must be run in a wor=
k tree
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep a HEAD | cat
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HEAD:a:a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git --no-pager grep a HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HEAD:a:a
>
> Reverting 7e622650 (grep: prepare to run outside of a work tree), or
> rather just setting the flag RUN_SETUP for grep in git.c again, makes
> the first git grep call succeed, too.
>
> As does the following patch, but I don't know why. =C2=A0The call cha=
in is
> quite deep. =C2=A0It seems that without the patch the static variable
> git_dir in environment.c isn't updated when git finds out that it run=
s
> in a bare repo -- but only if a pager is used.

setup_pager() calls git_config(), which indirectly calls get_git_dir()
and sets git_dir in stone. Changing GIT_DIR environment variable alone
won't work, as you have seen.

When RUN_SETUP is set, setup_git_directory() would be called before
setup_pager() can kick in, so everything is properly set.

> There are five more sites in git.c, path.c and setup.c where $GIT_DIR
> is set directly with setenv(). =C2=A0I wonder if they should better c=
all
> set_git_dir() instead, too.

Yes, they should.
--=20
Duy
