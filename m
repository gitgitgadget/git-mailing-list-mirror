Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D748E0E3
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380350; cv=none; b=rrMx0btD9WoIe7HPlYGS++3na0bNnDPwB5Ukg55noP1h0L+hCskgPESy/3Y8wkVhVnyLgMHidven27OiUFp8gYn7mF7Yxae7nvZujFEV+ZwCTZUQFYHfg0LzaCZVcGWC48Op+1FGC/LAC2DZVG5U0Z4KVd2TURWFFOlSGVYWDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380350; c=relaxed/simple;
	bh=v8Q/8DuOnoBSiu/5jrUNlSK+OQ7Sm98MmJdiYl0idBM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c6NbwmyX5mIQnNVdUSR1ZP4BGUAl+BO+hIIUMGuMmxdk2FpHBywn/5sgKLeOk4+VrqIrhbpffRmTgdt5G7E4BMsJMts0tOHH3P5BSLSb0gew43YKOk//F60dsTI22gFXwMEc0yKioUexKTbnlCBhcMk44Ah1TDA4s/bSbIPoMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oG0D+hjf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG0D+hjf"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so269234966b.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791380340; x=1791985140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fBGPtaVy1uySLXv2ORfiPoCNXjUQXCYhGAyRP5iAWM=;
        b=oG0D+hjfIVGlBLDPJCn4CAAuv3WZWpE7fCvuZmXjmadBmod3s7/Rjh3+eXX99hteb5
         GBEw4FTD9euWbH5D3pfTzQu0lNY9kmcv94gTraRfwc4GGSkOlNwIYPftNAObgMB63QO+
         j3xAkFaEcbHkRDK2Co4ynVDREs8M+PlQ7tCQpSYtzhePF8JWgPr64UgQUf7WXCeuIg3y
         qcfBWo7GdRX/nu8AqOWKymO4VcwinlBEMyW9pD3GX7j6zExVtTcAqWfVRx/tJfSNXhH1
         D4SeHGAYjgXZrxryn2sD3LCnny5OVga13XIEBA8BqdRTih3m6Cs+HBiaRBehqd+PIcEZ
         uPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380340; x=1791985140;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fBGPtaVy1uySLXv2ORfiPoCNXjUQXCYhGAyRP5iAWM=;
        b=rdpEwN+bMEnHybwsC+2dcJ8okhI6gaigNet/9DgL2eMbf3LGp0mkDnKLM4y7Yj3Bgh
         eayBilwrg/cJQry+SfzgzgC9jJgKBzia1UgvuBnXSr1Cx1tFq37f7cSjlPxADzRLXulG
         mYVehx55bjqtjKCR8Gu0G3dLK/3Drne9eYH4yUKdKhzS4IFkAX7Yokfc6/4Eov1aGVbt
         KK5JIueqXb+i3UUXJtJ9Y4IjNEWbKuGUqcr7v7LuGojFWxhghoLjNDDhBm7t9xPcY4WN
         D2rpCbBXfpXeSc/pXeMZHOZs58g6NW2jHji8Ir+f16nEH2mrc0jmupnz+LABZY+tu3rM
         ONpw==
X-Gm-Message-State: AFuF++nJsmNbSnO9X44pR6jvtLHv3aM7Qr2ywDnIDnlU4T4A0ZnYTbRM
	qHgbqaopb2x9HQYIY9a8gU+XRSQKZZBP2SCD8TNFgTO6WKq5YVN/gyDiZQfdQQmB
X-Gm-Gg: AYBFou3YakcRLrLWYeWppJJY7AdSCLuLoMDX6FHYoYwZF8+S/1ObOgl8Ul5DZBdyxLi
	/aO2Jx6AhwBWLuppbvdYCb4sBlYklT6szfrpjqJVfg7hJBhaALdd8b4i6WeI7MxjHLNmSBMI9O0
	VN60RfQYgtmLcII2ShfyWJ2VbLh2ZQHux/sZz3ZRfLHpC4ik5uF5JOLF/kmzqXbSIdSGK4ZTauW
	TF9+3CbF6PaDXM+NCBu9mFAU7kD2Z31lOZxTtVtnZrMHpzPN7MP3vkuY48KguwHT13LIagRuhNL
	cetAk6d/YlDguVqTgonLIF8y4GKA53Iq6OxGr4fhHwBU5Qz+VwmTiyiHEwOycijXjytZXGjihUM
	2kWCMCnfma/ys6CXuq4YMUfo+olSgpAzqwRKXRSNA2EiXRqpKBzuORb66vYy+QMcApannSbovYR
	9Er+QLDq0iZGpOifkyrGWTATOE6/Va8r1gZXfltJrbKYZkvQyEAYKtM1BaNZV6dO9tryPp2zWML
	BsAXsDTC1LRBT8VsuRKJnmEBXHBcSB8ll5/9f41vbmg29hpHC64manWTos88ig=
X-Received: by 2002:a17:907:3d89:b0:c2a:f1e7:d1ff with SMTP id a640c23a62f3a-c317bb4cba8mr215191166b.4.1791380340130;
        Wed, 07 Oct 2026 06:39:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c176e4dsm107346266b.14.2026.10.07.06.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:38:59 -0700 (PDT)
Message-ID: <42d3f663-6eff-4311-9bdb-d437a757bff5@gmail.com>
Date: Wed, 7 Oct 2026 14:38:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791206658.git.phillip.wood@dunelm.org.uk>
 <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
 <xmqqh5iyg7bx.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5iyg7bx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2026 16:46, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> @@ -4969,6 +4973,13 @@ void merge_switch_to_result(struct merge_options *opt,
>>   			return;
>>   		}
>>   		trace2_region_leave("merge", "write_auto_merge", opt->repo);
>> +
>> +		trace2_region_enter("merge", "write_merge_labels", opt->repo);
>> +		opt->priv = result->priv;
>> +		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
>> +				   opt->priv->labels[2]);
>> +		opt->priv = NULL;
>> +		trace2_region_leave("merge", "write_merge_labels", opt->repo);
> 
> A "if (result->clean >= 0 && update_worktree_and_index)" condition
> guards this code path, so we unconditionall call
> write_merge_labels(), whether the result is clean or with conflict.
> Am I reading the code correctly?

Yes, I think so. Ouch! how did I miss that?

Will fix, thanks

Phillip
>> @@ -5234,6 +5245,14 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
>>   	 * to move it.
>>   	 */
>>   	assert(opt->priv && !result->priv);
>> +	if (!result->clean) {
>> +		opt->priv->labels[0] =
>> +			mem_pool_strdup(&opt->priv->pool, opt->ancestor);
>> +		opt->priv->labels[1] =
>> +			mem_pool_strdup(&opt->priv->pool, opt->branch1);
>> +		opt->priv->labels[2] =
>> +			mem_pool_strdup(&opt->priv->pool, opt->branch2);
>> +	}
> 
> But we only populate the labels[] when conflicted.  What would we
> write when we do not have conflicts?
> 
>> +int write_merge_labels(struct repository *r, const char *base,
>> +			  const char *ours, const char *theirs)
>> +{
>> +	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
>> +
>> +	if (!f)
>> +		return -1;
>> +
>> +	fprintf(f, "%s\n%s\n%s\n", base, ours, theirs);
>> +	if (fclose(f))
>> +		return error_errno("could not write '%s'",
>> +				   git_path_merge_labels(r));
>> +
>> +	return 0;
>> +}
> 
> Would the answer be "(null)\n(null)\n(null)\n"?

