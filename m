Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112A2E92B0
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583356; cv=none; b=MayQ/MEaVSjYz4ZG+gD2a96YaPmAW5zHH5BDXmm7PROpyQYXSkb7QflqyIiZKLcm+IE7WCMM5ou334iuwhRjF2hn1QunJz8T5zsn99eLk5rgmq1BpXam3AY9+JjXlEr2r7FdondhRzinnytaeftH7AoUuryrjzjE1jhzH/09ewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583356; c=relaxed/simple;
	bh=KowuMH0ivrg6XdhQsNZNihREgzghu5G5RONmineyBLg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzFRFdjU8Y9YqXl49fTMfnrh5wFjHCJHjAhSeuRm/U1qF2IuA3SN9hMqlRwKvO2/HmhnoIWVgSqEGFMFP5TJ2P6eT82PYbBejvV0uPnExu56cQMzVQNXuUY+Rm82hJH6yHKzGBvbVNOnXlrAyETeE7arV9NdOnD/ebcj1ZsLrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR3NDtIB; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR3NDtIB"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89ea3532bfbso145409241.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757583353; x=1758188153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2d+5I3ZTxLhH6hV6sC8P0Mgsh1AoOAjjnNIQmEObs=;
        b=JR3NDtIBwBtlHW7fz9/+1Mpfi6QH4vUOB+AjMY/dCXlbvNCWkFAc6KPb7MCG+J0Mv6
         4dNmVmqo8T359OGTH5B2I8aC9MrHvIwQilKH7lA1o0uIhiob0JqRBDjv1xtMqdzGz0pD
         xTooGCPbW3QxG0si1Od8yD54B01canrDYWomvlSq78WrgGylm19EGfXjt6K0/TCUTH8T
         gXE82zzXkef5fT+Nrt7f2V89K2c6v9TWG7oraio7iGsf/ZHi99tVw2L5FD5tXphzS+xD
         M2flrRq3iDtylrBJUR4tcCTlyx3c2pw/wjVnEmViWE8K3yosFRS6b6o4uY80By8Qglws
         pdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583353; x=1758188153;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2d+5I3ZTxLhH6hV6sC8P0Mgsh1AoOAjjnNIQmEObs=;
        b=plrPE7RqteO00ltLotrEFbJ3x3/dzoM/g820PQeoB9HJc2Da187e/0VcsDeANHSdhM
         GJCGuKz/el+8pY4XkTGMK37I5FUJaWycWs52cvVUQFiEVMm5T+YLdJPrm54xYY350xDT
         bA9IRafAtQDMkY8TxNJfm0OyEQ7+F/KE4bTH3BBjk8DCSrNauBacgejZf43aLN0Aq2Oj
         fnHBpOKXNe86Jt3taJ3CFpm4oL9tq6MGSx9Ack3E+e82QE9spbKRpeoXqR/5A5qX0aT0
         NO1M5qNV3IIfuVC8AqnUzFKXQ1iFIw6KG3aAo2LQnTVqP7N+k6AruedzWVsJepAsED+m
         3wHA==
X-Gm-Message-State: AOJu0YyZOnfMIKDy1bsVUk9BvBSQqgaTbkmNyb3zRtJJIma7dkDdJkKF
	U5+SLJXKsMWmX0B1845auJ61yWS/ll6ziVivDdoR4CgvGpQhFhjuIuo3PpvDfzFqtD7eu25JVj6
	e/L5jpKQEub0PMq7bWYE87a0qZiBKE2Kyf/oe
X-Gm-Gg: ASbGncuiPxPc0cXA2FnVWdLqsDX31RrDKg6jTMh6EgDW+6zfS0WtvYlSiWNF3HHj+Jf
	fg1GIDsFOsPYmW7ihQSaQjA4jrmk/7ZQQvm56SA5FpRB/rsHxGdLdtmSSwDTXA6W5uSmKq4zEEA
	OrjDYmU2iul2exWSDtW9XFuoP6Llb9Y3lYMP3/Fp8nraU3ncWPPUYjBP2VK4Y37nj/zmbO6VPI+
	IkAgxw1c0SdYC685IVDHX1lE/bF9JJdNJk+c6dDtxtIk2GIOWnH
X-Google-Smtp-Source: AGHT+IHAgqbxJ3+gixZqNQHZllKwZP4/N7MwUOcZurzd+VgZYJzkLsv3Xq8qdqLeG5Sc6HeXbozqjtKXOVg2aSQJj9A=
X-Received: by 2002:a05:6102:160e:b0:4e2:a235:2483 with SMTP id
 ada2fe7eead31-53d13a4fb07mr4597784137.19.1757583353059; Thu, 11 Sep 2025
 02:35:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 05:35:52 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 05:35:52 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aL_SwghVaAXL-yeX@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-1-b2eb2459befb@gmail.com>
 <aL_SwghVaAXL-yeX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Sep 2025 05:35:52 -0400
