Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABA2DC79B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620143; cv=none; b=YPZHLz0qds08Uaqd3dmrsspy+cT5Xb4EgA79TreI/ubqVgz20lDBWHPrM+eHCQj+kGXhwOrFNKm/X3MyHGqgFXFdNm7g7DI0rK4y6pKbu+cXGdR0LhRGkMTIitaJ7cfxtUXO3Cxb2ZfzJ7x/mdrSWo5SGblaTJq9d3C7qZNyWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620143; c=relaxed/simple;
	bh=uNfpDQT1RboAcEm8by3aa8pAFEwo8uSp5gR7Ty0/W9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKOvnd0I1RLYBR3GKUY+7Np+BdvBnrq/leGP/pSi7rh/fvlQ4HUnqs5/YkynGhb/vRlxsuKSLRXL4bFIJeEFXeOG6INBCn685uflR9tWF4m/rYTlSg89G7DdxgPvyrV9SYtn/JqXJERZIcx6SGhovJ4+sry0hhLLEdIxUQHOOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQvmoI9i; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQvmoI9i"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018e9f902so2892351241.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620141; x=1759224941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c54ZJQiinSUU0djnuLtkM1UKA27AK6HbXmxyL8YHG7A=;
        b=ZQvmoI9isRMTIXFp6b/RPj91ihAUoGP6U1SlLJx0gzGHkHepMz5nqNvOaSYKdepODL
         ML2eTX+HW83WavnaGtbQG5cnKVhCJXgqNQOw0ap7QwIMtCAnjSKj7GZVHo7fOwqYwYSD
         v20Dny5fIRMcpfTVq34YtUtu+6j+lWIKpaJIMdl1G5vj/9AJcPh/OI1oXdgylqDKFsro
         eFHAujYOXceKS40cT3ftR83aoQGn5psUyOw1sfy46hHbeJVqn++6i+95j/WajJPf4HAJ
         oS4HChL03qOhrrN4TY4Vxg/qF6mf1Bsw4LMZCqnTdEe1QdvOqN610P3ngwl4Tutg1KYU
         dQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620141; x=1759224941;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c54ZJQiinSUU0djnuLtkM1UKA27AK6HbXmxyL8YHG7A=;
        b=W6v/DXFGC/LDTUuEetZStW3gGMKeUM6mRmX258TBfFxvhhi4aJMMNSoMMcdRktChFO
         ZDp76OJjcpwE3A1lIYvKHkJrebnJ/jgzuf/huYKaoMEQD01dLeUz+Ycnd5b/vK/Pm7ns
         /TL1lWs8rIENWJNXd9uUxhF/mLpo7eUsnkBknZnG/zIjZDlQ+JyHBmvLmG6hqdIhS0n0
         zygs5zFStpp9ldMbmRudZVR1JwKg8yNZA2OZf+IU4rK0DlrJJrwyRDLpdETfmgKjzSfo
         hin0uWhkEZNWbIFR5lq5XoH+JziMkXt3et3s93eT/Ugcm02WVjDUodUJm9XfSdahk3jK
         nHcw==
X-Forwarded-Encrypted: i=1; AJvYcCW1tQtr4f0apFejovhQj53NLcptoM+lmPUTrU4+7hvwbwFTr/3IW9J/4VkvhuuVjaDyWV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAfFfN2aN8dPkHjIiaL96wf7DT5Fbz3yeZW9O8ATWxOvrF92a
	pnxtEGhGUSePGmDlEyAic6kFiYOdw7qT0hfKV7Mb6mEy5uRUSMuWxenIRsyl2lbsebOSOCVtZZw
	0/DTSdIo9S2DcEOZFib85WWt1bRRr79s=
X-Gm-Gg: ASbGncvMmnf6lpTnNTfoO13aLN288BKmmhiuQqNVgSRs8fmi+emWwOyFzmHRjgNMfim
	fCDXb+jj0uNkOJFliUqHkto+K3VTot4J31pscTf01DzmkfqmUSXai8/okXCBaHHeKTQvhzVtls4
	E+599FC5uqER43ZnUZeVSeMmEy7JFXAcFTG7IkGg340WsM1SNhQjFUfBkOWaVeOOidN29jIFLxS
	kUq1UHvaD5HDjK9pxYKnuwTfUcWWdsj2fUYOD0VKw==
X-Google-Smtp-Source: AGHT+IE2PzH6E8OHotKNXsENObDlvw6c/1Col4PSgsVxZjtqQrAXrp4J+wPDavjRDqtR29neb64FdH470mlgW3Q+mt8=
X-Received: by 2002:a05:6102:3a0e:b0:5a1:f09f:524e with SMTP id
 ada2fe7eead31-5a58118f853mr748732137.16.1758620140638; Tue, 23 Sep 2025
 02:35:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:35:39 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:35:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aMp9OtXLfRw7dEwA@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9OtXLfRw7dEwA@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 05:35:39 -0400
