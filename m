Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A561B7FD
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271742; cv=none; b=JSujd7K77YSMFcLveJEafNYA5XUw3Z2h4u2dBCXlls3jV+Ukrv6/lsH8rqna1fyUERhhq0YSiPhSiPbXDpwzcWw/9PhsEDsRH2N7jl9qsiaBNlDAFZA3dl16pRUBx7vmwplvc5GEwUCpkgOJTOZDWiKGqrpT6xjrFwV/0UpFU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271742; c=relaxed/simple;
	bh=jk55ukkpGtu+L0cRA+BFKd6TWmX2N6oFkB6naU0DDZk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unUF28lFr2hy/gE/g+8B2IDEieWEdU3PzWe7+Q8XnYTGeLkHQ5hodmqaueDxKo+mTTUPdd0tthU3oekz3/a1q0iTodeKEILi94dYHpFbUCCyXGOM2mpsB5WMnLiI7HAZHMJ3j+Y2UTPdMMVG2fzn4q/cZKL+u885/AmjWDH1sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=U++QWuF1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="U++QWuF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728271739; x=1728530939;
	bh=jk55ukkpGtu+L0cRA+BFKd6TWmX2N6oFkB6naU0DDZk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U++QWuF1UXWH0fhiqTMBlNf4uTzec1BOHYK0Upe8MoI4IXm8XnQ/08Gk9Xohaq0wK
	 fXZtluQWC+rRerFG70ADe/ecATIsXZQZcJjqbFwCUVbAq44dd7cavWQkV1+PB0rGSp
	 Okc+ZwAvu8K7gqe7iyVR5RK5XZff7Tf86Z0QuZAU2LigBzyiEq+kTx66ZNeSj3RpdK
	 vZE47LnwYmnExwbgENE3LFrKJ6j1CF5P+GzFFm57g2iYvetngC12r2CQ2rHzS+3dGy
	 wWeCNNbFdFwz+0QdQe6okHxf+AAISh0+vIMc4hUvyjM3UEin97yV29Yvzh2xpqv6c3
	 j00hzjtQtbtVw==
Date: Mon, 07 Oct 2024 03:28:56 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <Mx9TmTS1dWiDxvYmluzhFOd7JikyhHmhluVLSYToYgzJhIWKsKUT2TV-FJIjUGKU6zp2w7KJJ2Tiz4kHXbi6mKg78FujZGel4Xx8iEEWgME=@pm.me>
In-Reply-To: <CAPig+cTDK7dk-BNgidQnyTBXi7dqQ1uZ91geerzN4aLtJyHkgw@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <CAPig+cSe0ykN=Mmb8Nwp112ROOCuhzzP0jofvL91PsVi8W4dHg@mail.gmail.com> <LyrqJt-X7sHVSKc-97V4-hTsDiIuz8ucEUMDtLCPWAN15k31EBjZnbeuJ2PldcCVvZaPyudvgb3H00T6uZQsI-XON7Ku8jNFjkfRCgrdr8U=@pm.me> <CAPig+cTDK7dk-BNgidQnyTBXi7dqQ1uZ91geerzN4aLtJyHkgw@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6ab5cc2e2dcbc187b63604b5b04492dec68b2254
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5a5b55a6085d9cac5b2c5f2cd0293c56edaf0d1bd40bbcea9d11cbf6544c6ad8"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5a5b55a6085d9cac5b2c5f2cd0293c56edaf0d1bd40bbcea9d11cbf6544c6ad8
Content-Type: multipart/mixed;boundary=---------------------2c63016c84ae162a11e2b7e94203c4e4

-----------------------2c63016c84ae162a11e2b7e94203c4e4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 22:26, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> I mentioned it because it made my reading hiccup, but I don't feel too
> strongly about it one way or the other considering that this is an
> internal function.

I reversed the flags :thumsup:
-----------------------2c63016c84ae162a11e2b7e94203c4e4--

--------5a5b55a6085d9cac5b2c5f2cd0293c56edaf0d1bd40bbcea9d11cbf6544c6ad8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA1VnCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAAw4QgAoHLiBcQRvoWPxABXnBO+HyIG0kaJKpVzxwBq7llU38TeygYY
K08ZO7sJLbhh+YLJN4+fCCFEemDSgpW9p+Vq0nfGYu2vkgHmnuwdb5puIR0p
s53Kq1Vz8IWzN73yPfUqLr5JyJOP71cn9NIyvnJpJLYmvhczoP17hVlVFtSy
Bo9/A15uldewEjrEVLg6UFze7htbb8TaHocSzQoshbhqn2Gfy64UjJaaxJz4
Te3dBjt5HDGibwUxvkx6c7DxYz92ZkWZwQU40qqajGnYaNuCaea21bMZgZvc
CjQT1/AqrlQaQES1WPGe4aA2CKk4r1v0Ay80Fkpqf/M6YjEicqSpfg==
=ikrV
-----END PGP SIGNATURE-----


--------5a5b55a6085d9cac5b2c5f2cd0293c56edaf0d1bd40bbcea9d11cbf6544c6ad8--

