Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2240F8C1
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636444; cv=none; b=FgC2XMf/rfbHrVXxna1I32xANmBOzIQbPxSs1FFJf/3gviMxHSzSwknFUSTCUVI8kMp4or+eM+/MKeWMuB09hw/sVxkrOALNSFaZudZiDIv1XCZ5n4bUhNOLucL2nI2nQ1olm10xeASP1cGYJBkydhWheBWGsyuMfZ/Ni9VpRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636444; c=relaxed/simple;
	bh=FeeDRPCt8N9TvDrxwNt6N1KPwC7ba1ecwbgBmGLjxB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYvW8gYqZjIOfx2Tc7LZpRTcQkY77O1UgofpzPORmC1GlDULCGvXQn0PtnUxIay7t4FfY2A2QZN07Up10ppdDd+/+KQ2vt4/dXaMqeAY+1TxnF/zT8caKu5RsGlw7y7UJbhVSLBrrqOz4qLRDpo54xDR6ygdrllGB+ZNvpTLUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox7j7QDB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox7j7QDB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc137464dso321854085a.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774636442; x=1775241242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9mP7Ileb+ZGNN3rWcQIcXdw3oXYMlD7qpwopALIVp4=;
        b=Ox7j7QDBUWLF13sA0UUoaFcDSnmKuDVHWYc9+MkKBHbkIv5ZGoFI+FJWMq2ZzCs4It
         IlFMOyUjyFarkQRqAVRB01Z/HJITwme9jxP5fqmdmmuMTrGBhPzkSVpI5LarxP/aLD4v
         yEFYkAo//de9PryurcfndId1n6ffZMyrABshPSf7w0+cJ+3f0V68BqQ3vgi9YjC+HwWN
         dZJom2+ohoJYT1QoXHlpyHkEcD+/KoyRk8n7OulC/atPx5YdBT2+w3EJN2anAsTzjarf
         Ud78OthU4h2obttWpgNXwgdYZ0X2fdYLD+a+e3DcyCdsT+YFH9X9WRocSDx326T35nGB
         LuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636442; x=1775241242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9mP7Ileb+ZGNN3rWcQIcXdw3oXYMlD7qpwopALIVp4=;
        b=UXl2XPOUY653L8KSIsICXB0CkQCembfMyjVgk5uEIyMbHnDTphyk1CXpSB+GOvX8wb
         VPsmSNLrROU6MHrtcSTpCZGXQ2BiPfiZOZrUV7YpGcdMV7onhWM5OCbPXp4g+mc2b0Vu
         Mr/LGyNltlYe6U88dLLG0nvP/veZmcauvwJmhAXORMokNL5MJRNfPG15yMi7ToDb8wRd
         eLyZd8d44XHG5LJrutEUxb1IqZcZR+fbnqjRiGkP5kl6c5H4X0UGGG8sKoWc91j2WnUm
         /0W6VdTLR6gbirHIf6lafMS0nErkwe7hpw8IJBPn54zG3FRTuRvky38vmL79EKYwIHtd
         U+IA==
X-Forwarded-Encrypted: i=1; AJvYcCWVaL0N8n/590x9e8C413Esg5XKzslKnOUCD24VWlbE420ggrTLgCWZtrVCmRXBIj90L3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUZNBAsYgDysVccGMWe3pwGQ5ncJN/X8SAkZb2EaCjfKAnZJG
	Qa7ZluymyrpOFLu4Bwb0xR/Kk0oxX4A8wMxyx01ELnjWcNgKaYzUxifh
X-Gm-Gg: ATEYQzyW0IlxX9sRBYSyJB3xT/5WWaQ2ml+hCJP3rQIGyXXSTK/jcV76WXjp59LELCO
	PRd2yWU3GI6JcGPGTebHjtMdwX1Y00Oy7Yp0s64q3MBV+wfnykM0hAsL1NhfOBmk9GWmQpc4c8t
	MX6OFYL5AY7HbrAS1OatW2RKKw3AuwVPTXwdLsIeIZsf9VNmqkFsfMjJLNAxoNhB2SsBjnm9fu9
	2FTesahsMuZlPx77TdQ8tEjZH+n8tua6xkrIdmBbrh5EhnHe9zTKjRuR2OppuqF9gVWuTogFOUp
	p43tohq4ljofj5pYh2oYzXPtk3SQWB5HHlwXnCPVdpw6F8YMVhGEw7moaJU7I2IILFBKy0eVUL9
	y4PUDgihOPKRjwLhndbsyH1Rp1CveuTomstD77dgX0vXEXZQb4/XJLdqKRhR21pFmRiIyJWapzR
	rIBu2gyvkNm5GMfmTjPjEUQ4Blxk3VvZ2SW8E+Lnzb8q5rEhkH+IAf9jr7t9zodPR4voAvMw==
X-Received: by 2002:a05:620a:28d5:b0:8cf:cf2c:e021 with SMTP id af79cd13be357-8d01c5e4487mr513868685a.7.1774636442423;
        Fri, 27 Mar 2026 11:34:02 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e39fbb0sm537447185a.8.2026.03.27.11.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 11:34:01 -0700 (PDT)
Message-ID: <21ab7d29-5855-4830-a22d-cadfeb756cb0@gmail.com>
Date: Fri, 27 Mar 2026 14:34:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
 <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
 <acWoqXUwVUB2/65T@nand.local> <xmqq8qbensw5.fsf@gitster.g>
 <acWz48NfB+dlbHAz@nand.local>
 <b6e6ea33-76f0-42f8-9546-2e900f239530@gmail.com>
 <acbDkI2vDXYu3mvL@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <acbDkI2vDXYu3mvL@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/2026 1:51 PM, Taylor Blau wrote:
> On Thu, Mar 26, 2026 at 08:29:57PM -0400, Derrick Stolee wrote:
>> On 3/26/26 6:32 PM, Taylor Blau wrote:

> 
> fails t5331.8, which verifies that pack-objects correctly handles the
> same pack being specified as both included and excluded.
> 
> But if you do the following on top of the above:
> 
> --- 8< ---
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 37c69f307d2..b6e4f950a67 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3946,10 +3946,10 @@ static void stdin_packs_read_input(struct rev_info *revs,
>  		if (!info) {
>  			CALLOC_ARRAY(info, 1);
>  			strmap_put(&packs, key, info);
> -
> -			info->kind |= kind;
>  		}
> 
> +		info->kind |= kind;
> +
>  		strbuf_reset(&buf);
>  	}
> --- >8 ---
> 
> Then that works as expected. I agree that the end-result is a little
> easier to read, so I'll squash this into the subsequent round.

Ah, yes. We should augment the flags even when finding a duplicate.
That's the fatal flaw. Thanks for working through it and fixing it.

-Stolee

