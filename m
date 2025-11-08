Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A71917CD
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762637698; cv=none; b=aV5EUWIcSWy6gZbWrrmjQnEwa+9j+6Y+0zXxpf6fKn8yrzQPDu7X40arLVJoMo9qd8A19FBLdEB++RoZZoyVrniu/3t3upG+2yVEzTrql4hRHKw94Rg/x05S7Gq80rR62ksdO4u/S42D4/Xy44PPP5Dwrnoe5gSntocXcVKspow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762637698; c=relaxed/simple;
	bh=ns0IG909L45RGhDCKeIfgmfTzNzNdlpHMz4GvK/qJGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=liZOTzMtqd9UUR+fD20KfayIcPNbBZMX3SN2zOgSCFDtFYhVYPj39zJ5dfIpOek70TFfsUslOwIsKfODah97VxgpTMeJFdg301TOooS2GZor0cRwwxCd0A9dCZhS5r3kzWc3bdFgSXS9hn5ga06HHzo/23fcNNIfqST/yM1ihgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI/HHcGo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI/HHcGo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so2716422a12.3
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762637694; x=1763242494; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrc2QItW5gYwrzwDa0y29f1LJL4lA/CoAnYMGcfjRKI=;
        b=EI/HHcGomhQS/fXQeIKY0smPfcrlB/zSYEL6W4sksayEUn4LVWESmGB0VVVqoquQtc
         b6tdcfbvLjZ8YWlenHl10TyIqyQTVhD/AFOGpTtdegGPt8HOqvYLn7m1rJ8Y2BwM2+4a
         cdP3B/SksYIDPE2Jd1XV4+dAHO9qJwkaRgk1r5HjWIY9GE3LftqHlM2CFOtm7I5QhvBs
         XTHOCt4tP02mcM4C4U6xhI7ZYO+VogOxll+GNujzaa5EDoAq6SCiUk35kPSLa/3qPEqt
         Wt6G/eYN/LO+aeRlqPGmkqh8IQQUov/Zw3acEcyQcQp6b1ErSTayzBHj+IGQ0AS2OEnh
         ysGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762637694; x=1763242494;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrc2QItW5gYwrzwDa0y29f1LJL4lA/CoAnYMGcfjRKI=;
        b=fNNK9esh5YDvoaL9ovzWa1svQUyOF+RXiDytyUSciAKhCMBFRk9LEzvgyQmknss5fM
         w36N9VdhnddSvh7ai0oKRicNcPChNQnyhu+JEdBJh7sPf7WRD5xikATimthiBCEm14dB
         MZKZ6IhHuUAg2AiibphB3H0A++GJWHlrxZn+Up9s6crACiE+xT5Do41ku1SOdnvVNVJu
         Z4VfTTmg/0yPQ2koqOdO3TDwmSdC4RCImbO1cI9Vhai9RXqVTJgR3SISGhBPXtgYLrY9
         OQPv9bP1wGYuVhb5L3/qol2ce4C4bVXtwpDWxxySQof0glrzOHfM6yp8CQI8Ol1UDCkw
         yTjw==
X-Gm-Message-State: AOJu0YxMhcFGJROzcdKkZt1Fd9UbwEaLa3LaeRydian4C6AdDyKpHpFb
	h+EbTUl8zPWpVGIhogK1s/BkTYHBQv6LEITUvAlVNaQ80Tc7GcAYFwN9
X-Gm-Gg: ASbGncvrqj7m5i6IrgGcm4/hcWya8csCx5QzI9oZrxmMsVC5Mo3qUw/KdqOL661GzAu
	ymCTAQe+llgH3z3o/1wpM8hurpnz0KBrQmhaT3t65RHF6vOopnOBIi/BOirpGcCQM/2TnokjLdB
	pLya0bdDldO85dorBBWFJ0Wde8rdZMktE5P/p9sVW7TVlMAWxrjGvASKbYWOTwWEIzc0gu/pGYr
	uQrj2oFjVJSpzprUOJqPP/CLAwL/tf+F2KBQFPSJMQHcnC6ekBIpzvkZJ3GzbeI2iPSftwOap/G
	8GHiUZp+34ntegJTUBZnoIVA6FNkX939f7IcbLh7oqKh6Qhta3lb5ry+O2dJ6BmgWQPvHlzMhkr
	wr/KlM9qs6RaeVuRiMEghc00ilRh4QHiq3Nl0VYgnuQG/tk3Vll70SLVHQw9jrmeLY3YT4HBZqT
	X75HNO
X-Google-Smtp-Source: AGHT+IHCpR21V7kQnT0RiCuQrmx7lZOxX50Xumgj/PoO4szJUu8hJZkYM5p76jo9Pm84zZabwqIEiQ==
X-Received: by 2002:a05:6402:354c:b0:641:61bc:560 with SMTP id 4fb4d7f45d1cf-64161bc07acmr2053409a12.36.1762637694046;
        Sat, 08 Nov 2025 13:34:54 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f7139bdsm7403661a12.4.2025.11.08.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:34:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] fetch: fix non-conflicting tags not being committed
