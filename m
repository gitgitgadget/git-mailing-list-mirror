Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E63314A8D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626200; cv=pass; b=SESqXfaOqDXkysX0Nzg8hMqhrSvwh3pn77dTVFpx68/xuSq7NiA1x5uLy0oi0CYoCmUGWsuiG85QV6gFXN0ocCEbcUVZRdHgpHY+mSVfcMdu2nI3+2pwLc0MRQNwa96mQ2fkgiIhf8dJbHnpq45xUhqNLRJMGm0nDGzkAnY5VtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626200; c=relaxed/simple;
	bh=lqqWxhitrfNQVN67yJKvDK48IrI7zCBDe1+Qb35KRmk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp3+yu53l7CEBmlMBR22vZeiyZ5tWUmrwnvNUMFeRbKTRb+eN4LM/Na1VryLnrp2JUCRhwWXjB/B6EI1ZsPYHYyBlUwCzJSvvCCim/bBcc+AlPWR6ltOlrVLZ4fE7w43xcPOtdMwblGeMOHrpncYsso0veC3olDIGcdTwIJFQOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaiwrwFi; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaiwrwFi"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5faddf6db62so2592366137.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 00:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770626199; cv=none;
        d=google.com; s=arc-20240605;
        b=ENPb+aV47aihhjzLwS3yYDbaOxFDO8IWFEYpmEByI6AZPDn7KPGpejTP0wwfIjQGxF
         V5lMCT36NqYlHm4nleBeRbRfpRXhvFH8vDiihqLu3w+4S6j1jn6Z/UVl0n4/Rm4Z/79l
         FmBvgpPIlvbLVoIFo2UqFJ8jQz19I1awDSYMkx+xmCi3iOIxF8IpNG+SWPMjP4nQcBrU
         jMzv+hBq5vISog4UDEm9VWcJ5W2sQRa0WHgjhgf+LTZCnUUN9fiVfcBFV1gG/qKKMtor
         21HQqZw3bZ86q7eyndgPXsSpcqwo19BW57ny48AnulNm235EOnRusnvx79PYg9bX+2wu
         HOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kjqG/UIF9eOutkWsxn2TnJlr1g0yMlzrEX6fdt7wyv8=;
        fh=36GvrYCWw5OkaeaSdsqipPhEw7Gn7pSb2MA75dK6swI=;
        b=Tr1X1wrnMdtoC8Wgvcanyecrf54ZX00NaxqSG26h0GMaDXBVS4FAxtNqMXtk1z6G8H
         +D5Ng+FKb7tqmyQBZEvBwhHzBiIrzwkk3Ns/IQvUAAOLGff63fNtDB2gPWf51H/88mRy
         S3wYkZ4ThNaNPw07Mx+PhUXEwBhtP+OC3j2NVwaJDx3EAGppSJYAUwKhhm4vLwqfxydH
         /TxhtRt5nPopqdLLSPths1awneybCr9XhQHLYvwcLur1tFZwK/9grDq34/2WNvEoqruS
         LLAgfryqWIn5W4IqhjH4iyRs5nLb91zJGnUclt6xSbNNOKRFfktPJrD5SBerHcbJ7jJg
         p0cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770626199; x=1771230999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjqG/UIF9eOutkWsxn2TnJlr1g0yMlzrEX6fdt7wyv8=;
        b=eaiwrwFivJgBaoBjLpjT+qOite1bvqHWOOtKvoLJrlkd+C+ZME073ykIAlhd1o6SYH
         sL7s+F+Mvvw5xkNv7eQwznGHzZhFW6BFX4uGLvoxcJpXj/IblAnS0ICDwDvdo35LjStt
         L9H5Z33UmDWNQpp6XMiWM1q3KcyO25WRyFXl24y07/RYUaJRwaF2AtkyGBmCAX/MPBO5
         5fhc11T/5CJz3riVTk747s1OMaTuJ/fEcitFbS/5KMO3D8nr46RD+lao33NC4ycBCYsK
         pOW97OrB407lxQqccxFXE1UZql+Hpf37HlWI9AEw/3hf+PV8rkjzsv9cQXU45QzyNfDY
         DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770626199; x=1771230999;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjqG/UIF9eOutkWsxn2TnJlr1g0yMlzrEX6fdt7wyv8=;
        b=Rjgr2m9gmzAgT1KUFyvRHpd2bxFCr+GCSGoVeSVm4/MkjEIBEOBvAaiDrjtMYBMc0x
         4unw6SnHDgMgil37fhjkifS6fZWN2rfaP5Xyq2D+Ixn1dG2KCpI8aZ4iICxUkig/B0rU
         Mz271Wmbe3r4K4EzgkQthIisXdNQcYdTdcBJ5mf+q8Ub59vgthbTEklw4NpMr2XPf4Cv
         p8az5/IrW6/+3vDrchvppo/m5i2fDYSIg4IAsVdH/Fz3n3JDeQNjNaCivpFhQdfkUMVn
         5wEkDY9qpSXNPOd4qabnxebXNJMWtZD2Frf9VzyEFhyifsVCXXUd85chb618+aAEh4SG
         24Pw==
