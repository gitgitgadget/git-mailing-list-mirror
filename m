Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF81D6DDC
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132283; cv=none; b=g/TxjIuYN3wPdOzaR8LLU+3ekSKn4vlqjufR+GqJQ87BN4QB/kNyuhiQNU0xAewvBBhUoqaZtEVr/Yy2BUIXXF7dXOxRFvgIbOd9JsvKOkuebnin0gC3YiYp51FJZtkX/zenA0E6RRFb6QjhCCca1F7UNdOIcPVoWPsEFyb2z1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132283; c=relaxed/simple;
	bh=wFMZIqE0JZnotwBwoP20gfSlXr2d0qu730wlcSXMibs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K/SG9P2WBpF2qBnSAXS9iFcg97xS5/m2fHmI5QcPa0MngJ963Tz/VtXf/GwEbn36GbJicz6h+Ew9aQeoSlsorwXayNqomMziwOcN7loyi/8c8QiCA4L+dl9SrBKYE7v04MThi85ZZ4AfYe4psaOCCI+huXVKTrs0Gdx+Kxs6Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA6eKt1b; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA6eKt1b"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38de1a5f039so1644907f8f.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132280; x=1740737080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RZ+8tQlQqHgYgYrOcmlQqfwUo3TZ7AHOc2McVe86lk=;
        b=JA6eKt1bC8l1jcP/wc/R2F72O48I9YZ4dR9TcaorMkP9Jr7wYPggZIVCkeBhMXuYCl
         hLLPkilAdCGpHI8IWq/y7ns95PFHOqvfkiKDIPDEhht91Lt+3p8oG1oTqpE6NmuQi97P
         +cO+K8E7x/5PD9uiOtNpD96xL1gS0EpGD9Rd3bP/n4/J4dkuiAEWd7KANNGo6WkEmrND
         ZIl1oXsRJZLY0APGg5A4vCwps+K41ibcBUmLJw/IqayDsK3M7vtHqaZ38bMBM7ZFtn8N
         clnRSSdZEm5ACPei6v4mlWeqfaOD+CeE1q+HuvuFX7z2RSY96U0anu7/ip/60LSdHy2F
         Nw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132280; x=1740737080;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RZ+8tQlQqHgYgYrOcmlQqfwUo3TZ7AHOc2McVe86lk=;
        b=XHDRsJ5siV5b3cMmLgdO+MgKCqequZLeeDkmaSaCtcxotSpgj/wspfr8XnmUzLAeTX
         P+zfdYQ5wb2z2YxGb+H0kOlW1mYH/9pWWeHaGYZSL9Zoej4nJ/LoGcGMiL0KkQd3RlGe
         X4IUcwvN+H7Lk3SalqmMawOWoXf1YJWPG/AnhEZL3XOGySbZVv3tv3Tx3/+31KwJAZ0J
         TuA2w4lnT4koE60PfsVfpfvYuXtSMkvLPugZl4n0dEMKMc58J2xCzOPbO3gWAAJEjmRS
         eVFHksP7sZZsxoa3dXzf39HrKyFNM0W1Bp/0yuEy6uKlpYgREyWcwt2/8m3jGKJKT3iR
         vatw==
X-Forwarded-Encrypted: i=1; AJvYcCVV4v8FWTj/NtqGSMZjYdaAHYnG5czjzM8WMIv+KkztpOGo59F3rvK1AR4m4nMVm6Ti6m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QMIgsHTCrz+r5h/qP3b6Vh7AlNt11nnMzIapM8xS7seb3HT1
	zFusqHHZ34z72m7OsteyA7lzPvJMGDl6HGNODoiX7ftLUupIwK1u
X-Gm-Gg: ASbGnctnOFcD+PYm/vgfsssMGxD/YpENLJd0LABgMetpGWqKiBCB+qrqvArk3fCqNAL
	d0m6OWukzTJPp36jDFDpR7wJGOzizrG/fVSyZHd60XntUvKq50HW3r/f3f7NIoQcawX/2L4OVAC
	JfugKaqtsNiSmEsqc+zO+1+Z3P/0HoXv6bLE/UfpAnUmVwtTiLEfZrBfkxKR25WvrxYL26OA0/P
	4iMXPmfgwnVrUd10AIkSoqZxtcfIdF0NscsIEpZwzgHx0Cil5fnhMH+RqiUAyie2xDO7LJsIe0D
	1lo8y3iZERc75SrM87jUwFuBj77TMK8QJPPiHV++AkqjqY948u+QoUrTu/BpOn8YUHi8YItDCPW
	AH40T
X-Google-Smtp-Source: AGHT+IEn9vYgjobT1sMGnFOm/YfnGk9BFRbc4AaXFxpI7A1thBsmb9MefzxEkv40an1AWOqxNKpYVw==
X-Received: by 2002:a05:6000:1447:b0:38f:2f0e:9813 with SMTP id ffacd0b85a97d-38f6e4c074bmr2297926f8f.0.1740132279712;
        Fri, 21 Feb 2025 02:04:39 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm23720579f8f.91.2025.02.21.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:04:39 -0800 (PST)
Message-ID: <efa58be8-e958-429a-a5bd-8df442f28bee@gmail.com>
Date: Fri, 21 Feb 2025 10:04:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] t/unit-tests: convert oidmap test to use clar
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-4-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-4-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:
> Adapt oidmap test script to clar framework by using clar assertions
> where necessary. `cl_parse_any_oid` handles the necessary checks needed
> for the test to run smoothly.

I'm not sure what the last half of this sentence means. What checks are 
performed and how does that lead to the test running smoothly?

> Introduce 'test_oidmap__initialize` handles the to set up of the global
> oidmap map with predefined key-value pairs, and `test_oidmap__cleanup`
> frees the oidmap and its entries when all tests are completed.
> 
> This streamlines the test suite, making individual tests self-contained
> and reducing redundant code.

This seems to be saying that by sharing global state we're making the 
tests self-contained - I'm not sure how that can be true. We need to 
move to sharing a single oidmap between all the tests because clar's 
setup and teardown functions don't take a context pointer. That's fine 
but I don't see how it makes the tests self-contained.

Everything up to this point looks good.

>   	while ((entry = oidmap_iter_next(&iter))) {
> -		int ret;
> -		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
> -			switch (ret) {
> -			case -1:
> -				break; /* error message handled by get_oid_arbitrary_hex() */
> -			case 1:
> -				test_msg("obtained entry was not given in the input\n"
> -					 "  name: %s\n   oid: %s\n",
> -					 entry->name, oid_to_hex(&entry->entry.oid));
> -				break;
> -			case 2:
> -				test_msg("duplicate entry detected\n"
> -					 "  name: %s\n   oid: %s\n",
> -					 entry->name, oid_to_hex(&entry->entry.oid));
> -				break;
> -			default:
> -				test_msg("BUG: invalid return value (%d) from key_val_contains()",
> -					 ret);
> -				break;
> -			}
> -		} else {
> -			count++;
> -		}
> +		cl_assert_equal_i(key_val_contains(entry, seen), 0);

I think wed' be better to use clar_fail_f() so that we can keep the 
helpful error messages. Using cl_assert_equal_i() isn't terrible as if 
the test fails at least we know the error code but as we already have 
the logic in place to provide better messages lets adapt it.

There is a change of behavior here as before we'd loop through the whole 
list of entries detecting all the errors. Now we quit on the first 
error. I don't think that matters but it would be good to point out the 
change in the commit message.

Best Wishes

Phillip
