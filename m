Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAA30F542
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595235; cv=none; b=a0JoT0yQfMQj3AiKMeudoXuVN5SnBZhpFR20Ou2TArQG8gE2WnoyWBJIzKCKUursHqcUh2qT3Li3Vx4cTgRwYY7yoldEdx3uOthOhAce+elpyd4+uMrqAg4lQ/hrMSzflvJRfx6LGbJXy1dSklJRzUYJ0XunMevWT4POinWxfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595235; c=relaxed/simple;
	bh=EozTcl8vpmPCG2kEbDRVMC+Pp0ckslyu4xACYKCJFRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NhiyjaK8BwuOQIjgvLcVONrOVcUvsrZ6J2BeuM35e2terD4j6HxrCj8ZBLnNOMqClYvd8A4k3uqWdkhBR50M32Z80HuurTbnjvHYDxy34DHhckodCCW/VSdEprwW5KCAOEipJRBjIWbXjwgy2Zk9bz+MdKHN8/NmIJLVtOqpcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=L+ODg8jM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="L+ODg8jM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595230; x=1765200030;
	i=johannes.schindelin@gmx.de;
	bh=HgagytNzVjaanym+tZGit3IB8ZNkfnv/Iz8VReKMYrk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L+ODg8jMrXSj7svHtIeIJeHHQG8/SunyYUCojXHhVMhf25R+X0hQ7W5PibMnuhfm
	 lj1kXeJt7N8o9mKD5V8ywYoiOCZmwcb8/f6aAwFIvjS3gAlI7o/UTxhZHz4D+MB2o
	 /NvgD0rY9ixASypPOQaoNNNfGF54p/uV/RCXPHV9e8GxpsGVNpgPYEUiDnhgTGhFn
	 zBS0o4PFqyBhnlVLPDLbnMFS55PLm8tl3Y73JlyvINStPuUZell4MPqdUe4BuOqqL
	 00MIaKM/yucA5+ZDC+JlYsSMnZy1VGHOgyDVBz1iTYL51pEtlxEIHIuy2+isCBw2S
	 GnPr6rkDxXxfS80+pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1vMlVJ3Sua-001dWb; Mon, 01
 Dec 2025 14:20:29 +0100
Date: Mon, 1 Dec 2025 14:20:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 04/10] t0001: handle `diff --no-index` gracefully
In-Reply-To: <xmqqms44cb7p.fsf@gitster.g>
Message-ID: <07dd2e66-7cdc-7839-aaf7-274b116df51c@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <3be9594e80c37b2b393f5883a173694ab6793813.1764440906.git.gitgitgadget@gmail.com> <xmqqms44cb7p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t0b1oNGDmBfng7mG/TXqkXByrUx2hZ7wYU6gmQAJNEJhB+MD9no
 EJ/c5MnJ0fHvmAwHJF3GtKqxxZ0A1I2N/6LWoIO0beSUWbRJ87lV0MRyOgoFUFSzBEoBYK4
 +uTU658v/s4tpMlYLiKe8U3nQTWHUVqKi9sZev/vp5sjM99jH96cLBoX+7BRa5+KwaAC/Y2
 7HTq0SToMwgF6fQFBfijA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NjE/PXAHSVE=;2iqrzFix9pmrju9ELtkbighTM1f
 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
 uEAtdB1EMqSRDudFKA3g+/BbpLBd7xFlh4Qk/X
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 29 Nov 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The test case 're-init to move gitdir symlink' wants to compare the
> > contents of `newdir/.git`, which is a symbolic link pointing to a file=
.
> > However, `git diff --no-index`, which is used by `test_cmp` on Windows=
,
> > does not resolve symlinks; It shows the symlink _target_ instead (with=
 a
> > file mode of 120000). That is totally unexpected by the test case, whi=
ch
> > as a consequence fails, meaning that it's a bug in the test case itsel=
f.
>=20
> It is dubious if it is a bug in this particular test case, or
> test_cmp implementation that uses "git diff --no-index", though.
>=20
> Either way, when test_cmp here does not do "diff", the test would
> fail, so you are correct to notice that this piece of code needs to
> be patched in some way.  I do not think not comparing is the right
> solution, though.  Would there be a better option than completely
> punting on the comparison?  Something silly like:
>=20
> > +	case "$GIT_TEST_CMP" in
> > +	# git diff --no-index does not resolve symlinks
> > +	*--no-index*) cmp expected newdir/.git ;;
> > +	*) test_cmp expected newdir/.git ;;
> > +	esac &&
>=20
> perhaps?

Sure. It's not like this adds much confidence, though, as the tested-for
functionality isn't specific to Windows, so I'd expect this to fail on
Linux, too, if it was broken, and running that comparison on Windows does
not add much.

Since you spent time on this, I will change it, though.

Ciao,
Johannes

>=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0001-init.sh | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 618da080dc..2f38e09b58 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -425,7 +425,10 @@ test_expect_success SYMLINKS 're-init to move git=
dir symlink' '
> >  	git init --separate-git-dir ../realgitdir
> >  	) &&
> >  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> > -	test_cmp expected newdir/.git &&
> > +	case "$GIT_TEST_CMP" in
> > +	*--no-index*) ;; # git diff --no-index does not resolve symlinks
> > +	*) test_cmp expected newdir/.git;;
> > +	esac &&
> >  	test_cmp expected newdir/here &&
> >  	test_path_is_dir realgitdir/refs
> >  '
>=20