X-Gm-Message-State: AOJu0YwI5oTCL0m0RMJWN37IQpB56qE4c3+WGoUeZbjYdJtSbOICl/vr
	I9vY9zBJnFdM7BhUOjEpiHOoMu9gnqFIHdky4Fa+vSKQnuErwoOj9C5DgPR+SK4KXr8Qfw9lrpQ
	Djw0a15ovuhrj3ZfXLLK6XcTAV4cQBUQ=
X-Gm-Gg: AZuq6aJSTwxlgeVKmSh6uUCzoGarCy8id87KkvXlCtKIOQPiAlp+s43VcfJ0lKXOIrd
	nf0k60KSUUT8DaBNH8/6Yg3ZA6HTei8z+9B3BANw87EPdNkM44h9pRdzT3rnDphVsUVNQWMOwhM
	ELZhMqlR4AjxT7hoDBPGX7QX3JbXH8iDPhNnkTeMIReW+eAeWuBXM19w8F+x3LPxYavuBk0gnUj
	qy15jhNVAnTSj4kezQ2a2km+BtaTiBjxjUtTQpqnXHfuQAzItCQWp2KEWZ2IvW9DLpdZh8SZ/ov
	mgzIAOwwIRhVO0S2XeZpNh9Vwl8w5JUGxYgfAmjI
X-Received: by 2002:a05:6102:3a07:b0:5f7:2468:83b7 with SMTP id
 ada2fe7eead31-5fae8c9bfa2mr3158409137.45.1770626199296; Mon, 09 Feb 2026
 00:36:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 00:36:38 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 00:36:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqzf5k9guh.fsf@gitster.g>
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com> <xmqqzf5k9guh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 00:36:38 -0800
X-Gm-Features: AZwV_QgGdTiY6FwuyTrCDDHXQVo5ad-LRxmL4B8MMk7czPj2ZDx79QJG79ha394
Message-ID: <CAOLa=ZQB3C9mr1z7QdxzFp34d0uV71ho6nRxgYLgpRV6sNkBYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] wt-status: pass struct repository through function parameters
To: Junio C Hamano <gitster@pobox.com>, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000a3b935064a600995"

--000000000000a3b935064a600995
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
>>  branch.c    |  4 ++--
>>  worktree.c  |  4 ++--
>>  wt-status.c | 48 +++++++++++++++++++++++++-----------------------
>>  wt-status.h |  6 ++++--
>>  4 files changed, 33 insertions(+), 29 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 243db7d0fc..e3cf273339 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
>>  			free(old);
>>  		}
>>
>> -		if (wt_status_check_rebase(wt, &state) &&
>> +		if (wt_status_check_rebase(wt->repo, wt, &state) &&
>
> I am not sure if this is an improvement for callers of the API.
>
> Isn't wt_anything() that takes a worktree "wt" supposed to work with
> the wt->repo repository?  Or is the API designed to be used to take
> any repository object that is _different_ from wt->repo?  I am
> assuming it is the former, and if so, the only effect of adding a
> repository parameter to a function that already takes struct
> worktree is to invite a programming error to pass a repository that
> the wt is not designed to work with, isn't it?
>

Absolutely, In a previous version, the patched directly used `wt->repo`.
I pointed out that there are instances where `wt` could be NULL as per
the existing flow. So this change is in accordance with that. Overall I
think the fix should ideally be around how we work with worktrees.

>> -		if (wt_status_check_bisect(wt, &state) &&
>> +		if (wt_status_check_bisect(wt->repo, wt, &state) &&
>
> Ditto.

--000000000000a3b935064a600995
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dd04bef36da17bb3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSm5KUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0JuQy85bFRyL1JQYjJaMUxKNnc5VHY4TlhOV21xTgpBUVByTWhyVlJt
TlpsUGZiaFFnblJoUGVqZ3EwM0h1NkM0TTNJdjhTSnQzMnNaM2MzcWwycG15UVRnaXQvMkJ4Cnl0
Y3k5TEcvZUNETlgzTUdsWitaaTNUcDRKMXRDdGZWeFpMTm1xNjB3bEsyMjg2RUMyZmpPQ2hjdE9K
dmMzOU0KVG1yN2pwcXhXeDREa2IzYStIOTEzSjlJTjZ2LzFEZEUxWTg1QTQ1MkVpak5veXBsNGdV
ZEI2VVkvQlZsU0Y1MQpTL1cxaDZXZUJlcUpLdXd5cG01WlhkYllSZlJBNWR1b3QyN3ZMMi9mMWRO
anY5UXN4K1pHb09RNEk5NlFKRmpmCldpUGJMVmI5Sk1nSmY4N3VxeHZyQkxvSTh0Wk9HMlFmTzdI
K3dGQjJpRTVSSmxicG5qV0Z3c0Z3L2lBNmVVSkkKN0YycnRVOFZOMjd6Q0FrWElBQ3NkRmg5ejJ1
eEhYTXlmc2hNSEJsZm11N1E0a0xMYUNrM2lPa0dWVmpSMmNuUwpZR2RmUmlJTmlzVXNCdUwvRStN
UDRCQTVTN00ydEhTMlA3OWxzamZ3Wk1mczVYTEhjSlZURWdDRXIzYU5FOGFTCmhZVThkY3gySEpN
Y3lCWThHRDJGYmQ2Z3pXK09NRkZIYktqaHdGVT0KPWZsd1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a3b935064a600995--
