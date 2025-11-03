Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1722ACEB
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189474; cv=none; b=V16wnVgWMf/d/Rk1KY34R0VpIXM1MBjSOAetGTWB96ef4jnFs36z/DiZf8BU4N+yRuMbkPPyK3ytS2SPniNo83RL2V54MfCakMhQLKZz/vnSemODm4ET3nZqI8PRpNHWeig6QOHPJBTfOy+Lhn4Bz3szMrpkMP+sciBaCqZYdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189474; c=relaxed/simple;
	bh=oR9eLUAS6Q8hp4g8BT0p4OzJdfTOPlK9aP5ZbcMpPic=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3AkRDUfwSqMftFIlNTdo9Y1ka7UxKz3EeqcAZCfs24AEn3h/FtON9k+L0OMzoQV5cgKIxaghReTRsGYAuri2+gRzpWnee4u/QkCL7Zecmxxtx3J1wtaZFmSLUEglUgruHR34sER0HJ9TMDtx+MfhhccW1g5mzCEvqp/3cjuBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWMp9lFL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWMp9lFL"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93537656791so446815241.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189468; x=1762794268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xiDVS5nP2g/Xu045jmb2P1DEhhfSsOhUEr/KACGLE8=;
        b=eWMp9lFLgis8Xnq6UxU8qPcMZ9sFaZjVjvhbqzcAgVWqp7nYQJA2YszlU7Zl8VUMZQ
         4ZLSzjhK6Or+WvTABmM8hICfmZ/BjTxisVUzKiC1/O1N3QiMil2/v+MjV/3/DP0D/Jkw
         bCmkz43rZxtNZoikja0wb9PXkRHgYxHnAGhqgPszy4kb87sZSEOWdKlTW0vc5Yj2pS6b
         9bekD3guW79vpBLePD+gHTPFUFe5aTfqLwpbo3vGj9pgjXHL9rCRv1nbF1/UJYSyfVbz
         j6myO0BsD07mAly+Yrj5ZvTp3Ca3U5TmUKRDaM0jOt3B4N9GvFUbtI5WTwqrfGBl+yjX
         DAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189468; x=1762794268;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xiDVS5nP2g/Xu045jmb2P1DEhhfSsOhUEr/KACGLE8=;
        b=BqBs8YSXjI25t0O507P86tc7yi2XreJMZDx9NCDGVTT65exPWQ+3QBS51gBW7srXkh
         1XaHCv55OBoc8fwkfrXFcShjKxNV3FGzJFW1aC/3zA8HJ4SoHwkwFZmFYrZ2Bziireqk
         2it1nRcFs99S8/TxY5qXAVljwdfcveoQlY9ZQ3hxoJHP97E+st2owMsO7JQRA3P3lcc2
         xXFpdWr90pFd2MsVA6PkAbL/Op0vjvpaM9goqie765X5zJrDlddfpSNFiY7EvKRC9We0
         6jX6dcwniP50JuFsmIammT2gfJ3Ix+keRN5xRjZ9LkXU9sP2NQ/OBbsad12DSa9CXRtc
         032w==
X-Gm-Message-State: AOJu0YwBcKO8f63lmUkLEDxjI2v0fSOng4IIbifYWXpl8HD1lB8yb9HN
	NZTuwE6T+LtA45enCnn6/qqp8yMJLy8gg+YMAMulb0S7VcjZx4H81d4Fu6EzH2l63VxvG+DyrYm
	rJeyP6V+HB0cQKaaLF+xTnkw1HWMR27wy0RhY
X-Gm-Gg: ASbGncu6bB1B+jtzqqb5Ma4OmV0f7dSnPMlOwGAo23e8xakDnyb396CQDF8tSh71XVn
	DPXQdy4HD3S8XIIBJ4m6Mv+igqcelp7Ca8lwe+2wXLz4bG7oGchtuP367vASSFejpyXpkdvf3dn
	XW8zMFmc7WEXu4kAjCT/MWwsxqRa9B3liKtKDaVbavPBHqh5EY9/OXT8wgLMucRNqO6Nb0Y6nVw
	XSk/YyhWZIM2eWT4qkq/3klkqJM73EtBr2oTrAwpTOJkaCxQv+RpTbSgZn6ymYn+lRkCnrMF/Hd
	v56eow49rm+vfbRvfJkvoB+Ahw==
X-Google-Smtp-Source: AGHT+IEpYVMXzNoy18/kR5tdo2ALp7eezO3GhAdBDPN3HpDOgN2pccirQE++XD/ABqjv7wKDiKMqOVETGxbznz5wyaU=
X-Received: by 2002:a05:6102:5112:b0:5d5:dbbb:5b86 with SMTP id
 ada2fe7eead31-5dbb12f75c3mr3346191137.25.1762189468328; Mon, 03 Nov 2025
 09:04:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 09:04:26 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 09:04:26 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQi1e0zWfRaxSKtz@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-4-a03d53e28d0e@gmail.com>
 <aQi1e0zWfRaxSKtz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 09:04:26 -0800
