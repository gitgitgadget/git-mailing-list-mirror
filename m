Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB11AD9E7
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933898; cv=none; b=RdySS5QHMlYEnn0ZjHT/CoolTpxbAcSjO5lkrW1bIfVhNVcMup4o8tju4zsZhZ3vGughSD/iOQfgW/FBxG7H9wzrp1MzDG02MdAZIUIk7b6DTphsPZzX17YP+5Qv61QASi1IHI6FvjDgRfEczAUEbtefEuvfhkiGFt4Xhs0dCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933898; c=relaxed/simple;
	bh=IrJarU1pETUWkHcMaeldtNG4ZNWJKDP/w8D4PkbtZQA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BswKdjGqJ3kJLHteqdCHNrCFlrb+G4hXc6DsP+W3pHSpIPDv/Xl0o0H5Tn1a2pvIoElcB3TubJc7PwTyl+8zmQ3i+Mpt8fTF3JjP9V6pafl0Fm6m2ZDcUeH+OwLu3rJmLQlmwUgKg/yfvvhX1W/vtNUT+vDdAliSrnEAvTD/IN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udy1X89E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udy1X89E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-425624255f3so26616305e9.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933895; x=1720538695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIT7tFTJYC+wPopyc9GIUN9SdIj/BSClIqmtDHEY4ic=;
        b=Udy1X89EFvLPw9uro5bkqPJnWSC5DTnncSL2FHPgktQQJx3MIzFS9MpXvTX2qv6b/4
         IKv9piQ++gRmCWvDIDOMFIRLBiCQghPwYwZW0E0wVuUgphYRoTxoP2PmfQKbJfj6tSn4
         f3O4OvsdqTSDTJKdQKTe1HS2K1K4kxJG+/noQduuZzs2ySrem41XeNCzbSNqHW2r6z3G
         RcsFA9LcA8aZMQysG3m9y2jQPvtCGRSvA01oHZUqsJn1Xe5KlIKN77DXV9zVtsGA6qCG
         bPE7ZcJGVVIDoJJUXz5yTbXiUG7az9DDIGBwHJM683myVaTZ7+ylxbyMMpNcGT8/iHtb
         8aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933895; x=1720538695;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIT7tFTJYC+wPopyc9GIUN9SdIj/BSClIqmtDHEY4ic=;
        b=vIvPzQ4BBkW5A4XC8G9ZqmijTf7zs0TFMkh4Yv1AYWi/o8C9tAgJ//ufyZLzMSKVGO
         KDJTMiKqlKZbnsfOABCcS9LNfVte9ULp0QhqG9YWQs1h8h3UOu5kNJNawkhSEU3ULo0h
         4xwXPveQv8GYP4vAaJ8X/1Mp8z5v/WcsE3JCKNrcXTlFHeD/PZ2bdYU676gmBvessoAx
         4L+CZNelP1GVm6ax7QTCDtxo7MFHjWuVhKYeKB9GZ60xdjlVImjR32AcSNiosxO7LgSC
         MNeQ4Rf836d84NjzOtexUdQp+/4sIfIUs7IX9DSGVb4PRy50QLJClwtRvlvlJA8yduOo
         LYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsWgUBzwMyqsDOOLLBrHjtvdhjW7+kxjFtfARGxVmJe/YVXX52HlLhlBAyj1vViF8iDQOF0D93ijRTxcC/Q2UB2Yu6
X-Gm-Message-State: AOJu0Yz7fOLJ9tdKEgZVnIms/UukIRsGw4wGXNWOdBMOfph9fohjKibU
	w6PFZ5zdAfPTsccB5SDMNN+VL3BKAGCl9Itc4feEO6mT6jp3YEbj
X-Google-Smtp-Source: AGHT+IGwrSFZ/qxV78hcnAuAtCglZflwHDA/WcWS6hba5kVVNsP0y890C/WViylfkHYFezJXf20w8A==
X-Received: by 2002:a05:600c:84ca:b0:425:6da9:51 with SMTP id 5b1f17b1804b1-4256da90069mr105740885e9.4.1719933895470;
        Tue, 02 Jul 2024 08:24:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257c4e1112sm130516915e9.3.2024.07.02.08.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:24:55 -0700 (PDT)
Message-ID: <16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com>
Date: Tue, 2 Jul 2024 16:24:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>,
 christian.couder@gmail.com, Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <20240628122030.41554-1-shyamthakkar001@gmail.com>
Content-Language: en-US
In-Reply-To: <20240628122030.41554-1-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 28/06/2024 13:20, Ghanshyam Thakkar wrote:
> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h.
> 
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> This version addresses Phillip's review about detecting duplicates in
> oidmap when iterating over it and removing put_and_check_null() to move
> the relevant code to setup() instead. And contains some grammer fixes
> in the comment.

This version with Junio's fixup addresses my previous comments. One more 
thing occurred to me as I was reading it again

> +static void t_iterate(struct oidmap *map)
> +{
> +	struct oidmap_iter iter;
> +	struct test_entry *entry;

I wonder if we want to add a bit of paranoia with

	int count = 0;

> +	oidmap_iter_init(map, &iter);
> +	while ((entry = oidmap_iter_next(&iter))) {
> +		int ret;
> +		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
> +			switch (ret) {
> +			case -1:
> +				break; /* error message handled by get_oid_arbitrary_hex() */
> +			case 1:
> +				test_msg("obtained entry was not given in the input\n"
> +					 "  name: %s\n   oid: %s\n",
> +					 entry->name, oid_to_hex(&entry->entry.oid));
> +				break;
> +			case 2:
> +				test_msg("duplicate entry detected\n"
> +					 "  name: %s\n   oid: %s\n",
> +					 entry->name, oid_to_hex(&entry->entry.oid));
> +				break;
> +			default:
> +				test_msg("BUG: invalid return value (%d) from key_val_contains()",
> +					 ret);
> +				break;
> +			}
> +		} 
		} else {
			count++;
		}
> +	}
	check_int(count, ARRAY_SIZE(key_val));

to check that we iterate over all the entries as well as checking the 
size of the hashmap here.

 > +	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));

Best Wishes

Phillip

> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	TEST(setup(t_replace), "replace works");
> +	TEST(setup(t_get), "get works");
> +	TEST(setup(t_remove), "remove works");
> +	TEST(setup(t_iterate), "iterate works");
> +	return test_done();
> +}
