Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888C84A39
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574629; cv=none; b=XwLVU6q2TBYA4JJkM8ASGm0hWeuCGWzK2/F1XEPG6h5iarWtIUhmxLHTd98o905kOcMrK5a70PkoqGxahbWrnyf1MC+ej5vcQdMKElgzi0h79aXsZd1A37jW/q+5p4jRQ1Fhiu4uWJRzGkJsRH48Vk9SUnHjouy9Ay/O64WiHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574629; c=relaxed/simple;
	bh=GyPmJ55rfbx2Z62dCr+CnSgnP0ZKyPRjwddyo9tdXaw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uxOdtg4vStqRIEWaMi2vqQbP41HNZ/8ZLNcKwNwiHnXOwcyiRmEaMCtGyUektriLmFZ/5LzT1Zah2MGizWBeyCM3jJclKPWzjFbRMo7NKnisWbb9OrhUvPDod2j78VbVZORA2sWjW6+BN6eHKp4BQ5Yh973sFdjvogLmrroMbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdzclHhr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdzclHhr"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso775247966b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574625; x=1730179425; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGuDXF1CCInKDbjhAS9ZcIQKyL3OINGf9z/iX5GeuL0=;
        b=XdzclHhrP+Y6TgN/jV6uuJH6tI6K5eM3f1xMjY26md/fBxGZEzE5uNy8ETeonPeVXV
         TkVJ2lcRpbHoZXg98pPbdNuqEeiHjKcc8lpMhaseboPqgiz8FnNtdPiPtCQumT9BcudA
         iBJnN0vvOMZa03gOWMxCzENv3q/CL/9tYPGMFRTToyuvXlTeYcidI7ZgpoWezgtQfrEe
         wrzNl3kI98UYp3AJzhnIcbxYnQ8YO+umqQWzQNhmIsPtOk4UDLvvJOJO3+yrwzfhRO5D
         zERKxVXHIZn62FSjO4XhneJ/6KUoyrXBIAaBjb0UyTb5SuixmU4k6Q++QfrtQW1GRZlQ
         BtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574625; x=1730179425;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGuDXF1CCInKDbjhAS9ZcIQKyL3OINGf9z/iX5GeuL0=;
        b=GioXhPUFWfPTZTKuyhNK8Xle1TEKsWpbZTKTibc4BcrYI1nzJD7DDbyPyGf6mXM+s5
         0eA6MG6u93eBH/j6ugwVCVUcmFFCBZdF2t/ROZYSLLKVlE4WgTp3twM/k27Uv8RFpkJn
         F7T5fVQW0GJuX7baYSktSrXfC2zJHRKAICPUVEWc98sBwjtNN3tkRj3n1fco8+35Ene7
         H2aG68RL8loRnshUd09JNH25s4N8Fo8YwGRl3cvhsXzZBvWShdbdFeO3Wa8KXqxeRAzS
         /KkOh8qPCuXxD1QuoarXhK2C0pgqzLQ0bLPGeRUiP4zxljJ7jM+CEJ6vZbHHH1MgpeZS
         mANQ==
X-Gm-Message-State: AOJu0Yy9tSe3A7tOCxBHEYxoaMk5E2JjoAY3yRaKD0HOzgScgNNo+DJs
	B9u+mhTWopfnq1PFrwombPkbG4MHUWI7J7N8UohT+FAAUEfA80FaAKOkKA==
X-Google-Smtp-Source: AGHT+IHKqaPb2Nia9Oam0bdmGE4YxY9lG+w/D/ZJlDmpxy82oTgMZ15fNnQdhN5OZRuHTSC/Je+thA==
X-Received: by 2002:a17:906:f592:b0:a99:ff43:ca8f with SMTP id a640c23a62f3a-a9a6995d6camr1244103766b.10.1729574625433;
        Mon, 21 Oct 2024 22:23:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6545sm287288866b.31.2024.10.21.22.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:23:45 -0700 (PDT)
