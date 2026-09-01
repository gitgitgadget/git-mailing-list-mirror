Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA125B0A5
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261441; cv=none; b=GDDoXD7wrJ+wn29JgRo3MKcibr9xVR+dVT+5yrstBa8tS8N7GJAm1+/1j1lf+hz/98ER+g6BAxSAMQSchVitS3ApHylSpBjTiTUE7kz1E8Pw8eSSYqDG/ai/cykuJAIz6koG90/M1LTvrfJc5NwD0X+QdlgdTPK6COgG/yaMumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261441; c=relaxed/simple;
	bh=X7Ch4vCyryearq8ZfUIFmCvoQUXu/giDE2rHXHEDT7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzWH0bFURu3wfUFiDLf587UWabnI9gcNjQ47jBooa8lIL1lGghGRVGUUFTQ5gTfCapTlTTJFvsxPvkHuEW/27VFUrXSP4LHLjnST8bcX6n9AOYH/CmF+aaZk3RUSWsnmmyq21J6KFbgwNbBQkZnahLVKKEliAjE6eUE0UepcWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P9UskWl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaLDuJC4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P9UskWl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaLDuJC4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D5FE140011F;
	Tue,  1 Sep 2026 07:17:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 07:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788261439; x=1788347839; bh=OLqwweA+Z2
	5cY40doKmBAIrhGB8nvVy9jTkpsgi3Q9I=; b=P9UskWl8Z6AVw9wHZbO2o9CoIq
	b1YQnDd/RDCj+KABEWw1PQZtvBe6lfFN2+UkbrydBw08jLwnUag0maxubVX0osa+
	VBvXKVa12yI3Ojr/IFEQFYHE8mIl3IgSxeDxi3iWu6BqEn4bLcrGMEaa14Caa8Pv
	KiTRBKx2G0z+mlm32j+OnCZkrhahMZyJRv5k7GbN9Nmj39Y/cD58eVMtfchfqxw+
	UDJDZn44AmNt+DQ/wTlVhRlMUvGE1a6rOmB5s98SeHa3LL/oxzaNS7HS63dZocGg
	TY8v/kAUBochmq+gA0jUjq9/Cao6fuUgftSiNrMuuEztb+Q9eetg5eEioajA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788261439; x=1788347839; bh=OLqwweA+Z25cY40doKmBAIrhGB8nvVy9jTk
	psgi3Q9I=; b=gaLDuJC447G/L9jV2zzKf8VYUCVDXTwusWi50C204kMp2rocobw
	gJlm71huDEpXYH1kF2L3VrCJHwBwObMkW3ifm6DfeFX4aQ/xebS+LkNtpJKFOdk9
	TloRsfnPZXKY/4Xh3U/f5QA9XeEEBZdxY7jnoL3/+bt6rnLDgSYj2Wv0d6kROw0F
	OhJfgy3we7qFmXzZbzoX6TCMtQ/QGCjdE0bEDRVdi0fuNmNK+PRULgldSVK7T1GE
	TVbpDu96e/bDir2TSXvcX5o7T7l5Clgi8YD8A21/jKb1RPDO3ocza0pVHe1L+VPO
	Z9en6TBKnZxT7vhRB1AE1LY0siwMs13ZN0g==
X-ME-Sender: <xms:P7SWal2FLh_eg8FVq2KQWWT1aV-5r03epZBwwppa_0yEia1EcMoeKA>
    <xme:P7SWajhOLlycHY2RcQGZoW3gfPBjob8rBwlkURmYuEC86xnt2AtSbiP6LdQsh4dZo
    b-kWg3dbIEmyml-iJ6-LnZH6_OtzwaTgY-yL2ptfsLFuvjRO3A4CQ>