X-Gm-Features: AS18NWDIq9G-hJGZ5gOyhwOJvPQk0tXyTXhTDizJp00I4ShN6OL0GoVAmlgI5PI
Message-ID: <CAOLa=ZRDY6ORDngq0Np0Y_8SFXRWWKAmmsecQfpqeqrLCfbN0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] refs/files: catch conflicts on case-insensitive file-systems
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000006c3cb4063e834320"

--0000000000006c3cb4063e834320
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 08, 2025 at 02:37:35PM +0200, Karthik Nayak wrote:
>> diff --git a/refs.h b/refs.h
>> index eedbb599c5..41915086b3 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -31,6 +31,8 @@ enum ref_transaction_error {
>>  	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
>>  	/* Expected ref to be symref, but is a regular ref */
>>  	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
>> +	/* Cannot create ref due to case-insensitive filesystem */
>> +	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,
>
> Nice that we now have a specific error code for this error case. It
> removes some of the guesswork we previously had to do.
>

Yeah Agreed. I dislike adding a common error which only affects a single
reference backend, but this is nicer.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 088b52c740..58005d2732 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -647,6 +647,19 @@ static void unlock_ref(struct ref_lock *lock)
>>  	}
>>  }
>>
>> +static bool duplicate_reference_case_cmp(struct ref_transaction *transaction,
>> +					 struct ref_update *update)
>
> I think the name could use some improvement. How about
> `transaction_has_case_conflicting_update()`?
>

That does read better, will change.

>> +{
>> +	for (size_t i = 0; i < transaction->nr; i++) {
>> +		if (transaction->updates[i] == update)
>> +			break;
>
> Why do we break here? Shouldn't we continue?
>

We break because we only care about matching updates up to the index of
the provided updates. Further updates should recall the function.

I'll add a comment to explain this.

>> @@ -776,6 +790,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>> +			if (myerr == EEXIST && ignore_case &&
>> +			    duplicate_reference_case_cmp(transaction, update))
>> +				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>>  			goto error_return;
>>  		}
>>  	}
>
> Okay. If we cannot lock the reference we now try to detect whether this
> is because of a case conflict. That only catches the case though where
> we have a case conflict in the same transaction, right? How about the
> case where there's preexisting refs on disk that cause a conflict?
>

Existing references aren't an issue since in those situations we can
create the lock file. The issue here arises because within the same
transaction we try to create the lock file twice which causes the
conflict.

> Patrick

--0000000000006c3cb4063e834320
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e5f27947fa28a04c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qQ2wvY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDd5Qy80dFYzN3IwZkpldWhGcWVjM1I0dWJ0bnc2VApMMGl5bU9EYmlo
ZjVuK3pMT0l4VFJkYjJaeDNRR1oxR3JRRjA5dysvK29YMDJEVkw5YUphelU1SXJkV2Q4UlNICjls
OW9HRTl4RUNPZlNXT2w5MXNtQkYxL2M1RElmeWNyMzdzWG93Z0tlcUZYdHlxK080azNpeHlwK3hv
Uk9VK0sKamNwR1V4Tk5QTjQ5Q0J4SFZvRXpwdjN4YWh5TlhqcW9ZcjkyNDJSd2NISURKN3BKS244
VFFJL3R2LzZTcHA0YQpQT05hMFhOZXI2U2FaVzNPQThTWm5UMnVTRUt4Rks4dHhwNFZUdjJVdDRR
aHN6eFZmdzhTeHkrMnFIdzJxWjNCCk95ZnpkYWM3UmhOQWozUGhNaExwZnBSOXY3U2dMeTBGM0RU
YlRYZFBXU1p4aVltR3lXMzBYcm96RDBrWjFCb0EKRFo2QlliSEhaVkNPSFVQYmxzUVdTSCt4Zm1I
eXJmN2VaaHBmaWRMOEFhYWVGbHhLNCtKM3ZRc3VSeTBxUkpBRgpNMW5rN0ZhK2VIejBma29WV1F6
Sm5neUVFTVJTb2VsQjVLWWJRMFpUQW43eXUyUlVSdCtCT0NZdXJJVk0yT3YxCnUzL3Y4ZDZOdnNG
bEY1cm1kejNuTmxvREk0dVdMOVVZY0xTL21WYz0KPTE1enIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006c3cb4063e834320--
