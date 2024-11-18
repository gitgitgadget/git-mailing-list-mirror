Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6391A9B28
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937651; cv=none; b=krM6rK3F2c+CWUomVatbsVcYISscDxeIYOn15eVO4ZgctAeD/z8gEofkiTRgizYQAazUm+ba/NfglIQSe3oZ0u7HCahlddPmbBoyAlpvAYM8XP2oGAeTuCaNIBX3Dlb82wCtFSSqYTqEXV94V5nITecBmAhscVkI/h0uCnvelCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937651; c=relaxed/simple;
	bh=uGrFOXjrSp9bsZgWxdkZELJxBzADnnWm36+Rig7yJzg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTEOI5VzrTiSjey0RdWSoUiq9YeHEWGUbVFZsYp9L9gBjDQ+F3rVFqFDh5AiU21pmd5UfShVyYWfP/Uo0KZtE36nxbuChlZ8Nj3G548+e7HPW9IaTfefamV0aXZPpxOQyDdohR1kP3sRMZkC/p44tBRAf6mM0eNEaJdzOfwjUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI9S8wFy; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI9S8wFy"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-514b8bb231aso157940e0c.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731937649; x=1732542449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K335WIMYBmWqlUOfVOE0JssdcYrA4akZXcoof8jMQq8=;
        b=ZI9S8wFy9hFawWks637rucviTrhxTjwnWNrTPEyPZhGjdvircYgXvt61+7j2sHZwj+
         YiC+aoCTOJNOoRGRSGZ3uR7pyF81qA+BL+q6pvHhtbZNr79iVde1aCaNkrfG6iAebRpg
         32Cffvy3Ktpf5SfMFuqUaOYV//QH2ejKkEsHqk1k98NA6UlHcfjDrFcWRytm00jC7Pgd
         O7mawYd6kELJKJwWPhfJTGoKBjBRtsvD7B4U7Yt0nkDKG7F5XI6qNB8PK5sgvBcYKd6E
         Vd0rcKUOtk5WSYxib8crcbBZNS/KRTPvQ4E/GFXjTaEF+l/ufuHaY8TvMneqXYRvsBLd
         1UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731937649; x=1732542449;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K335WIMYBmWqlUOfVOE0JssdcYrA4akZXcoof8jMQq8=;
        b=bdzNrdCxkLBGQlKsSCpJzTD1hfp4I071CPyExTVkQAdFBVHv+r3F1DcEEUnZjVBdpS
         7XbHjB4Qs1f13BNNzcEKWBykXsSjj/N9cA7Yq0R8tr3IOXbQiE9is4FM/M4SVbERtxUi
         LZzXirqbnSnfgWbqzgAfgBOErM4AySNM4oinyXuLtLSdI4KbKwMCo4f9GkjpBBd1rBGP
         hxc2ppGwZ20YDY9Xf6NbxOjXRNQggiq02cOMnRVoTryZv/MNOO/Tp0hkfEcte7PGWYRu
         bTNp68H/21CF/CsDkJjxnGm2df9c8dFUIrxxAsAbXEYvmBxQBB6LPKV53lCXFONa5Jtb
         /5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4XM7OkIB3P1P+V8t7wBFO63gqH20A5+wUD+dbmL+bX7wd9VBvkDGlrGoky8MEVYFNF38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+bYHBwSA6niu2aYaTVj6c8Di7POJC730jLd1Uzwi3s5SPVux
	yUJVx9+s0iQstpNzPPKNduT3ZnCUbp67mYPu0xrJOELdw3sohZVyCNZEwNEvjYwaTwDMM3TEwX9
	KZL4osnpiD+4F4RCvX9t+nZMLPvs=
X-Google-Smtp-Source: AGHT+IHUAklmQdbHx7hf/bjvxZLRTvxJSgS5P4fxJxfJQ5LVD3i/ZNc4xhXyG9XH6dDadQpTKlJNTKMFWOBuiADM3mM=
X-Received: by 2002:a05:6122:2a06:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-51477f14a71mr10703401e0c.5.1731937648903; Mon, 18 Nov 2024
 05:47:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 13:47:28 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <38cfe85bf5b82c70848e4b295ba6cae33dcfd667.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im> <38cfe85bf5b82c70848e4b295ba6cae33dcfd667.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 13:47:28 +0000
Message-ID: <CAOLa=ZTauvuFOT1cH=N81st19XBNh587Fx84QE9h+MAtK6rDEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] reftable: explicitly handle hash format IDs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005646e5062730288b"

--0000000000005646e5062730288b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The hash format IDs are used for two different things across the
> reftable codebase:
>
>   - They are used as a 32 bit unsigned integer when reading and writing
>     the header in order to identify the hash function.
>
>   - They are used internally to identify which hash function is in use.
>
> When one only considers the second usecase one might think that one can
> easily change the representation of those hash IDs. But because those
> IDs end up in the reftable header and footer on disk it is important
> that those never change.
>
> Create separate constants `REFTABLE_FORMAT_ID_*` and use them in
> contexts where we read or write reftable headers. This serves multiple
> purposes:
>
>   - It allows us to more easily discern cases where we actually use
>     those constants for the on-disk format.
>
>   - It detangles us from the same constants that are defined in
>     libgit.a, which is another required step to convert the reftable
>     library to become standalone.
>
>   - It makes the next step easier where we stop using `GIT_*_FORMAT_ID`
>     constants in favor of a custom enum.
>

So this patch tackles the first scenario mentioned above (for
reading/writing the header), changing the second scenario
(identification of which hash function) is handled in the next step by
introducing a custom enum. Makes sense.

- Karthik

--0000000000005646e5062730288b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e437f63b98bcb237_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1JXOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHdNQy93SkZ0cTRVRjh4NmdxT3ppck5FNjF2Tlg2VQoyRWkycXhEZi92
T1dwYzJpaE8rSGZmN0t5UVpkdDVpUitNRGQ5ZlBuWlAzeStseW1FOVVFekhuYzlPY2ptdWNtCkVS
c1R3YjhNdWhTcE80NFpoZ2pDY1JZS0xEZVp5Nk91Z3R1amNuN3RuSjAzWGlDUTlQaUVDdnBjcE9j
c0xwaU0KVTFwWUFrK3B5bTZLMDJoczQ3dEN4dFR1U3Vwa2hCSU11NW1UYmI2d3VKM0FzMlJaQVhv
SlAxcm1kbDBHdmJ1SApEcUxyR1ZjWE1qVEV3dVRSN2trYlFNUDFYVFhrRkRBL0prcmwzSmo5S0Fm
cElsanZ0ZVlvZVJCWTBNY1NKY0ZFCmMvNFBuWlIyYy9lUCs1eUpDVjBPVk9UNCs2ekE3VzdIUThR
Sk5KL1VZNFlGT1ROSXdVNFlURGNPSUFGSTZKdysKWi8vUjBGVUNqcmhpd20xMW5mMzNaQXhrcjBG
bW9HM2lEbG5oV2pGSFdDT1VoZ2ljRTNUcmpPdUVFV1ZHNnNVOQowZU5MVEF1SmpmVkFidUt3VkNs
MWE5UmtzR01pbDBScm9LWkl0SWFiVVBLUlRtMDNKNitwL2M1WGhBV2dJMHRsCkFPSnJzUmY5bVdv
enR4NjZWS3ZFT2I2SWhGV1RiMzF0WStTQjVhdz0KPURkUTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005646e5062730288b--
