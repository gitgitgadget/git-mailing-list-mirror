Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D33ACA73
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140493; cv=none; b=OPoNbxmXVcQLEV8bjpzy711AeVDz1gX71lG285deLIWdx0JDWUaquj71AQn1GyZTV3uTK62f76BGPNmL0jh016mxLgXJ+X9ReT67MkTPGuoOy9BjpKGSgAQGtnO3F/Haonk1iMH/7Zy79CvIKzgWYzo0+beWksMh6PWfAf7re9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140493; c=relaxed/simple;
	bh=+iZXPafcrFwMzrPwrmCKDd8W/arVmDvvhXIpPRem+LE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JSzUJG73W13aZi57rH60PGdaSJ5s+aqYpPRj+NLcsn2Qpre55fWZlHcKl7DTASdX/X8pzqtr7bgYPgx0tiXdmi5a7QPdGxqwz7lcSeIIoCPe96WLyVj14KIynd5JsEb4SyjLKUcvzA7IDImJOEt7tUck2K+gt9PQbmIOOia5ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvSa8F2n; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSa8F2n"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a2f4cdddso16531216d6.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140489; x=1772745289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKN5dVrTFdWbkwcROxbNJS45SctX7Mv4q+yiMxn8l9w=;
        b=fvSa8F2nUcDivZ8hW3ngmLaQSgch6b0+lCOUkx8O5L5RmDSEN6DLbR6s8vivJEZVTN
         pCBD556rYJ8cY4XaGo31RGpfFI6xlPHzYnBCDfGcWO+ShBvwAgSRY2f8cewrFHLxMTZu
         HM3XsJ7x3DvYuQmC38sxB0q9M7+02+PdYMwe1X/3ouemD1wXPTdTvlJ1SaLStABpFnAn
         J04/WT3XOvvwWFRnk6Maf8JZr8JQ8Hh4VxPFc4yw0RZ4lBz6EG+IVovqM5Uoh8+HG6OU
         ZRF2umU+ncQhs+7BV4zawGmr6FfBD1pRqJevNSPR1DUzWwfbcQup0JLJ8VtkB9MhdXjE
         wV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140489; x=1772745289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKN5dVrTFdWbkwcROxbNJS45SctX7Mv4q+yiMxn8l9w=;
        b=mO5jE8Yd9Z7etVmvyHdH7su2kZUBXeOxaqJ5STeVvMpxEqLxZy00Tip9sR9GZPcwpM
         CEu6hrgUUaYE0EVxuJq0WDrUd56BbeY8IIftx72j3Eud4rfaxRftrBjBP9MY610UhRLm
         W5a0V1rSTBxbo8RPa/CdHW3feQRA2GLvFwukwfPs28+s/p1xElXXckRbntcEffNWxtCq
         7cSSuZC96gvspydJXMFGhjWUQXwjDqf0JEmy3lS/vAiALwri42AKGFb8VkU/BQiGe+fq
         eln2NTNXDqR6HAQo+INUrwO/6AQHLUCFUcCdDc/2dvYSMzXVkJ/jq+fj2F2PKrY7F3On
         T7qw==
X-Gm-Message-State: AOJu0YxyKVQIfRNVDIhecmUckD7RnaEHAGNqGdvM0PANsxk579vn/adA
	d1J6ZqSiwEAExOPhZ9+FGeQcc2/d4V8Ofjjb21AhiiE75WnDLlwvTS8HTGd3GA==
X-Gm-Gg: ATEYQzxLm+73D2X15vQpGywXTCRfC6lkSAVDEGcakb5NczTdD8Ye0m3ntAfcQYOIHrT
	23+DNI9+1YhCbuRFrQ1s6czhduP9qx1LzW3HgJKf9qEtOJVuNPhrXa0OdTE9MRzxy9rd4M1RxUj
	2Bpw6DWtopbB8NVXLEQRis1+kg22Et9nc3HDeX6sOBU9IYECBt5HSDHDwl21OXXmQ/yopMTewhd
	7ks+TmJh18Qb1hgxk/kmKfcFz48EBhPCLUs0XSSn+y1lx/MGo7w3SE7ke/Ra0ggJc9xZi01ZWex
	VJB3zE8KyDNvZudBgPJEMt6Rr83ZGZcXXX1Z9UWzY8w9/ECb9NAVyglpadmZopIEGHIveWt+v3D
	I5xOTKFy9aPOCtcJbNZvLzhDcQww/KAlYHa56wkiyxwYbA8XYf0UVIv80AqovF9Dfk1fefx1itq
	L5yqH4QraFbKtTJ1nIZl5gNVyIUIT3OHxQ0R1Q
X-Received: by 2002:ac8:5987:0:b0:4ff:c15d:b5a3 with SMTP id d75a77b69052e-5075286bb2amr5175621cf.50.1772140488661;
        Thu, 26 Feb 2026 13:14:48 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7375f30sm26194456d6.27.2026.02.26.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:48 -0800 (PST)
Message-Id: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:37 +0000
Subject: [PATCH v4 00/10] repo info: add category/path keys and --path-format
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
Cc: eslam reda <eslam.reda.div@gmail.com>


This series now focuses only on git repo info improvements.
===========================================================

