Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267D187F
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707653494; cv=none; b=H9vDD1xGBzBQx0p8MTQcX1G0Lgz/a3927n6T9KKjtGOqJUjfH9QirAAjw9mL9KG94I9AsWJHOtijXDentJcy+CZA9Kv1HwxcgoX+KXZZ7coEEdBg41g7UTw/qibSXqbWLwe5qukTWgC9hapdaPLDHNVEL1yvR2izq7uacW2fBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707653494; c=relaxed/simple;
	bh=++zTmWD+AY+hnHX001n2bukyZ0n0S6KIOgAZeNaW5i4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=mPo3LeBsSBt5/A03LOMJVS9Ks0sU3i89hC3Jgo7xB23Ajf+nMs76AZhaC70DwkM52BS/N1ZfDY+VrQ4ZiMJGhuIA0OemTMGfbgD39gApXBA1N14MyKrCad5Y9jBlOAGdxGjW3IkuI3B6yAto3V6CzOAyS2PwcTuH4RqqLMNbPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpJwLhLM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpJwLhLM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso1619009f8f.3
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707653490; x=1708258290; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX4WewxQQWHKXNX97LqLnvD5W44xJM6eQGmA2yADfFo=;
        b=jpJwLhLMQ1HKkfMcBCcfjTc8QLa5NB+weJ28NuNjL/HJLM7wUpSPcEmQfaLusxSxrG
         gPlTtYCCCyktLbWQCRlg7YqMAGuQyNJ1KVEhB6I1vAJ5VyY1c9tJDUlnzWQF+htB/yTN
         T7S58+tsNAtDQ/QUuxEPooKwuyYNvxvYg89VP+TBNdAJgh8hmJ9SDNqjfgRXAPSZs3KI
         DqY7oA4tU7G+QO5cO6fsc5QKDY79+t9AGgt4gwDGIotHq0/jmWJbdKJ7yAew9xyIPxe2
         +H68Q1hf8g34DNvMDW2ZUrAGCoWw+mjKXkv1q+erWSfCip9HZHimFUblZWuD34sKDYfC
         +DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707653490; x=1708258290;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX4WewxQQWHKXNX97LqLnvD5W44xJM6eQGmA2yADfFo=;
        b=E2kfRBJOqbnvji8y68Xznl4iR+16P+Tsl+1r/+FBzMOyyNpyhguyo6MMnpJzIqyAox
         y7z8kZks0wFqiDxNRNEHwAtT13bNLP81niSjOIz8O1JzSqTN4Uw106eMJkt+tS+VEbjg
         Dhm6Mjf10VtpGuELzamA0JeimFRh/5he7SbwTGEIQ4Wp3tonp2SGOLPvzRz9b3KCb627
         GdBtFUrtxamnOnwErlpUhbu+Q/7H2JKp6vnDnnF+CtLxg4VQK5cIVJ5R1d8o3dDtJVdJ
         UpzCCjgkHoURCJ0TEzv6qO9n4k46y5wmLd1mPOkYOVcVgJK2ZbRzCunDOKkz6NpOJIsR
         Vhyw==
X-Gm-Message-State: AOJu0Yw3TzQMCjy6Y65ReTqStKO2071HBIlBhPnLjWOWIvahFgbkolIp
	pjPG3wJpeiKD01zeg9hoM8APWKRa0jXZ8K2Sx/qZBkOJt38LzcW5wNDVSUdl
X-Google-Smtp-Source: AGHT+IFbndSFkwsuzt2j6yqJSVBMA5pD2eyjMcNA46YgEusgs6avrPvkyNCC6lt8b8Qrk9K19t2eAw==
X-Received: by 2002:a5d:4e8b:0:b0:33b:49bb:5f91 with SMTP id e11-20020a5d4e8b000000b0033b49bb5f91mr2921813wru.16.1707653490224;
        Sun, 11 Feb 2024 04:11:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0033b13922263sm4124605wru.60.2024.02.11.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:11:29 -0800 (PST)
Message-ID: <pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 12:11:27 +0000
Subject: [PATCH v2 0/2] ci: bump remaining outdated Actions versions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

I noticed that Junio recently bumped a couple of these Actions versions, and
incidentally I also activated automatic Dependabot updates of those in
git-for-windows/git. Dependabot noticed a couple of yet-unaddressed updates,
which I accumulated into a single patch.

This patch is based on jc/github-actions-update.

Changes since v1 (sorry for the quick succession):

 * The linux32 job cannot handle Node.js Actions, and therefore would fail
   to run the latest actions/upload-artifact version. I only noticed this
   after submitting v1 because CI does not fail (since this step is only in
   use when something in Git's test suite breaks).
 * To avoid making the same mistake even one more time, I added a commit
   that puts big fat warnings next to the Actions that must not be updated
   to newer (i.e. Node.js) versions.

Johannes Schindelin (2):
  ci: bump remaining outdated Actions versions
  ci(linux32): add a note about Actions that must not be updated

 .github/workflows/coverity.yml |  4 ++--
 .github/workflows/main.yml     | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)


base-commit: dcce2bda214ac4c838f4b85f2c550816df3a6ac9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1660%2Fdscho%2Fmoar-github-actions-updates-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1660/dscho/moar-github-actions-updates-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1660

Range-diff vs v1:

 1:  77c0810bf1a ! 1:  2b35b9878a7 ci: bump remaining outdated Actions versions
     @@ .github/workflows/main.yml: jobs:
           - name: Upload failed tests' directories
             if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
      -      uses: actions/upload-artifact@v3
     -+      uses: actions/upload-artifact@v4
     -       with:
     -         name: failed-tests-${{matrix.vector.jobname}}
     -         path: ${{env.FAILED_TEST_ARTIFACTS}}
     -     - name: Upload failed tests' directories
     -       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
     --      uses: actions/upload-artifact@v1
      +      uses: actions/upload-artifact@v4
             with:
               name: failed-tests-${{matrix.vector.jobname}}
 -:  ----------- > 2:  9088cc60bda ci(linux32): add a note about Actions that must not be updated

-- 
gitgitgadget
