Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFB356757
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394695; cv=none; b=ChRcHQ3/v4ExZSki/RuGzROKNH8k5UzYj9GOLP1DSdDgil63ejhvIzdqdfvNA3FAYHe6/SKGn29Nv+S2nRv2aYSa5giAQqF7mOs5vKE9oBsAkXWattQuZFzsDuXhz5FbbXD6XxPktSdRtd8Mzc8D0Th05XiYt/JZTfwGH6k81vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394695; c=relaxed/simple;
	bh=VHkyt8J3eePP8MbMXSk4Lx46HaheDHG5Yf2rPLyWMTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q67EIP+a9fwRYwDQbVL3nfMbTzntOPUAx3Rf85/1KcBpGn69yb2PcdRjnxF/U/qdGmOckq9T/5zW73FStlRw9CiyH0r8u1/goU2SiL9CmZycvVfrFbpjhqmOFHWw9g0Xeu6H+teoNqecw0z6CGQxYYdVgGtLdAjLNVvOzuL4Y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pl9myGlZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAV215Q4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pl9myGlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAV215Q4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D469AEC042E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:38:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 07 Oct 2026 13:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791394693; x=1791481093; bh=VHkyt8J3ee
	PP8MbMXSk4Lx46HaheDHG5Yf2rPLyWMTE=; b=pl9myGlZhVJMeV/+li1zpeBn/V
	bvZqklEfF3RTNxb4wc1xwIG/QscRdBI+Q8V5fZV8ni3XHmgwKU5Mo5BLZLynAW+D
	TEbnbVaW71uMFl/FjefN4txy4P/GGupUOuPWvbxwq/OZlhmx72n9atLPfETjDZhx
	XfsjYURYiJ+79lLGpMATwTWzbr0Q9II7qzoMBIlIlEALDX8bRnkf8cb1ow4G/NAb
	Ppe93kXG9rREDfCFLjjxyiQ7G73lcBztDJK38LhMCm4cQzjBdme1JeEOIcknC6Qk
	Yg7YCspeq6mLFCIUvPK2qw81CFs7pqJY1Sg/0VhRlf9DPv+UtD8dQpkibibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791394693; x=1791481093; bh=VHkyt8J3eePP8MbMXSk4Lx46HaheDHG5Yf2
	rPLyWMTE=; b=KAV215Q4JV87K8CRsCtKYp6SJGN9rtudxQyNHp/YVgvhY5dC/KH
	h6VLyMaMnttMwuHVNJANiYKmMxqhS6Gaz859aGuRgxz5YOOb4j4y/aWEpDz6HvtZ
	z0x/UF5uh4omqQ98iu95pIkLmOyPCNIF+nGcnPFsdS9d6BeIv80wfDB6G05VeOBo
	UbPYSKqTzf11733XgQL7jNs0RDLN3ARVku41jMJ1PgJPv6RfZvLe6TxV9lM7ZLJz
	CK58rTXRMWgNtDX+JEcGVjJdJ8xEVNWa4Chz4kmEqwGrUVmU9+ZllWGC+mHU8wjE
	d/Wdj1vpf7oYU+6K0KqcYEorKBOfdZM+HWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791394693; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:U4fxxF0b3ga+/OeclPxf6XPpEwYB/2g5EphD4HOB0qCd0Tv
	8YFIrDbDOGlKVyQF/w3X2qWAcqUHOuqmAJGVUEp8MThVbx94p+QAZcxEBLYiVzzq
	4+qSbnQLy0auPwTY9pZ8spz0NFcFmr4JgagnvVmcWUYjMnC6Ry0GPSQN+qlA3G+N
	i5EsHu9nIc/d+NN5Aab8gx0TZGvoKhi3Yn4DSJtQkyTzVbEObgjv2PJnKPgv0UlZ
	U96fdx1oeZ3YEUeIq1+68h7kpWCXzxxJeALwY/msoh1vuJVM5OmGLZuUadI8b0nm
	DY9JpeAXNCUXY4aduXPMHByO+6pKrLM3Dl5DYKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Eam/0ClHZUF1M1ETfv3WO+584ouM4u02t4jutegd7/4=:VHkyt8J3eePP8MbMXSk4Lx46HaheDHG5Yf2rPLyWMTE=;
