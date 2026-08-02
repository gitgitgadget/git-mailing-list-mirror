Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D523C503
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785709940; cv=none; b=WfxzrBquNtT91FOOGCqO8URzLqPYg0fg0a5SZkV5h4l/a6niAfKhXeJUVOrKMW1o1suKThF6IwLX3SC5T1ALodXG0lxvLkY9igMHneMFx1BhTVO2JVTT5+jN98L73thAKIKIKBCuraAWJnCtbXoonnv9memYacnVDLoAjoyCtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785709940; c=relaxed/simple;
	bh=rTUFEsiVN/vLko/7EMBuA2flQRswyqIDKLtBYGheReo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaLmwpX24Dc5v85shgnw/1tjOdRh5JcLhVFngTH6haEidkuR/xCc7is+N4Ue2Y7kuC/2up7tByZvSB1qpmQovpM/FX3AGm09fKnM9BFI8MrgyrrA2/iaXin7H8yknwsVo8VAfo72nBdpwWvs7ukoV/FCBZx1cNSvNUEhYgeiyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SympUtdK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SympUtdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785709937;
	bh=rTUFEsiVN/vLko/7EMBuA2flQRswyqIDKLtBYGheReo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SympUtdKzYr6YATMapFTw5RqYDUX5K6zrj+T0OTkcRSgR25JsPrni0zQ/xVBirQZO
	 qH/owlqcs8aT4PGY9Wlb4wYlcczeBcErEd92jVVeI94UPF6wbeESuUsOXQ+dGTVz/g
	 Jcx/J/bLIPapAeeocI/qXln4jyoUHlhGyL0NKvt3MRbnscCopw8MeQVgM+1Cqs/UTb
	 3bxZG7ePVweOLLwabuZq7qLGLh9wn2iQSybpgO3rn5l7WFeoI0XnpyPJYTsz5U6tzA
	 HDUbfIYu/Af7VwYvjK4W+E/poF2MU86mViNO5hBgIjpLhWK0HjNWhd9+Hshqm5G6ch
	 19KbElILyL7h/ZBuQNiIVsqqf7Xk4hiND1HO8rnQl5k+jfKOAE+98/3Q0lKtmlL+nm
	 OB1Uf8Zpq/CjeXKA6OiFTkbYUpeaKh2Aw5C4lqTHUc7Tp5MyKMPV0P77M/f1sPzd/i
	 kjvuPExe7cSuKSMAheZkQ7UiZ5J/qI+PdRMVUwZg5eQOQgwgXZ7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3C27F200C4;
	Sun,  2 Aug 2026 22:32:17 +0000 (UTC)
Date: Sun, 2 Aug 2026 22:32:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Arijit Banerjee <arijit@effectiveailabs.com>
Cc: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee <arijit91@gmail.com>, ttaylorr@openai.com
Subject: Re: [PATCH] index-pack: speed up promisor link recording
Message-ID: <am_Fb79hCnwmRzjL@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Arijit Banerjee <arijit@effectiveailabs.com>,
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee <arijit91@gmail.com>, ttaylorr@openai.com
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
 <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
 <CAFwoC-7wUzce_XvuviXZe=5eTxJ5yyCpz=vsOheWKPCnz9Kr4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6mp01P19UApuZmTM"
Content-Disposition: inline
In-Reply-To: <CAFwoC-7wUzce_XvuviXZe=5eTxJ5yyCpz=vsOheWKPCnz9Kr4A@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--6mp01P19UApuZmTM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-02 at 22:12:16, Arijit Banerjee wrote:
> Thanks, Brian. I am not trying to bypass the project's policy.
>=20
> The investigation is in the same general spirit as the Git performance wo=
rk
> being tracked here:
> https://openai-git-upstream.openai.chatgpt.site/
>=20
> I do not claim to be an expert on this topic, but Codex appears to have f=
ound
> a material performance improvement of about 15% on end-to-end blobless cl=
one
> times.
>=20
> Would it be appropriate to treat the current submission as an RFC? It see=
ms
> worth trying to preserve the technical result.

I don't think the project's policy prevents you from doing analysis and
investigation with an LLM, although it does require you to verify the
correctness of the results and be accountable for them.  If, based on
the analysis of the performance impact, you write some code without the
use of an LLM that improves things, I think that would be allowed and
probably welcome, assuming it is otherwise acceptable.  Some
contributors will be willing to review such a contribution and others
will not, but it is not outside of the policy.

However, writing substantial code with an LLM doesn't appear to be
allowed.  The kinds of trivial changes that I think would be allowed to
be generated would be things like fixing spelling errors or adding
include guards to header files that lack them.  Of course, these are
also the kinds of things you could mostly fix with a small script, which
is why they are generally considered so trivial as to be
uncopyrightable.

So I think to have a patch accepted in this case, you would need to
totally discard the existing patch and rewrite it by hand without
recourse to the generated code.

I understand that the SubmittingPatches documentation is a bit long, but
I do suggest giving it at least a glance so you know what to expect.  I
think reading this sort of contributing documentation is more important
than ever since, in the era of LLMs, projects tend to have strong
opinions on what is and is not acceptable, not only just in terms of LLM
usage, but in how code and documentation are to be written and
formatted.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--6mp01P19UApuZmTM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpvxW8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ6NHStjjiegAfhzFFedCOZvYjlnYSFbVlAkxPryCN19W
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADqoAQDeMeIAyGbySniO7vl8ACc+GncL
jAAnzrJJgNGrYPIdVgEAyDoJblhfAzqAC9A5+xRurjB5zTQmqerftSzaZyTFCwQ=
=i5Wp
-----END PGP SIGNATURE-----

--6mp01P19UApuZmTM--
