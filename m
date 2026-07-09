Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9311CAA6C
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567936; cv=none; b=ey8C/87KnUYxMo3oNjbZ+ovdoc3vIOPRSUiKt7SAm4vazfLE6hKZL6bCmPofcFOtXbtoy8IZVZ8RWloZSqPc+eYxVulBMQztMzU7RDY+dH4bfofVWxOo8zhemjbxdXaGIfFdl52mc9DQJ1/iZeFJkgYOqpHcw0Fxh7/SShLN0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567936; c=relaxed/simple;
	bh=ywyxbHlmGDCgvRDZjFR2TbD1Pz1o3F+/L3DLeIYz+TU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1MTqiu+vChOe/ygZv5i591HbllbijPTjnNbrOGPpsw7GUWLa6UgVtI5ZVaJUb2HRXdRy6OlhM2eAm2g2LImCOF/V8jEFXao8YcKLHIIcunVFBBQ3aSXshuqilPVxXYySZEQY4HWxcTZ5vMl6ZAy4c1RFsoLc8DAQDRt63HRVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EOtqUwj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQHtd5zl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EOtqUwj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQHtd5zl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5FCA7A00AF;
	Wed,  8 Jul 2026 23:32:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 23:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783567933; x=1783654333; bh=McL7N5caqN
	1Bern71ERE9Lvp2eTf5Drh+OSXD1K4098=; b=EOtqUwj9khdvnNNqKfGRmbtKvA
	9/kFpAIKMBTbitzkWAsLTGgVRlIrA9UlBtdAQISlG5+gvgr065KtxQfK12Oi0EkF
	B5l02NZDxeUTOj96QPY4eQnX3h6vPXpGxqfVqUjD6VjbKOpMQ1N3WSQldl43JqOb
	I8hgZot0rqYghrDtuU0Funm3GvDqV23497tCnJPh5JPBhRwG0tyy3Nt4jh1aLX56
	8vhzYjZLjRNyPOgcYHYvdUR9Ewl/eN3iM5bLgwVY3ZQhZV9sv5MxirZirEZBAbRO
	HdkaDFd95qrYwQcWt0vpdzFF/RCJ6q93tL8koMZSDuC/rpSF+2sq9MjCybAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783567933; x=1783654333; bh=McL7N5caqN1Bern71ERE9Lvp2eTf5Drh+OS
	XD1K4098=; b=HQHtd5zl/3FeJFap3gLGk0zr6ZRylV7Xyw70iHaDzyDnWsA2v7G
	WxI/GQvyfMcsuXka8ex+2xrOc2Ips+8uolDNjyxMg4m+hrAx6TpbS3f/KeD2sco7
	yplhtZZACeUBdjLsjkZkqUOCDi9SGJnWMTod6emY9f8cV8V/Az8Rlp5L4teKQ23k
	AnIc2IUrYwEgJNx1/Yk1ldg5GrTX6Exdcu6Lr2Tdn/RwHi2TUZL4aOvo8qbY21NU
	aKo/bz2FARfwPHPwNL23Wfu/CD4BzcIdGTTXo+XRteYAb7rc+jteOv0eS0znD4eK
	NbvdgieXrHI7eXgWwdV7ayYWNA3w4jJceFw==
X-ME-Sender: <xms:PRZParURGJwOIZw68q1aUxsejOSV1E_NCxq3DMrTL7DZpEiWZu2w9w>
    <xme:PRZPaqnoMsKA218LslpMWchffuGRoSTMJgffb8A4ox00LgclmYXvYNG1QPRwPYqyj
    QsWSs9h2X0VViKXz4yXV5eyQJStIbWjY0AyjeLa0AliXl2YM-2YEA>
