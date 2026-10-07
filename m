Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9557404E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348589; cv=none; b=olRj/gnGuWl9NB/pw/e9qERALedgQ3da4plmRDMpw2+dzSVARedgOpWoxiRrmT2DzuISt7Dbny9T93S3nzgREN5RJ3AzmzI4Eudu9ywAvf7eZaYTBbKGRwbxa2ilohm5kCgcETy3iMPiHmbwTmvPZ6fysRYHRfX33zJKMj94NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348589; c=relaxed/simple;
	bh=PJjSeEDNZ/QiLhlSWMss6DJDUuOQj5q1CKvKnIPUNDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQolNxMeNGxmASj112FvgxjZ8ocGl+CCYRcsZMtV8uEFixknp9nWrQ/CRifFAewI2t47YlCLE7ryxbtSJTs3IdAN3MG45cd/bdmWa1b9UhxAvlkSkqgfOt9WCWHCMwydgdrGcRjpyNngWw3LZWLAKbmhH45y4d3nXvRh5xhjXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ArtRiw1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPynAUFu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ArtRiw1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPynAUFu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 01B49EC0295
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 00:49:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 00:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791348586; x=1791434986; bh=q3fI8vp1jR
	qAcMqcpbHMJJDvuh27A4PkZgK+abakIkQ=; b=ArtRiw1b2ZEiHFrfWknO1DOj8o
	xB8Qwbdj3K4jj06rmpp33b4FlygBBX0bC0fZ2MH8umG/7PtkjNfcst43YCT2CsPS
	Vs7wM78xbmXR+0SFDBA/Ds5QLqM6iytbIflApxNWfBdnLCp20qa3jF1Eiug6R8aL
	Vpgi+QRLhbTmdRAgh4fIS6MO4SY2iccLE712HOlYgGQgonhJ0qonEFMKYbhvG123
	RP8xvLwmD48oBe9hvG0SX2WWHRfK/b2lCVkN+Mwo+7BPLRrTtAuif75ie/IBPtpD
	XYR3M6YDw/jtLluY9Ph9ERlaDamBWjbGYk6mOVsrR4099y9e1R/uULjXM+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791348586; x=1791434986; bh=q3fI8vp1jRqAcMqcpbHMJJDvuh27A4PkZgK
	+abakIkQ=; b=JPynAUFuY02DSQ6G7ii1PhE+IvUQm4QcY8vGmMWDSJ3X4FumLgW
	ZkNWTPCm1JSTrretQfUY3a7t5BbfhiS/wqAVw3YJ5Jle0qN0c9KD/01sxMIFMFEU
	7rEEkYIDxbtzgKuXJ+Jg1YcbL+3PQFlq4UHjPR4cgaooa5x/Sa80XD7WdvQ8SX9d
	El0XCehNsGp1f/QCWNzmF9ILv5Z41XBW93Y6mYYhtOVgVjGzWx5BizLWvjZnfQdf
	lE4EnI4khkkV9dkLOXsocH8BEmKjgFYUqHhHAgnhscdotA5ll59Paw6NMzYEqZpp
	8HPmX/tjnbHdGdc46adq4m5mjTpLgDO/YoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791348586; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SKJaw5Vazs66/VAf5wxEWb8cJiKcaMabs0y77pmfsqpu6BC
	1xcuvnHyp6wPKvAydSLkJ/Z7/w+0vR7rDuIBXi2148OfQhRGYHZuf61wI4ECZlj4
	MVXIiowf1NazmgFcHkvmKiEYx2Ma7rwisV4NJ6rsXALoAil8EntXIXLGu7e6wI7q
	NRet1cYoZ02TxohfC/4PWJ3+yLMutZ18H4T7CXTxqlqWQWYGR8FDjvgMBPoIIi7/
	zvZODiO2+ey3LTKOqRb3xq3/G0GyRfrsI2630YbgJcNthy3FNXIfKnCxBGqPBhMu
	IboB5ctlS81YPXtITt+/rwzyOaHj3gzpnUzGMMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G0vNH6FnTWR3SvMaT6q6B8julApw9Or9Htw4YIG4KtI=:PJjSeEDNZ/QiLhlSWMss6DJDUuOQj5q1CKvKnIPUNDw=;
X-ME-Sender: <xms:as_Fai8NRBZ2hQlGnCQJJwO0bRqda8h4rGU_Fbe0NATfroVSlUPqEw>
    <xme:as_Fapm9UqOgN4nhyFJ-kRCNyGmXZFHlXv9qMsMjd7Ysb5HoTsd9eC02NBH0ZYitJ
    QZT2lUE2aFPetHjLO-LN6iz7eVZdLFhUhV2DzoQ9y6vCP-FCCJBZw>
