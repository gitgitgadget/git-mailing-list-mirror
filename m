Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30321274641
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985708; cv=none; b=RZLmYGwDLh7r2LgwkG6Kypetzr3d4HHObM6k9dwuNvsdw6idnyjCZqLTemnAPJ0WaTTeX5s+IljFIRndxnBMUfdRJneXG8l5kF+YfRFsfGZymNdo9wAu17xdD0dAFOpEjTLpz2RA+5Qe/+p3dypH9bPlN1teWNKwBm8xNTL0ZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985708; c=relaxed/simple;
	bh=X/napwSoCceO7uRVvdxKdh1vG7IjQ67kVzJmlTFmYxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hQhYesCvkehY0zpZvLsEqIjvWb4kcTZeR7yqetsIOKT3h+AX/zYrdJpXf2U2jiS/pdjWhcmBQ1Qpb/BLInjJxe/a9IwZqNFlgP9GCdc0E5tvUgcle2bmzIFKshirTmE3RlijahTX4RrDIlujZEk3nsOVA75nNwn6UCeR8NEuuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=caksYkZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/GFlfJF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="caksYkZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/GFlfJF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C6FE6EC01FE;
	Mon, 17 Aug 2026 12:54:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 12:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786985699;
	 x=1787072099; bh=xqO3q/HNLAKXmjN8hq5DWKo49YxNlTQBmha7ox5ATKU=; b=
	caksYkZmayjVmgk++KzYc2nelezInjIPxb3sYO76+nnNLsOKZPSVoW6Y6fKfdQlv
	QrQYae4eRjNo9tcoB6q6kC8JTnxtCeNWyWLrJ3GGO2iadP77TI5hVjOnIP6G3oum
	P/fBgPW1+h5/Vt0VED2dgHovj0cPSguFrQwvfpeFFF8mzOnwL5LjG1vWpXk1n0Oe
	ofFy8EVHxFiaoY0AP2FywNhrzlrRa09f3vSbX1ejkmA2s+tp3lEzdA0R523PaY6A
	IeFUwNMwgX6zU7PedAKdy+olv5ujLz9+LG9uF9vczNC7pyxGiMVbOoiHbbVUEUT7
	9tNjMjyylb0D1/9CINa2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786985699; x=
	1787072099; bh=xqO3q/HNLAKXmjN8hq5DWKo49YxNlTQBmha7ox5ATKU=; b=h
	/GFlfJFN6DhlmEbWWWQgfw7kJu1sSVcu/oaEEGQT0oKBgraw3TlgUCZ5MYsfeTE1
	1g/wc1RZ1IabAJZR4kKUFaqyBsdWCm/l3zW1nnD93KQvJvCBSFf2zSCXObACpxBn
	MBwGnfSFzQKcZ23+hJepFBbvplWkmenf7woyadThhMrLlAHnm8BeLCL0AL/frPVU
	m4j0h/ZAHVxmskD/SiMAPGds84x9c+cTRCnBL2NZjCF129FaVz2qfD/QlEDCAfvN
	ed2RMbPIU5CFVy73uCiNrfP+6KqPtLm846DbErrg6RIIBKm3kxZD5e59GqPpSCf0
	bxyVOuGBpCG3Xrmefri2w==
X-ME-Sender: <xms:4zyDahOJ77MO6D8pA4kEPOZiC9ioIT-UR9kbhj34I4yLq0MMvwxYww>
    <xme:4zyDarZmelsK8RrwmlWOdyaLBm4NPstIr8h6ZVrkqCszdAbzYD_vNPyJRwgRvwa6Y
    WFxTdMj31E6Kpn7LSQQQ_EnCQ01nXMukvQWEv8p1hoapaLh12F9Pek>
X-ME-Received: <xmr:4zyDatpHq6PNXDlkqkeyYYVydI1NNX_OjRAe77y6i8mmeYTPvJP-yiZMdhddV_RL8TNh-V7D-w8iblFbeDCRwH2f6x5XMymAwQ>
X-ME-Proxy-Cause: dmFkZTGWYCHBYTYXj3ua9TGG5oz/yXDNca2KVmKvDJd1myR7DjpNwONNM/ihw+PUutiNWV
    kgjJSGi/7KqjU3p7zO11Um/l4r919LjL+ZuP0g7i29rVEo/UnvIK+YIH98qabQpgEVLrrP
    TT+7/nmXGfqP4hJ5ipFdbIArN6r0xjG8HlOnjFiNtWw2jsBsij2z2J84+2yP8Vdv3w3+d9
    GoUkouotyhkC3zM6fPLjmSgQdySG/25yExlHgms1/58p0Y5XCkAFID6piyDlD4nhtVbUVv
    gljx1Nkm+PYBFIyAnOSmBopDs0vNuSTtlfHTxUqessV+QPvIznReBJ/Awy7OaQP79wvuNT
    Y60qiKS0diVlCw3zzAkfCn7P9uNS4n/b/NjyN64/AniOSF2/iqsz58jXtUqqMWbMZ7DMLj
    jO60stXDH/B/u8APqTMYAMKHq6CcQMiGohRIhfRxKX0kvFWi/gBpWBWzUHLVFJvL8ZCTUp
    onmdpAGSlEfo1KQ2WbRzaRo/sT9SsIM7t2dNUP56pKpq0dOIdg8aK8P50UwRckPkKhuGSC
    gaBFRlB5LwK/MCpmE6Q38oLCc0Fk1aMLQDUv5XeuJrUrRvJqiGoqPaD1rpiHJH3hoT5YIB
    yGE258DjWSq8/yJv+qYSnkIrAqejKqalv1i21VlH/ai+sRjr+uhY1RRquTMQ
X-ME-Proxy: <xmx:4zyDanb3PcRa6f0EkXmvoNNhTumgOgLLlC-yZyRrTYr1R4hhoA_CyQ>
    <xmx:4zyDatTc3xlhWG8teQb6E03Qfv_kmX7C6wV0oKSL1h4CWjsx_yLe3w>
    <xmx:4zyDam7_uJo5v_Y-yhqNE60_pCLZSfYR_dPqFprgaDl9zQRqPXotEg>
    <xmx:4zyDaqyffGFvlgten5Yj5fQbdUKyLGp799JhVh1_PpzCKo9zM4yWng>
    <xmx:4zyDarhnbf8Svbqzij-LJC9lWgmHrpiR52yjDjUHl9Oe0BTIAgA9EM_E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 12:54:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] format-rev: learn --abbrev, --color, and --date
In-Reply-To: <0bd9c642-9e88-4c82-81ee-20fdeb3c2797@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 17 Aug 2026 16:48:54 +0200")
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
	<format-rev_three_more_opts.b84@msgid.xyz>
	<xmqqbjb4ktz5.fsf@gitster.g>
	<0bd9c642-9e88-4c82-81ee-20fdeb3c2797@app.fastmail.com>
Date: Mon, 17 Aug 2026 09:54:58 -0700
Message-ID: <xmqqa4qk661p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>     static int format_nul_cb(const struct option *option,
>                              const char *arg,
>                              int unset)
>     {
>             struct format_rev_data *data = option->value;
>             data->nul_input = 1;
>             data->nul_output = 1;
>             BUG_ON_OPT_NEG(unset);
>             BUG_ON_OPT_ARG(arg);
>             return 0;
>     }
>
> But this does not have the `NULL` deref. problem since we just
> unconditionally set two boolean values. Still, for readability it’s
> better for these two statements to go at the start. Since they are
> preconditions. I will add this as a patch/commit to the series.

Yeah, it would be a good idea to establish the "validate before
doing anything with the parameters" pattern.

Thanks.
