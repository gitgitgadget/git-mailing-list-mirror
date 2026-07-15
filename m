Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFD370D71
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078230; cv=none; b=mLiK29OORIdHFZOwgXU+VsxwPcZuS7cPOXZbBZYQMDe9Ohs4SEPn01ytiwUZBcuGcUvftX/VDrvS8DRPA/u4EvSND9P26hxbgdiNHgqxRpIcLCpkICt9J7IdOjrmrgBlUii8CfhG7ycvjqkImP9yGV+x9OzN6mzWIdMRLNiepN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078230; c=relaxed/simple;
	bh=V99t5TxdXXAUvdT+eMPTi54KhrLXrI/GXnWSLqpw4TE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dkwE60PRVJodMhZL/9QkOcgWBl5AbHb7BiRf8t7WYkZwyKUnLdrZisxHZFwsuQxWPr1SOH5j5gmGGB/OYhMbOruNk2Z+gYurvH93yvlRfkHtoN0sR73oo8mycW3vwUE3kw2yGJkW/EsJDFSf4YSIRCQoHGb2fx0FKFvyNcD+b54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=udSODxqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4LNjxOr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="udSODxqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4LNjxOr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30DA7A012C;
	Tue, 14 Jul 2026 21:17:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jul 2026 21:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784078227; x=1784164627; bh=rLJ2K57Hhs
	7u3GXq/89IxPuJKcbzCAVYqqdE+fkWV1A=; b=udSODxquVi/KObpluSSrNXIELU
	pxWlI1bwDpU/GZZpn4qn3kHmiAIl5+Sdp7ozvtHnnEVc3pFJm0LG6gfNzP0X9oaR
	CQ5VF4KTVqj73ds1N44iwVeqwTNIXJ0T5w8SYnsJ1QGPRJkZhxLtVlxdMc5BUxGu
	Aei/yDmDsBw7C4xPcXw8bUCDrn8n1aDCB/yX3tQvco9JCL9srKDGAuBtevxm3qUN
	2ua9O4yGnplT7VumWOkOo18g2pLnYqbYBuNx6gpBbNJHi69v2Tkk4AhJC582SNA8
	1WrkU1PLha1rmKYx2p6ouw4HrkclSNsz4yHn+8ekhi7oBLa1lkA+XskjJP9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784078227; x=1784164627; bh=rLJ2K57Hhs7u3GXq/89IxPuJKcbzCAVYqqd
	E+fkWV1A=; b=d4LNjxOrhgWs3k+UBI8y/iradsyoF6U4rYar926ZZlSl3vDqnMn
	KgXz6aOmQCO3CpmRwfR/u8LcziljnwZ81qktOKEWUce9+08rFDem/pHObeCDRb1n
	FWzVkvOeatCIR2UWtFmStOwRveMIQ3PmjoJAWO3ZXRCzvmv8cHZzORgg+voSf14R
	Bo+TpHfzWkOkX5FKoirmbuJsJMaYIV8XeRkzvLgkmHdQkspQKyXa8qxwFUES0+EU
	d8tvkicGUhW+TvL+1Y2fn5RKBfZChDAF5LtseSp1S1pytSMk6K2glXgsHzXbS3Fs
	pa66hzPRq+ia7VzHtdVapPH95EPyDOA563Q==
X-ME-Sender: <xms:k99WapGN6_3AWzRrqaeLdjN3jGac6lckyQFkcx9QCjR52RsNWN2SDQ>
    <xme:k99WalVNVmG3REDnzMgSTxLrfxODaU_SXD8sllWt_fJy1WQhaQLey2Tla4hxfyx-0
    9VBsYtNKZXOOpVlIGePspMX06LA6BIHCf-8jjzE64J4J_0v-romaA>
X-ME-Received: <xmr:k99WagJZf2kCbYm_TjXAcOWA0X-dH_Ob7Dd98KPTEl2Mw1xx7o0dx1q3z0hJ1m6r1VUlv5MIdI2b_p5CKO96s0YWkq5ijfyPXCRgBxw>
X-ME-Proxy-Cause: dmFkZTEbJk2hcuy/EilNNnuDP3xPBEin9U5wGcaUTFcov5qPC5xuAq1f5MF+t4lpr1h7WK
    LvnDLmVT35ZoAgz9s7KBYrEivZU5tyflgVCG0cKldAxgEHjdhYCS4HPWUB2ev/c2RW2ubj
    CGmets8u4jJrhJFUIC2hHtMh0LfTSUygBVgFP3cSMSW0MS/qw8nY54ZzB2xDzSH2w38tBJ
    ts134NpYwvBxfsDf89t91Jklc/BmDSttfYC5K0hfZAZZ2tS4ATaHvG1QdA/Qdxo0aS8Dtx
    UNTYx8iwHA4dV/yLcLTjeGAnSmA1IAK/wKC6an5uWRu9tdrj93v6X5aXIlODP/a2l4kcS3
    U6oImarCsPzf64/F0eL4WgrKNgm7sK7thT0+eN2vo9EjQuQs0vXJADgrBnhZvygIbuxeR8
    mkC0bXFVB0Ph0Qy2Hi4/nHgoqTID+icy51a39iMGoSN34PX5XvMF2yHycFDRMaBeHQVnvs
    9ACqaJvYG9KT2aeX43Ws9rSsrXa6us3XgxZmiNLBDt+L3HU/IzdDrky43TsxVCnCc6BGWk
    ZsiATWMbJ2algRXIAbOdJLeoWyV2nfA9daGUfgtv19g+LPMToK6R2COZZsnO9ukACtyHnr
    g+rSRmJk+ULKmJ2PL8nL5sBkohh7tiPEh+CcenivlMK9FJcf3HPSoUk+Zjag
X-ME-Proxy: <xmx:k99Wat-_KPgRXaPEVIAe7R8rr5OqzgQHNzAWmzzw6D6FlabvmArsnA>
    <xmx:k99WarJBkTYk317x8cXBYUc5Sl1bP0Ri1w3kH9f5qj4hCIVyJHfyCQ>
    <xmx:k99Waqkyjfc5rjkFde3TJwzWyzDTkRnDvgg8a9H6aSX7cOWGqbOC6g>
    <xmx:k99WanN7WQz6arMdeBkdOacAa8ZHejVPfauuuU3ak_ffqkg8b47IKQ>
    <xmx:k99WatiSql02wiFnYGBFInYYNZFjidK9g4VLGCDYKWmcoMpNCoFcsCwm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 21:17:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] bisect: check strbuf_getline_lf return when
 reading terms
In-Reply-To: <17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 14 Jul 2026
	22:48:42 +0000")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:17:06 -0700
Message-ID: <xmqqh5m1qcfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 798e28f501..fe66d84382 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -498,9 +498,15 @@ static int get_terms(struct bisect_terms *terms)
>  	}
>  
>  	free_terms(terms);
> -	strbuf_getline_lf(&str, fp);
> +	if (strbuf_getline_lf(&str, fp) == EOF) {
> +		res = -1;
> +		goto finish;
> +	}
>  	terms->term_bad = strbuf_detach(&str, NULL);
> -	strbuf_getline_lf(&str, fp);
> +	if (strbuf_getline_lf(&str, fp) == EOF) {
> +		res = -1;
> +		goto finish;
> +	}

We want to clean-up terms->term_bad when we fail to read the second
line after reading the first line successfully, no?

>  	terms->term_good = strbuf_detach(&str, NULL);
>  
>  finish:
