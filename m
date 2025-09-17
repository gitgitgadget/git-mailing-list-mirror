Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9C2F2913
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094774; cv=none; b=pRmGUaUFENxR2la4Nn9SO43DZVp7YMucU18ChxyuJWJbn6ppDz9r7xQiY80iHH673f/VoiaOuAboqORzb//iR2yP2RS6FvoTl83oCf8bg2OQoYf7zkE8+hPcMKRb3B7Zhil8btrFOLlc8fbOcw/lpQo3+o1Nx7q48jdXJawMS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094774; c=relaxed/simple;
	bh=ukgmfW8m2wIWyz1vnPePCfhd9WJhbShPyzKahBu5K3M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfQcwAQqppTXDC65K5yM3KX9/Aa97wGY297sNK6/DNs/gJqkL5eTaJrwalSdnHtG4KZYQ2Fvi4AnFpMFmy4KTJlS8Fl+dVgvCJUzje2gymAt5CK2KkEmOf5+DGQ7pYZuTHT5gd2eLu8pt834ydXy8kH7cV9TOUZW+CGs+NUcnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8sq5VqJ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8sq5VqJ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544cb520cbeso4036354e0c.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094772; x=1758699572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzWeEWeNhoCD62AQoMMCbgpMGoXC7+GXhMU4WFXy5Xo=;
        b=U8sq5VqJppM0KCBgAW17NsFcT2nyNnsVJIzgsoLOVBe/wGDNFEX0B03qV7UVaYWfMx
         4ShMIGu4XWjElI42DqgKUQ/oUDzlMxGDwJ7nsi1Ze8Eq9yfL0z00Mg2NZLUCGH12gsFl
         Ea1LK/JL3Vy8JGoWfOh2uQrzORV0RdXgdb+2P+qKNVMNvqWb6NGoUM78KtZDN0b3ItG9
         OiTodDBmPwqPKsQONzy1wKiVariRwSaTDV6BMqGf3iPZNMv7AReL2dLHlyX1BKC5IzhE
         R6DNWRNMFUX2ld4J0GGWAuWOQa3nJhqFlIuG9DpSet+OsdisaiSV7VX7Q12WZu4UixkG
         R5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094772; x=1758699572;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzWeEWeNhoCD62AQoMMCbgpMGoXC7+GXhMU4WFXy5Xo=;
        b=RNr9tlU3Y9/3Vyafwo8GGfPX3L/beuNCwpKfa1hU9gnzH9uH9VVCCHMiIjVLukFuuA
         Id5nrVy5PAkg8xQAn/64fzogvgvffUx4eMMPRF6b21xHCJpxJHaFdTTDidc6gIjnXB2h
         woZY5Dqa1dGIbIdlXaZE/UXAxEM4XMlOyNMX3VTZBwf+1UsuPv1bkbMd8eTNyLTyeM+1
         wpkYXiDs/H3mxywI/Je4sZ1izTpZJMZr68XQ2nZYvU3X/u+eWzAVcRk6HzTP5AxkUSYT
         6vjEAcEp8vpayE4BdXmO2kpbSzDG4SGGAlBeil1YfA83OQOoUYF4GLIhS+YSGeNUDUNe
         J/GA==
X-Gm-Message-State: AOJu0Yx3vdjXxjU9X/xIulcQB5M6EJE++W7XW9z9pBTUsxqk+87VKdG8
	4puAtmlJNg0dnToYgdrUaviBLP3P5lnyZmO81NaLgC2UY//CRS2a30z4nnbdzW1+TJnSeR1+3L6
	UlluRpGv8h6Tz9puvkvQnGtA4c9fvEhQ=
X-Gm-Gg: ASbGncutazODbFvGBwqFWx6lfapKWU7tOOBxZhKDQ1acwGNW9dsUH7xFemMEV8dMw+K
	YlBaLXxAhxmSnMQ7etvh99nGDfSBPMaAdnAdJHDdtYE+8dtemfjjA8fBuewLWiN27bfxciN3L7f
	cv+LUvfGKaBgyv+h6yfYX2H1mFMYtInYDDv9iQYkd0C9iM1crbKkb7G5RjH2OUNiC/Pq27yHNgk
	G9Y9rMmPLpsPTe5Aa/tF0lkaMOg4zs0A6/+pzla
X-Google-Smtp-Source: AGHT+IENo5w6aAeE/qYITouVQx766breXZJGeLnhD70udNY/sxGGkJpLJ+Wu8P36BskX4rEhiZo6z753Gjghq8eAkVs=
X-Received: by 2002:a05:6102:f99:b0:4fa:85f:31c0 with SMTP id
 ada2fe7eead31-56d63ef5916mr312699137.19.1758094772090; Wed, 17 Sep 2025
 00:39:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:39:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:39:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <672jdldtxegx4y3gdtcyrnsz5nsy4sh6pk76eftqrukwug3f3c@xwso5f4vukn5>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>
 <672jdldtxegx4y3gdtcyrnsz5nsy4sh6pk76eftqrukwug3f3c@xwso5f4vukn5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 00:39:31 -0700
