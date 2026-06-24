Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9833F8C5
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300418; cv=none; b=EeJZPNatH1T+8nX1AKUV97XPewwtTsA0chaa+chkOoiNJORbG5S7f+lpHmFeCJ89jPmuiICwcKlGGeMfsiE9EiGbrNpuUNV+olO1Sm03ghCtPNtr5OTvQ7Ml1p4M315gKAi0WSHYdZZrOt4XrifKx5xjERZMkbrN+UruWgYCcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300418; c=relaxed/simple;
	bh=LVd4jXbESohKInNpAh8YYfltYMMUHiUuUfOqUc5wzgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqRklcKAeXPhMYXoh12HzY4pHMYm46wA9fCyNFB+CEZnIAECbBOMEYTRAiEaciayxzvGeoUDv3wv96jng3esDl0aqaqjvJXvDjoD5IDTcanlvhQi25mR/X6iWPyXizlmnaEKZWk/jO/HwUBnUnby0H3/abmL9AErndtCqJY5CIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jcnizv+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9i8xNXZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jcnizv+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9i8xNXZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 849D11D00104;
	Wed, 24 Jun 2026 07:26:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 07:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300416; x=1782386816; bh=/bjBJkWqGw
	ywAxInxYrS89/cG4KLSi+9khq85ZFu6Fw=; b=Jcnizv+OpUZJfriNr28UFFpwD1
	OEVix5XlZBqZ5awKYZfUjb+8pvjKDiLKpXXCL8Msc58ShrO/moiGfJhpsvB5N5NW
	LBomlSTYrLLp5bGCBEmv43JbakGGxALYSBCK9GWQ3H+jKD/evLlg0Y+cm+axR+d9
	azbUmQ487C0Ri3nZ1+MufqwUDhCuPxMziHIBCbcXV+KbpZ7CuaqrFVqY2uDsd5RD
	tnGsfE99dCaEQNqhuz8uFgevNUN7ASpIG5N2e2m/63FF+701GE8XYDV1En14tY/R
	mREuR4YOTzMpaQOv8Na4IoqGJCxHV+sBWLkmx55X/oN37GZdOnkcP/lBn2EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300416; x=1782386816; bh=/bjBJkWqGwywAxInxYrS89/cG4KLSi+9khq
	85ZFu6Fw=; b=b9i8xNXZM69qOw+aaehzk2t/iLwGnoK8l2ibA5do/KVRvOoLY6s
	8bcojukYkBXrnnEuNPsP+9YeDwTUcuteSsgrOjvZuTa09CoNqkjRHG1VwXvpeXeM
	HmnTi0dbOiFMiEVqEvvRPomw7QKXk+HlyAZgkxPKvNDJ3xi+O3ppGdL1NXIZKRx2
	TiUhaXjsKSjptYxHEt0PuqsI7GbgyyEUBBWzIUBkA+9Gb5S0/kpwYLBO6sD9Kx4P
	CP0qtgDqdtCpUKAHFt4hk2fAh4jFUm/MgbtyXyuMoJ3i8Y9G+l1gA6H9A902v/cK
	6pl1Nr9Ez7ebZWIw66l31GLPbdLoV0/dDSQ==
X-ME-Sender: <xms:AL87ahXKRI1CXWkTJQiG0Gw4WTkK7nr8_3WuCYm6k9XuhdjSCR8TtQ>
    <xme:AL87anmIyE1-PesBsOzOu4zvKOvT5cPKAdQvNtzI7thymxNlQutz3a1oP3-bpdYdb
    L7DAGFyjdNImWuyz_lSixNUlEeL2Z722tpHLMVbPzJ9IOmVrkW5hg>
