Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE48271450
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423754; cv=none; b=MzHhpfNXyESRY7/1M22woRC1M/FSGEozeZtderVD8wAqXeVUAazMhs2/zNRtRLW0ef+lK7m+n4Aib/5b4A1Soytjm+XlrWk0TGNKLbGjq9pOGWcfOudhVdX1XxABFyr03lHBoVZOKUxsmn1H9MkL2wjQTNKqrRC/Qd4coqmq3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423754; c=relaxed/simple;
	bh=n2uhCrJmGpWVdc7FqiXc68KeWaoX//z05U5cEVYPlpM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k221hkSOmYzC7Or3CxJVdLAIXOXiiKyIxmC5qpU3IVwjSfJ2pXL0hfTBwMHxc3TMpJDUO257pkNs8xrFk91K8Ch8jZwpWGznjZel80kSj9flJTiDTzsFNDn0FQ/UncPcYaV34EBcsE+pPyhhhFnVZIBKgmZBJAvjzsmNuAyJf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfNSpYjG; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfNSpYjG"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1274204434bso696637c88.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423752; x=1772028552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSXcob4XcaRfLep2zm7pZ6nN97aZxHH28yi2lHp9AWc=;
        b=IfNSpYjGCQtNeb3iVebuE5ovIqIte3YqF289SBsQw5SEKmTaxPMO1oVpP8f/GkkqAb
         DeWFj0PD83oMgY+BwmGXQWh0LGMDT1qRZrEvEMWv86u1wkcm2bOiUMK3tSWoMbcXC76m
         0btENxn3OCyf47khj9bacn1FXAxx0N1+AECRTO3mO0lkZAiH3i66K633UI8RLugBwN6s
         mZ/6rQD3bNR6Fp8BtQCK4WLac2khEpI9h4iRcUltMUfiC4NheuAMfcDuNMxjxhjZStQm
         +dbo8NoCHkxeyQkE9tdfRmt65MidUuA4b2A+HpAazD0eKckY0OyesAEBUcsy8FfmbQ8Q
         4cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423752; x=1772028552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSXcob4XcaRfLep2zm7pZ6nN97aZxHH28yi2lHp9AWc=;
        b=QxETn6P4a0Y/QzF00WBw++Psev22zgRGyEd+UvbvfJ5KjCs5EDAydpzzm+II6J0t3x
         KZaxFo8sjsYG6b+w2Emhb0KaGdsBk27V3+BwHh+mt2RMmJYQ4XUI8yVes281+LzfJ9vZ
         pOezjxqIiWJsXrnttlJu+tmzobCRvkiqiE5bKb2Z1nC6F1UqXWqFVR2JprM3i8vWiZ9c
         TDuHINnzXCcDUheICS60toHJUVJRKIWJkWoaeMGDblQyCIN0O+tKnxOydNO7AYxi+geH
         oYIYuRP2FoA4y91wYGe8spnpN4dxEDxiWwOkhJbeV06zLnOoru7X0ofFkGyrY8gWRfJq
         /kww==
X-Gm-Message-State: AOJu0YxOYfJE2OQUn9b3Xp5IkWIoxQD3k70dMSQ5V6ItezKPqJFl0APi
	vKMKcdFE8tWtboSf8GzUuOWv/qlcA7NZx1JZgD/0C5kj88zPiN8qfQ5TdpxQZQ==
X-Gm-Gg: AZuq6aLoe2ci49Lx4C/xBxHahm0CZRnsvdhRsI1JrXRZ7z6lu/zupFbMDk2r+6/uLHK
	rvg1wRIG31rkM3F1/d7ou4EWphCXV9+CRFHmC43yQr4iP8YHpraVvByYEm/t08I9B1Ymbo4rTcw
	22UR01pCcKPFXB+DRxjele9q5t+oCRGBEfH0QNRNiMSPfQttKLYzdK6ibwE+fEPwo2Bx0Vt0BHt
	0jmsFPOOcNsQZetugiyxAcFYgtAQk8YA+PwqZFykeUDR/tOcKH3dVdMGBCIri8qi5Aev6Qadh1N
	kEU+eOGOMlwJfHMOE975cw8cx7/etRayTaboYfkn8Via/gTrkKRxhD2TKR1A8oJ0Q+m7DT4G0S/
	1R1mR+RFSSow9JQcBdVcQJbnAWyOslM/VVqTWZ7umYynqiS/mArtHZz6xmUFeXJgUwn9w1UXIOJ
	7vIgncYlMw8FnSbAjJS3Db/qnsUxTDUnQHUy91
X-Received: by 2002:a05:7022:1284:b0:11e:3e9:3e91 with SMTP id a92af1059eb24-12759909e20mr954116c88.26.1771423750707;
        Wed, 18 Feb 2026 06:09:10 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b61ff7sm18469262c88.2.2026.02.18.06.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:09 -0800 (PST)
Message-Id: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:03 +0000
Subject: [PATCH v4 0/5] http: add support for HTTP 429 rate limit retries
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Changes since v3:

 * Clean up of all strbuf_attach() call sites

 * Add strbuf_attach() contract enforcement via BUG()

