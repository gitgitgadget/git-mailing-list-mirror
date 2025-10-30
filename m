Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B08274B40
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851986; cv=none; b=n0nyjMeSX2ozdw+7ElJUXflMU5Y1sf788O6a7TbI6l57ZTBh8SqAcKgx0An1jvITR25tFvXPTjtM9hTUQY1Cus7Lt6Y7waIaDDzcDTRUpaOWCG/vvaGdPn21S44Rer/J5cJOAlBkt1A6IEVIeiNAqLfAqeuMPL/thQ6xYMcJp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851986; c=relaxed/simple;
	bh=sevlVb5wk79KNbRKump88pec40OnxwUdX0slirIsFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQdziJ6/w3lBHKRNJsoDaOA+7ziH0iksaOlkxnZBMsl0TC69HdU9i2gHLAai699pEillHvNFYu0NP76/rboU/EBW6VOwsTAW8kLSul1NOJlr5EdQdOSCUxZfd07jbsxLy5pWj0IU8MxJxtxm9YJCFwMJnaKAQujX0OObzKIWmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9fRKw87; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9fRKw87"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a76584ea6cso314455b3a.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761851983; x=1762456783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMmhjXfa+AUkW+1GRraEC0lRkdWEh1/9s4uv+5EH1UU=;
        b=V9fRKw87pcsF89feJA+Stw0wc1BJyhrCLESrRILwNr3Pp14YXamjxF3Omplhqi5Q/w
         DCN9T+EbVoJ2jYHrAThgVEjHEHVsPCkus1qrHhzAV7tE0durFw2ICRAgA/c4Skfqk+Yd
         YDvgcgATWkJzUd9LJ2GL0HE0cN/hBuhvYHPrKJDPzM+mk6KHzRgzJQYohLKgjMvkUi/T
         p+CQ/gs4ohlijR3LNapZq/i15oujT6soC5TgGg0TjURtevz56w7Se7dfZIfsngvGLiSE
         KtvIKirJ+tMDbZm96kIVNoLH7gRTCt+LGrJ24EVqiaawrJwwc4DRZiqJ2axnVbLK6nzB
         6aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851983; x=1762456783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMmhjXfa+AUkW+1GRraEC0lRkdWEh1/9s4uv+5EH1UU=;
        b=oPy/wSlGqIICCZ6EtKXcDbVFcmzyBiJxPyPPneBetB/F/IXioUCci4wQzsQzC8+Jb/
         OhXEm9HyiA7fIf4QlBldMSdKdH4Y731PmK9uP5kdlTZuUED5kbycUEVw7yR0SyOlnB3P
         fBhfgFLWYeRhwn2FVgliUyT2fUQixE4uNTmCeTVijr7A3UV77CGRYpMeSLcU4d2KDkCU
         nX3eOOxzGmM25h5v15B78NhVhqB0VrlLLmyRUVyYDrd4ZzHlAf3BzH5NHWpkwjXvCtQt
         Kd0P0GeUtWOYNKcePCHhZ+grGwUDaxCTANy7rGdl5+CeBa/mDfxb9Hsf2xMijXOXSnIe
         jHdw==
X-Gm-Message-State: AOJu0Yw9OlrxW6qyp5K9Ws07/rpOoZq5VQvqE3B7guZMAs37k+uW2pJn
	3UfrST7MFQgA+2xaaTh1txSEXfG7fEHlXxB5w6rJNlpAT8QFyOB5+wvMawQtvxL7+fY=
X-Gm-Gg: ASbGncvcr4znjdafaj2FEDWfHspaAEKTouBnNiHlpZ3i+s2qp0Y+tybIDTXDLI17yfH
	P3fmcHOnjZsfrEtwN0mOyxbf7FfbtzJFQWyeeKPK7uudpCx5uUg6zlQ4DsmHldEMQOiF9zF5Leq
	6BN3rwb+zG7gU+Zo1rrMmnqDAJ+xnX/5JyHRGaxcIsCrfZodulFhFJ+FZLOjmmLxvaDZR5gXO4E
	XCRJGEaP7c9klexiIf87Aoo8kFpXTHLvO6oO8WTJ26P/5CMJnjWXoeCsqDNlQzXuLZ8HOSCLr1g
	PFe+QG/UwjyiQoeT3rrmIk5YAPWIiqOQ/DOAmlhsDKolru9x1Vbdv0+3hAuMi6mL4edMB+t1o1/
	8MehriA3NQyJPKuYrQ660WErRVmT0iuTQFpP8sg5k1SriAc8oVfi+i1vygdAJ2Jf3dXfsX6H7Wv
	d8J4Wq+lJ6q+T8+J81PggzloAbtYFAyUbuu8XnWeS9om8OjOB8XyXbmu/Ps0yjAkjk0iJAbWgDF
	7Ad1oMfAqopxH3lhcA5VU0GQzgvkEZ/BpNQNVBa6btZ
