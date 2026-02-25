Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B92ED154
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044619; cv=none; b=qoqKvw7bqje7wC6CU5w0gTVUz0Xsy9qU2F6VshtoyntsIatuG+AHXKm4X85ei1jYTwhosaFdUrx1w0X351HGhB7gY39qvXIYn6MzWSQ7h6vRE/vrVoZ3XItcUkz4M2wI9jIbH/ek3JSjj5kCTNWyTNMXGdXzLqUbgnXXoxn+IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044619; c=relaxed/simple;
	bh=JpPrX3qi6ZnarwhA8xLpNsLaG6K+QO1AIfdiegmhc9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2LSGjZK4/dDeMx1omYWXQzuDwMX8FD+dKX1IOMZJTlcTa/3MZ3jqwesmwHrWmYJJZ7cGeMMjBsYX2Vs62TYvcn2OJ2ficTjpHhReVZmnCPOP93IwNkSl6cxZMF81+CzhY6bDAaY/i+MXAjzJHBzyNtkPcu4+z6hxB5hFF+kKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJr7rpzN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJr7rpzN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fd9c2b2858so1824960137.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044616; x=1772649416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcmiR5lojlGK06BJKSWHkn0QC8I+8kETT8KUAQKdCgM=;
        b=UJr7rpzNWqUFiDHr+vdApnMSZpT99MPSFkW9wVWPWvjMJI7q64C0/jzL3OZF/EwrFb
         sMmIgYAYJVpmTbnIt1ImcePeBZ1RjXahHHeBK9kxtfwSTGP7N43Xpk5iLnFlPPl6F0Te
         wk+tSAnLlPoHKr8DO6EOB1eMyfzr4AKGLGmRPl/f9AQBTclhzYpRReXIy8Ha9fBK9bkK
         w+u9s7rr8Is4y9SOfd2L6FWGdch7Y66deyuAG17CL1bgp8ECt2jDaZBD98BdeNBTajlQ
         uDqsJ5/6RMMpcFpP/kWDjQtGbD7WDy4bBk1bNULWRZzGFc624oNEhbHLFJYzw7bBTi5y
         bgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044616; x=1772649416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcmiR5lojlGK06BJKSWHkn0QC8I+8kETT8KUAQKdCgM=;
        b=k9JaudlH7ZvwtzBkQWdBru4dwgl/1+Dx8qUPA1bc1q7lQ60Uuoe9rF95s4uiNUHLCq
         zrPpgZ4IrhfzIonry6J/CoE1WgNb4MLyw6BGTDx4p2ko/eJoQziwi8ziGinFFpcf4oAd
         UAdk19gFyOdiKBsupILkeDGG4BmCzCsbwn/WsThQ+nvmLC2mxagYS+owIovq+gwtwN7/
         gszLR/w+uWRFkpQkIECYsHpc/LfhAwPrbF79+0L+BUu9XF0yJl7m0w4xx0MdkkYxA8bu
         JIO7M/zhehgmEfdWsDkJYvv7ZqTjuLjERV3uzWyRYpo57IaH0pqnRMJzVZRuMM/4LyjX
         4rpQ==
X-Gm-Message-State: AOJu0YyMHR+6G301IPW76ym6ho/TuXMfilE64aPy5eiC6LsBtMdTb4EK
	HlYzWzEvjxJ/C98RC9vOVvK+AXBRf4WA8SkVkHdMsQ6r6Xii5bZPb/bcLSvs7g==
X-Gm-Gg: ATEYQzx8tV/TFZaMOMpayfeszCV97dF+ukSIKq0tqz0JV3PVVsv/z2lBNkOe+/yi3Gs
	2WxntrAN0DdNzC6gn+t1Fb6CxwAIHWa01PA4PhJhv7uDsnPKX+AHgykcXCbVv+ZqSel46j1nNHt
	lKbYECY5AxUE8T2gOKC5gYSE0/gUkQacbsTjLuSeW4cJ9W9mXGbKwrPu07PvFhXcUs3WB3D+iu4
	RxSqjf2xOpE/RaDE2vD+isUTWSjKwW9DypwYy2DV13z8XcaVBHnNNqg2T23d15akgGeihldzzkT
	fPUJxHBiAncKGXu/DcEOTiuTHC1IXgMcBy/7ssWqqA0GTcuhX0BFGgdAku2hphmArHq0RrZ7nGr
	HkyUvwl68pzue9/1gnEgxo4yDUMAqEWJJVpfyFjSbDj+7rZtZwuTTKcRMopMij8s1cxgvQoDlSj
	RI/TUPVCVnTP/wHEGh7BVh/usPMozdOo7UW03REkbG+HT17mF4ixps9UJKVDD+3GZvmAiQf6k=
X-Received: by 2002:a05:6102:30c4:20b0:5ff:17bd:9e83 with SMTP id ada2fe7eead31-5ff17bda865mr435664137.14.1772044616341;
        Wed, 25 Feb 2026 10:36:56 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.36.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:36:55 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 0/8] repo: refactoring leftover nits