Changes since v2:

 * New preparatory patch: Introduced show_http_message_fatal() helper
   function to reduce code duplication in remote-curl.c (suggested by Taylor
   Blau)

 * Removed specific HTTP_RATE_LIMITED error handling from http-push.c and
   http-walker.c for the obsolete "dumb" protocol, allowing generic error
   handling to take over (suggested by Jeff King)

 * Added support for CURLINFO_RETRY_AFTER on curl >= 7.66.0, falling back to
   manual header parsing on older versions

 * Simplified retry/delay architecture: replaced complex non-blocking
   "delayed slot" mechanism with simple blocking sleep() call in the retry
   loop, removing ~66 lines of timing logic (suggested by Jeff King)

 * Fixed Retry-After: 0 handling to allow immediate retry as specified by
   RFC 9110

 * Changed http.retryAfter default from -1 to 0, so Git will retry
   immediately when encountering HTTP 429 without a Retry-After header,
   rather than failing with a configuration error

 * Improved error messages: shortened to be more concise

 * Fixed coding style issues: removed unnecessary curly braces, changed x ==
   0 to !x (per CodingGuidelines)

 * Improved test portability: replaced non-portable date(1) commands with
   test-tool date, added nanosecond-precision timing with getnanos, replaced
   cut(1) with POSIX shell parameter expansion

 * Split out strbuf.c bugfix into separate preparatory patch (the
   strbuf_reencode alloc size fix is unrelated to HTTP 429 support)

 * Squashed separate trace2 logging patch into main HTTP 429 retry support
   commit

 * Kept header_is_last_match assignment for Retry-After to prevent incorrect
   handling of HTTP header continuation lines

The implementation includes:

 1. A bug fix in strbuf_reencode() that corrects the allocation size passed
    to strbuf_attach(), passing len+1 instead of len so that the existing
    buffer is reused rather than immediately reallocated.

 2. A cleanup of all strbuf_attach() call sites that were passing alloc ==
    len, leaving no room for the NUL terminator. Sites with a
    known-NUL-terminated buffer now pass len+1; sites where the source
    buffer has no trailing NUL (ll_merge output) are converted to use
    strbuf_add() instead.

 3. A hardening of strbuf_attach() itself: the internal strbuf_grow() that
    silently papered over incorrect alloc values is replaced with an
    explicit BUG() check, enforcing the documented contract that alloc must
    be greater than len.

 4. A new show_http_message_fatal() helper in remote-curl.c that combines
    the repeated pattern of show_http_message() followed by die() into a
    single NORETURN function, reducing boilerplate at existing call sites
    and providing a clean hook for the retry logic.

 5. The main feature: HTTP 429 retry logic with support for the Retry-After
    header (both delay-seconds and HTTP-date formats), configurable via
    http.maxRetries, http.retryAfter, and http.maxRetryTime options. If any
    computed delay exceeds maxRetryTime the request fails immediately with a
    clear diagnostic rather than capping and retrying silently.

Vaidas Pilkauskas (5):
  strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
  strbuf_attach: fix all call sites to pass correct alloc
  strbuf: replace strbuf_grow() in strbuf_attach() with BUG() check
  remote-curl: introduce show_http_message_fatal() helper
  http: add support for HTTP 429 rate limit retries

 Documentation/config/http.adoc |  23 +++
 apply.c                        |   3 +-
 builtin/am.c                   |   2 +-
 builtin/fast-import.c          |   2 +-
 git-curl-compat.h              |   8 +
 http.c                         | 190 +++++++++++++++++++++--
 http.h                         |   2 +
 mailinfo.c                     |   2 +-
 refs/files-backend.c           |   2 +-
 remote-curl.c                  |  49 +++---
 rerere.c                       |   3 +-
 strbuf.c                       |   5 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 trailer.c                      |   2 +-
 18 files changed, 629 insertions(+), 38 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2008

Range-diff vs v3:

 1:  821043c664 ! 1:  a3386f5b56 strbuf: fix incorrect alloc size in strbuf_reencode()
     @@ Metadata
      Author: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
      
       ## Commit message ##
     -    strbuf: fix incorrect alloc size in strbuf_reencode()
     +    strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
      
     -    The strbuf_reencode() function incorrectly passes the string length
     -    as the allocation size to strbuf_attach(), when it should pass
     -    length + 1 to account for the null terminator.
     +    reencode_string_len() allocates len+1 bytes (including the NUL) and
     +    returns the string length in len. strbuf_reencode() was calling
     +    strbuf_attach(sb, out, len, len), so alloc was one byte too small.
      
     -    The reencode_string_len() function allocates len + 1 bytes (including
     -    the null terminator) and returns the string length (excluding the null
     -    terminator) via the len parameter. However, strbuf_reencode() then
     -    calls strbuf_attach() with this length value as both the len and alloc
     -    parameters:
     -
     -        strbuf_attach(sb, out, len, len);
     -
     -    This is incorrect because strbuf_attach()'s alloc parameter should
     -    reflect the actual allocated buffer size, which includes space for the
     -    null terminator. This could lead to incorrect memory management in code
     -    that relies on sb->alloc being accurate.
     -
     -    Fix by passing len + 1 as the alloc parameter:
     -
     -        strbuf_attach(sb, out, len, len + 1);
     +    strbuf_attach() then calls strbuf_grow(sb, 0). With alloc < len+1,
     +    ALLOC_GROW always reallocates, so we reallocated immediately after
     +    attach even when the strbuf was not extended further. Pass len+1 as
     +    the alloc argument so the existing buffer is reused and the
     +    reallocation is avoided.
      
          Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
      
 -:  ---------- > 2:  f48b1f07c4 strbuf_attach: fix all call sites to pass correct alloc
 -:  ---------- > 3:  557fd77444 strbuf: replace strbuf_grow() in strbuf_attach() with BUG() check
 2:  3653067f0e = 4:  3a39dc9e39 remote-curl: introduce show_http_message_fatal() helper
 3:  3cece62a63 = 5:  5e0f4a56ef http: add support for HTTP 429 rate limit retries

-- 
gitgitgadget
