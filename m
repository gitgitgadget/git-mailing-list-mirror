Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0491D63F7
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732125; cv=none; b=q7OHjI/m/j9WT49H10lCkU2242GDgM+rL5st7EA79bmg9CyOSx35l+VhbDrU9wcoyY2nOmPFUJEOh1V5efCZYvM1iozhTEC8GPnM2VKEfz+B6E8Ar4EFyJa/tb7ZxfS1kItuy4dImf65xkOd4QVqu3b7VqQArsh+MNaCGoQ2PqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732125; c=relaxed/simple;
	bh=jZIZ/Mi4LSHhwxys2fS7Nod4k9gvk1pv+GmkmmW75YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRmVzeDnP31ULkL6NxeU82GRpZFhSaXnPrlIM8ZgkPilrdgPserF9X2VMSH5q9k/N6KYHYHF7MvJdmM+o+r81qa1LlIbKPwAKlZhbIiHkV6Zsycq9wRd39rzb6/4hd9hXkAwtX4MdbZXN9gU3ALko7gGO/Z991xnY72Os0mg09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzYnqPBX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzYnqPBX"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4548625a91.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732123; x=1760336923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt6Bo7xfX5X5vH7Z7tiXzFmVgfWbBnOjnzu30f1Q3xs=;
        b=BzYnqPBX5JLW33jMVPKxfI+UAIjNlH/EnT+a/g/m3JMWrzd+pMJNtR6d7hUNAgiS3s
         dM5hRytSHijlWVGXsLvri/d4BmcFic2Z4OsYULKmAbZSePWFK4cf36Sdo25Fwwgbt+zX
         gH6pmb/xPww8VuiaxwgYv1PIyKlf2GSW9lGqFlXgN7UQx0il7D8rbLG+3vx9Gouu8Z5F
         Umg/+N2pMO94C++6ogtEtHou3WNaQf9dMnWBwk+aAJxFXqqxb8t6m7sjy0UY+BNzMcQ9
         FrVwPz8Yr5N8a6LP8v+QIOpLMkaVZSiQd+Hni12+UqoplcLnbUdCGkP7m4kCIKNbVovN
         YydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732123; x=1760336923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt6Bo7xfX5X5vH7Z7tiXzFmVgfWbBnOjnzu30f1Q3xs=;
        b=JESoBVF9W4+j9NWFXWfNm4N/+644MEdbNlW4Jvhs1L/EtosSrWnYHoTpb7A9qHurIZ
         Iy68AP3W8wlSfr1trheb9KnD+uAjvV1oovCy8nhgO/5TOkqr4yEHkzyvc7lEYR5RiRjU
         Gk1hV1f3pyBvGqyCwhECzMpW5a4IUrIlyzbsiJ3Bge5EBzBvBWU7lUuKdEP92nqAyedp
         136wndkhYrPnanz0/C87tDlj/OE6Y2l1K0z1Wy1yWcxFIlW5fenJBweJJ/g91q6W5lM6
         Yb5gLSs/HxNuDuUgjL2IeKInL/YTkm+cL+op89IETgrfTUfdQDv2CMOtPOG8L1CUY0CI
         deDQ==
X-Gm-Message-State: AOJu0YzQ8E3OtDo+65LXr7XTzBHnZFBEIrdvMOhsPYFKaDuouHHRONXn
	CqOdudT8Wqcok45pyK9taQAkrwWY1xNdJT0HLuN7wlBUVcTUrFn3yxbao61TFw==
X-Gm-Gg: ASbGncvttOGcBXtrvO0Ju4HRd0CbaIIrRRq2oGC4AczwY3q10raKWFIRTH0rjBUvkv1
	XVcfYAHuXK0htv4Q+LNNZ/tXS5XyIDnkKSXrGze6itaimgAD0HQ8alpyW3VJDu1JjGBDoXpbC/m
	RdH1dBS2NQltKy3xqGTKCzDpLAkulu4F6ArhNy9xB6gjqNCGzXAEm//QTenw92v8Kgaod2rK/DA
	XOwYCdMoFnwTeIxE9Het4ca5LekoQZjjo8HW+na2x0xav11T+zE3aLBhJ6gD7lqYiCaXKkW3lnm
	T3lD3VzP7VG2d3bWlrEiqX4nG91E6NcLu6kusQxHSb+4FU0cYz5h3/ef7+qAUV5RYAkHqccEss7
	rQ7wVYsIPrY8ml3EEJbJYdLsz+RQYunvxYemGQnteCg==