X-ME-Received: <xmr:P7SWajSmG7qxnpqIRXx9LHX2f-OeWxNg1ma3jl9PXrb6C-UKchP3gw>
X-ME-Proxy-Cause: dmFkZTFba+pbvBezrs1fmQ9QmNFOEwMeDO1O6I/H4s9fbvlxMTumFlu/oldFOtd5bVioBh
    66b+PM7MTE0itZdNMH3BLRZNLViWQLRpTe7EaOPrFoy/g5xfri7LTTzAr69SSa9sPwgX6H
    eLUfbNPdZzKbfmVuwsZicEDDo2ssdbSp3d60qVPK81Ak1G8MC6ndvN7pJ8mJHHZ8W8HZPq
    TUNY+8cyqL/6u0kVc1k1AYkE4imW1p1oHWYDQBMsDGqONw//8rd+2skf/vj2WT7rYMUEYM
    KIbppAbvGyAgvr+fq8FKl2tVgUagUOVvRJw3f1DY3BxB37jDOtqKeNDW2KahRpmPDjLTry
    fZQGJboV5CdY2fnNtWygGmQPGJx7Jz0hDVpxuyyfyama1wSIdbbnLbozcqvuBITb9yEp8a
    GkovjEDm3t8utQCtxXmrA4v8lTSCmdcKUxQlpmbk5pb2M5bh8slHMHicf5Rq9hkHnr622B
    w4Ts+U/zQ8tcCzbkZisU08idQb9hBLKRudGUb9k7VjDHPxp83JGhpiDFGXLes/+1pFIqk3
    O1dV5KjqvnocCGGX43NB1NQ5TwtauzvTzOjYtVPHap2YRHgldDDfWFAhAcXR3D4JpKLSjH
    +eKcx7BQtMAxDJuABknnOKGvOnayQo2JJj8sAjDpu+o4ZWlpedl4vB9fRUUA
X-ME-Proxy: <xmx:P7SWasj_0k2w7IwMKSxxq2YvhrUpTbUkymzv3nbt5YoREUHctdUuPg>
    <xmx:P7SWar4TZlsplfhKDH0NuKfvC9vRDFSrdzVUM0Kx5-T09Y5uzpXqlg>
    <xmx:P7SWahCd7KHa6m82J512tdnppesX0SpXSxYamGwiU7y1uNIGytorKg>
    <xmx:P7SWaqZJbp8ViPdnKu0HbZvF5VgNVL7rkr8MqPnSRqrn-pXfO7aH0Q>
    <xmx:P7SWav9Jxv62sjDEqufitE3EFvboOZbkhqf3j8AGbjGV7UyhT3AXt7tD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 07:17:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcd79b01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 11:17:26 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:17:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v4 3/3] t/lib-httpd: document writing concurrency-safe
 CGI helpers
Message-ID: <apa0N7VNNkcKurbi@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
 <d8d11ad246b2e5ca73ea131e908d74111bb0fcf9.1788222476.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d11ad246b2e5ca73ea131e908d74111bb0fcf9.1788222476.git.gitgitgadget@gmail.com>

On Tue, Sep 01, 2026 at 12:27:56AM +0000, Michael Montalbo via GitGitGadget wrote:
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index a216e5376f..8ca09fe85b 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -159,6 +159,17 @@ prepare_httpd() {
>  	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
>  	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
>  	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
> +	# Apache can run the following scripts concurrently per request. Make
> +	# sure any state management logic is resilient to race conditions.
> +	#
> +	# For example:
> +	#   - use "mkdir dir" to ensure only one request "succeeds" under some
> +	#     condition (see http-429.sh).
> +	#   - chain (&&) atomic operations like "rm marker" (no -f) with the
> +	#     logic that "claims" the marker instead of relying on a separate

Nit: I would have written "with the logic that is guarded by the marker"
instead of "claims".

> +	#     "test -f" and "rm marker" check (see apply-one-time-script.sh).
> +	#   - use scratch file names that include the process ID ($$), so
> +	#     concurrent requests do not overwrite each other's state.
>  	install_script incomplete-length-upload-pack-v2-http.sh
>  	install_script incomplete-body-upload-pack-v2-http.sh
>  	install_script error-no-report.sh

Other than that the whole series reads a lot better now, thanks.

Patrick
