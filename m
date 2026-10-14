Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E513480DC1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005803; cv=none; b=ejDZmgYi/Tvh/eOb+3ORNzQjwe25+4A5WDbLsqfRFvh2qQoWNuN1F1ATGW0fuiTNTQ84jzOom5kR015UgL3YC6AltBqZVnzLpYbP8X/qJW3Vt0EkBjln1yDPqg1GdLED/dcMnLJPlchcdAz7gYBToiXlKf2Z6+mmoJ8Iw6IYfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005803; c=relaxed/simple;
	bh=nEovl5o7DwYzIa9cvDW64Xe6LUfNrRRgf8FbJhD1a6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dd2UwzLh/ukRu67ctSvOO65ntE8BO+3Cg76glT28OeaGHvaKeVEqWWtKFuzyJYQKYAM6pZNU43JmWEVhaC4wioMUjHPNv91+4W4qn5FMUWuIxPP6fTzH17rrfkoQi//+9My9U6Qy1/dnpmpuJiW8RC4f/HbKE1GkGDjwaIFaL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a+1yyBOA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQ1gZ+IT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a+1yyBOA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQ1gZ+IT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BD2914000B8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:23:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 15:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792005797; x=1792092197; bh=nEovl5o7Dw
	YzIa9cvDW64Xe6LUfNrRRgf8FbJhD1a6Y=; b=a+1yyBOAfiy30MXeqXfZyA+NOO
	DtvaOVIowxjnuEnJCN5n15JCrU8yMo2n0h+mqyrbZ4uasUtLzK00Bv/LwP/IhdP2
	Okou54+xyznAd8sjXmktJvOXm9epPj7yuPusYgYG7G57wEmd1OhMMOwqZ32s+xWR
	5xbY+3kNUcfK+ejgX6la8WG4YN3spONbcgr19+iPS3WEbU4HNQLhwaRE1v4MrQ5d
	yGastQgSe0O0diHLcdyXi+U/dFcz5m40M3FgXLbRNhaQhE2Fv/qfUTH11RvizYj2
	Pvw/otpQt1O5UbrEV2e/rCVJcvmcYtNCg7MjmL0uZWRonOV+OJVfy3eC7ftQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792005797; x=1792092197; bh=nEovl5o7DwYzIa9cvDW64Xe6LUfNrRRgf8F
	bJhD1a6Y=; b=nQ1gZ+IT1KdB8ippDyOJzPuY0BxbKaBAw0mZAB1mfFsTfxuOCu0
	RIGNMkg12sJ73ZFax5YnFV7NpY2JoOLN5Hjo953aJDsoJsB3EuFtfJPb59lOOO2q
	fWWuYSEEayXaEbLjcODLPPLO+LqUC2lapvyM0MtkNj7Ti7l7EQA4g/5Fo6f2uCIK
	mXs7jvpo1LqtvWtxrg4UocOZ/AX3ZlharQ/OXmqKiOWJRM1Cdyg12tC7LpYaCGXU
	tpaxi3ixQTOMF6cUkdg7DEtDYHBtG1SrJRusUS1epbQsF30l+aNVTQyJmJt5TK1l
	7KBhr4shkVyTyxYUy7gNE9hqZ7hFEnriiAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792005797; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Wf8KFUosAVnZygFrvN3zROx4ZUIQ8a9KlLJiciN9nd6kusv
	HaOofJex4e9JZ6uFPWxawuW7zzDs7GPs2x95FaOLbhPHBI8RyITxzyThOKrvA+4l
	O8Ci/qUpIR/UyScHxzJUjTu+DFV3v/fwGNHt1IrD3Pht8kJZ8IT5LGqMgeNX4nwI
	V6vs11G74bzPtL76CNOFujC/RC8ozv1EBS4i3swPYSF6al5ngfJBi/TiSDkSvECS
	NA1UwVv2dE/Tqs2VAv/4Ne2woJ1cBX0rg48SQ8vAE2FpVTwNRyS05OKbDy9S7zyY
	CMpQxcaHlFdBsSE8kj1OzLtZLosKkGyqUJUxyCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:x8zTsuA2ztD/oXNc0WRaVB7kusEjciiMQ7u15Md4mqY=:nEovl5o7DwYzIa9cvDW64Xe6LUfNrRRgf8FbJhD1a6Y=;
