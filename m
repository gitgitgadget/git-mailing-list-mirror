Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAF267702
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731923; cv=none; b=fVeLAiAGWmsVHWoa6HiY5xxxOamI8DBWXs/GYu7d7Gg+BFkurzwpDDPBIHf4WaemYQR+UALm0A/7JDGUlTLzn8YicEWrm4bFkJ6ZzZ6edtJ3J/ot4KN4vFsg6jBZgP+1AFwYq6qCrjcT/Kxhjjf+fI+hNDiRpQqX36pAEGRPkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731923; c=relaxed/simple;
	bh=Ogk6L2Vb39QjSGFw3FC5seVr5PMlNq+ZWJr6NthcFFQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIcNoNlZcAF34oU3eze47JVkZHfrwLvKjB5qfRqIlTh5vqq7A8P80RYsWUEP8f7r5G9nOogwQCjXc/LUZ6tu6zQlo00LW2Zor305QNwumxdDg0yU3huBLDZ7tkXIqdtl7Fmu1X/ZvXTqJBFVXHWnC9+bp05sqbT64DO6u4uA0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFfcjzzE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFfcjzzE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c9376c4dbaso601262685a.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747731921; x=1748336721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhpJgbI0Oxj02m6rPkmDv/8e9yl/F5tKNtHu7qGrM4=;
        b=gFfcjzzEublxAhCQKuuAcvEo2y6PB4NDajFHmNQL8DgV+W4cJpvB1Q5bIUeUhSelWR
         9hSKN5/vm4N/Wd/t1NHx9xgvj3WYBFYz+9olvO7dlNzvqpXYP5d/q9FoTkqWItkJywhj
         S5B8TT6w8cO++DWNerOza3f8eXeV/RNl9QqlP8RFpOCogaFFFw9KARnZ4JZ9NnUIBOnX
         ySCBk9jObmIgjUhAGxd9rxqfSYktWTvLPiyDl+7CiBDuNGHIQrxIuxN3VJaVxXgIGV8E
         Btda0WoRSLUdkxQhAhOrMridEZ+NGqsBThlraVErc/xG00Z94H/BAAOhhhkv+PxFdRSu
         q+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731921; x=1748336721;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhpJgbI0Oxj02m6rPkmDv/8e9yl/F5tKNtHu7qGrM4=;
        b=dyn64JuVCXHSMJYM3cGP8ZpX2Dl3e+bYGMBPhCWV032GDkXZRTsgAwa//O68VdLZLc
         GGhPa8TTiP89GIc4/c5W+NjVYQVeL4h2vTQemFCH+VCqMbSyjq8Vbm+TLFzwcnsbI5TJ
         S8Uv4vIV1VnTlPywGpuOAUmN2t/+xXLmXzCtznlu2Z92VX39ffWdSu9mS+/4pPoKLzZB
         wbLEShcLPxykymuJcP4ZG3zSPONaoEFzgJhF7u3+QGoRZldYfRMl2fb0l4fLoF0I/eWQ
         BQ/GvagZC6iqdusD8P2IIe0F8bVsXUR00jm/X8EZcUsKf6sHOyV/VhpiEkdEEiBTyS15
         F2Yw==
X-Gm-Message-State: AOJu0YzjSLg4YKVqiKU70M3NtXCMa++BDg9aF7+C33Ae8OSR+tN/6T8y
	SpA9p6g9P0gIda/uNE3P0fj20KMTZffWl9F0k5NiOYJWijCd+30+4MW0a/4b494vc1MUuqWrNnE
	xUfxem8iWw/WmiGzXLAZO4lX7wMbSR7da5XHU
X-Gm-Gg: ASbGnctke32SwiCDsc1hENnFHmNUURWD4eMJNXpxUKTFlsAfQqHhM0IKSPq8JupOEeN
	RYZr0NOzir2FOc4hCj4NzcDwgub4HLorIKVFt3Pbs39MPDFfMusA1csTg3jx46yq7hY5K24B/PS
	z0xjDTYnauiup4gjHcIb1KdeGVm4MgtJ4=
X-Google-Smtp-Source: AGHT+IEVzmqkbEhnwPsoCBFB7UTEFQSo9/uFcvzj0W4Fb449kt+uvvbdpNoBjWvuTUX2IDMUbWrSLG+LBBVBRSplI1c=
X-Received: by 2002:a05:6122:888:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-52dbb430348mr13898043e0c.2.1747731910045; Tue, 20 May 2025
 02:05:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:05:09 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:05:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0usmprh.fsf@gitster.g>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
 <xmqqy0usmprh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 02:05:09 -0700
X-Gm-Features: AX0GCFtzYE1HBj6EsjUSAoxcAD4bDAS7VjhQmAwNjU3ztGfXeol6_uVn2SI_STQ
Message-ID: <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000a94b0506358d8bfb"