Date: Sat, 08 Nov 2025 22:34:42 +0100
Message-Id: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHK3D2kC/4XNwQ7CIAyA4VdZOIuhgMx48j2MB8Y61kTBAFk0y
 95dttMuxuPftF9nljERZnZpZpZwokwx1FCHhrnRBo+c+tpMCnkCEIoP9ObF+sxDLHzA4kYKnos
 BjASrW91rVm9fCevi5t7utUfKJabP9maCdfpPnIADR6Ocxc44AHX1T0uPo4tPtoqT3CvmlyKrY
 kC4TncCW3feK8uyfAF/S8YTAAEAAA==
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 sunshine@sunshineco.com, gitster@pobox.com, 
 David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9476; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ns0IG909L45RGhDCKeIfgmfTzNzNdlpHMz4GvK/qJGM=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGkPt3qj5pCM2HeyhJ1b++GOpRmFnrFscFddNTLuvKkkx2A8j
 YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7d6AAoJED7VnySORox/hf0MAJqV
 Lpw7b8LYygbdkmypaQgOguI0aYjv8PgGdxpuj/uxmo5XIKCLKuEOTOukV7xOGvxvDtjaMGEiACP
 6cPDUwBfN99WDVQjdqLO5T65Fgn/08Vxg4GOfi6nJoPqpfTBOyUhTqMk8gjubOrt2oVDIm9rBTj
 uJmkxx1kGJuhm5nQgUl6UoRHjfQuXp6EkxbYjXu0njWx3PV67DxiUN7FjFmPSDCERGr0oAwhKow
 bFHYzTbrDxk+s+sbvpAanCBST8ArWuTji5aBMaA6ZsuX66KrU9OGB9npKZhTYXmI/ButeVNhxcv
 c0+g+EiavUZxH1wWUDnGhnAt0fzxECP7B1VeRSQ29ewGn6cXDt+yIddjmpSzcLow9b6j0NPCWoM
 2p5P0bsgDUm0w4J3+4BJQUck2Rp3nFE8+UMjNL6XIb9M7usWp4dR4ZVYzQQz7S8S2tJFqB46bl+
 Nf5dVrOebMVYg779hhTUgbgDCwaFlEtq0HCd/Qs8wPNV9e61BY6ax4DikZ6g==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This fixes the bug reported by David Bohman [1].

The 'git-fetch(1)' uses batched updates to perform reference updates
when not using 'atomic' transactions. One scenario which was missed
here, was fetching tags. When fetching conflicting tags, the
`fetch_and_consume_refs()` function returns '1', which skipped
committing the transaction and directly jumped to the cleanup section.
This mean that no updates were applied. This also extends to backfilling
tags.

The first commit, extracts out common code for committing a reference
transaction and handling rejected updates. The second commit ensures
any failures would also commit pending updates.

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Split the patch into two commits. One for extracting out existing code
  into a new commit and the other to perform the fix.
- Add back error handling when commit via the normal flow.
- Instead of calling the commit function at every failure, make it part
  of the cleanup code.
- Link to v2: https://patch.msgid.link/20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com

Changes in v2:
- Add a comment to explain the purpose of `commit_ref_transaction()` and
  how it works.
- Also extend the same logic towards backfilling tags. While I was able
  to add a test for the happy path, I couldn't figure out how to test
  when `backfill_tags()` tags would fail.
  Tangentially, this flow seems to only be triggered when using the now
  deprecated 'branches/' remote format.
- Remove unneeded subshells from the tests.
- Link to v1: https://patch.msgid.link/20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com

---
 builtin/fetch.c  | 73 ++++++++++++++++++++++++++++++++++++--------------------
 t/t5510-fetch.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 26 deletions(-)

Karthik Nayak (2):
      fetch: extract out reference committing logic
      fetch: fix non-conflicting tags not being committed

Range-diff versus v2:

