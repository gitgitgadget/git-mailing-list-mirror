Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C23FB94
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444148; cv=none; b=AkczKJMc50y6rqRSzG2ebSJKCuUJdQUHwrhWiFr4cr7jZukywk8mvmbSYqHGecC9/GqF1SOYqMZ3he+/B6Gx+KPd9pyKcExahxouezyTeTkKPPdJRVz851Fq4zB81LufA0zFcKXj954FERM1B1WZ1M5wl6AujhQ3SjB85Tq9E4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444148; c=relaxed/simple;
	bh=Avsh2vN2ZHzfnKR15DhlOR/9qP9+H8TsnCpHjErKdWQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NVlfFAiB6d7QCtkz0Osy68rvI3N5Q8ifd5UBD1466G5/1QxDdtiBk4cWkE2drQaQhqLBDV9+4XRz9Xg+eMsvLHP46gIFlNAMcR2kuzzvH3E7XaJBHrxUwh3fGG45QvB5Dl9m33bNg6pvCcds0FWqL0G5QHsZM0YdoTzPnDvptIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HsfW8TCQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HsfW8TCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720444133; x=1721048933;
	i=johannes.schindelin@gmx.de;
	bh=5IDtbBmemtT79ns6ed0VtMbOp2XOhhdu2mI7rNq9BOM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HsfW8TCQbJY1PDrxvvBkOWejU7w+FSohEcFoWLmSBulHZ8hkP+G3un6keKE7QHWv
	 vaPzDo8vlvLshW7makOvBLrjVWe5bldX0IKLXyr1jJhOT0qQvoxe0bdEn31PMV0oA
	 gcmpEeRbNvDqfpXtd83jVWfUW4Rf7Jr3GR+0lWKffTqyMw5zU/IK/pFKw7g1KdXgW
	 e874r1GeiVMzO3oxJV5sqiIJYHmzai67ihJFKlRPQK+wR1QSVxVqpOg3V9gmbM6Ho
	 z8On+wyd4XTeSN29cc/NqqXj6yR2TWGZzheEoy1XvMyEQxzM1wLhAXahfJaaKVlnX
	 ArsmtH5HLyt0wJgeDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.58]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDp4-1sBE8j1mPI-010Pgs; Mon, 08
 Jul 2024 15:08:53 +0200
Date: Mon, 8 Jul 2024 15:08:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
cc: phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>, 
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: BUG: "git var GIT_SHELL_PATH" is broken on Windows
In-Reply-To: <ZovDPbgBS7WJIipz@tapette.crustytoothpaste.net>
Message-ID: <cbdae028-db3d-b43e-57ef-52182452f49d@gmx.de>
References: <cc267962-ca2d-4c4a-9ed8-d40c4d282522@gmail.com> <ZovDPbgBS7WJIipz@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WAdNmE6ItdJhpIoRF3XQQswH8eB5PuyrFttVm+TjcKcd585FjOs
 jmB41nIgc9W6nH0/eSPKuleSpf9INQj0JTy1BCvdWLSIy5ACXm2CgKdozvcRmY62qvhTLvx
 zckPUjbCC4a3YByEPLtsL37HPLfBiVlNqGlW2uWhZDvE7pE1Aatn+6tTGv1KgyoD7jXGjZx
 zOVimFeR6oJ5Lbg8LyLFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zff/lDatUiI=;JrwFMPbdYbfzcCtEhXZ6zWmpDfY
 tthpCk5o18X7qr7VyMT+YwxRx8rnDG34Lkk4IEJi9HpBBKlDe0gl3Ey4TwVPF1Ukqw1nVoW0c
 j2fYVvCCRzWtXN90psx5XRdXuZIP94ucr4/P4rbgFxTZ81l6WLeGh9+z17D+YwFpWlpP3Zt01
 dEgtW8BwYDSjscr9g0ZLQyZIQbIxwQWtns6+DBJY9VE81OfxcQdKMH5WystSoMqM2Ajzht14x
 Bjt0UGZnuSkeIoUTnF5TctXmVJ1nJ0yPoPWPuqs7d9jXRkv506o06OjqS6QmWB6jHq/KN+EFt
 dkVriiQRKUFd5AVyeGZvntPKP3MaPAykhdKP1qYnlrEEvn4l9rSbe1vLVGQ4wtwUExgiLtRaz
 Uyd623P1Sm2JgrpUZ6noOgBHw8Sq939l4bg9XjqrE4Wa/gFm7fS4sSRx8fLCmn5IkPU+Y+0QZ
 qb1JFfpzB8Xmzd7hSa+YR+ugWSTns0cFYshpX/+h7oibh/0QR4o/HYIyI54cTZUFOp/MLudHq
 OX7GVSyackxlM4ZcQxOAwL2ycV7Yd+LrWbGekRWC434XBkFOWJgbRR8I79+lp9jfeCJKG8JQ7
 0ulCSJqAtB5FNCJYtaWjYGAJp9X0uO9V/nbWBsoOiAkL8okIqzxYATq8sU/5X4j8TdycYKvrZ
 3h06s6nH+R07z/jRkXVmEn5MVgwVGvW+GthbWDioMbMhI4rwLDmfbNJnvCN/6frgw8TO9ydRF
 c3Vf+qT417wTL+DMGDEjxxNVO60LUNmSFJ0X0ngf3s14qe+LVGfY1HAGCPfMwvjoTjxTZAeJT
 936tBJAhi2TgPKiAwTlIkbCWSokrn6KJHxfl0XOTHtbUs=
