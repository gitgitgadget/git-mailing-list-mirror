Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA1135411
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676450; cv=none; b=H/DQoYwrcbe9wJJ9yuBRDcHMFnSnCV/1gRykNKXtlotg1hg2Yu+KMKTvdqvMYNiRc7AxEXpLfP8IGEo7/E9wnXDLgllJj6Cj/nAF/2oQ+BRdWs+jiZ1PfZBjmQlHvsctTJOYngNswyv3OgTBfJiZBYKjKabCtby2a2F4FY2JIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676450; c=relaxed/simple;
	bh=Fvp+jV5dcCoSraiPZRUSvTJexKX7HgmmFaBNhRg9EuM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nhC7v9UUF8XhesKzbxxRnnsGpDvAMp8yL01jiR7eVwtOFh3curugwLtMqHYWk/luCU+4nbquQEZxPgTWVkxmgGJNfqoSVcZoa5j9QFsbCTByK55NalsNDoW5tHB/ztO6Ck0TryEDnqRwlAJdUPhmlmb4r/rvU6iZszwPyq33OUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsVbPa5n; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsVbPa5n"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso41028461fa.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676446; x=1713281246; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Spf4KseZOKa7yc0CJ/49ClieC0jhWewmGaRTN9irJqY=;
        b=AsVbPa5nzryPJKaq4RIuE3S5V78IkDmYo/9ifPsuN6A/PjT3aNK8vydIrxy2Pf4ajw
         UOJ82B83z1Q1qSpZiQD5ncGRezOFmAK+MnOR/bt6Fn70fU/FcR1/xlRuZFO0ZUWprieH
         5bq6hvYU4o+ZpkZFvc3DpO5YZIYNl6BiKIIDpwfIkK5aBe1dspA0FMvZwmg8/LYgYxn3
         WMGYA9hni/T6nFD+4hqkGCOrXukhtRaLgqnImkdyx3Kc50AQKAt2QP28fPsbSrAlQSJ3
         XQHcOzgnVaN63Ho7aUAQbjivth57L9YcKNPYIVu7ukXqT70u22KwvN/OESPadTZ+kepj
         bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676446; x=1713281246;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spf4KseZOKa7yc0CJ/49ClieC0jhWewmGaRTN9irJqY=;
        b=ACI86OzeHwWYxQyLcr+jfZpijoolLdV9gLYes5CCgfwqgHy2Wn1s/qpcEHD189DLhX
         SmZ7c4p6w5vGsnaREzOXhwaGQkYG3kSUzv4KfE2fk1g5KrvBBMNNZaE8ddpkFYqjtwoV
         MrgEiR8wkQ3IQHsF56FMgrK6ds/CunX4I4ArwBlRbtpwmUIcE0wJpHqqnIcprfkjf7Ve
         UDAeGmThMKHYvepKuMG+ANdohXTtMtGgAIs2tommgj2R7Zqk/IdfciDMMDBBKoPgJK52
         22KQUs91hS7iWAoxTKh/Fq58a9WHk07DmNlOEhTpYjC8Mn9l67jaX+JH3swA9KHh3zng
         KD/w==
X-Gm-Message-State: AOJu0YwbjgDtICLR+6SMLJidZGOYW2CQru6M2cWSQf/cI2rwwS2GAhsK
	fLm81acfg9ieI6dPdkxPhhyvj78Tkb8Slub00veaGIy3qgnYRvgJWUAOY+I8
X-Google-Smtp-Source: AGHT+IGn3MLPEYtrHY5icdYSKISOC6p7OTGbHgV0rixk/9bkaFShuNgvxNyeeni1sp4vp8NQOgr6iA==
X-Received: by 2002:a2e:8449:0:b0:2d8:7293:631e with SMTP id u9-20020a2e8449000000b002d87293631emr115262ljh.48.1712676445860;
        Tue, 09 Apr 2024 08:27:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j31-20020a05600c1c1f00b004163de5135dsm12832743wms.34.2024.04.09.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:27:25 -0700 (PDT)
Message-Id: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 15:27:21 +0000
Subject: [PATCH 0/3] Cleanup rebase signoff tests
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

This series cleans up the tests for "git rebase --signoff" in preparation
for extending them and fixing a couple of bugs in a future series. The
cleanups are:

 * move test setup into "test_expect_success"
 * stop running git upstream of a pipe
 * restore "git rebase --apply --signoff" coverage

Phillip Wood (3):
  t3428: modernize test setup
  t3428: use test_commit_message
  t3428: restore coverage for "apply" backend

 t/t3428-rebase-signoff.sh | 67 ++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 37 deletions(-)


base-commit: 19981daefd7c147444462739375462b49412ce33
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1713%2Fphillipwood%2Fcleanup-rebase-signoff-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1713/phillipwood/cleanup-rebase-signoff-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1713
-- 
gitgitgadget
