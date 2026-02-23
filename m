Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0436142E83
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856409; cv=none; b=JvpzrXfrgqW9mMEXOV+esTWqN0qizY+Utkityiuk2tYqqZXV5yJEBfPLhbLISr7rDWcJBjrCmrwHv3S+x+95aPP2GjaQUQD/y/c8hny6seDEEh0DHBNi2umps1Q36CaCo8Cld/BWUTXoldtcEN/vT4/hiOiqru7TUBf5UvG9XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856409; c=relaxed/simple;
	bh=nO9UyQBlWtTi3hGzliRt+2Yfvblhb9Bm21/ecZfnZ7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H4Fd0DBhiVH1L0VIBgywXe9aBRM4Ic2LSn2For47MCHx2lnxwqPqybKjy4HTPI9KLft/V8RSPHShhTo4uMOdAcrtD0SgLhiwOwjGNkrK7m6Ldk+Vd0sVud23MVnAvvB7hpO/5zE7yNAhdk9bXJf2+bmwCCOpnKhst7a6m60jAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGWDLh9t; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGWDLh9t"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so2834520137.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856406; x=1772461206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcaNg5lw9l4JIP3/G/Fabz618aHzA9/m2qrDkTf4KaM=;
        b=PGWDLh9t1IJ3Zp4/DbLoeYZkJd4ieeN2MVSKYFOdRET6u6M8mMepY4lbvrOAFX7r+5
         +HI/Qf9RqztTrjno4nXSPjtM/jecg4wNXRe2Q3jiNrVh1qMB1rKzgeqCpivqE4PTNWgJ
         uWyCx5ZR3X5vSgI+WAeYnpiARSEwoY1cBjz52Ee+rL1YyewM7c7tDQqdUrhXABQeUHUH
         fbSebOwk9WwjPnK+dqJFg59/HXhB+zCj0G7mTd4O3kYOyggxzaG3xqbj1RgdCTaHkyOC
         tmZ9CzJwTuGj70qN/8hcM1qsobRNOSalwE23Y6IW1R5O6/Cv4Y8aWzqrOEeYFMrdXWT7
         ejIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856406; x=1772461206;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcaNg5lw9l4JIP3/G/Fabz618aHzA9/m2qrDkTf4KaM=;
        b=dAX4LZd7DNEepO2piZk+hjRBYO96RqpTgMe82DZvAigtvfUvYMccIZflEQkMuC9P7F
         W6JoRSlpCxPcZEUMQniBnYg13nSalTg/bgSwT4+TYMjtqMuf6SNZY1+9VLlETor+FNgt
         08QHIGU795OEThRf7EIp3EDhExNJ9UTVhz3rOjQcwjdbW+UXqEgMn8F992xoEO/GP5xZ
         iiNRRbXYzIa08TaEtZN9vnMJUoIFi6xFkfg/f6M3PnhWaDY5LjmPOWZCvpxWsnSLg/Ik
         tiN7iFE8qWGVi355uQw0cpBaU+/5dx9XvOxjvtvishpMJmaIGIOJXReOGGYuHeJXT7JL
         Zrag==
X-Gm-Message-State: AOJu0YxKAtPLiuLr7bID7J6+pjV7apZI66/spx48UqGtH4oLkW1pM9le
	C7Is3V+nPkvNeagmBg326nuoDwBKiFvPfbhHRzPZZkYc+0JVvjMMEyNxmrRB7chE
X-Gm-Gg: AZuq6aK4FFZF3I/KwLYVGfFGaU+W8QXRQc5cyPgLx9TeuWt4w6+hOfXFkUsrHVQs2+N
	7Lg6YID1xBIUO5g5frAHQrURurdFW8BN8YDhPlz5q+g1kysTfz22ALnR4H+XArXC/x0esHsN2qn
	AT69OozxZt+Pz3Tn1XlztJwpS++UlQUgOP3CVq1hJeob29zPlq93oBc9tEFdi36vPVekN9yNw7s
	L0zf8WLt4+dId90erUJeklsq510a3GnAWL30+UipjdLb0CJp2u9svZHQeAe6Wk5z1ff2NgdxKyo
	bo2BZ7Aygj1yZOnc15ZA+ciwKnazbfamMee1OZ18QejgHiDF2hF8fLnCPs/2JOAai1Slhc56M1S
	OBhor590qs6TEg7nbf/IxNTa38c6pNt0huZzxHaoiojnnqsx8MmTILopoBbmqustkem982TwWrA
	cLeazghqxRKTlFc5s7QkI51FO6hA==
X-Received: by 2002:a05:6102:3f4b:b0:5f8:e2d3:c463 with SMTP id ada2fe7eead31-5feb2e5ee2dmr4648262137.3.1771856406346;
        Mon, 23 Feb 2026 06:20:06 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6203b13sm7776112137.1.2026.02.23.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:20:05 -0800 (PST)
Message-Id: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:20:01 +0000
Subject: [PATCH v5 0/4] http: add support for HTTP 429 rate limit retries
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

