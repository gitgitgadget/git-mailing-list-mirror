Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FB23507E
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524087; cv=none; b=XK2svDBJsTJZqM40YYwNhmG+Il5SU/+FSiOKTgdxVwPNxEzLhWK+RXUXfXVaT5OtiCTBKrefQsNwfHBdLxd6ujgvX6QHeOioL4Hjc0Knc6t/4URCPmQcnmIUKe0DB5iSgVIauZ8jwm0VtNQJAuG/ACGWpAtE7LqW8uYCGcfS8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524087; c=relaxed/simple;
	bh=6Ue7W61ZXtYfJBQFHmL4ur5Uxk+NkynRQUdotX9UbvU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1IUyal3GtX0rxyi+n8Uv1F2jtgBSkzwMT24OTxXpsxeuWrAC57a1ikPIPF6EKoaLr1HIwpS8W/oNOQ1+c9tZQvfx7ffCeSW8bDUvG021qKXcqXjPFluE5ixcbVhhHj9Mw+LdRwXMVtzWCf34kBxt69xixFgnc7U7HfNKC8s0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7QDod6O; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7QDod6O"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93516cbe2bbso212571241.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762524085; x=1763128885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQih05MOHN3czhr5w0udBZSI4E4waVQ553zuQwYmjrI=;
        b=X7QDod6OtC5qBfjJlEGPkt1nrK0x0CWpdf7RP8m8vs2sUnHCadsIe3i7LgYsMi2cTk
         lRCdcBr1lsDr8lFdKTBQxmf3p5cNkcU0hf3i8W7HkPwYitBRu6oUJamb+rk5ftw3T/ZR
         NPqUd1bNwcR6OiukzmzN2Iu7xW2K/cveuxWDdaiXtufFDUSg/w7kUn6tIm71HlszgIqB
         mmgDz84m0J+G9rr2acgI2rPJW7jfGHjQhRyViwaKdUO/QMf0AxYnRJdf4fmuSfirQZXp
         KtskZh5oERb/DypZeEqDM9cDP/sgGY27RDPrnZUSiTYhXp06bQZQ5AWwdNfuyPAItST4
         KP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524085; x=1763128885;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQih05MOHN3czhr5w0udBZSI4E4waVQ553zuQwYmjrI=;
        b=P8a9U9XpaHvJVGccunLeKnhHnbWg6u/5upgI6W23f0zWqDFHriApfnloJKMGQJCwfG
         0rEvE9HP8pLApm6W/ypVGHdSpeLHQi52M47rN5tFfzF7mrwviQPkFUfcfVNB8Zrw47qm
         9iYhTEmyuGhV1GwZAvF1NfTeUMlRrNJFZ6ELf9tx+KfNEbYoeFyR8RfxuKPmMzcqo4Xd
         EpfzMRJXLJBz+O9Q2El/wYlT737l9TPOOfga/hyo/pBsM6pn+ByOnkJ1kbOf7yLsakj9
         PVx6XhUMJ0ZZ5QiZGzN3o2v26PZMVcL5NMgI3Bq+lRdeOGAgAV+ek4jGdS4YWPm/GVoQ
         4nKw==
X-Gm-Message-State: AOJu0YzW2FP7+Z21eNfII5EdUjtdI6sqPMCpwNlhyfkoaI7MvPzVsqmA
	hGGedExFNvk4982gPxvIYGzPm2L1bYHo7ejBu6qh7mKceEuTFq2QYoA8jca0Ro+9Gh7SKRUR9UQ
	GuHdXBUuIIfincloETutD8RnIIfT5b4k=
X-Gm-Gg: ASbGncsKefeNzJ5j96G4gsgbifd22GFmdCYUEAP00gVXsd1lTy2nH+KC/nUhrU/P0my
	+sogLEsHztpypRgNj96sh9MlFWk2/fmY3FA3BY+aMG1gRipyZyCOrFvKoryrvPXnOyW5VD5MXGQ
	wz3w+pR7oTWhKeeo+vCnSXCtgfRwJyTNUOU7HZ3BJCwLgg++qsbPcUK0SGyPAa5AEyCcRt5JI6L
	iSas30zM0ugGCnrC1r0YjA30I0WRdRYdxmldqa5KCBtcwPn3tBZT6LxkyxLRF182uLMkCUonwu6
	CQOv9g0w78JCIQ==
