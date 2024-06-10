Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325854FAD
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061624; cv=none; b=Lz9j+JoRUMIRS0/MAjkg6ePTa6oNk21zxcrA4cOCxpjbvRAPKlJSpuWQFi/BFY5G37yNU+BlBtc6LJ0Mw4YkBompDITTk8dH3RbBYjE5P/9s7b0Di3B1uksoyLrXVJ2cJEKu383caZHZ9jv0gAvvAWtdrmvMQNBilStbtl7riZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061624; c=relaxed/simple;
	bh=p7M1HfAuHLeFmwkoqHCv0z4L8wg0OjQnq9OKbEAP2V0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=utpvoj3/xmTDqpk2PATlz4Q54iM5uwgvKkb4rLIXf9Zm4dlsoogkRG6G2CUB/rKsmq0AXyuR93DdHGXasPeuAv8mAIEzY7AEgFPP7SqKEMVhU+XXQHu0S8fOScWQaF028hTCqNMtqYDbzf5yqTe0ykONNDFom+AeRpnHL9E6u6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vlbvskk4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vlbvskk4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12405328C0;
	Mon, 10 Jun 2024 19:20:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p7M1HfAuHLeFmwkoqHCv0z4L8wg0OjQnq9OKbE
	AP2V0=; b=Vlbvskk46uKKCX3IA6QDVuz4TKmR+SZQoR9TJ9qVrlqF3QosGTkPyd
	hbghk8s5fbEKSxdPM69HKwKdPBu3RpCi5F7C3wrPqBrdCIlfKPwH0nysdg5yEX2Z
	uPZAbOYPpPmHpE4tQyt8Pu521hYwI2S6K8CVr8+ti0ooA1RSqVaIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B487328BD;
	Mon, 10 Jun 2024 19:20:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DA49328B7;
	Mon, 10 Jun 2024 19:20:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
In-Reply-To: <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
	(Ghanshyam Thakkar's message of "Tue, 11 Jun 2024 03:31:59 +0530")
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
	<20240608165731.29467-1-shyamthakkar001@gmail.com>
	<xmqqed944uq7.fsf@gitster.g>
	<72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
	<xmqqr0d4zevq.fsf@gitster.g>
	<7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
Date: Mon, 10 Jun 2024 16:20:14 -0700
Message-ID: <xmqq8qzcz8pd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE6CBC86-277F-11EF-AE5D-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Yeah, I'll reroll as rebasing on 'ps/no-writable-strings' did produce some
> errors but the change required was minimal, so I'll include it anyway:
>
> diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/t-oidtree.c
> index cecefde899..a38754b066 100644
> --- a/t/unit-tests/t-oidtree.c
> +++ b/t/unit-tests/t-oidtree.c
> @@ -62,7 +62,7 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
>  }
>
>  LAST_ARG_MUST_BE_NULL
> -static void check_each(struct oidtree *ot, char *query, ...)
> +static void check_each(struct oidtree *ot, const char *query, ...)
>  {
>         struct object_id oid;
>         struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,

I somehow suspect that you do not even need to depend on the
Patrick's series---tightening the constness in the function
signature by itself is a good thing as you are not writing into
"query" anyway, even without his topic.

Thanks.
