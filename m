Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A0165FB0
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452885; cv=none; b=ZUcDWO2VLAt0yQX+Jvb/XrMqsQ1Tjj2/04/OQxt9t0QTaUqMOFV53QzD/32yfXuH+H3NvCO2FyL9G6HzSeyCGMavK4q9eughk1jJdVCdnkd0S+dkb/cuvSpNv5ZYhS8eTFozMarXDfuINVgefJThkxlX2OA/x6aHHp/or2F7pyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452885; c=relaxed/simple;
	bh=H5D5FJ41Y/2QeBHGf//e/pdAI/Qlx5By/5he7TRbjmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqKFClwQsE57p6hj5zZHbpX2AUaR7WJuGsLLm86N6BIS/N/yYlNDD+De++QbYRy38KrKBPP1BOKeSM5CntKoDPzxfKse1Dp7oMI3+muRFPx71PjVd3i26YbCFaCqSEv4QMn6wRM3zmcACKRW7vndcPA0pRaqNShlxtC++PYEJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjgMHsTX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjgMHsTX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso12391491fa.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452882; x=1714057682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6NIHWgiSGv8eMvkVytnidmVyFw8tqiIE/Q8oLLkVAy8=;
        b=EjgMHsTXBMlE+Tb45Y6dD+tfAlK0cLnOkycmacL+G+HXMhymryWtLOR7t958j1S0Fx
         MDOgbcahm84tz5YFdfmgfDwA8r/vSFj2Fml4OpIEmhN62MvAlH0/BmTfpmsCK6Lm2W+p
         xFhsjzK/KlH0r9IxVdqoNc6E2LSPtsnAMAnA7TAjS8EOJsK6QjlUFekrjL5Ff0QCaNBn
         hCgin4cCc0aULVBJa1CyDgpVJ0p9JjO9VAhSIxgyx/tSNyF81dUpJUkAQYELV9dByrvx
         J02HMqsKj1+ZTF7ciayh5HUdAXA0wpx9m8UGKuUPFaWykzOidKRm5EHY74ZEuGN1wQ/3
         CGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452882; x=1714057682;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NIHWgiSGv8eMvkVytnidmVyFw8tqiIE/Q8oLLkVAy8=;
        b=Ab0nQwHj+4IB5YCrlwiYOjXiLWQf3n1hhICI/pHbb3OzWRfIXXZknaHXreUmgly45M
         Q6GicIqfD+TnD1WbSA0sZ5M6QH4/w5niWfi1sfrITgjigQbyVuef7TavjQOuVN9ok6GU
         OjemHIE70Ngocc6OlQhkIBR9HRc2lnHz0e3YTebmTzB/ay0ivZWcRJPiJGmnoGV3mHw5
         +ykUXPrH7E4n/aLubbCr88ew7fNZZSlXRll4v7F+jo7D+GMdWqTYZ3Ls0gaMo5qUaju0
         bOA0q5Pb8dYog6cWbnLiGgVSeXJPL8wsf6D6TBdpHTpAbijq2WKG+khLJLHX05NTne4g
         sa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu2/J4BCGqxdBYFI/zkvHUp5EXDGHKdHENyWAHtqFH71rZcXGNTIll27H4RPlsBC7BIU9VZpkZN7G9fGH32cw4BlP8
X-Gm-Message-State: AOJu0YwYL40TBTzMQeGRiXYHJZbfg/er8b6rXQ19e7XOTt0TjDqPftDo
	LseJ5sB/o0B7dTbiyM0rl7bpmJRvg97zYcl5lApusrVARajNewcF
X-Google-Smtp-Source: AGHT+IHgq1e+8AVXsGQOe6btYwYItqTGy6WNQAeJdYUfzBGpTr0OblwruOXKEcUyTCGKRMeR9kMptQ==
X-Received: by 2002:a2e:3217:0:b0:2db:175d:a261 with SMTP id y23-20020a2e3217000000b002db175da261mr1893185ljy.29.1713452881623;
        Thu, 18 Apr 2024 08:08:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id z6-20020adff1c6000000b00343ad4bca7dsm2043377wro.85.2024.04.18.08.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:08:01 -0700 (PDT)
Message-ID: <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>
Date: Thu, 18 Apr 2024 16:08:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240412095908.1134387-2-knayak@gitlab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

I agree with Christian's comments on this patch, I've got a couple of 
additional comments below

On 12/04/2024 10:59, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index 55d2e0b2cb..967c81167e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1228,6 +1228,7 @@ struct ref_update *ref_transaction_add_update(
>   		const char *refname, unsigned int flags,
>   		const struct object_id *new_oid,
>   		const struct object_id *old_oid,
> +		const char *new_ref, const char *old_ref,
>   		const char *msg)
>   {
>   	struct ref_update *update;
> @@ -1253,6 +1254,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>   			   const char *refname,
>   			   const struct object_id *new_oid,
>   			   const struct object_id *old_oid,
> +			   const char *new_ref, const char *old_ref,
>   			   unsigned int flags, const char *msg,
>   			   struct strbuf *err)
>   {

Adding these two new parameters is quite disruptive as all the existing 
callers have to be updated. It makes it easy for callers to misuse this 
function for example by providing old_oid and old_ref (I'm assuming that 
is an error but it is hard to know for sure without any documentation). 
It also makes the calling code harder to read because there are so many 
parameters it is hard to keep track of exactly what is being passed. An 
alternative strategy would be to add a new function that takes a struct 
instead of lots of individual parameters. That would make the calling 
code more readable as it would be clear which struct members are being 
set (see reset.h for an example of this). The approach of adding a 
struct is still prone to setting the wrong combination of options so 
either way it would be helpful to add some assertions to detect mistakes

	if (old_oid && old_ref)
		BUG("Only one of old_oid and old_ref should be non NULL");
	if (new_oid && new_ref)
		BUG("Only one of new_oid and new_ref should be non NULL");


> diff --git a/refs.h b/refs.h
> index d278775e08..645fe9fdb8 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -696,13 +696,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>    */
>   #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
>   
> +/*
> + * The reference update is considered to be done on a symbolic reference. This
> + * ensures that we verify, delete, create and update the ref correspondingly.
> + */
> +#define REF_SYMREF_UPDATE (1 << 12)

I'm confused as to why we need this as I assumed that we could use the 
presence of old_ref/new_ref to determine that the caller wants to update 
symbolic ref. Having this flag means that there are more possibilities 
to misuse the new API setting this flag but providing NULL for old_ref 
and new_ref.

Best Wishes

Phillip