X-ME-Sender: <xms:hYPGao9nOpp5tqzDOADOzsjOtjGy1HobUDlrmpSKZihWMIjIjYVO-g>
    <xme:hYPGai-WipwOknQWen6a51p45d1rN-TVX3wqIuqmwLT53z1zuz-v6c6O8huf3-Qci
    OQUMh91Muw2M8X8lwGMIdxjrszOulPVyUugTK_ScYPQ40Ks1Gt22Ni6>
X-ME-Received: <xmr:hYPGagQIiErbvxeubFNfZKa7qt2MJGRgemyzR-1QB4p_X355cmFAyfISGVdhCfv72PDJwUBP3VT9HQ5CxFMMdNXMmk3HEUxa0aYZ>
X-ME-Proxy-Cause: dmFkZTG1YuC3vg3Hgy+7xBQDkL/gasF5BaMPgcYIPnTZpZwKSceKdVNVsVk++4nQtm3KjW
    72ueeR/O5OfTd3nXpCDroX/M5I1+Zd7cTASw9IKPNQuZzLfWlfYYQZO4HKmMIjFfAoWRkP
    DADjOkoosPR7rcpAahmXUju/fxjDIi6kdQ91OOrmBv+jK2QpxpexlepdKCSc9NZOjxqA6a
    HfRLvJxx21nd01d3uJrD0g7yfI7c3aSevjpiQe8gbWHXS6/c/rKC9N+0B/wRD1X1HcvDvo
    rMzkHPd/6LflwUqH/TiW+I6PTjRy/EKPNeieFdo1EBAMDaVZ+RqASTmQNH+XoBPTM2JRrg
    pV4/99jQl3sO3oaOgWv0Tw6trOPLrGmpJDzGxlUgUIlMLtYfzy0cPV0sr6TKByNaHEmbNU
    Y97fYHGZhxHTOFAsyz0mho0TeUJAkm1PPd2tpLMY2C0ofF+UNnpMvD8pCxFTRgunCgYAED
    RkJS69B9bcZSTr6zTsTUIcESEcbPqOEWq+/DKXyzx6lMR3vDi3V6uYzCU3hBAL5rTQv9q/
    e69yVxWf9GwdtfqgGGdzIIsl8ipcMKce44bJy7aVGaQUyt9waKxhYJrgo21KiA4fxpZbal
    xAQTcMmVPwI4FBfz/dxpEZgY2pWvnG9Yi0lJfval6XA9oMpx60e9IWupo4SQ
X-ME-Proxy: <xmx:hYPGaudvfl25F-naBoEyz8s9ViYSnD270fszVCxHyArE074iIMNKJA>
    <xmx:hYPGasADCCqNKOTo7IWaYYgxATtg9J4GwEiC_d02E0-eDHVr-dTUwA>
    <xmx:hYPGaol4FWBFtad0GezSOjz7dsIs6TwOovn_ktI7fYDd_dZEVBay6Q>
    <xmx:hYPGavfDlZM6kHZ69HYBbLTFsNc82g668suT4WQqna5TyzR4ktKMnQ>
    <xmx:hYPGakJ8_9XjF0IqSUmXbhHtD43ZLz6FsiC7ELaQFVTMu9n4XptGx0ru>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:38:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [NOTES 03/07] Documentation
In-Reply-To: <20261007044944.PjN-Ln9E@teonanacatl.net> (Todd Zullinger's
	message of "Wed, 7 Oct 2026 00:49:44 -0400")
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
	<summit-2026.94e33e9ddf234334.03@ttaylorr.com>
	<20261007044944.PjN-Ln9E@teonanacatl.net>
Date: Wed, 07 Oct 2026 10:38:11 -0700
Message-ID: <xmqqqzi18l8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> But if Red Hat really dislike requiring Asciidoctor for git
> builds in RHEL, they could ship the pre-built docs, as I
> used to do for EL-5 builds due to an unsupported (read:
> ancient) AsciiDoc version.

FYI.

The prebuilt docs I publish, which I presume is the one you are
referring to here, switched to use Asciidoctor in mid 2024.