X-ME-Received: <xmr:AL87arDH0zoQriuKyRo0zSwZEOPMx9UOfJgbcBMpx33af9e6PmKHKtw4UK7cIzjTQYIGdbaZjKEow6A2u_uWUKrhZfhV3YPeNyAWlTw7>
X-ME-Proxy-Cause: dmFkZTFvMjUcyQW7PAKeKQZD6cQPbipPIgW76ipC9Y2lZ4+VoEmdPqU49QmEsLOdMEyCBS
    K94a8OiULp5tRK1IjfwXaDTRIirJr8djENFsydjwDw4Q5X7pRMBOa1sEDMX1Lkm40Yu2+A
    TJnqJ8AJGK3ShXU8JTTOqsVVVTWPPJcJCU5gVovag8Ses15tIaLVSQd/kMLC0fgu6VwltN
    +8yTLLKGkuztA0WAtIeS0BcwOiqOvCzgn+X/Stv7BOVT1QHWX7I1x2rGZqly2wWiw+uKuT
    aGl8Zs0zSycbzJ3IXffuCBJirH7Bcwa/MnO0f7NLRVxzIRXNKmyA7tcN3at8IqL+REfWWV
    h/RFSCm0YCcnCAAlA9jr57OA5w/dBFjDqWt54ImNO1bywa9IY3SQiS3ZCq2ePLp64+auhL
    8LepeJAMWKY6Ta7ijgYF901PADbyJCjU38wVnH2Xe/IUXYpAJcWBRxq6RERhw+fr1DuY82
    5WyV0x76mbFgr0uiX0N82ur6IgSDc3VPUAAkigXmR/5Xtj28ui6ItLfym9denNz9JDPFxE
    ooWS7sWPBx87J98lBGs2R2hZGwYP8j5ny2zzOSq+0Fn80n0S2Is/jXPqeAIOVV8eNGChq9
    z3CKtrQWs21jIlxgjkAkz8qcZF/DIJEOuqnKqcTiEHTFZ45cU6IN8+L4P2Zg
X-ME-Proxy: <xmx:AL87avduri_2Uw-uCoc0ZAI4lSk-fP3h46HcNO98m3_q4oikRDie0A>
    <xmx:AL87auKmcWzsUKN1WH34zFQwY6DlXBCIJTmZWB7BNqkyFiQ07P9-3Q>
    <xmx:AL87aqcFQ7oh23mCg0077svp-2uB6Wi1y_4nS2ErCC0NmGHMNrJiFA>
    <xmx:AL87at0kJmnQEPqMOBKJT-rGRpecogK0ZpeOtEB81T_HUto6uY6s-A>
    <xmx:AL87amGeRy1BO9DWteXrAE8wdcNK3qRViiLH4QfEJw5jtLT7dXEQynJZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:26:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6338f7fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:26:55 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:26:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb/transaction: add transaction env interface
Message-ID: <aju-_Nf3kmoIidue@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-6-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:19PM -0500, Justin Tobler wrote:
> The ODB transaction backend is responsible for creating/managing its own
> staging area for writing objects. Other child processes spawned by Git
> may need to access to uncommitted objects or write new objects in the

s/may need to access to/may need access to/

> staging area though.
> 
> Introduce `odb_transaction_env()` which is expected to provide the set
> of environment variables needed by a child process to access the
> transaction staging area.

Possessive s is missing, I think.

> diff --git a/object-file.c b/object-file.c
> index 696f05dc2d..14064d188a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1691,6 +1691,16 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  	return 0;
>  }
>  
> +static const char **odb_transaction_files_env(struct odb_transaction *base)
> +{
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
> +
> +	odb_transaction_files_prepare(&transaction->base);
> +
> +	return tmp_objdir_env(transaction->objdir);
> +}
> +
>  int odb_transaction_files_begin(struct odb_source *source,
>  				struct odb_transaction **out)
>  {

Makes sense. Transactions may have a different way to quarantine the
write than using a quarantine directory. So making this functionality
pluggable so that backends may expose a separate set of environment
variables feels sensible.

> diff --git a/odb/transaction.h b/odb/transaction.h
> index 7898770071..536458297b 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -32,6 +32,16 @@ struct odb_transaction {
>  	int (*write_object_stream)(struct odb_transaction *transaction,
>  				   struct odb_write_stream *stream, size_t len,
>  				   struct object_id *oid);
> +
> +	/*
> +	 * This callback is expected to return a NULL-terminated array of
> +	 * environment variables that a child process should inherit so
> +	 * that its object writes participate in the transaction. The
> +	 * returned array is owned by the backend and remains valid until
> +	 * the transaction ends. May return NULL when the backend does not
> +	 * need to expose any state to child processes.
> +	 */
> +	const char **(*env)(struct odb_transaction *transaction);

Would it make more sense to adapt this function so that:

  - It receives a `struct strvec` as input that the environment
    variables are to be amended to.

  - It returns a normal error code to indicate errors?

Patrick