--000000000000a94b0506358d8bfb
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The git-fetch(1) and git-receive-pack(1) commands update references as
>> part of the flow. Each reference update is treated as a single entity
>> and a transaction is created for each update.
>>
>> This can be really slow, specifically in reference backends where there
>> are optimizations which ensure a single transaction with 'N' reference
>> update perform much faster than 'N' individual transactions. Also having
>> 'N' individual transactions has buildup and teardown costs. These costs
>> add up in repositories with a large number of references.
>>
>> Also specifically in the reftable backend, 'N' individual transactions
>> would also trigger auto-compaction for every transaction.
>>
>> The reasoning for using individual transactions is because we want to
>> allow partial updates of references in these commands. Using a single
>> transaction would be an all-or-nothing scenario.
>>
>> Recently we introduced an in-between solution called batched reference
>> updates in 23fc8e4f61 (refs: implement batch reference update support,
>> 2025-04-08). This allows us to batch a set of reference updates, where
>> individual updates can pass/fail without affecting the batch.
>>
>> This patch series, modifies both 'git-fetch(1)' and
>> 'git-receive-pack(1)' to use this mechanism. With this, we see a
>> significant performance boost:
>>
>> +---------------------+---------------+------------------+
>> |                     | files backend | reftable backend |
>> +---------------------+---------------+------------------+
>> | git-fetch(1)        | 1.25x         | 22x              |
>> | git-receive-pack(1) | 1.21x         | 18x              |
>> +---------------------+---------------+------------------+
>
> Very nice.
>
>> The first and third patch handle the changes for 'git-fetch(1)' and
>> 'git-receive-pack(1)' respectively. The second patch fixes a small
>> memory leak I encountered while working on this series.
>>
>> This is based on top of master: 7a1d2bd0a5 (Merge branch 'master' of
>> https://github.com/j6t/gitk, 2025-05-09). There were no conflicts
>> observed with next or seen.
>>
>> Junio, since the release window for 2.50 is closing in. I would prefer
>> we mark this for 2.51, so perhaps when/if we merge it to 'next', we let
>> it bake there till the next release window opens. While all the tests
>> pass, any bugs here would be high impact and it would be nice to catch
>> it before it hits a release.
>
> I've read the difference since the last iteration, "git diff @{1}",
> and everything looked sensible.
>

Thanks for the review!

> Not an issue with this series at all, but one thing I wondered is if
> it makes sense to change the type of strmap_get/strmap_put to deal
> with "const void *".  That way, it would not be necessary to cast
> away the constness like so:
>
>>     -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
>>     ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
>
> without harming the other side, namely
>
>>     @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
>>      +		if (reported_error)
>>      +			cmd->error_string = reported_error;
>>      +		else if (strmap_contains(&failed_refs, cmd->ref_name))
>>     -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>>     ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
>
> this piece of code.
>
> It may not make sense, and even if it did, of course, it is totally
> outside of this series.
>
> Thanks.

It definitely does, The only other typecast I did find for `strmap_put`
was within 'strmap.h'. Nevertheless, I think it makes sense to make that
change. strmap shouldn't modify the data provided. Perhaps #leftoverbits.

Thanks

--000000000000a94b0506358d8bfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6b25eb9b883c8e17_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nc1JjTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3kxQy85UWZDeWk1WFBzTlV4eVJjTDE2Sk5ualF6OApxQ2ZhaGd3d3Fp
OWtmSHp2NkgxVzRFV1NNRmY5VkFLUlFqbWt4WVNwdTRqVEFsVWY5L2xiOW1ldnd4ZTlSdUVMCktR
OXBqNzc2aFZHMHRmMlh4N01VZkZFN3A0RWhLbFIvYXVUMXRScHBvU0syNlFqN2VmTGFaUFZRd3V0
YXROV0oKaTJybkJJSlZCd09Xenh5WCt1SHV1K1ltQU1YL0ZQU2tpMisvakQ4Szh1ODJUTE0yd3RY
UnpXcTNkNmRqaUVhagp3cDg0cnFLSU9VS2poNTBlQTdDVkU1LzRXV0FtN1VvNG40aU51YlFSTmJ3
cjdFa1l5UzNBVFJKRGJPUFJWMGpoCi90aWlmUndaVW5DbmhlVnQ4eXZOSWRGbVhyOCtYZWxwVzVE
bzhvcnNSZWJRbDVpSURzK2EvTVBiMlcxdk9jRVMKVmtoQmp0VWU4aEVVY3FDM3NxT2hlZ3dRMm13
bUNBQXFNNTZxN3E5R1Bwc2Z2bEJYbU02aE5ENkhBNVhwV3dYbAp2QndPUVN6dDdDVCtoZGZvR0VS
UTdkaWd3SkNKQko3NnNaTlc1V1Y5dFhyYWR5S1BiV1JXWGdmMU9YSDE3TDhCCitVcHRDdXZOYjIz
MEJocUY0cmtGZWR3TS9BeUJtQUZuelFLVjYxMD0KPUhHZ2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a94b0506358d8bfb--