X-Gm-Features: AWmQ_bkrC0TX1SiQrarrqzp-axxaSXkl-NGGypdxPfN6L7uvqRx2zaf7VjT7bcM
Message-ID: <CAOLa=ZQSEETU_AzKdr2ugH9982bgPFazAR_jHFoX6px7Txy=Yw@mail.gmail.com>
Subject: Re: [PATCH 4/5] maintenance: add checking logic in `pack_refs_condition()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000049a59c0642b3b59e"

--00000000000049a59c0642b3b59e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 31, 2025 at 03:22:24PM +0100, Karthik Nayak wrote:
>> The 'git-maintenance(1)' command support an '--auto' flag. Usage of the
>
> s/support/&s/
>

Ah, will change.

>> flag ensures to run maintenance tasks only if certain thresholds are
>> met. The heuristic is defined on a task level, wherein each task defines
>> a 'auto_condition', which states if the task should be run.
>
> s/a/an/

Yup, thanks!

>
>> The 'pack-refs' task is hard-coded to return 1 as:
>> 1. There was never a way to check if the reference backend needs to be
>> optimized without actually performing the optimization.
>> 2. We can pass in the '--auto' flag to 'git-pack-refs(1)' which would
>> optimize based on heuristics.
>>
>> The previous commit added a `refs_optimize_required()` function, which
>> can be used to check if a reference backend required optimization. Use
>> this within `pack_refs_condition()`.
>>
>> This allows us to add a 'git maintenance is-needed' subcommand which can
>> notify the user if maintenance is needed without actually performing the
>> optimization, without this change, the reference backend would always
>
> s/optimize, without/optimize. Without/
>

Thanks, this is better.

>> state that optimization is needed.
>>
>> Since we import 'revision.h', we need to remove the definition for
>> 'SEEN' which is duplicated in the included header.
>
> Quite weird that it was redefined in the first place. Feels like a nice
> side effect.
>

Indeed.

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index c6d62c74a7..72177305ff 100644
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
>
> A bit weird that we have to declare these two fields even though we
> don't really care for either of them. But I don't mind that too much.
>

Yeah, I think there is some cleanup to be done in the files backend. But
I don't think it should be part of this series. If we don't add these,
we crash with a SIGSEGV.

>> +		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
>> +	};
>> +	bool required;
>> +
>> +	// Check for all refs, similar to 'git refs optimize --all'.
>
> Style: this should use `/* */` comments.
>

Thanks, will fix.

>> +	string_list_append(optimize_opts.includes, "*");
>> +
>> +	if (refs_optimize_required(get_main_ref_store(the_repository),
>> +				   &optimize_opts, &required))
>> +		return 0;
>> +
>> +	clear_ref_exclusions(&excludes);
>> +	string_list_clear(&included_refs, 0);
>> +
>> +	return required;
>
> You return a boolean, but the function is declared to return an integer.
> This works, but it feels wrong.
>
> Patrick

I get what you're saying but returning `required == true` also feel like
a bool return to me (even though it is an int in C).

Anyways, I'll make the change. I don't care much for either.

--00000000000049a59c0642b3b59e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a3403c41a39b778a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSTRKY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2RNREFDVWNDazg2eDFhSWpCUHk4VWJQVVdrSFVoVwpWRGxmWTk5eDNV
VS9VbU0vUzRlSDZYbWxlSitDSktVREVycndKSGxrY1orTUlRR1AwbFplVXNwcmFnTWdyTi94CnlN
SDM1c3ZzSThuUmd4SENHdlZWRXA1YU9FU0FvTjRZN1FkQjQ2eHJRYWk1WFEyS3BMRDZDUEVIaW5V
RGpBVG8KR3YzZlBmT3h1R3NJdUI0SHc2dmJNYTd1SWRuWkxWUG8wWTV5KzhyaU5uWjRoTFhEYTFJ
cUpqd2VORW1FRXdFUwo3cmFCdzZTNGplbGRRNWY4NjQrODkxbXJkS3RRaVl6M3BDRUt3clpHSmNz
OGQ5eUZSc3ZCUXlIcVgveEdYT0FuClFNakszQjdUUk9zMlJRNm5ub05veVg4cFc5ZjVDUFRXS2dD
eEdYL3JmN0szK3FBenNWNThodjVTcTFhYmhSR2sKQzR2MG5MZllEbFJoNS9KMXpsTmJJd0tnQzJ3
THpPWndmS2NnakhkNTdPZ3BpaTYrK1pJOWJwT2pIM3cxWkNicQpDVkZiVXJTMmNVTDh5dHJzT0R0
U3U3Z0U4NlVocmhieldVY3NydXBZNzRpbmMyTzJieWlzeDVSTEo4SmQ3bjRUCloyOUNwNm1USFdw
ZTN4VThQRFZzTUhQNkZ4SURtQURFS3U3ckgvWT0KPVlhKysKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000049a59c0642b3b59e--
