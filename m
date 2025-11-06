Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A930F7EE
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434270; cv=none; b=fUtEHnzX9ND+azfcnBpI6sV3A6+glilka4q9PMRpBFJyOLCEJxgojO3xMqbYeKeIHWHFpzjYAEKplEsIwQD5JCcs8EQJqyhjziI9JvTj8KRETMkTcni7ZPyB+p1B8TjfSBOejDdgY/sj3j7/8bonbkIuEfd9O8taoqFtNCz8KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434270; c=relaxed/simple;
	bh=aRCtC6a5FrIjk68SviZ135Fi5B8gYUI1svNd+WQQhiU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNFwQDgvuVpxaPCj/LuLqpXgtaAepHfOkA5537jd6uXXUCBZOrNCcoN5gM9ydlJN9+/eeDDhr+rUv70p/fARgOklcUkjr9iXW027yUy44R2PKCCArwRRWF6c0SWQMQ+44w0KM8Ry7L7qViUYx1dx7UHJQJaC6cnzsvUJcRpobUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDwqE/zA; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDwqE/zA"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db2a0661e0so536741137.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434267; x=1763039067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmHizhwbcXrZ1rSWhrxh25p+KI4HGB0a6kg5HmL/mUc=;
        b=YDwqE/zAafMCT9pcMxhKV4J7GXOLKWhj/Rz68rhWwFHwCMZSUGuiYflvQcu5pBkFSt
         /Z7H/UdlWavm0xpAjHqnZOdBovca+MD17XJvVIsTmhclkrNubV/OpHP4TCaMac5tMLHH
         XS3k4Ng8GAQ3xcw5grYrxe7c3Jf+gNW1aWUiupKGZ/QvltUxaUr88Pel6+G4e8Qdopej
         tRODfweRW1ScCo46cE6dFXA+dSpRcqA0su11dS8bucK3/9BiVRxZkAYTDvjecdhudTLT
         kNfInuM5+VZNAkq7jQY+NkShWZc8xK66dwbgOFd2xY0HrPe5+oZWcwy1mpifS1rb4eUR
         OouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434267; x=1763039067;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmHizhwbcXrZ1rSWhrxh25p+KI4HGB0a6kg5HmL/mUc=;
        b=YNpUsMJZVMKsSnZcFbiaeGmkJyg5MatUgN2motVATL4SlU9SCSPg+Q7bFWYJyZOBfI
         HfoZ0xWSFxjgWNGFny9+UnKK0v/y+rxHf7L5Qld6Ny4KVVDueGV5H3GbAuo8rPnuOZT4
         wE+Nbq95J+M3eva9qeIl+VDiq6YYhXL2CY9osb/eunFrHg/r9Iv2Wemv5c8RgyonOduB
         v3c/M2bc49gdUD6joIdC4nH3JP29NoAgYlSrmRWUf4Hdcw3Udgww4qH0P49099GocJLY
         Uo9f1nf+AjEL/1EgJcNT1nHijK7bWR4ceGNFSH3YqS5ehD7FkY6D+XV6Drv2OahMIwcy
         pbMw==
X-Gm-Message-State: AOJu0YykYgbzLvo7DW/2+Yn4DVhGEifiuayCDu5Tj50h+ON3O99iDx0s
	GQ4Lq8wjo6ZT8gh6eKC8ev9IoKvOQSOqB7NB93vdyqZEpqokHzu/eAbLvwv7EfE8ok5CDLtAQGT
	qXB58n8O+4S98tFMHmFfwJirPU0EQ628=
X-Gm-Gg: ASbGncsEdrYh793HoJFB20uMEitVivKbcw1YatQAn4B5MM9eLQ4/drXOYIBGPWP/Tj5
	t5cr4SSqkBGnF0kxLis/B/XiQ65/mb/3dZuy6XE0jXB4wZe1jYCRBPxu0UuJeXe9EsGJCSvSbmu
	yLoqgEcmvom7cgBCT4v7/rJi01yY9X7UENx22nUl+w9utYkr103xxC0mdH2q5JKrPaOs9arTlz5
	ChDq9WbSAxJGE1+L7PUHGNao8+JwyNaj1Rm5tZ2aVR5S3suvL+9BXiZ1M4=