X-ME-Sender: <xms:pdbPasIILYQ7UxP34PcrpzvYWwvQLsBTKcV3TPmSqQJ5Gv9MBun1hg>
    <xme:pdbPajDtDyc94iteGuSlanYPiIwL2ee2j1Wv1fdenNHLfLEEt2h9z-n4ML2tSQBxN
    rH_VxHPaDnKzsGyc7Qd6wcNk0x10Vq8hHm7ePPo-E2ZqtnG3P0J_zBE>
X-ME-Received: <xmr:pdbPalCwM9wjQTAPrq3cGHDfpUfR8BqZp_oV4hpO8eDjY17moGLe6LuFNENnjw5nWMwVBCOyV7AklfBxb_R8eYkR4ymAqede4KJq>
X-ME-Proxy-Cause: dmFkZTEfl5TXG60eh9424FhCTtEC+3DdKRjmAkAKIPVfeap56KWv2t3f0r0loosqq0PqUC
    73Ki3LmdcoQU+M8F7ip2rl8+dfHwCJ5+sr/B7TRLKxzWTIdCsPeoxAPkMHtep0NEdVST2v
    4ZkmXIXSZ8p2aZClVjad/QTE+LwWUIWSkNMYOvVvZJ+TZ88n5X8kKJQL+O/Kg/U3X0JR++
    l1zN/08tH0EwB1mwK+rIs6QqDV3BB0Z0xPsk9hwaQxLLv2lT5Ac8NNNZj9BvfEhrPW6dej
    uDFCrAzacY7EgLsJZPSAESXoKEndLNa4t4UkXXGUKEOH9f35Mowqke34tpT1MJBBlIQYIe
    d7shBlin6Q8RnXOWVYbiNzdjJcAgogQFasYI9pxsTQ3sTSMlDoKjZZO+vUVaPAFcy+LyZO
    TX9ui3DomATCfdakeRKEzzYWnRHj2E4TtzEOvKk760HLfscxmZZhPCT4wnQtYKYKljMbMJ
    LWX88jwpGpcH8E0COOKUS9PuXaHJJWpjdmHA4PKlCVHu2XwKMDleJ3H+rNbDqzBtiDuuJs
    gH41ViBGgjSzNlxnNWon+B+pOqbLkyWhvQIuPWMrj3A0OrdJAB6gDwJDUde/CuQV5y5c0x
    y2KuARFiBmpoPtKVChlUMnF3ej4XaGdy90a5qSwOYgRlUaXLLWRBTAE952WA
X-ME-Proxy: <xmx:pdbPalAcy6FgbVCI75X8ucmZPCvgAW03fRIfCs1T3UuQath65suNtQ>
    <xmx:pdbPagqrwA0xwoemCQ4-CXChyb-KiGCYg4rXQcH0ZEjYUgDm98dTKA>
    <xmx:pdbPavko6FF1uvwUUe4bKRNSd_IFvb0kxZhOrNxcKO7mFuPZfxUjyA>
    <xmx:pdbPagxwbn5jDJCQ3Dnv6FZiyM4oPTGxzHHABNdnuUYgrtyF-gaEkQ>
    <xmx:pdbPahgSLcUqw0yGf3FMMVtz7ZPIxu2ThfwwB3smlLz4xHuKaLh0hlWl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 15:23:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2 0/2] connected: fix the connectivity check with
 alternates in deepening fetches
In-Reply-To: <20261014181134.56220-1-iwiedler@gitlab.com> (Igor Wiedler's
	message of "Wed, 14 Oct 2026 20:11:32 +0200")
References: <20261014103507.35317-1-iwiedler@gitlab.com>
	<20261014181134.56220-1-iwiedler@gitlab.com>
Date: Wed, 14 Oct 2026 12:23:15 -0700
Message-ID: <xmqqy0c0qe70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Igor Wiedler <iwiedler@gitlab.com> writes:

> In a deepening fetch ...

The usual "engage in discussion before sending an updated patchset"
applies here.

cf. https://lore.kernel.org/git/xmqqece02no9.fsf@gitster.g/

Thanks.
