Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337C749C
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729505; cv=none; b=OB1K2sDW2nLls24IANWdlvrKCVXQ0j4+8zpDgPPogMfALlaLhgIvGFpyAqx/jw1t2TqLw+hIX9iimO177slzuRHxKxMAglzbck2z8jfo1ZsBn07EeJ6HGD7NHRxz9Nirq+dt/8ZVCvjoMVYQGjZtRDAHwmtyD0vVZNAKvxOMgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729505; c=relaxed/simple;
	bh=U4wDxMn2yruiNftKbPR8LSCBlj2vvoV1xTbTSmqXTPE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RgLMwI4YzJzKxQ8J9kmWzoxgX8Ozby+BmwAUoRaAEIPmU22YgiNy2IMEwnuZgDR8X5yX8eurfs5KAEYIfm1ZkiRiKrzlAIAbTHup2nhUlfMdVejfrZKqvi18cpl+pi+ff+F7XB+/QnpsLD2lglrF704kPvR0IbvYJ8yChppGNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHydpvED; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHydpvED"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fb49c64aso546577e87.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729501; x=1730334301; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1246Xmy7j7VF9O99kzfMkBATcuKm6eQQ7acZLqMJWfg=;
        b=aHydpvEDXzTvZKJD5A74xtCzS/i6UVorwTM0QbOwBjtX/cRVnSC6DUZy6Nzugd/a2P
         5f/zG50bCJyBhYuzVAzHHlRIvGHszyVVDLQNM7hB+YD06X9lc1yi5pg0RwAoIIGHEIb7
         bEa3c8hC9lK3Y3LIOWBKe7xlpcHsUQRkjnMKdvhZj1veiL3VcF+DFPFzYFAB5gipEdbF
         tIqpt6ZBz9tiSaR+GFIJSBh0dr7A9SwCSD0dmTvZiqiTa7sDZbNkjcdgNCxNcrujQ5gU
         599sKArPZEc0IA5LUD7k4OPfxZAKXu/0O73Ka86bO5JlU+sDT5QyKFjZT1WahGKeY14R
         Gwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729501; x=1730334301;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1246Xmy7j7VF9O99kzfMkBATcuKm6eQQ7acZLqMJWfg=;
        b=B+OSFbdvghXruuQ1+sUm4ZX3QM8DoUPDabbbj83CGzi1kp7Jio5OkiQH7CEiI12W6N
         RVuh5DkIsII8rCCv0tswONL0ah1HR/JpFV2qvPq7lFerz3zwLGsykB7r2wxK0xfxxe87
         ynSicVGEFDwvnfSC88UOkzFAGONjmSh8F2q3IazblFAuftEqPhIf4MqzONObIqHwthrp
         iCVq/8dh8DhyD8z5BWaX/YCVRAu8a3CEdZqdPhPVuqcdCn6mtRUi7HLZHtDxVEcpzM0n
         JBO5r8SE0xOIJ0TfXmwHA/a+NNw76mcDCry/zo6ekW6Mk9+Q755pSMyVKzWRTEzTNKLR
         VfUA==
X-Gm-Message-State: AOJu0Yy7Qp43ca1cjPuBxGIMWB0Iju7Hxu5S8L0/iRWj0w9ZW8DwPy/k
	HPcF2S0lBQewz/MlrVQls9Ii6N0Y0fOyqtT5bGRL7CW1GlnihEk857FsjQ==
X-Google-Smtp-Source: AGHT+IE4wGrZBZwuzrTJV2/BzWyEDfoo25HHAHaiWmiXQAYCflSHQW8VFP2nGMj0Ay5GDSzybyI0Zg==
X-Received: by 2002:ac2:4e06:0:b0:535:6951:9e1c with SMTP id 2adb3069b0e04-53b1a328374mr3617412e87.15.1729729500430;
        Wed, 23 Oct 2024 17:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706a7sm547210166b.141.2024.10.23.17.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:24:59 -0700 (PDT)
Message-Id: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Oct 2024 00:24:55 +0000
Subject: [PATCH v6 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
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
    Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes from Version 5:

 * Save the content of .gitattributes in .gitattributes.bak before adding
   conflict-marker-size=3a, as subsequent tests do not depend on having
   invalid lines. Restore .gitattributes to its original state after
   testing.
 * Use test_grep for testing failure output, as it provides a cleaner
   approach.
 * Use err instead of actual_error for conciseness and to maintain
   consistency with the style of the rest of the test suite.

Usman Akinyemi (3):
  daemon: replace atoi() with strtoul_ui() and strtol_i()
  merge: replace atoi() with strtol_i() for marker size validation
  imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
    parsing

 daemon.c              | 12 ++++++++----
 imap-send.c           | 13 ++++++++-----
 merge-ll.c            | 11 +++++++++--
 t/t5570-git-daemon.sh | 25 +++++++++++++++++++++++++
 t/t6406-merge-attr.sh |  8 ++++++++
 5 files changed, 58 insertions(+), 11 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v6
Pull-Request: https://github.com/git/git/pull/1810

Range-diff vs v5:

 1:  d9c997d7a9c ! 1:  3daedaeb260 daemon: replace atoi() with strtoul_ui() and strtol_i()
     @@ t/t5570-git-daemon.sh: TEST_PASSES_SANITIZE_LEAK=true
      +test_expect_success 'daemon rejects invalid --init-timeout values' '
      +	for arg in "3a" "-3"
      +	do
     -+		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
     -+		test_write_lines "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
     -+		test_cmp actual_error expected || return 1
     ++		test_must_fail git daemon --init-timeout="$arg" 2>err &&
     ++		test_grep "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" err ||
     ++		return 1
      +	done
      +'
      +
      +test_expect_success 'daemon rejects invalid --timeout values' '
      +	for arg in "3a" "-3"
      +	do
     -+		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
     -+		test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
     -+		test_cmp actual_error expected || return 1
     ++		test_must_fail git daemon --timeout="$arg" 2>err &&
     ++		test_grep "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" err ||
     ++		return 1
      +	done
      +'
      +
      +test_expect_success 'daemon rejects invalid --max-connections values' '
      +	arg='3a' &&
     -+	test_must_fail git daemon --max-connections=3a 2>actual_error &&
     -+	test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" >expected &&
     -+	test_cmp actual_error expected
     ++	test_must_fail git daemon --max-connections=3a 2>err &&
     ++	test_grep "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" err
      +'
      +
       start_git_daemon
 2:  da9ea10e4e1 ! 2:  0ea3b349560 merge: replace atoi() with strtol_i() for marker size validation
     @@ t/t6406-merge-attr.sh: test_expect_success 'retry the merge with longer context'
       '
       
      +test_expect_success 'invalid conflict-marker-size 3a' '
     -+    echo "text conflict-marker-size=3a" >>.gitattributes &&
     -+    git checkout -m text 2>error &&
     -+    test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" error
     ++	cp .gitattributes .gitattributes.bak &&
     ++	echo "text conflict-marker-size=3a" >>.gitattributes &&
     ++	test_when_finished "mv .gitattributes.bak .gitattributes" &&
     ++	git checkout -m text 2>err &&
     ++	test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" err
      +'
      +
       test_expect_success 'custom merge backend' '
 3:  9b2b2dc8fc8 = 3:  17484df5200 imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing

-- 
gitgitgadget