Message-Id: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 05:23:40 +0000
Subject: [PATCH v3 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes from Version 2:

 * Use ${SQ} for single quote.
 * Change the commit message from Updated to Update, Replaced to Replace.
 * Format the commit message well.
 * Used warning for when marker size contains letters instead of die to
   avoid breaking somebody elses command as the test involve adding
   conflict_marker_size into .gitiattribute which is commited into the
   repository.

Usman Akinyemi (3):
  daemon: replace atoi() with strtoul_ui() and strtol_i()
  merge: replace atoi() with strtol_i() for marker size validation
  imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
    parsing

 daemon.c              | 11 +++++++----
 imap-send.c           | 13 ++++++++-----
 merge-ll.c            | 11 +++++++++--
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 t/t6406-merge-attr.sh |  6 ++++++
 5 files changed, 56 insertions(+), 11 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v3
Pull-Request: https://github.com/git/git/pull/1810

Range-diff vs v2:

 1:  a333d8a4013 ! 1:  e292b82d6a1 daemon: replace atoi() with strtoul_ui() and strtol_i()
     @@ Metadata
       ## Commit message ##
          daemon: replace atoi() with strtoul_ui() and strtol_i()
      
     -    Replaced atoi() with strtoul_ui() for --timeout and --init-timeout
     +    Replace atoi() with strtoul_ui() for --timeout and --init-timeout
          (non-negative integers) and with strtol_i() for --max-connections
          (signed integers). This improves error handling and input validation
          by detecting invalid values and providing clear error messages.
     -    Updated tests to ensure these arguments are properly validated.
     +    Update tests to ensure these arguments are properly validated.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
     @@ daemon.c: int cmd_main(int argc, const char **argv)
       		if (!strcmp(arg, "--strict-paths")) {
      
       ## t/t5570-git-daemon.sh ##
     -@@
     - #!/bin/sh
     - 
     --test_description='test fetching over git protocol'
     -+test_description='test fetching over git protocol and daemon rejects invalid options'
     - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 
      @@ t/t5570-git-daemon.sh: TEST_PASSES_SANITIZE_LEAK=true
       . ./test-lib.sh
       
     @@ t/t5570-git-daemon.sh: TEST_PASSES_SANITIZE_LEAK=true
      +	for arg in "3a" "-3"
      +	do
      +		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
     -+		test_write_lines "fatal: invalid init-timeout '\''$arg'\'', expecting a non-negative integer" >expected &&
     ++		test_write_lines "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
      +		test_cmp actual_error expected || return 1
      +	done
      +'
     @@ t/t5570-git-daemon.sh: TEST_PASSES_SANITIZE_LEAK=true
      +	for arg in "3a" "-3"
      +	do
      +		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
     -+		test_write_lines "fatal: invalid timeout '\''$arg'\'', expecting a non-negative integer" >expected &&
     ++		test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
      +		test_cmp actual_error expected || return 1
      +	done
      +'
      +
      +test_expect_success 'daemon rejects invalid --max-connections values' '
     ++	arg='3a' &&
      +	test_must_fail git daemon --max-connections=3a 2>actual_error &&
     -+	test_write_lines "fatal: invalid max-connections '\''3a'\'', expecting an integer" >expected &&
     ++	test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" >expected &&
      +	test_cmp actual_error expected
      +'
      +
 2:  5d58c150efb ! 2:  2ad3b0faa05 merge: replace atoi() with strtol_i() for marker size validation
     @@ Metadata
       ## Commit message ##
          merge: replace atoi() with strtol_i() for marker size validation
      
     -    Replaced atoi() with strtol_i() for parsing conflict-marker-size to
     +    Replace atoi() with strtol_i() for parsing conflict-marker-size to
          improve error handling. Invalid values, such as those containing letters
          now trigger a clear error message.
     -    Updated the test to verify invalid input handling.
     +    Update the test to verify invalid input handling.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## merge-ll.c ##
     +@@
     + #include "merge-ll.h"
     + #include "quote.h"
     + #include "strbuf.h"
     ++#include "gettext.h"
     + 
     + struct ll_merge_driver;
     + 
      @@ merge-ll.c: enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
       	git_check_attr(istate, path, check);
       	ll_driver_name = check->items[0].value;
       	if (check->items[1].value) {
      -		marker_size = atoi(check->items[1].value);
     -+		if (strtol_i(check->items[1].value, 10, &marker_size))
     -+			die("invalid marker-size '%s', expecting an integer", check->items[1].value);
     ++		if (strtol_i(check->items[1].value, 10, &marker_size)) {
     ++			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
     ++			warning(_("invalid marker-size '%s', expecting an integer"), check->items[1].value);
     ++		}
       		if (marker_size <= 0)
       			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
       	}
     @@ merge-ll.c: int ll_merge_marker_size(struct index_state *istate, const char *pat
       	git_check_attr(istate, path, check);
       	if (check->items[0].value) {
      -		marker_size = atoi(check->items[0].value);
     -+		if (strtol_i(check->items[0].value, 10, &marker_size))
     -+			die("invalid marker-size '%s', expecting an integer", check->items[0].value);
     ++		if (strtol_i(check->items[0].value, 10, &marker_size)) {
     ++			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
     ++			warning(_("invalid marker-size '%s', expecting an integer"), check->items[0].value);
     ++		}
       		if (marker_size <= 0)
       			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
       	}
     @@ t/t6406-merge-attr.sh: test_expect_success 'retry the merge with longer context'
       
      +test_expect_success 'invalid conflict-marker-size 3a' '
      +    echo "text conflict-marker-size=3a" >>.gitattributes &&
     -+    test_must_fail git checkout -m text 2>actual_error &&
     -+    test_write_lines "fatal: invalid marker-size '\''3a'\'', expecting an integer" >expected &&
     -+    test_cmp actual_error expected
     ++    git checkout -m text 2>error &&
     ++    test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" error
      +'
      +
       test_expect_success 'custom merge backend' '
 3:  c09c7b3df0d ! 3:  d0aa756d2d0 imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing
     @@ Metadata
       ## Commit message ##
          imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing
      
     -    Replaced unsafe uses of atoi() with strtol_i() to improve error handling
     +    Replace unsafe uses of atoi() with strtol_i() to improve error handling
          when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
     -    Invalid values, such as those with letters,
     -    now trigger error messages and prevent malformed status responses.
     +    Invalid values, such as those with letters, now trigger error messages and
     +    prevent malformed status responses.
     +    I did not add any test for this commit as we do not have any test
     +    for git-imap-send(1) at this point.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      

-- 
gitgitgadget
