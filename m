Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411550276
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230429; cv=none; b=KKB4OswOHh749j56qldmdCZB1wY5HhZtNio90PczOK8nRF9fQATagzamoRrBkepfyjsbCfhSJaLMwEb7uwvA2VAs8Hi2+ErnTO8gT/O36Fw0dOmsDvKJVBTBbzASaAfhoYJjIRyrYctcVGbevoWdK9TukD/ww5i4eYi3T5ntfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230429; c=relaxed/simple;
	bh=IJXZCBwrYlIvgvn1U/tXhXWIw+zNlFC46JTaqHZtOts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krt2gRaKo4n5D67eaM0TKee6u9HB4YgBXn759fDGglKvvFw+J7BweuGD/4tkgivtavlKkKsQgx5mkC036zCOPgyTK64XwZyG5EOjKaJzYxaeVOV/Ol2aP2mWEcJ/r+BC+YjmLZNLS8SHv41ipn2p1XzjWnQHqYEVCw63Ggo3AjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K6xYQ71l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml9UBgzB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K6xYQ71l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml9UBgzB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 126EB140005B;
	Thu, 24 Sep 2026 02:13:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 02:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790230427; x=1790316827; bh=dx/TB0BSU1
	2WU+Fnc/2Ysb3hkdsgdsG6noR8c31QXHg=; b=K6xYQ71lFKLXFObBj0YRblx4Ie
	h4K4n3pZBC8AkuN/rsqWR1s6m3UEhwzS0ClGAqsO/hPqbKF+1pxu4MywJTvO3Glm
	gOlTBXFLGqnl1VpvW2FRVUHc29Swb92UHslkj3QIFBkcGsoaVEhUTgvvrnf20FnF
	S4UMNcdXxCp6VMJvKcvoagsf2kCSk2kQbYAI9ynBIFSZLLnXYYPosXNcyJ5eWRTJ
	RsQVJVOxPrsRfX80cjxrfIJZgEnhzruq0Y+yxoaQzNKQo/4pFI4mHX2bg3QIGLRc
	4EiQ7MtgJuigFt1W6+uCu7jjEWGI05n8iluqx1Lx/UNRAEzWNGBqo4XvVJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790230427; x=1790316827; bh=dx/TB0BSU12WU+Fnc/2Ysb3hkdsgdsG6noR
	8c31QXHg=; b=ml9UBgzBwDyCnFQjx/WgwHbwWUY7hJt4jyLCatqceIoZkkEyac4
	PLEWDJDrKyu3sx/yB7JqJjyd1Ias9vaeaDv4+EB22jujsNAhuTQRcSs022zTZrMQ
	6lEw03+Wp8NoB2kq0zlKsU7Jy+Dh9u2J2gP5oDZqkCi74/ClPgjLfbPOn5dWfqQ0
	1r1fDTMpIU39GEKFoGSv64zDk6ce7RqyU75PaF/vaHitDu/advE81/eJpEx5i5xb
	5RAWFYX0bsN14RyUGKSHT44333qGddk5wsgmpSOEs+23Ik/4ZveTwN0Zet8aG5rw
	btY9RpLzzaMQ9lC7qO1GxZohxnpHMvfjvBw==
X-ME-Sender: <xms:m7-0aivHv6VHLunpqtdaSzMBPTf_5t39k2Q4DVCMvfWTi7sfjpHCAQ>
    <xme:m7-0au5mDneFbodO19wKm62zxkA0sQIEHmHjUWpHrTp9aXeFBvu8Ph6YANY25z_z0
    rN7YXx452i5QIvRbxPfRLpCHgU3h3147yHaPsoP4H6uedmXFLGKsoI>
X-ME-Received: <xmr:m7-0arKvgR0edVbVce4p1Hg7BNSENX9Ji545-1nRzElhJj_uE-_WGcdp9ECaj3w03NVovT4>
X-ME-Proxy-Cause: dmFkZTGVNSYmBsY1DUJIDrUoMga+7nM3JommT5cdgBAvClTMNiRJ23FT/LvWlzW8h9KxIv
    1tZo22OW6QJkYwKVQDfN950X4utuM2WRlB5eVCna40C6hiTcOVDpX69eJnd3yE++3LPHYM
    zEJTln7a0HXQ04N6JND/OKV5/x05e7kH1CTcWm11fhAm98TRnm21nQ/Sp4VkL68yVu1aah
    FxUD+fnXm9xV0AjFnkVJSRVzZmkwom7BzbRSNj8WnPgzDqrAfZ4iVqFASOlHlWn9jyZhZ/
    OiurjdcetRf2SY3mO5jVy9NMVWZ8ZzmQbwQiwaVIzjvQooEI36FnOD+kLFI3b1QKZXEGB9
    OlJGq5GN8HT8NxfShaPn7X2WBqBhhlHr1DDX8YxV3t76S7GG+rQqCFEZ+LATV6qE+2JYAy
    oKzxitCvh2we4CIdzzFRehQmZeBZpjtdGUh4XHPaAXrosEcoNX+A8d/ptsAjnjF2C/9P+0
    yBWMxugzLQGtNpVEshH9Zl382JuMavdqBkdRriVjD0Cc8uHune2jCkUUQwGOyJe/d/cIdy
    9N391KWS3spcXj8rXN+VtyaVia/99PkSUVLY+ghSI5+7wf2JVHpZPqF+BmwOahoZKo/P6L
    EtS4F2Ujcg/v2i2aLKCMtwzFDLrILKz/PPI4+28wl2R66Hw/HfO1MAaey7jA
X-ME-Proxy: <xmx:m7-0am4-9FDZYEms-k6Z_oSJ39rTY-qhmGrZvmUIUCGw77aNca0DhA>
    <xmx:m7-0amzk3kNMs8C1qXSqiA71C-aliiolAVSTtuw5goHJno8Nd921CA>
    <xmx:m7-0aibLQW0in2_UmVIq4J8cAGV882exRkS6XlIKlEfOKhKvpiHczw>
    <xmx:m7-0agStYkr1vGHNJRvGMDnsZm5Y7jJ9H1iBSBLtjcQUZdwo89xg_w>
    <xmx:m7-0aq7G-myGuABVcOo3g1CFPNXAnqPj15Yua_fNP-or86E7lFz5NAJj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 02:13:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6af02e0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 06:13:45 +0000 (UTC)
Date: Thu, 24 Sep 2026 08:13:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t4205: compare huge output without diff
Message-ID: <arS_l1hPIr7I2Gn-@pks.im>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>

On Wed, Sep 23, 2026 at 01:13:28PM -0400, Tamir Duberstein wrote:
> The huge-commit test compares two files with a line larger than 2 GiB.
> In Linux GitHub Actions jobs, git log produces its huge output but
> its subsequent diff process is killed with SIGKILL.

I've never seen that failure before. Do you maybe have a link to it?

> Use test_cmp_bin to compare the output byte for byte without constructing
> a line-oriented diff. Remove the two large files after a successful
> comparison, releasing more than 4 GiB before subsequent tests.

It would be great to back up the claim that test_cmp_bin is better than
test_cmp, e.g. by comparing peak RSS and its runtime.

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  t/t4205-log-pretty-formats.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 4be5c51489..6279a7e9bc 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -1189,7 +1189,8 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
>  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
>  	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
>  	echo 0 >>expect &&
> -	test_cmp expect actual
> +	test_cmp_bin expect actual &&
> +	rm expect actual
>  '

Hm. Sure, releasing these files isn't a bad idea by itself. But we
rewrite "expect" in the next test anyway, and "actual" will be rewritten
two tests further down. So does it really buy us that much...?

Patrick