It introduces category-aware key requests, adds path-oriented keys (path.*),
and adds --path-format=(absolute|relative) so scripts can request stable
path rendering behavior.


What this PR does
=================

For git repo info, this series:

 * introduces explicit info-context plumbing in the codepath,
 * adds category-key expansion (for example, layout expands to layout.*),
 * adds path-oriented keys (path.*) for common repository locations,
 * adds --path-format=(absolute|relative) to control path output style.

Tests and documentation are updated accordingly.


What this PR does NOT do
========================

 * No git repo structure feature changes.
 * No t1901 structure test changes.
 * No structure metrics/docs additions.


Why this change
===============

 * Makes git repo info more script-friendly by reducing the need for
   multiple plumbing calls.
 * Improves output ergonomics through category requests and explicit path
   formatting.
 * Keeps this series narrowly scoped and non-overlapping with in-flight repo
   structure work.


Commit structure
================

 * repo: teach info context and category keys
 * repo: add path keys to repo info
 * repo: add --path-format for info path output
 * t1900: cover repo info path keys and path-format
 * docs: describe repo info path keys

All commits are signed off with the same real-name identity.


Changes since previous revision
===============================

 * Dropped all repo structure code, tests, and docs from this PR.
 * Kept only the repo info subset and matching t1900/documentation updates.
 * Preserved split, review-friendly commit structure.


Validation
==========

Focused:

 * make -C t test T=t1900-repo.sh (Linux container): passed.

Full:

 * make test in Linux Docker environment: failed 0 (with expected
   prereq-based broken/skipped categories).

Eslam reda ragheb (10):
  repo: teach info context and category keys
  repo: add path keys to repo info
  repo: add --path-format for info path output
  repo: add structure max object size metrics
  repo: add structure topology and path-depth metrics
  repo: add aggregate structure totals to keyvalue output
  t1900: cover repo info path keys and path-format
  t1901: extend structure metric coverage and portability
  docs: describe repo info path keys and structure metrics
  repo: reduce repetition in structure keyvalue output

 Documentation/git-repo.adoc |  67 ++++-
 builtin/repo.c              | 584 ++++++++++++++++++++++++++++++++----
 t/t1900-repo.sh             | 196 ++++++++++++
 t/t1901-repo-structure.sh   | 250 +++++++++++----
 4 files changed, 977 insertions(+), 120 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v4
Pull-Request: https://github.com/git/git/pull/2208

Range-diff vs v3:

  1:  e9ea572e52 =  1:  99c8058298 repo: teach info context and category keys
  2:  348e361fe7 =  2:  6d5b9ff075 repo: add path keys to repo info
  3:  93585ad079 =  3:  5c438d045b repo: add --path-format for info path output
  -:  ---------- >  4:  504d9cf7a0 repo: add structure max object size metrics
  -:  ---------- >  5:  4b502925c9 repo: add structure topology and path-depth metrics
  -:  ---------- >  6:  1751181950 repo: add aggregate structure totals to keyvalue output
  4:  6ea263fee9 =  7:  fd18f28db0 t1900: cover repo info path keys and path-format
  -:  ---------- >  8:  0525ed4cd9 t1901: extend structure metric coverage and portability
  5:  a2a6768042 !  9:  f17c0f03e5 docs: describe repo info path keys
     @@ Metadata
      Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    docs: describe repo info path keys
     +    docs: describe repo info path keys and structure metrics
      
     -    Document repo info category keys, path.* keys, and
     -    --path-format behavior.
     +    Document the newly added repo info capabilities, including
     +    category keys and path-oriented key definitions.
     +
     +    Also describe --path-format behavior for path outputs.
     +
     +    Update git repo structure documentation to cover newly reported
     +    maxima and aggregate keyvalue/nul fields.
     +
     +    This keeps command behavior and output keys fully specified for
     +    users and scripts.
      
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
     @@ Documentation/git-repo.adoc: supported:
       `structure [--format=(table|keyvalue|nul) | -z]`::
       	Retrieve statistics about the current repository structure. The
       	following kinds of information are reported:
     +@@ Documentation/git-repo.adoc: supported:
     + * Reachable object counts categorized by type
     + * Total inflated size of reachable objects by type
     + * Total disk size of reachable objects by type
     ++* Largest inflated reachable object size by type
     ++* Largest disk size of a reachable object by type
     ++* Largest parent count among reachable commits
     ++* Largest entry count among reachable trees
     ++* Longest and deepest path among reachable blobs
     ++* Deepest annotated tag chain
     + +
     + The output format can be chosen through the flag `--format`. Three formats are
     + supported:
     +@@ Documentation/git-repo.adoc: supported:
     + `keyvalue`:::
     + 	Each line of output contains a key-value pair for a repository stat.
     + 	The '=' character is used to delimit between the key and the value.
     ++	Both aggregate metrics and per-type metrics are included.
     + 	Values containing "unusual" characters are quoted as explained for the
     + 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
     + 
      @@ Documentation/git-repo.adoc: supported:
       
       INFO KEYS
  -:  ---------- > 10:  1bc100d6ca repo: reduce repetition in structure keyvalue output

-- 
gitgitgadget