X-Gm-Features: AS18NWB7Ogyi-BWhncajYJrHYOpnCinzsiK5KrcY4Wv9gRFTyYUrmWw-_IQ0O3A
Message-ID: <CAOLa=ZSy06tp7PbTOq+L77U4YqA6G1OEZbPb4F6S2dUw4RkqUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] refs/files: use correct error type when lock exists
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005f5a2d063efa56c8"

--0000000000005f5a2d063efa56c8
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/09/13 10:54PM, Karthik Nayak wrote:
>> When fetching references into a repository, if a lock for a particular
>> reference exists, then `lock_raw_ref()` throws:
>>
>>     - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
>>     because transaction contains conflicting references while being on a
>
> s/transaction/the transaction/
>

Makes sense.

>>     case-insensitive filesystem.
>>
>>     - REF_TRANSACTION_ERROR_GENERIC: for all other errors.
>>
>> The latter causes the entire set of batched updates to fail, even in
>> case sensitive filessystems.
>
> Ok so this issue isn't related to case-insensitive filesystems. The
> issue is that now we use batch updated, a single pre-existing lockfile
> causes the entire transaction to fail. Prior to batch updates, only the
> individual update would fail, but wouldn't stop others.
>
>> Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
>> allows batched updates to reject the individual update which conflicts
>> with the existing file, while updating the rest of the references.
>
> Make sense.
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c | 20 +++++++++++++++++---
>>  t/t5510-fetch.sh     | 26 ++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 01df32904b..69e50a16db 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -797,9 +797,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>> -			if (myerr == EEXIST && ignore_case &&
>> -			    transaction_has_case_conflicting_update(transaction, update))
>> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +			if (myerr == EEXIST) {
>> +				if (ignore_case &&
>> +				    transaction_has_case_conflicting_update(transaction, update))
>> +					/*
>> +					 * In case-insensitive filesystems, ensure that conflicts within a
>> +					 * given transaction are handled. Pre-existing refs on a
>> +					 * case-insensitive system will be overridden without any issue.
>> +					 */
>> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +				else
>> +					/*
>> +					 * Pre-existing case-conflicting reference locks should also be
>> +					 * specially categorized to avoid failing all batched updates.
>> +					 */
>> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>
> IIUC, by returning a non-generic error here the individual reference
> will be rejected during batch updates instead of aborting the
> transaction.
>
> -Justin

Indeed. Batched updates allow rejecting of individual updates. It only
aborts when faced with a GENERIC error. So by marking this as
non-generic, it doesn't change the flow for regular transactions but
only how batched updates would handle it.

--0000000000005f5a2d063efa56c8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fd7c471e563b361f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qS1piRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlZlQy85TEIvYVFxVHdJZGFaUXJjRk1ZNmtUbkF0SwpnZzRBbTd0QzZJ
aFNvaU1Ba1NUMG5YVkRpUWxRMmlUMDBSdVg1dUZ4cHA3TmhiN3dTTUR0eCswQVdkcTRBZ2hvCllC
dXNUNTFNV2tXVlV4OFE3S3M1TkphYlpaQnhDNXJtWUZjZFhpaHpGTWNiZGtqZW9kMkR4TDQxY3Q0
RHhpaWQKQll0N1M4NjBwTC84OEpSQk1MRFArem5iUWlQMDhOU3hxU3NFTzJIZGI0b3U0dUF0T3VN
alAzRy9wZ2ZvOGdNdgpwNm54NHpVM3hnV01USVArL2FZZFN6NEtoVjhGQndsb3Fha1ZLbHpPU1NF
OC8zTC9hU0U2bFdmWkUrVXp5TXNYCmFMWDhiakxxU1ZuV3lFQ1Y0WCsyTTk3d0grY2ZBcjQ3Misz
blVyeS9FRm10eTcwb2IzaXF1UGppVWZld25IM2EKaXlRUzlNY3Z4V2crYVQvdmNHWXJBeFRZS21H
Wk1KbndodHdRbzNHSlVyeHNzci9BL3FvaGpHZ1gzOUFUZTM3NgpUd2NOOUhZYmo2SUNHSVVTRTk1
N3J0dndncDNFU0lLZWl0Tm9aV1BQblJpVS9NcituU3h2YnAxNGhoNEZSUW5GCmp2by9xWVZqQ1NZ
ZlhseDM3MVdVN0hXRE9pRzFBRXlEM1o1R0tkYz0KPWFvUlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005f5a2d063efa56c8--