Changes since v4:

 * fix only strbuf_attach() calls which don't need reallocation
 * remove patch, which enforces strbuf_attach() contract via BUG()

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

 2. A cleanup of strbuf_attach() call sites that were passing alloc == len,
    leaving no room for the NUL terminator. Sites with a
    known-NUL-terminated buffer now pass len+1; sites where the source
    buffer has no trailing NUL (ll_merge output) are converted to use
    strbuf_add() instead.

 3. A new show_http_message_fatal() helper in remote-curl.c that combines
    the repeated pattern of show_http_message() followed by die() into a
    single NORETURN function, reducing boilerplate at existing call sites
    and providing a clean hook for the retry logic.

 4. The main feature: HTTP 429 retry logic with support for the Retry-After
    header (both delay-seconds and HTTP-date formats), configurable via
    http.maxRetries, http.retryAfter, and http.maxRetryTime options. If any
    computed delay exceeds maxRetryTime the request fails immediately with a
    clear diagnostic rather than capping and retrying silently.

Vaidas Pilkauskas (4):
  strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
  strbuf_attach: fix call sites to pass correct alloc
  remote-curl: introduce show_http_message_fatal() helper
  http: add support for HTTP 429 rate limit retries

 Documentation/config/http.adoc |  23 +++
 builtin/am.c                   |   2 +-
 builtin/fast-import.c          |   2 +-
 git-curl-compat.h              |   8 +
 http.c                         | 190 +++++++++++++++++++++--
 http.h                         |   2 +
 mailinfo.c                     |   2 +-
 refs/files-backend.c           |   2 +-
 remote-curl.c                  |  49 +++---
 strbuf.c                       |   2 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 trailer.c                      |   2 +-
 16 files changed, 623 insertions(+), 35 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2008

Range-diff vs v4:

 1:  a3386f5b56 = 1:  7ec2d66447 strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
 2:  f48b1f07c4 ! 2:  3e0b78cfb6 strbuf_attach: fix all call sites to pass correct alloc
     @@ Metadata
      Author: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
      
       ## Commit message ##
     -    strbuf_attach: fix all call sites to pass correct alloc
     +    strbuf_attach: fix call sites to pass correct alloc
      
          strbuf_attach(sb, buf, len, alloc) requires alloc > len (the buffer
          must have at least len+1 bytes to hold the NUL). Several call sites
          passed alloc == len, relying on strbuf_grow(sb, 0) inside strbuf_attach
     -    to reallocate. Prepare for changing that by fixing call sites to pass
     -    the correct alloc.
     -
     -    - mailinfo, am, refs/files-backend, fast-import, trailer: pass len+1
     -      when the buffer is a NUL-terminated string (or from strbuf_detach).
     -    - rerere, apply: ll_merge returns a buffer with exactly result.size
     -      bytes (no extra NUL). Use strbuf_add() to copy and NUL-terminate
     -      into the strbuf, then free the merge result, so alloc is correct.
     +    to reallocate. Fix these in mailinfo, am, refs/files-backend,
     +    fast-import, and trailer by passing len+1 when the buffer is a
     +    NUL-terminated string (or from strbuf_detach).
      
          Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
      
     - ## apply.c ##
     -@@ apply.c: static int three_way_merge(struct apply_state *state,
     - 		return -1;
     - 	}
     - 	image_clear(image);
     --	strbuf_attach(&image->buf, result.ptr, result.size, result.size);
     -+	strbuf_add(&image->buf, result.ptr, result.size);
     -+	free(result.ptr);
     - 
     - 	return status;
     - }
     -
       ## builtin/am.c ##
      @@ builtin/am.c: static void am_append_signoff(struct am_state *state)
       {
     @@ refs/files-backend.c: static int commit_ref(struct ref_lock *lock)
       		/*
       		 * If this fails, commit_lock_file() will also fail
      
     - ## rerere.c ##
     -@@ rerere.c: static int handle_cache(struct index_state *istate,
     - 	else
     - 		io.io.output = NULL;
     - 	strbuf_init(&io.input, 0);
     --	strbuf_attach(&io.input, result.ptr, result.size, result.size);
     -+	strbuf_add(&io.input, result.ptr, result.size);
     -+	free(result.ptr);
     - 
     - 	/*
     - 	 * Grab the conflict ID and optionally write the original
     -
       ## trailer.c ##
      @@ trailer.c: static struct trailer_block *trailer_block_get(const struct process_trailer_opti
       	for (ptr = trailer_lines; *ptr; ptr++) {
 3:  557fd77444 < -:  ---------- strbuf: replace strbuf_grow() in strbuf_attach() with BUG() check
 4:  3a39dc9e39 = 3:  973703e9dd remote-curl: introduce show_http_message_fatal() helper
 5:  5e0f4a56ef = 4:  bfee1f10c0 http: add support for HTTP 429 rate limit retries

-- 
gitgitgadget