X-Google-Smtp-Source: AGHT+IGNnKQc5aikqudJiK5EXwcf4mVARYGNjefSAw+IyVEfXM0blU9NJuOzSNG+o1n7ciomLw/VQdvk74YKG/chZZ4=
X-Received: by 2002:a05:6102:3914:b0:524:3e12:6590 with SMTP id
 ada2fe7eead31-5ddb212082dmr941500137.14.1762524084206; Fri, 07 Nov 2025
 06:01:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 06:01:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 06:01:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cwayobvml63evuasdcamvkx5rpwectmwrwxr3cwxqrkxtketqa@lzm62c2xe75v>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com> <cwayobvml63evuasdcamvkx5rpwectmwrwxr3cwxqrkxtketqa@lzm62c2xe75v>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Nov 2025 06:01:21 -0800
X-Gm-Features: AWmQ_bl3IRWPksq0xqCEQKBDizH0pRjr12hdczZ7kT0r7xdY4sTdLg5a8AKhdpU
Message-ID: <CAOLa=ZR9oKD_Zz3R+1W=f3M9Rd_FgNZ+AvFqk+ia+BSaACTsfg@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, 
	David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f29bbd0643019d39"

--000000000000f29bbd0643019d39
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/11/06 09:39AM, Karthik Nayak wrote:
>> @@ -1858,33 +1902,8 @@ static int do_fetch(struct transport *transport,
>>  	if (retcode)
>>  		goto cleanup;
>>
>> -	retcode = ref_transaction_commit(transaction, &err);
>> -	if (retcode) {
>> -		/*
>> -		 * Explicitly handle transaction cleanup to avoid
>> -		 * aborting an already closed transaction.
>> -		 */
>> -		ref_transaction_free(transaction);
>> -		transaction = NULL;
>> -		goto cleanup;
>> -	}
>> -
>> -	if (!atomic_fetch) {
>> -		struct ref_rejection_data data = {
>> -			.retcode = &retcode,
>> -			.conflict_msg_shown = 0,
>> -			.remote_name = transport->remote->name,
>> -		};
>> -
>> -		ref_transaction_for_each_rejected_update(transaction,
>> -							 ref_transaction_rejection_handler,
>> -							 &data);
>> -		if (retcode) {
>> -			ref_transaction_free(transaction);
>> -			transaction = NULL;
>> -			goto cleanup;
>> -		}
>> -	}
>> +	retcode = commit_ref_transaction(&transaction, atomic_fetch,
>> +					 transport->remote->name, &err);
>
> It looks like previously, whenever `ref_transaction_commit()` or
> `ref_transaction_rejection_handler()` returned a non-zero value, we
> would "goto cleanup". Now that these operations are handled via
> `commit_ref_transaction()` though, it looks like we no longer handle the
> "retcode" return value and just continue. I think we still need to check
> the return value here.
>
> -Justin

Good catch, will add this in. Thanks

--000000000000f29bbd0643019d39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d3ae32e090917d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTis2d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkRUQy80dnJYZmFMK04wT0NvSFJsY3BIN3pFdFV3MwpSVE9TK0dBU2Nn
V1MvdytUTFBLS3FhS2swamd5dEtLTTZtY2tPT2ZQZUVqRVJsMzkveC94VlBWMkdxYWRtV1NzCjhj
cTlMVHJmQklDTEFpUEJESm5tejd1QlhJWHFLcHY4eSs5SXpzT253OTZXdmxxZUpkcUxleUFPNnFH
NmxQdFUKeFJ0bEUvalZSQWVtVmdHTUJiMnk5OU5EMGsraUtmT1dtYngvbjU3U2tGOGlPZ2ZtbW03
ZzM1bVZncXRUd0NUago3eUVQNFhweGpzMDBsRDJEMWRycUlITzlCZTlHcVdQeDZaM29Jc1llcmV2
djFoMkZCcXpMc2RyUzBES1pGck9JCnY0TjJ4a3RJNWZNNDc3MzNXZ1NicXZHbGJPdTFZamthY0Fw
QVdnWmFnYjhuajBVTXlUMnMzMEVUTDBtZ3JqejcKRnVzWllLaS9qT0hsY0dzT0N5V0hwalovUE85
ODJuL2VGRHdUSVRuTnlBbDN1clVoajRNM3dLUnlaMm1LM0xJMwpaMmpWVjRqTWlHcGh2SkJEdGdT
MUNjc3FqcUc3VGxrM2RWNU94NStXWlVFTlhDcGFySXdmTXhLcWhZNHhCZFA1CjFhaTdGeTBjV2pJ
QTF0eEdxeEFkN2ttYk5uNnV4Ymh3UWFiU2VEWT0KPUV4LzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f29bbd0643019d39--