X-ME-Received: <xmr:as_FagXDsPpLx5DhaulGd7HqwfFsSwFwY_EfHQlQBn1DPkuWK1yfX_iB0bAW6Xgq3QMZ79FIJCq7DCy0fM1vRj15MitB4cak6MEhCv796IgeURXJ9QAjJNo>
X-ME-Proxy-Cause: dmFkZTEP1JeXzc9WL3wDPsuvQj895cE5ToUhKDonBCnSWMwVjG1/obcfKbdik5TS4TcORS
    +0lCM6PusBm6r+KPNyR5mfrKKutG702ZKCHXW/beaqnHcPL7Dxyb+PJGW10/5cswDyRqfa
    XxsYDwPEJp5px1DilYnlhLrhW+rQUS2SgrKZGLiUQhW0etldy7a6USdKFk+v7t4f2X05W8
    S3u8g5CueywoOwutnqsP71DpbI8NCPdVcO9YqAKrYWADsPfk86HkzUKndVwEdAE/7wmHQT
    PJ1ieufU4c4Gp0Ux18K/tq1hZJh8vUhq6q2u6Rpxcn0gNrULQwx+jYiHKy0swDVZ0HsQuH
    0XdhC5dL499LJ/eOJoCgb3nB6DtNj5o+j5NLc/y3R3vyO167sxrJnC0QNppt35wmWvfpS0
    y5Z4zN9/BRc0nn/Ul3uCvzW4FqnwXX46AKYy0wXhQeOpL4TuIgw3Oo8E9qHXSCIB47PM1p
    hLJptnMVTqWxhCO2Ftbc5FQ46GYjywSpqmfeKscjcu81TUaM3fBw7o5UplDoGnKhauY8WX
    iiiVIW35RB1M1KiEAzYU91CPKxzAIB115Zvi3jH8v9BlRS8I0IuDubI/r4+yHK40brG9WN
    qwM6d3MHJAcmaPc1oMW2yAsRU3m42Ux6lORroT5dlesllBp+OjyLTRXRtUTA
X-ME-Proxy: <xmx:as_FamGxtjCPEMC9Hsu03srCHt-Lw-rbjC0UXlbSS1PUmyW5vGiFng>
    <xmx:as_FakdpqLm7jAtcsOTSBXN-oQIFd_N3WXvr8OqYO_dwVNHUP3PdZA>
    <xmx:as_FavL2uv7DV6vpk-xyEyE-I-Q0ZOdgrFPaZz2KlKTogwpl4cQRRQ>
    <xmx:as_FahHZyUgpFRuq0Qgmxmnpti5ofkndN7Rw8jsjVoHXmqZI48oYBg>
    <xmx:as_Fai1_d6PDzTixGbHknsoogzAhEnXySC84SHPK-rhaMs0CrPiBq3ZZ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 00:49:46 -0400 (EDT)
Date: Wed, 7 Oct 2026 00:49:44 -0400
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [NOTES 03/07] Documentation
Message-ID: <20261007044944.PjN-Ln9E@teonanacatl.net>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
 <summit-2026.94e33e9ddf234334.03@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.03@ttaylorr.com>

Thank you for the nice summaries Taylor.

Taylor Blau wrote:
> Topic: Documentation
> * Peff: We support both AsciiDoc and Asciidoctor. Would it help to get
>   out of that dual world?
> 
> * Patrick: Traditionally this was for migration. AsciiDoc was thought to
>   be unmaintained, but it is maintained now.
> 
> * Peff: We could move to Asciidoctor.
> 
> * brian: Fedora still uses AsciiDoc. Asciidoctor is well maintained,
>   written in Ruby, and reasonably portable. It depends on how much we
>   want to support. I do not know whether Fedora is still an obstacle.

The Fedora packages have used Asciidoctor by default since
e942c8d (use Asciidoctor to build documentation when
possible, 2020-02-25).

    https://src.fedoraproject.org/rpms/git/c/e942c8d

That hasn't changed since I stopped maintaining the git
package, so Fedora hasn't had an issue with a switch to
Asciidoctor for quite a long time.

CentOS Stream / RHEL uses AsciiDoc (with the odd exception
of 9).  They _could_ use Asciidoctor relatively easily; it
is maintained for EPEL already.

But if Red Hat really dislike requiring Asciidoctor for git
builds in RHEL, they could ship the pre-built docs, as I
used to do for EL-5 builds due to an unsupported (read:
ancient) AsciiDoc version.

If we switched to Asciidoctor, it _might_ open the door to
replacing the docbook/xmlto dependencies and having
Asciidoctor directly generate the man pages.

I haven't thought about or looked at that in a long, long
time, so I don't know if that would be a worthwhile change
or not.  I don't recall if we need the XML step for other
outputs, like info or PDF (neither of which I ever spent
much time trying to build).

-- 
Todd