1:  703593ef40 ! 1:  8a1efdd999 fetch: fix non-conflicting tags not being committed
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    fetch: fix non-conflicting tags not being committed
    +    fetch: extract out reference committing logic
     
    -    The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
    -    updated the 'git-fetch(1)' command to use batched updates. This batches
    -    updates to gain performance improvements. When fetching references, each
    -    update is added to the transaction. Finally, when committing, individual
    -    updates are allowed to fail with reason, while the transaction itself
    -    succeeds.
    +    The `do_fetch()` function contains the core of the `git-fetch(1)` logic.
    +    Part of this is to fetch and store references. This is done by
     
    -    One scenario which was missed here, was fetching tags. When fetching
    -    conflicting tags, the `fetch_and_consume_refs()` function returns '1',
    -    which skipped committing the transaction and directly jumped to the
    -    cleanup section. This mean that no updates were applied. This also
    -    extends to backfilling tags when using the now deprecated 'branches/'
    -    format for remotes.
    +      1. Creating a reference transaction (non-atomic mode uses batched
    +         updates).
    +      2. Adding individual reference updates to the transaction.
    +      3. Committing the transaction.
    +      4. When using batched updates, handling the rejected updates.
     
    -    Fix this by committing the transaction even when we have an error code.
    -    This ensures other references are applied. Do this by extracting out the
    -    transaction commit code into a new `commit_ref_transaction()` function
    -    and using that.
    +    The following commit, will fix a bug wherein fetching tags with
    +    conflicts was causing other reference updates to fail. Fixing this
    +    requires utilizing this logic in different regions of the function.
     
    -    Add tests to check for this regression. While here, add a missing
    -    cleanup from previous test.
    +    In preparation of the follow up commit, extract the committing and
    +    rejection handling logic into a separate function called
    +    `commit_ref_transaction()`.
     
    -    Reported-by: David Bohman <debohman@gmail.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fetch.c ##
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
      		    struct refspec *rs,
      		    const struct fetch_config *config)
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 
    - 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
    - 				   &fetch_head, config)) {
    -+		/* As we're using batched updates, commit any pending updates. */
    -+		if (!atomic_fetch)
    -+			commit_ref_transaction(&transaction, false,
    -+					       transport->remote->name, &err);
    - 		retcode = 1;
    - 		goto cleanup;
    - 	}
    -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 			 * the transaction and don't commit anything.
    - 			 */
    - 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
    --					  &fetch_head, config))
    -+					  &fetch_head, config)) {
    -+				if (!atomic_fetch)
    -+					commit_ref_transaction(&transaction, false,
    -+							       transport->remote->name, &err);
    - 				retcode = 1;
    -+			}
    - 		}
    - 
    - 		free_refs(tags_ref_map);
    -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	if (retcode)
      		goto cleanup;
      
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     -		 */
     -		ref_transaction_free(transaction);
     -		transaction = NULL;
    --		goto cleanup;
    ++	retcode = commit_ref_transaction(&transaction, atomic_fetch,
    ++					 transport->remote->name, &err);
    ++	if (retcode)
    + 		goto cleanup;
     -	}
     -
     -	if (!atomic_fetch) {
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     -			goto cleanup;
     -		}
     -	}
    -+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
    -+					 transport->remote->name, &err);
      
      	commit_fetch_head(&fetch_head);
      
    -
    - ## t/t5510-fetch.sh ##
    -@@ t/t5510-fetch.sh: test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
    - '
    - 
    - test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
    -+	test_when_finished rm -rf base repo &&
    - 	(
    - 		git init --ref-format=reftable base &&
    - 		cd base &&
    -@@ t/t5510-fetch.sh: test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
    - 	)
    - '
    - 
    -+test_expect_success 'fetch --tags fetches existing tags' '
    -+	test_when_finished rm -rf base repo &&
    -+
    -+	git init base &&
    -+	git -C base commit --allow-empty -m "empty-commit" &&
    -+
    -+	git clone --bare base repo &&
    -+
    -+	git -C base tag tag-1 &&
    -+	git -C repo for-each-ref >out &&
    -+	test_grep ! "tag-1" out &&
    -+	git -C repo fetch --tags &&
    -+	git -C repo for-each-ref >out &&
    -+	test_grep "tag-1" out
    -+'
    -+
    -+test_expect_success 'fetch --tags fetches non-conflicting tags' '
    -+	test_when_finished rm -rf base repo &&
    -+
    -+	git init base &&
    -+	git -C base commit --allow-empty -m "empty-commit" &&
    -+	git -C base tag tag-1 &&
    -+
    -+	git clone --bare base repo &&
    -+
    -+	git -C base tag tag-2 &&
    -+	git -C repo for-each-ref >out &&
    -+	test_grep ! "tag-2" out &&
    -+
    -+	git -C base commit --allow-empty -m "second empty-commit" &&
    -+	git -C base tag -f tag-1 &&
    -+
    -+	test_must_fail git -C repo fetch --tags 2>out &&
    -+	test_grep "tag-1  (would clobber existing tag)" out &&
    -+	git -C repo for-each-ref >out &&
    -+	test_grep "tag-2" out
    -+'
    -+
    -+test_expect_success 'backfill tags with branches remote format' '
    -+	test_when_finished rm -rf base repo &&
    -+
    -+	git init base &&
    -+	git -C base commit --allow-empty -m "empty-commit" &&
    -+	git -C base tag tag1 &&
    -+
    -+	git clone --no-tags base repo &&
    -+
    -+	git -C repo remote remove origin &&
    -+	mkdir -p repo/.git/branches &&
    -+	echo "$(cd base && pwd)#master" >repo/.git/branches/origin &&
    -+
    -+	git -C base commit --allow-empty -m "second empty-commit" &&
    -+	git -C base tag tag2 &&
    -+
    -+	git -C repo fetch origin &&
    -+	git -C repo for-each-ref refs/tags >out &&
    -+	test_grep "tag1" out &&
    -+	test_grep "tag2" out
    -+'
    -+
    - . "$TEST_DIRECTORY"/lib-httpd.sh
    - start_httpd
    - 
-:  ---------- > 2:  1de8d8b953 fetch: fix non-conflicting tags not being committed


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