X-ME-Received: <xmr:PRZPasbzauSY7mAp-leUKlQ3hhAIWv0cPBnj_-Z_HQXpm9XyhzZ1YmD8QtqKCc6QVHw2-UW5LS2UaIKSNcaV070HLH1Hk6Ua-8F7jrg>
X-ME-Proxy-Cause: dmFkZTELC10VNiyy/OsHUjg49fk/wtP+vft+W+B0C8luTWXy4bRT/N0rdJeWl7gLW4M+aG
    IZEjBOsh9FrRmI/TMv19IINcnqm4l2zX55qCVQozxcqk20nvSGxxqwrTpKQDdK5m6lz6mU
    P/T0e540j8PYS0mRmKksM+3uo4PGoIzLTmE1JVCQH/5bnUMys1/lHcIulxC8u4WXkiUN48
    PJ/f8WNo75ydDVeA0cyZqu3eSvSxhgUgv5dWA5nlijvYfp1wr89kGZxJFdQHuDz+jqQ50j
    9pbMtGtBLa1b9VgB2ggvkT7M2O82gpeilYsDlHBkedO/OZvkn4jykCEPWwBKl3e3VC1DjH
    qbHo/h2LV296VCC2NeUXE6eUEr/XrYIcVGlfwWW3V0Jfj3PiD50WhGrjiYDaIcmz9MtL+2
    jZ+Gt7nBp8tj7WLdzHcKyYkEFJVLfrrkjNigf24ooj+OwvCC4jwRs/KyMBBo640pggFf2K
    oJvvqp0SSyvwf+INZ+UEl1/6oAdqRDa9RGYTCTDeI0E9tQkO+SBRGOW0AD70ezumHo5RVt
    RhbPi7T6dvhiuv3ub1PJt/foVLNWNZBh/VEi4RR4EdSNihD7FNGExkdlIOlvMVsP2XSYNI
    AlmZYXlvFnXQZIvRjrk/rICy5Dt1r5gOaZAKLYiimTMwe7JYz/A5IQku9q2w
X-ME-Proxy: <xmx:PRZPalO9NaBFAGsFEnAoAYbbhXDfEGf1_ep9WQW1stwKhmvTC6NvEA>
    <xmx:PRZPahZkv66Pc4yQJrBYoIhR2z8xv3qLuXICzSTuJHkPahBBG3z9hQ>
    <xmx:PRZPaj2vRwIl4lH3jVDGoQABQyyllYidNYdieQsoBm50lbHd2jJSZw>
    <xmx:PRZPand-HVp871-PY1Yubb1XOD_PNMBOJ292qcSBPefin6_IWb_dKQ>
    <xmx:PRZPan5NVLsLwsNQwwkEnKkPOOesnS1N0sXaleFD4dv_IoYHHTHTF_Ha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 23:32:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 06/11] odb/transaction: propagate begin errors
In-Reply-To: <20260708235925.3992097-7-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 8 Jul 2026 18:59:20 -0500")
References: <20260708041412.1157499-1-jltobler@gmail.com>
	<20260708235925.3992097-1-jltobler@gmail.com>
	<20260708235925.3992097-7-jltobler@gmail.com>
Date: Wed, 08 Jul 2026 20:32:11 -0700
Message-ID: <xmqqjyr4rg78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When `odb_transaction_begin()` is invoked, the function returns the
> transaction pointer directly. There is no way for the backend to
> signal that it failed to set up its state, such as when creating the
> temporary object directory backing the transaction.
>
> In a subsequent commit, git-receive-pack(1) starts using ODB
> transactions and needs to be able to report such failures rather
> than silently ignore them. Refactor `odb_transaction_begin()` to
> return an int error code and write the resulting transaction into an
> out parameter. Also introduce `odb_transaction_begin_or_die()` as a
> convenience for callsites that do not need to handle errors
> explicitly.
>
> Note that `odb_transaction_begin()` now returns an error when the ODB
> already has an inflight transaction pending. ODB transaction call sites
> that may encounter an inflight transaction are updated to explicitly
> handle this case.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
> ...
> diff --git a/odb/transaction.c b/odb/transaction.c
> index b16e07aebf..a5fba7f908 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -1,15 +1,20 @@
>  #include "git-compat-util.h"
> +#include "gettext.h"
>  #include "odb/source.h"
>  #include "odb/transaction.h"
>  
> -struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> +int odb_transaction_begin(struct object_database *odb,
> +			  struct odb_transaction **out)
>  {
> +	int ret;
> +
>  	if (odb->transaction)
> -		return NULL;
> +		return error(_("object database transaction already pending"));
>  
> -	odb_source_begin_transaction(odb->sources, &odb->transaction);
> +	ret = odb_source_begin_transaction(odb->sources, out);
> +	odb->transaction = *out;

Can odb_source_begin_transaction() ever fail?  If so, and when it
fails, would *out be left untouched?  I am wondering if we want

	if (!(ret = odb_source_begin_transaction(odb->sources, out)))
        	odb->transaction = *out;

or something like that.