Date: Wed, 25 Feb 2026 13:32:09 -0300
Message-ID: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

There are only three changes in this version:

1. Applying Eric's suggestion of instructing to name array plural if we're
   dealing with the values as a whole
2. Making it clear why we should replace the NUL characters in the files
   consumed by tes_cmp
3. Replacing characters in just one tr call instead of two

Lucas Seiki Oshiro (8):
  CodingGuidelines: instruct to name arrays in singular
  repo: rename repo_info_fields to repo_info_field
  repo: replace get_value_fn_for_key by get_repo_info_field
  repo: rename struct field to repo_info_field
  t1900: rename t1900-repo to t1900-repo-info
  t1901: adjust nul format output instead of expected value
  Documentation/git-repo: replace 'NUL' with '_NUL_'
  Documentation/git-repo: capitalize format descriptions

 Documentation/CodingGuidelines          | 13 ++++++++
 Documentation/git-repo.adoc             |  8 ++---
 builtin/repo.c                          | 44 ++++++++++++-------------
 t/meson.build                           |  2 +-
 t/{t1900-repo.sh => t1900-repo-info.sh} |  0
 t/t1901-repo-structure.sh               |  8 ++---
 6 files changed, 44 insertions(+), 31 deletions(-)
 rename t/{t1900-repo.sh => t1900-repo-info.sh} (100%)

Range-diff against v1:
1:  041d00fdbf ! 1:  51cfa0901e CodingGuidelines: instruct to name arrays in singular
    @@ Commit message
         Add a new rule to CodingGuidelines asking for arrays to be named in
         singular instead of plural.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
      ## Documentation/CodingGuidelines ##
    @@ Documentation/CodingGuidelines: For C programs:
         unsigned other_field:1;
         unsigned field_with_longer_name:1;
      
    -+ - Array names should be named in the singular form. E.g.:
    ++ - Array names should be named in the singular form if the individual items are
    ++   subject of use. E.g.:
     +
     +         char *dog[] = ...;
    ++         walk_dog(dog[0]);
    ++         walk_dog(dog[1]);
     +
    -+   and not:
    ++   Cases where the array is employed as a whole rather than as its unit parts,
    ++   the plural forms is preferable. E.g:
     +
     +         char *dogs[] = ...;
    ++         walk_all_dogs(dogs);
     +
      For Perl programs:
      
2:  ccf0e85919 = 2:  35feb400af repo: rename repo_info_fields to repo_info_field
3:  eccfcf8164 = 3:  f2926725a2 repo: replace get_value_fn_for_key by get_repo_info_field
4:  b360e3ea11 = 4:  03874e8021 repo: rename struct field to repo_info_field
5:  3c4ae0550d = 5:  02682a08e7 t1900: rename t1900-repo to t1900-repo-info
6:  63b516b424 ! 6:  10accd800a t1901: use tr in git repo structure output instead of expected value
    @@ Metadata
     Author: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
      ## Commit message ##
    -    t1901: use tr in git repo structure output instead of expected value
    +    t1901: adjust nul format output instead of expected value
     
         The test 'keyvalue and nul format', as it description says, test both
    -    keyvalue and nul format. These formats are similar, differing only in
    +    `keyvalue` and `nul` format. These formats are similar, differing only in
         their field separator (= in the former, LF in the latter) and their
         record separator (LF in the former, NUL in the latter). This way, both
         formats can be tested using the same expected output and only replacing
         the separators in one of the output formats.
     
    +    However, it is not desirable to have a NUL character in the files
    +    compared by test_cmp because, if that assetion fails, diff will consider
    +    them binary files and won't display the differences properly.
    +
         Adjust the output of `git repo structure --format=nul` in t1901, matching the
         --format=keyvalue ones. Compare this output against the same value expected
    -    from --format=keyvalue.
    +    from --format=keyvalue, without using files with NUL characters in
    +    test_cmp.
     
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines and nul format' '
     -		# Replace key and value delimiters for nul format.
     -		tr "\n=" "\0\n" <expect >expect_nul &&
      		git repo structure --format=nul >out 2>err &&
    -+		tr "\012" "=" <out | tr "\000" "\012" >actual &&
    ++		tr "\012\000" "=\012" <out >actual &&
      
     -		test_cmp expect_nul out &&
     +		test_cmp expect actual &&
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines and nul format' '
      		# "-z", as a synonym to "--format=nul", participates in the
      		# usual "last one wins" rule.
      		git repo structure --format=table -z >out 2>err &&
    -+		tr "\012" "=" <out | tr "\000" "\012" >actual &&
    ++		tr "\012\000" "=\012" <out >actual &&
      
     -		test_cmp expect_nul out &&
     +		test_cmp expect actual &&
7:  6e0be4e746 = 7:  508a2af2e3 Documentation/git-repo: replace 'NUL' with '_NUL_'
8:  e4125e2370 = 8:  cbf17b7abd Documentation/git-repo: capitalize format descriptions
-- 
2.50.1 (Apple Git-155)

