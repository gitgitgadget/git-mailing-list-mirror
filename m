Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxWYmFvB"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12904FE
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:57:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66eso12405875e9.3
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583026; x=1702187826; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQAs841ZxSkjj8SOV4VUxxS4N3241mfzhD9mZu4ix5A=;
        b=mxWYmFvB0id8pM8jFOhU7KwyPSxAMMjLZwRBGtKFQFrcRzrmMy+WImtigznJutXegs
         ZYXXqxg3RNK1/jPSvDeG+eGeAokL0LcFk8SuHYymgdn0JD8491lY/Njy6SlAyslSRXzY
         VMGFqaOKMg8fxI1f+DeF7qVyBn36CskVJw7Lus9opcp4lSDnAgBaTtPhdts+uLVqk7KH
         qK7L/JaI7W8rn+oUpvq7n+/fcCBvRVGvQZG2xHIOqi7I4+ak7QRDwVSMUJhT9cF7pnql
         2TeEEJyJOy63GbENbZKd6JjTe+bTJnpAezZwNJo/y5lVUvUAm8JKcZMltDFswxDo2U+x
         PsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583026; x=1702187826;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQAs841ZxSkjj8SOV4VUxxS4N3241mfzhD9mZu4ix5A=;
        b=pkAv7qTlfX77B40Wkb7oO5kPgGcK3UQbgaXtIn0IALC92Xbvr9XscUi/GCVbTigBYC
         e3w0qoxKuAL1FcnchsAsCq81QOMsqoOGQKB5MSwSUb/wZZYUfFLJqnag8CeMfAi2mVA+
         jKxlTRTzDNAWaaBGlCXF8gSEqlaBqtz7Td2vYsQM4x7+EwA+ZyY7DfYEabe0Idi86V6O
         y9H96/KspgKYT/RG7Jw7RkpEkLCXwJmMawr7xS3jXBQerdTearwmUSssi/VEAvIXhYT4
         tMhahH2hfPv63ScF0wOhLddA457c8DKA1XgXUdHPECM7u02JeiMYhfMLuBjgW2R0YGLy
         lOWQ==
X-Gm-Message-State: AOJu0YxGtWVB2X69rIREABlVkHCT4J3W6xI8KQ1Un4x/Z9W6loKJk1K5
	atTFDNDspRvyxO7ymd/bUc/ftLBs5S8=
X-Google-Smtp-Source: AGHT+IH8HYGMPTVIbn8KHsAF+4LGcWB4eZ8wIcXRMGObKMA059xayMuMfumCmK7AQvrrlNANsfG0Zw==
X-Received: by 2002:a7b:c3d3:0:b0:40b:5e59:e9f5 with SMTP id t19-20020a7bc3d3000000b0040b5e59e9f5mr573412wmj.148.1701583025426;
        Sat, 02 Dec 2023 21:57:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b0040b30be6244sm10717303wmb.24.2023.12.02.21.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 21:57:05 -0800 (PST)
Message-ID: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 05:57:00 +0000
Subject: [PATCH v3 0/4] Sparse checkout completion fixes
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
Cc: Elijah Newren <newren@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Elijah Newren <newren@gmail.com>

This fixes a few issues with tab completion for the sparse-checkout command,
specifically with the "add" and "set" subcommands.

Changes since v2:

 * For patch 4, provide completion (and startings) of arguments into
   patterns that match files in the index -- as suggested by Junio.

Changes since v1:

 * Use __git wrapper function to squelch errors, as suggested by SZEDER
   Gábor
 * note that we could use the index or HEAD for the more involved solution
   in patch 4.

[1] https://lore.kernel.org/git/xmqqv8yjz5us.fsf@gitster.g/

Elijah Newren (4):
  completion: squelch stray errors in sparse-checkout completion
  completion: fix logic for determining whether cone mode is active
  completion: avoid misleading completions in cone mode
  completion: avoid user confusion in non-cone mode

 contrib/completion/git-completion.bash | 123 ++++++++++++++++++++++++-
 t/t9902-completion.sh                  |   9 +-
 2 files changed, 127 insertions(+), 5 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1349%2Fnewren%2Fsparse-checkout-completion-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1349/newren/sparse-checkout-completion-fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1349

Range-diff vs v2:

 1:  97e20e3b99d = 1:  97e20e3b99d completion: squelch stray errors in sparse-checkout completion
 2:  212ba35ed46 = 2:  212ba35ed46 completion: fix logic for determining whether cone mode is active
 3:  1cbbcd9097c = 3:  1cbbcd9097c completion: avoid misleading completions in cone mode
 4:  604f21dc827 < -:  ----------- completion: avoid user confusion in non-cone mode
 -:  ----------- > 4:  89501b366ff completion: avoid user confusion in non-cone mode

-- 
gitgitgadget
