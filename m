Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7DFC11
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728270590; cv=none; b=FANViHLK6CkTVu2EcHDGlfcRySo8I6tFmhEEa5G3tmMYptRtzYHevHxRyYregbt5P3o0Xz0CK4kF8s0GwqTjxiWgOYE6jkgFLIb+q0BL91bYingmcf5mPwgPyvZ/hbRj5DtRqvjG8B1bEbXjarqaULdjVqEyoTmKw5aUgyghF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728270590; c=relaxed/simple;
	bh=0l3d79voZF66XDbuPfP2xhJZUT4MrbELYfJv/y5lR4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkczt/WTI7sJIPtSSNrzMdB29dmX/rt715AidEiL9z03p1jHaqD8s07h0AEDkmOH93wVJqeTD2DLzy36NhcqDQavmZEKIsHxkctmUzvahQlknRl4RNIazhA/SA80uunaj3K4F9n9Hk0rfBjFzNzvMZHXFzReP7kLbGqBpEVkrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AKja6ReV; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AKja6ReV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728270586; x=1728529786;
	bh=0l3d79voZF66XDbuPfP2xhJZUT4MrbELYfJv/y5lR4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AKja6ReVYFrsBubSOSEf+Gis9Wwq1GM+xkcybSOorI4UeRJmgVTf+hY8JEaT7ifw2
	 gPbArNSYaXkX2WWF1U4xX5FNHQ99CMexPuLPDBceDsAqRTxYGqTkB4HkO1GYYXiDm8
	 ZgYxb2DImTjMjM7dx0tH8dsjMHGrEaZch+aAdNyniQa5zjII/diln4297SjugnOkKH
	 YgnwTv4w3Cl3wgmXY+a7sldfCLUvcBgbGCbDXxMEJ+P6z8el/yqq4JGpSWWvSiYxoo
	 21qhpVfWjCmocuSihNWccurdncq7Hd1IMN0rkzcNoOumRJ0koIqKZwhJBJzv1O4qKg
	 EZ8aYDE+nncrw==
Date: Mon, 07 Oct 2024 03:09:42 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] worktree: prevent null pointer dereference
Message-ID: <5W8yoVL8G4LGoKUVNQNecXZFYtWnQeA71z8hQI4C15XzaPjvJFPzMA2x5DDmTRj4P-7WFYXaJ9F_tLIpG2N8JNiHlWm_cbMHC_KNjO0-lnM=@pm.me>
In-Reply-To: <CAPig+cSqWomvpgAGUCCaxHG9UTy+JecRndM9ynwdBgUoLYAXTw@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-5-cdwhite3@pm.me> <CAPig+cSdVVy4huueVQpiO_Gvn4SAXAiQj-uVnuScgfOOFJ6h0g@mail.gmail.com> <VKrLGkXtD_CWHlQJRx_JqPn9sFsjKL88fRnGvA2UcV_gvQxyv8kmIx9M6BkPRfAx9paB7KrjkL9XAE8P2P2EPJnciBN4F6LAAc176NzLh6U=@pm.me> <CAPig+cSqWomvpgAGUCCaxHG9UTy+JecRndM9ynwdBgUoLYAXTw@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: dca4d69b06bbc7cd3dc8f9957e1f1e6305a77114
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------e994ff95cb65fc562aa0755fd5ecb29fb45f9578c97329d4c3886f4a166a2299"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e994ff95cb65fc562aa0755fd5ecb29fb45f9578c97329d4c3886f4a166a2299
Content-Type: multipart/mixed;boundary=---------------------a50933ffdb22dd67c0ddaa29f805d55a

-----------------------a50933ffdb22dd67c0ddaa29f805d55a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 18:24, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Reviewers are a limited resource on this project[1], so it's ideal if
> submissions can be as reviewer-friendly as possible. Extraneous
> patches, unnecessary or unrelated changes to surrounding code, etc.
> all make a patch series more onerous to review, thus are best avoided.
> (This concern prompted all the review comments I left on this patch.)
> So, let's drop this patch since it adds no value to either this series
> or to the existing codebase. If someone needs such a change later on,
> they can resurrect the change.

Sounds good, dropped.

> [1] There are far more people submitting patches to the project than
> reviewing them. For instance, according to Junio's latest "What's
> Cooking" report[2], the patch I submitted[3] a couple weeks ago to fix
> "git worktree repair" to handle manual copy operations is still
> awaiting review. (Since you've now been living in the worktree code a
> bit and have had to digest the "repair" logic, perhaps you'd be
> interested in reviewing that patch?)

I'd be happy to take a look!
-----------------------a50933ffdb22dd67c0ddaa29f805d55a--

--------e994ff95cb65fc562aa0755fd5ecb29fb45f9578c97329d4c3886f4a166a2299
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA1DnCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADUFgf+ODugP4LfJK6Yu4ZahPA89PpkduglbUIkMXXciv2zopuiqhkX
XmtJD3rb+P1jDBvBvsv5gPk8tAh/5sI20jtgddarPjOD5RuAoTpY3psEme6f
78jrHNmcwNmp5pQzx08nyZGfNFCBt07MCS4UEQ8T665fZ8OMGtQjHNNeKVo9
yemOtS6GfpKYSwAD0bttDC93KTR8AVrNXZ+kIl87zUMhZr/B7/St5wgSUtRr
jASyUvxEe5u8fTA7aJg6sit2HAly0IHSq8c2TP3hP3WbpfJNGfbTXE+oG5x7
TF7hsL+AvToJRJ+a4eyyE9fIJ76Nf7mTPYirSHqnCFM7k/zRii5sEA==
=ZdQi
-----END PGP SIGNATURE-----


--------e994ff95cb65fc562aa0755fd5ecb29fb45f9578c97329d4c3886f4a166a2299--

