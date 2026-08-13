Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E911419315
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653088; cv=none; b=pRtNss4VBiNfjZR6B5C8PvBs+SQCa/oVUgUuWQrz1wi94IawThhHvrJ6nfuFIajdCpYIG9I0WGKkFldzfRWD8O2EYb8NqPQH/xh+f1GvcT29C5UPCWRoQrxEYt93kXT/SSyhHUq/sBE5SBsL8wUastjWJiy9Gs3If4AwWHkCukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653088; c=relaxed/simple;
	bh=UX2+lcC5GxwzSzD6M7gI4XC0TnG3N75zGg/8UyH2qTo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lq78NA0KjgVZsAl0x0MpWpxpDiWHQnX148hgCCdncGF9EySHO6YQYYhkF1whdq6o5RgVR6vamKj13/HAzQa7eKWtcrZDnmF57aJvxeazu8jgXlVWu6cwqlKwMXJ9XqbbFjgPpetYLIYeFSfVfGW7U7nmRNGUvA7cY/wT4OecUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LSnNgbES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FUg7BnId; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LSnNgbES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUg7BnId"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AFD37A01D4;
	Thu, 13 Aug 2026 16:31:25 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 13 Aug 2026 16:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786653083;
	 x=1786739483; bh=Iu/YW09UcXdMdce6zddVDBDsalHOp9RDIR1PVMe18EQ=; b=
	LSnNgbESMiBNOElCD/uay8DS/vcmfhH2OGnTjrXWS0bRV3pOIt7C79jhyyUr8LBZ
	x+/A0B4LFx+sHv1JOi6O+9DdUpYFC7V7Z+q/yjQKBtVpt91OmMH7Qkh0seR+Xl8A
	eONYi2ySml4MLP/vjhe3+39mW6/Nx++oGpEle9OYm3z0JDvcjjRfLvj10f0TsXjC
	pkuV9g2qF7CZ4aflH6fB/GQy7MrHIj31QZiMMoD74KUbCVFaGM2mpcCTOptZPiW1
	5UeRjZGA+ANjqpyfnmTaHLRO5o8gLpWcnr8I+o/6m1Jg7DLFj6CNrRSQSP2DBZ+k
	DHL/hfvDjRGbUpI57NZz4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786653083; x=
	1786739483; bh=Iu/YW09UcXdMdce6zddVDBDsalHOp9RDIR1PVMe18EQ=; b=F
	Ug7BnIdXCy0hlPTpjONqORE3M+6yI15V5S99hiS/5UIzjKKjHmqF7dA/sIMwZDb3
	FVmGtDi3yrec9LpM0IpsqL1W078H44/7rVkKt7WlF1Tczw7cMosMvhcfLfNDFa0x
	NSu2Khcpi8yd8mFZMrU4Ge2U4awtfamta3/dgH7B6w5dm4M96thnUAkdOiSHrqBX
	6886L9LRR+j82lh+wIX+6ET7wyaPc1RoIAcQPhBoIoAedLF1z55FeVNs1G/zahFT
	DrfQMLA9NDFmvhTp2Q1doTVidBM6wiuowaB7VVLuO/ZV1YUyhPGa9p/MPRPdKkzX
	+Ny2goCzPtRd9U4p1Kj7A==
X-ME-Sender: <xms:mCl-avWaV-nc68_f4qnrVBI25GWiW0DJNfkaQPFN3mh7_AFr4WuDvv8>
    <xme:mCl-aibs7zqseLkUxywmPT8NeWQllDE1tSPsLnnjNKH4F7mU6b6ktvjDsT5OIYGX0
    fc3Q0mWO-Kl59LY2M-Eo0VYOWeFZuBzexPZc4wIrmVgW98eQl351Q>
X-ME-Proxy-Cause: dmFkZTGa2ORkkAjA3++rQlZMik250aoo2+G6VyETHqbLumkwe6kcsdP33oOX6S4z8U46s0
    K9FuWtTU+/rUKKGZmDsb8Y1I8SRkLbY6CjlMtk1HbgzqH8Y8VOSOot/aO+tpUvPPycGLXn
    5JrlHyNeK1gG316FaDDzqb3PT8RJi0HXnyTu58hWSuto0v9OM/vDvqYAKGdowl/JCi91H6
    +p2nq5GfIaC1p/UxB9GYRdY1XTkdamYM2zctHkxLOBQJ3igTz21j/nZLECo6V2IgJr/1ac
    0AYLLSaOJQ3J1VX7s+5APQgy6+fsABLaL9UVv3h6JRMhTlkcJyojuBPyU94uhu98zJTZTg
    c6OITmFsYfcLDmAM/Vb4woy97NHgt4nrEbLlCwUwNHsxzijnddG1BkNvFNcAqEnh6VUh8U
    jo8aQ6q4d4FX1YmCejx3CQXx5GmgpxktiJJTfoXdBKPfLP3XP27f49rFLV4B23OnNIucjv
    bKqfsWzkVq4WW1x5NQnPjnI2rVgKdzptlcu5sbMwvu7Yccfw0IfhhQFgk2W6HOJIJbEC1X
    hVWtaUDcP368DTTBVTvH54vgyYaWNv15uKH28Vbmx/CUghZbAjuMtTQSk7NmbnRr/giP82
    wR0TUq14VBJEs60XTJCh/ephDT96HPOvmkYSqkv6uuDkg7+LK8p/F74eprsQ
X-ME-Proxy: <xmx:mSl-atC37JGxYhAfzdqUfLShGOz2K8KusunDm_Iq7eyUCjt3CZHeYg>
    <xmx:mSl-ak2TnIa3td5DVvn95bSeqze2eBBM6qK9jznRt-GzY8JbnSey7g>
    <xmx:mSl-av20c_SCat0D-SVGLC-8InypZC5JmhNFqMrpVQ-Uk3fby4GTGA>
    <xmx:mSl-apB8S9hgGcW26EVkjeuvCM8HhcQ-EWMi1QeLSNotpWGFnHgSFQ>
    <xmx:myl-au0Af1Bv2YIYTJUcN06LJqDjA8gPD7krwWu_h7589WRYMQ1JWjIf>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F0D9B22C0072; Thu, 13 Aug 2026 16:31:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 22:30:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Vincent Mailhol" <mailhol@kernel.org>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Philippe Blain" <levraiphilippeblain@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <bd3707a8-70ad-4308-bc93-5aad84e028d6@app.fastmail.com>
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
Subject: Re: [PATCH v3 0/4] completion: add support for 'git history'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 13, 2026, at 21:05, Vincent Mailhol wrote:
> This series adds Bash completion for the subcommands of "git history"
> and their options.
>
> Patch #1 adds the basic subcommand and options completion. Patch #2 and
>
> options. Finally, Patch #4 adds completion for pathspecs accepted by
> "split".

It looks like one line was accidentally deleted/blanked. But I think 
it would say the same thing as on v2:

---
Patch #1 adds the basic subcommand and options completion. Patch #2
and #3 take care of the value of the --empty and --update-refs options.
Finally, Patch #4 adds completion for pathspecs accepted by "split".
---

Was the paragraph reflowed with 
"#3" at the start and treated like
a comment line?

>
>[snip]

sent from mobile