Content-Transfer-Encoding: quoted-printable

Hi Phillip & brian,

On Mon, 8 Jul 2024, brian m. carlson wrote:

> On 2024-07-08 at 10:07:17, Phillip Wood wrote:
> > Running "git var GIT_SHELL_PATH" on Windows prints "/bin/sh" which is =
not
> > very helpful when the path to the shell is actually
> > "C:\Users\gitlab_runner\scoop\apps\mingit-busybox\2.45.2\mingw64\bin\a=
sh.exe"
> >
> > Support for GIT_SHELL_PATH was added to "git var" in 1e65721227 (var: =
add
> > support for listing the shell, 2023-06-27) with the aim of making it
> > possible for external programs to learn the location of the shell used=
 to
> > run the command returned by "git var GIT_EDITOR". As the commit messag=
e
> > notes this is especially helpful on Windows where the shell isn't
> > necessarily in $PATH. Unfortunately the implementation simply prints
> > SHELL_PATH which is unused on Windows. As 776297548e (Do not use SHELL=
_PATH
> > from build system in prepare_shell_cmd on Windows, 2012-04-17) explain=
s the
> > location of the shell depends on git's installation prefix. For the
> > git-for-windows builds it looks like the shell is always in
> > "$GIT_EXEC_PATH/../../bin/" but I'm not sure if that is universally tr=
ue.
> >
> > It is possible to work around the bug by doing
> >
> >     git -c 'alias.run-editor=3D!$(git var GIT_EDITOR)' run-editor
> >
> > but it would be good to fix "git var GIT_SHELL_PATH" or at least docum=
ent
> > that it is broken on Windows
>
> Ugh.  This was indeed supposed to work, but I no longer have access to a
> Windows machine, so we'd need someone who does have one to write up a
> patch.

Funnily enough, the test suite specifically tested for the faulty `sh`
suffix.

Also, pro-tip: With GitHub Actions and
https://github.com/mxschmitt/action-tmate you can fix compile errors and
other problems directly on the hosted runners, including Windows ones. If
you do not have any access to Windows machines anymore, that's how you can
gain it back. I use this, too, to ensure that my patches work on macOS as
intended, as I do not have access to any other macOS machine.

As to the issue at hand, I offer
https://lore.kernel.org/git/pull.1760.git.1720443778074.gitgitgadget@gmail=
.com
to address it.

Ciao,
Johannes