X-Google-Smtp-Source: AGHT+IE9drADNOCd/hvEuu3jwd5GeiP2gsGNll9BgNvlL+ymWPEg9iqr5sEL1BcxKxDAzqm4OBg1Bg==
X-Received: by 2002:a17:90b:3a91:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-339c27af0e9mr14426433a91.25.1759732123168;
        Sun, 05 Oct 2025 23:28:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-339c4a31975sm9764773a91.13.2025.10.05.23.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:28:42 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:28:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] enhance string-list API to fix sign compare warnings
Message-ID: <aONhmrE0otiyZ16f@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMp8yNFiXDyk2hP4@ArchLinux>

Hi All:

This is a small PATCH to enhance string-list API
"string_list_find_insert_index" which has introduced sign compare
warnings.

---

Changes since v2:

1. Enhance [PATCH v2 2/4] commit message to express the motivation is
   avoid overflow.
2. Add comments for `string_list_find_insert_index` function.

---

Changes since v1:

1. Create a new commit which aims at using `bool` for "exact_match"
   parameter.
2. Rebase the [PATCH 1/4] and [PATCH 2/4] into a single [PATCH v2 2/4]
   commit to avoid confusing the user with the motivation of the
   original commit [PATCH 1/4].
3. Enhance the comimt message of [PATCH 2/4] to improve the motivation.
4. Update "i-- > 0" to "i--" for [PATCH 3/4]

Thanks,
Jialuo

shejialuo (4):
  string-list: use bool instead of int for "exact_match"
  string-list: replace negative index encoding with "exact_match"
    parameter
  string-list: change "string_list_find_insert_index" return type to
    "size_t"
  refs: enable sign compare warnings check

 add-interactive.c |  7 ++++---
 mailmap.c         | 10 ++++------
 refs.c            | 13 ++++---------
 string-list.c     | 29 ++++++++++++++---------------
 string-list.h     | 12 +++++++++---
 5 files changed, 35 insertions(+), 36 deletions(-)

Range-diff against v2:
1:  c3786fa386 = 1:  bdcac9b5fa string-list: use bool instead of int for "exact_match"
2:  7ac8fd69c0 ! 2:  0d6d09c8b0 string-list: replace negative index encoding with "exact_match" parameter
    @@ Metadata
      ## Commit message ##
         string-list: replace negative index encoding with "exact_match" parameter
     
    -    We would return negative index to indicate exact match by converting the
    -    original positive index to be "-1 - index" in
    -    "string_list_find_insert_index", which requires callers to decode this
    -    information. This approach has several limitations:
    +    The "string_list_find_insert_index()" function is used to determine
    +    the correct insertion index for a new string within the string list.
    +    The function also doubles up to convey if the string is already
    +    existing in the list, this is done by returning a negative index
    +    "-1 -index". Users are expected to decode this information. This
    +    approach has several limitations:
     
    -    1. It prevents us from using the full range of size_t, which is
    -       necessary for large string list.
    -    2. Using int for indices while other parts of the codebase use size_t
    -       creates signed comparison warnings when these values are compared.
    +    1. It requires the callers to look into the detail of the function to
    +       understand how to decode the negative index encoding.
    +    2. Using int for indices can cause overflow issues when dealing with
    +       large string lists.
     
         To address these limitations, change the function to return size_t for
         the index value and use a separate bool parameter to indicate whether
3:  1cf914fab5 ! 3:  9bfe17ab19 string-list: change "string_list_find_insert_index" return type to "size_t"
    @@ string-list.h: void string_list_remove_empty_items(struct string_list *list, int
      bool string_list_has_string(const struct string_list *list, const char *string);
     -int string_list_find_insert_index(const struct string_list *list, const char *string,
     -				  bool *exact_match);
    ++
    ++/**
    ++ * Find the index at which a new element should be inserted into the
    ++ * string_list to maintain sorted order. If exact_match is not NULL,
    ++ * it will be set to true if the string already exists in the list.
    ++ */
     +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
     +				     bool *exact_match);
      
4:  8a445549dd = 4:  2a602954f2 refs: enable sign compare warnings check
-- 
2.51.0