X-Google-Smtp-Source: AGHT+IFanGyuYuO5H8a22lA5ejbndND6wgbLayvCVUj7Oq1ghg/3MFnDw8XPBwKNfQEzkXcLE+AV6g==
X-Received: by 2002:a05:6a00:179f:b0:7a2:756c:bccf with SMTP id d2e1a72fcca58-7a7790daa78mr672225b3a.25.1761851983226;
        Thu, 30 Oct 2025 12:19:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:e197:ba89:d0f7:5538])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a445156004sm10359135b3a.51.2025.10.30.12.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 12:19:42 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 0/3] replay: make atomic ref updates the default
Date: Fri, 31 Oct 2025 00:49:28 +0530
Message-ID: <20251030191931.30837-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028214609.10041-1-siddharthasthana31@gmail.com>
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v6 of the git-replay atomic updates series.

This version addresses Christian's feedback from v5 regarding code
consistency and test patterns. Thanks to Christian, Junio, Phillip,
Elijah, Patrick, and Karthik for the thorough reviews.

## Changes in v6

**Fixed parameter naming inconsistency**

Christian pointed out that parse_ref_action_mode() used `mode_str` as the
parameter name while the rest of the code used `ref_action`. Changed to
use `ref_action` consistently throughout for better code readability.

**Improved test cleanup pattern**

Replaced manual `git config --unset` with `test_when_finished` pattern with
`test_config` helper in the replay.refAction config test. The test_config
helper automatically handles cleanup via test_when_finished, providing
better test isolation and following Git test suite best practices.

These are code quality improvements that don't change functionality but
make the code more consistent with Git's established patterns.

## Technical Implementation

Same as v5, using Git's ref transaction API:

- ref_store_transaction_begin() with default atomic behavior
- ref_transaction_update() to stage each update
- ref_transaction_commit() for atomic application

The helper functions provide clean separation:

- parse_ref_action_mode(): Validates strings and converts to enum
- get_ref_action_mode(): Implements command-line > config > default precedence
- handle_ref_update(): Uses type-safe enum with switch statement

Config reading uses repo_config_get_string_tmp() for simplicity while
maintaining proper precedence behavior.

## Testing

All tests pass:

- t3650-replay-basics.sh (20 tests pass)
- Config tests now use test_config for automatic cleanup
- Atomic behavior tests verify direct ref updates
- Backward compatibility maintained for pipeline workflow

CI results: https://gitlab.com/gitlab-org/git/-/pipelines/2130504045

Siddharth Asthana (3):
  replay: use die_for_incompatible_opt2() for option validation
  replay: make atomic ref updates the default behavior
  replay: add replay.refAction config option

 Documentation/config/replay.adoc |  11 +++
 Documentation/git-replay.adoc    |  65 +++++++++++------
 builtin/replay.c                 | 121 +++++++++++++++++++++++++++----
 t/t3650-replay-basics.sh         |  90 +++++++++++++++++++++--
 4 files changed, 244 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

Range-diff against v5:
1:  3e27d07d3b = 1:  1f0fad0cac replay: use die_for_incompatible_opt2() for option validation
2:  643d9ca86a = 2:  bfc6188234 replay: make atomic ref updates the default behavior
3:  334da71911 ! 3:  6b2a44c72c replay: add replay.refAction config option
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
         replay: add replay.refAction config option
     
         [Commit message unchanged]
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: static struct commit *pick_regular_commit
      	return create_commit(repo, result->tree, pickme, replayed_base);
      }
      
    -+static enum ref_action_mode parse_ref_action_mode(const char *mode_str, const char *source)
    ++static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
     +{
    -+	if (!mode_str || !strcmp(mode_str, "update"))
    ++	if (!ref_action || !strcmp(ref_action, "update"))
     +		return REF_ACTION_UPDATE;
    -+	if (!strcmp(mode_str, "print"))
    ++	if (!strcmp(ref_action, "print"))
     +		return REF_ACTION_PRINT;
    -+	die(_("invalid %s value: '%s'"), source, mode_str);
    ++	die(_("invalid %s value: '%s'"), source, ref_action);
     +}
     +
     +static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)
     
      ## t/t3650-replay-basics.sh ##
     @@ t/t3650-replay-basics.sh
     +test_expect_success 'replay.refAction config option' '
     +	START=$(git rev-parse topic2) &&
     +	test_when_finished "git branch -f topic2 $START" &&
    -+	test_when_finished "git config --unset replay.refAction || true" &&
     +
    -+	git config replay.refAction print &&
    ++	test_config replay.refAction print &&
     +	git replay --onto main topic1..topic2 >output &&
     +	test_line_count = 1 output &&
     +	test_grep "^update refs/heads/topic2 " output &&
     +
     +	git branch -f topic2 $START &&
    -+	git config replay.refAction update &&
    ++	test_config replay.refAction update &&
     +	git replay --onto main topic1..topic2 >output &&
     
     +test_expect_success 'command-line --ref-action overrides config' '
-- 
2.51.0

base-commit: 57da342c78d8bf00259d2b720292e5b3035dadcc

Thanks
- Siddharth