X-Google-Smtp-Source: AGHT+IFLOFUF2e2Hhdavmy3WQxtoN/4K4QmMUfoIYDemS+h8zFg7tqbe8LSUi7Sps+WctDtSGwkBelVGnwTe8ChuIHI=
X-Received: by 2002:a05:6102:f0f:b0:5db:e2c2:81a1 with SMTP id
 ada2fe7eead31-5dd89129783mr2244766137.14.1762434266718; Thu, 06 Nov 2025
 05:04:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 05:04:25 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 05:04:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQyNSOdPWAxm15U3@pks.im>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
 <aQyNSOdPWAxm15U3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Nov 2025 05:04:25 -0800
X-Gm-Features: AWmQ_bmE-zdbIouOczDZQF5t913XTGqq5kOIFAntBFsYcbQHCJOCgIdhUS1D9wc
Message-ID: <CAOLa=ZQ18H8WCp_m=7rzWt1HRRiWv5Ag63ceV2r=_BwyttyK5w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] maintenance: add checking logic in `pack_refs_condition()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000068741b0642ecb44f"

--00000000000068741b0642ecb44f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Nov 06, 2025 at 09:22:33AM +0100, Karthik Nayak wrote:
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index c6d62c74a7..c3e7a84ec2 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -285,12 +286,26 @@ static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
>>
>>  static int pack_refs_condition(UNUSED struct gc_config *cfg)
>>  {
>> -	/*
>> -	 * The auto-repacking logic for refs is handled by the ref backends and
>> -	 * exposed via `git pack-refs --auto`. We thus always return truish
>> -	 * here and let the backend decide for us.
>> -	 */
>> -	return 1;
>> +	struct string_list included_refs = STRING_LIST_INIT_NODUP;
>> +	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
>> +	struct refs_optimize_opts optimize_opts = {
>> +		.exclusions = &excludes,
>> +		.includes = &included_refs,
>> +		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
>> +	};
>> +	bool required;
>> +
>> +	/* Check for all refs, similar to 'git refs optimize --all'. */
>> +	string_list_append(optimize_opts.includes, "*");
>> +
>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>> +				   &optimize_opts, &required))
>> +		return 0;
>> +
>> +	clear_ref_exclusions(&excludes);
>> +	string_list_clear(&included_refs, 0);
>> +
>> +	return required == true;
>
> Tiny nit: I think in our codebase this can be written in a more
> idiomatic way by saying `!!required`.
>

Fair. Will change.

> Other than that I don't have anything more to add to this series.
> Thanks!
>
> Patrick

Thanks for your review!

--00000000000068741b0642ecb44f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 40498a61e369f107_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTW5OZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0JqQy8wUWNENzZVU2R3OTY2dkdPdDl0WEFWcUJqeAoxOVk2WnVsdGVI
RCs2bkhkYmY5djYzMmhDTlNWa01NTERYd214Sk9Wa08xbzBSRmNMVkdDbDlCVldQMGpRc2srCktz
bm5pWlcyNDlsZmpRSUxzalVCakF6cy9zNnpiT1pvcFRReXRDS1J4dmhOTXMwaElzUnB1L2E3c3ZR
UGVPa3gKbWt1OFJtUHNLaTBaT3UzY2FFd0UrOENVSUVzb3RPMGlJdEROWUlHYzcwdFJ6Si96V3BT
cmNkNk5TTzd0ekV0eApZZkdKcU9LOGoyQ1JUK01KR3VGQUNuVnEwcktvV0lvZVcxNUxrWEFqVmFJ
M25DZEgyblFJSmRKQ2Q1UTRvNVVmCnFCODNKSktKcGhuTnJYcUlwUVBQNUk5bC9OWXBXMktURTVp
bEh2Nm4wcnh3WVRVYVhtQkJVTWlZQzVUMHYybnUKZ1kzQWpXaTlJcXRXakR3Y3UyODhVQzhBWFIv
Q2hlTUp5VStGZ2VRU09rV25XUnYzb2Z2VjRyUGxDajlNaEFyVQprTkx0S21jQWRmNHIwSzVnQ05S
ZkhPbWUwMW9KOGpZQ0NBRTI4a0VMVEwyaDE5TC9VaDZGWmpjNHNRS0NSa1FUCloreVJxekF6V1VR
b0twUC9QRUJ5ZEQrT2k1alpra0xQL2JhK3Nqcz0KPXNQeU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000068741b0642ecb44f--
