Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053F3DDDD2
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492919; cv=none; b=gZK0Jk99B97rfuFbxFpxa40AfrdzhT7gzjL8kU4e4qXLyjnQmspXquYXkVUNM3/1DvqvpWTDsH175W+vSyawxO5pfKlkZJi4V8wuqj43OVcdT1TO6azqttNLD+p983eKMlu+G7nwV5vQXuHDF7GshsYPJWPYzSoi1bwZowvDPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492919; c=relaxed/simple;
	bh=RFkIvOF9kxpiwO19r/UTsgPVBDitPaKas+cC3HPgFo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C684JtH+8wTw8yefopOxKbMj/Igkbntkep+I+4ASv7vB4+mS1SVSH/W3JPgzjfDt10HNf+UADyY8yRfW1wNKU3xFalMT/14DwdnWefdM9cW6khIR1FEWMCqKySYhiH/DWEXBjQJVtXk7/XMszdm3I/mIZmD2jATR2KFIrZK2Vjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TOmPRVvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5cDlW4N; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TOmPRVvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5cDlW4N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 462C8EC00D1;
	Wed,  8 Jul 2026 02:41:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 02:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492910; x=1783579310; bh=JY/0VeOjBs
	seduWLlbyL9XGrQt4UTJH3PZlZUEnJej8=; b=TOmPRVvFQXo4xE3hA/SaA6zzhn
	bPcHeMoTb0F2mnFS5WILPGHO0STMCzIs5Lvnd9HD1g/v53DxljDhUpIyFJ9YG5wr
	NtmICucv13PM6dGV+Ia864UJrnNbDiNE5n7FfGEDJTcR0wZGX9PZ7tij9ghUAIrw
	zXthH7tGESgwbeh9Yww60XUFM8rwZcHYyQd731uN1gEBxD7GupE5au1m8OCeAInU
	S3cVGoL8Bpur4iqdKLRMGPremeHja8NV3QriyncIProuTRWoIQBz8RrZ5aEx2eMs
	mJjzBKYHdc8SoaNuVmM3VEOmOyMckEWrDIcbDicJD3tS0BYdEsdxCx1CEa8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492910; x=1783579310; bh=JY/0VeOjBsseduWLlbyL9XGrQt4UTJH3PZl
	ZUEnJej8=; b=a5cDlW4NbHy4Lc26ifY5546dMZ4OhTLzE+vVZL3TkQA8tsZRmKj
	3i8JOnHA1GLQ0y2ymAFt9DUr+qW9PgD1nKnaj+sbE4L6CBRa4LdmIMkGq/2LDKse
	cCjhm27gcvnxE4g8in+jNm1439TcP6/YESDExnv+dQ+Y0dt7FZFYUHs3Vr6dw9LC
	dO8i1W6JZogqXvykLLQ+kFqyPN44insMy5OqdEBVTW4/ixtxUArispYsRnjwvaSt
	LvnmorelR1B5N0EyQYuklI5/T3OEv5/Qn3diphu08vdmHBCq0tZDyjMI+B9SAv+S
	PUNP9CuyTzqbTYLBFDZ7dKib2wZaYgs7WNA==
X-ME-Sender: <xms:LvFNaskHTj9cx6sL6Mm73zDzcDsELR5kjln6JkYfkMWlkar4u5olog>
    <xme:LvFNajTeVTxpuTEUdcrUVzQ6yV8AhRQ3_fF6lUL_uhn8QMMyug-tff-8MyuarcKLH
    KS3OlR8ajQWu9YgH-_-tug3uN5ZPXTrqBbYtzMgQHApROk3DcxhFKw>
X-ME-Received: <xmr:LvFNaoBcoPrls7CiL4DBWAMQNhFkTvf3mgnTmDZohoiVYv4-MyPGNFJKKLfs8XId08L8QuEWnpJCSWG_jC25L3BS7cuNqKt3FupxuPT5>
X-ME-Proxy-Cause: dmFkZTGZXL/xVJBZRT0XjNqQmj0NiEBsL4QM8RtI8yDGZADKrRfylrcgFrWZI9uiDIKpJG
    NjKjs02P0Mm6RVE/7hDfUtc9cztgn2Cw1NuVWkTQj+sAuE+2j63eSJoWyolt/Iiji6uwfB
    AwsPpkAgDLBwGtskl6J4DfVEmE3a8CrgO0CsSJrcgOSpTlkDb4uBEU2zo8XcOuoumIzvPq
    jcg3C9N3hj/0A3Ui37jFkht3TKzzhYoJNu6TlM4CtvieEBaYn4bcsRChYX5mEXYpyukiBZ
    qNG2o1iENbIAOWxM/sLhn2X9ptN7rf4lBdIWSM0XtBgVFCdgfwbiDeFlBqFipjcVgu8+Pp
    EwbT9UeQKYjc0L0bzZ8P5HjvgeY5qb15E561zEdjixGZkQmJ4zCjTqOAcEHCfq3pMYnRND
    QSg51qFj83fjV7FIqtB1OVJJtomzaoyt1ancw2xFIZ91jzgASNjy1g1Mk7XSR2qMk8qI5/
    J5xf1lf25TkqEXqKrwLsiUxXNwZbr7imbD5O6AOgflC4+yCTMvK6JviiaUnw60f8X1JUWJ
    3ELTVkMf56fHEpcLhzh54A8FojHJu7ViFdGyGUtRL0ag9xnA2SbeOnIQzTg77Y/fdc1I7l
    pcBY1u79zT2pA/osz6NJrOOswqqpzeXgjPAw0nZdxCZsem2SjD6IuTC1GOJw
X-ME-Proxy: <xmx:LvFNaiTmLPgQ0fk-tXvPSckv47zKytAk1XMH5wRYtKIyIisJ6RULqw>
    <xmx:LvFNaurQc82Rd5v3_HQw7LPAYcZiS0mULxakIDyUUT0uydIIVeA_kA>
    <xmx:LvFNasywSxbsoe47g9g55SNXJUtLzbzUI6w9DkVq1Eyd3A9MwX1Qig>
    <xmx:LvFNarKY9NDpjdnWKA6kndFEusqCSnDML5GTB-yF7u7RQKKnF4SetQ>
    <xmx:LvFNanTRf_qowRCH2-JF8sMIspW-79qJssngYEG2DvSFZcX_iq26slo1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 848e20d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:49 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 07/11] odb/transaction: propagate commit errors
Message-ID: <ak3xKlQTPP5OXYRn@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-8-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-8-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:08PM -0500, Justin Tobler wrote:
> diff --git a/odb/transaction.c b/odb/transaction.c
> index df4275151b..51af2c9a61 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -16,19 +16,26 @@ int odb_transaction_begin(struct object_database *odb,
>  	return ret;
>  }
>  
> -void odb_transaction_commit(struct odb_transaction *transaction)
> +int odb_transaction_commit(struct odb_transaction *transaction)
>  {
> +	int ret;
> +
>  	if (!transaction)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Ensure the transaction ending matches the pending transaction.
>  	 */
>  	ASSERT(transaction == transaction->source->odb->transaction);
>  
> -	transaction->commit(transaction);
> +	ret = transaction->commit(transaction);
> +	if (ret)
> +		return ret;
> +
>  	transaction->source->odb->transaction = NULL;
>  	free(transaction);
> +
> +	return 0;
>  }

Doesn't this cause a leak now?

I think this interface here is doing the same mistake that our reference
transactions did, where we automatically released the transaction on
commit. That caused multiple lifetime issues with references all over
the place.

This isn't an issue introduced by this patch series though, so it's fine
to ignore this for now.

Patrick