X-Gm-Features: AS18NWAowxGbZ4WGbC8OL1hDsuko8lHt6a9KUR0Pug5O5DZ-nCoQA96jg-3AKFQ
Message-ID: <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000c74627063f74a81e"

--000000000000c74627063f74a81e
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> We would return negative index to indicate exact match by converting the
> original positive index to be "-1 - index" in
> "string_list_find_insert_index", which requires callers to decode this
> information. This approach has several limitations:
>

Nit: It would be nice to start by explaining what
"string_list_find_insert_index" does and then talking about the negative
index. Perhaps something like:

  The `string_list_find_insert_index()` function is used to determine
  the correct insertion index for a new string within the string list.
  The function also doubles up to convey if the string is already
  existing in the list, this is done by returning a negative index
  "-1 -index". Users are expected to decode this information.

> 1. It prevents us from using the full range of size_t, which is
>    necessary for large string list.
> 2. Using int for indices while other parts of the codebase use size_t
>    creates signed comparison warnings when these values are compared.
>
> To address these limitations, change the function to return size_t for
> the index value and use a separate bool parameter to indicate whether
> the index refers to an existing entry or an insertion point.
>
> In some cases, the callers of "string_list_find_insert_index" only need
> the index position and don't care whether an exact match is found.
> However, "get_entry_index" currently requires a non-NULL "exact_match"
> parameter, forcing these callers to declare unnecessary variables.
> Let's allow callers to pass NULL for the "exact_match" parameter when
> they don't need this information, reducing unnecessary variable
> declarations in calling code.
>

Makes sense, and much cleaner..

> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  add-interactive.c |  7 ++++---
>  mailmap.c         |  7 +++----
>  refs.c            |  2 +-
>  string-list.c     | 14 ++++++--------
>  string-list.h     |  2 +-
>  5 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 3e692b47ec..7c0fd3d218 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -221,7 +221,8 @@ static void find_unique_prefixes(struct prefix_item_list *list)
>
>  static ssize_t find_unique(const char *string, struct prefix_item_list *list)
>  {
> -	int index = string_list_find_insert_index(&list->sorted, string, 1);
> +	bool exact_match;
> +	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
>  	struct string_list_item *item;
>
>  	if (list->items.nr != list->sorted.nr)
> @@ -229,8 +230,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
>  		    " vs %"PRIuMAX")",
>  		    (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
>
> -	if (index < 0)
> -		item = list->sorted.items[-1 - index].util;

Thanks for this, this is so confusing to read if one doesn't know that
the incoming information is encoded with a special format.

Rest of the patch looks great.

[snip]

--000000000000c74627063f74a81e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc106f3b692c6a70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU2Fla1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWxxQy85QnZENnlmRlM3Z3h5MytKdUJuaGdsbFNrcgozYUR0QjZpeVFK
aVQ3aXYxSHNGZDE3TWJRSFRnMGdQVkJ1azM1dkhWZkhpK0VUUVZ0djZDVmVEY1NERTMvK1VhCktp
K1I3cVBEZ0h1Wko0aWRvYnh2RzZaRU9xUk9ZdmM3bDZHcWRKbVE5aVlNdDRzT3B2T0xxbXg0eEFS
N1A1dlkKbFUxVGU0VWtFc0Y3M1huQm91bENmMWpMeWloOEZ4dU5jUFVIQmErWmJqYmplMHBGTkZX
aU0yMnVMNmNxR1hYYwpDSGcraDJ5LzZVZU96WFRrTXBzUFVYQXg2ZEQwNFI0VzJjYTNOMDRZNFFT
WlJqaERGWVV0TFg3RVZ2RGRKT0F4CjFvL2dOUURHek9VT0V4MVNQeFRpRVlNVld5VkkwYjVrc3FY
MEFDZk5maDNxRDZrUTNQSUYyNm1jTVc3MWFseVYKK3lhOStnTkdDV2NaeHppTHMxRW1NSXd3YTV0
cm9WbDFmYkcvcjJTTmpUWU9wRjUvRU53b0pTd2dqY0xYSnZ1UQpmQ1pRbmtyWlpoakVaMTlaM09W
NWxncmZUamNRQVNma0xsZjUxd3J2L2YxZ0d6dDNGLzdBLzkwL3ZabWNzOXdQCjdxOXNnQzdMeDdw
OGxPUXpLbVZpSzdLMkVadFRuQTJwaEF3bHVwOD0KPWNMRXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c74627063f74a81e--
