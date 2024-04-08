Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37681422B6
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593023; cv=none; b=j7nhs9NpbV/TwNyRIwNzLv1zif95JesCQDjaHRlDaPveSdWwg+hi62RyS4mmLcufSH7DDyVr5eeXGqIQo+51o+tgKAj51FOMMAukAfNlceP95ZnFjUt7Q41o+WB0eV7qMYMKz5Jg3EDXYp6PDlDG5VMGFIbOoR8k+9lc/jyQ8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593023; c=relaxed/simple;
	bh=PdLHRzwS/AvedP/ryxz6r7FRumbY9Ib4yeuhlXgT/ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=H2Gehwnt42vqzgXsBKQFJ47ZnC/bsTYRXBw8/pR5LwHC2pBTT5/7yPiEKhk/iD8nao9P7Got5w8JIwHEjwges1U876pyyuE9vA/bhWMWeGs8cpFcR5w7zpFdYka1f6tqsLkGex9rCRHBVGblb3Us/6xJUmWBEnBKdsf6biqKp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAV0uiEP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAV0uiEP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so23214681fa.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712593018; x=1713197818; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RcbAuMRspmmLC4IwuNkST0ImebMApEypYGB3Lo5CH0=;
        b=DAV0uiEPA5fGBWIys9V1JkcTAjuH2pI+NFRgJhpldO/CXyMAIlU243G+7oBGPzcyG6
         VSmrHMKqpUzbCpznGzVYwFL88QgWv0nkOxbjhClSOD2d9SNYke1vCsyG3gZBppy0Uz/z
         SdQlkYKudbqyNs7zJHV1/bBm4V9Q61pee3YNND98RCDX1nJPcjiZ6lkc6ea4WLlj878r
         +iP/L5WHykV/Wp063jzDUIrImDRTT1AHNepUVGq84Bpj0W4ktyX3KO1cNvsmxFxepmD7
         ++DpgYxR0cgGBiC/jFOdBGzwZD8g7ylGYyO0VoEGLejcjbsXL8QR2J1yOIBbYxEn76JW
         nbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593018; x=1713197818;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RcbAuMRspmmLC4IwuNkST0ImebMApEypYGB3Lo5CH0=;
        b=rMO5MNt47mySf5xYkZrql+o/QAZKAGA1PZEDr4X3GceQ4JeRdqoAofjzloXKT3KHxt
         e5wX+ElYnfQ/oWqVUtU0YB+SvnvtdTKBQJuK0EeHxjeZKnOigPmth+VOyIbiZ4f5HttU
         VfaVltIsqyjjuhjuM7FW3qRnNFTN2aPfm7EQE/Pu/UZUSH1Fc8oGXmhzGpcbOKDBN77J
         jv3CoQ5EoJm5eXvEoWczP3bi3+BkJODhjnqvL0kA8e5uFxQYj4Uh5s4ACo18UIlmCCbG
         mkDDaKrMxEP31F7160YWAX2quDIlK0WSBRqeJiJQ2LQG0yTtX/Bc2hR9gpJaWs599y9S
         IJ4Q==
X-Gm-Message-State: AOJu0YyMIXO7yNzxwgXpDQycqOVa/r1zxEw238yNB8CMBbLoGvLUyb6R
	MESnuwkvF0dqt+bxGNNhUZ+ywOcSZ6KNCuPLrVZa2Dd/zXdiy+dXMMxAm1+P
X-Google-Smtp-Source: AGHT+IGJgMJ8A5+UJbPHn4DI/fv2GtjShkJhfZVxMV4Y5HlC2oZckpEUWpBjJULPEdRIMxEBvZoCTA==
X-Received: by 2002:a2e:9a9a:0:b0:2d4:744c:24ab with SMTP id p26-20020a2e9a9a000000b002d4744c24abmr6660013lji.27.1712593017756;
        Mon, 08 Apr 2024 09:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0041674bf7d4csm3801545wmq.48.2024.04.08.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:16:57 -0700 (PDT)
Message-Id: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
References: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 16:16:52 +0000
Subject: [PATCH v6 0/3] reftable/stack: use geometric table compaction
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the sixth version my patch series that refactors the reftable
compaction strategy to instead follow a geometric sequence. Changes compared
to v5:

 * Reworded commit message to more clearly explain that the already existing
   configuration to disable auto-compaction is being exposed to callers of
   the library.
 * Simplified expression to set the disable_auto_compact configuration.

Thanks for taking a look!

-Justin

Justin Tobler (3):
  reftable/stack: expose option to disable auto-compaction
  reftable/stack: add env to disable autocompaction
  reftable/stack: use geometric table compaction

 refs/reftable-backend.c    |   3 +
 reftable/reftable-writer.h |   3 +
 reftable/stack.c           | 125 +++++++++++++++++++------------------
 reftable/stack.h           |   4 --
 reftable/stack_test.c      |  77 ++++++-----------------
 t/t0610-reftable-basics.sh |  71 ++++++++++++++++-----
 6 files changed, 145 insertions(+), 138 deletions(-)


base-commit: 4b32163adf4863c6df3bb6b43540fa2ca3494e28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

Range-diff vs v5:

 1:  a7011dbc6aa ! 1:  9c8f6b336ec reftable/stack: allow disabling of auto-compaction
     @@ Metadata
      Author: Justin Tobler <jltobler@gmail.com>
      
       ## Commit message ##
     -    reftable/stack: allow disabling of auto-compaction
     +    reftable/stack: expose option to disable auto-compaction
     +
     +    The reftable stack already has a variable to configure whether or not to
     +    run auto-compaction, but it is inaccessible to users of the library.
     +    There exist use cases where a caller may want to have more control over
     +    auto-compaction.
      
          Move the `disable_auto_compact` option into `reftable_write_options` to
     -    allow a stack to be configured with auto-compaction disabled. In a
     -    subsequent commit, this is used to disable auto-compaction when a
     -    specific environment variable is set.
     +    allow external callers to disable auto-compaction. This will be used in
     +    a subsequent commit.
      
          Signed-off-by: Justin Tobler <jltobler@gmail.com>
      
 2:  7c4fe0e9ec5 ! 2:  c7bc7346540 reftable/stack: add env to disable autocompaction
     @@ refs/reftable-backend.c
       
       /*
      @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(struct repository *repo,
     + 	refs->write_options.block_size = 4096;
       	refs->write_options.hash_id = repo->hash_algo->format_id;
       	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
     ++	refs->write_options.disable_auto_compact =
     ++		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
       
     -+	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
     -+		refs->write_options.disable_auto_compact = 1;
     -+
       	/*
       	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
     - 	 * This stack contains both the shared and the main worktree refs.
      
       ## t/t0610-reftable-basics.sh ##
      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause auto-compaction' '
 3:  8f124acf0f8 = 3:  d75494a88b0 reftable/stack: use geometric table compaction

-- 
gitgitgadget
