Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E01509AE
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686650; cv=none; b=P18p3AJ96JJax5Rlnygtjdr+18zjS07sHQoA5zamnUb5jhFbaHerSQQNp0ZESggIDuQr34qqhtgjSLPq331BJfRRbAYzN1CcBkOeoQ0ObAc4D0hyIksrEX03Bgb/TLkjnMg4P1APFETsc1mGR2FJyQ1PI0C9tlozFtCpKpDBUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686650; c=relaxed/simple;
	bh=RalRJlHEPwucvcdHhkfKK3Gam4Y2uPap9sWC+2v31R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGi3vAQqsAs6OAT1ITTD3ICov14cDp/OmD2V6T/QbUg8WI3YsR4bQHpbmrCIhBg18gXTtuqk6iYsxeIvsu9PnA3q+wC5XTVu2M232PfmyF6SWc+b+hDCW3wpSx0mxSVgNaSz+qn9ijMqf1ylREOUYJ8cMP0u0CYyAIO3YC4zpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZsIKUzZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZsIKUzZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso4060965e9.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686647; x=1721291447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swt1Tg0KKRoXwRJ9D7Sxj6jcA0FAcpla3w0tbc8bXOw=;
        b=JZsIKUzZPOS3/kZ6f8SfrSYDqWGf35nb0e/B+/rXiPCYHz7qRRcbK+B3umt6nP7z34
         WSbhJNa9kyPIsUTHWdw+Pz7UumgzNvJeUHQzR1hG9JPmFepVDWzQSLZgsq0iLbjJI6jD
         TBq0ulue9Y7XnxdPS+JQHrEeRmXlXhKxczOEPmHEUB1sm03yQ34UB0HqzUrdahzq66NB
         Oo1JIcugsuV83i+0wI3TrDe3+FiSOmjAZ2BnD4aOuaLZy5+4heTwFhIEqad885rsqycd
         jh7chwx9/VJpdtsOwEW7/NGemxjlC55DRA1XqRh2l9J6CjC01bbikJjMK9jL0Mjnhsry
         Tqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686647; x=1721291447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swt1Tg0KKRoXwRJ9D7Sxj6jcA0FAcpla3w0tbc8bXOw=;
        b=QK9nohuRm1+SUGNPo++LueM0n/N/3+S7E4v6bv+2/VErdYIHqujiVj/Y79LAlSWXXX
         60LUg6BBcLoPEmPe7qUHbS/e33BLQSiG1e9RFa9fWryUuD3rIvR/Uob36tXKFAe2Aosd
         5lx4qGRaWt0F9Ez9KHw6rkTCgzabwVxoFERwXqe4r6efJHVb+kg2n8Zc9ZdglXUdsq6o
         sqCCoNO1mb0QB9ZY9byfJgAAmFrFWNWDS3IaRQgdxgVmBlQXgHAfJGozm8Tz7Ov2r8ds
         ybYyNjmLyjIZKHj11GBeW9W0XPIJPdPrWWBP/V47CtQbVJYU10qmrPDUjWn9VPhs86eb
         FAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6dlHQxam/mYobXIh9w02VVK0XeaaZECJCjz5oEzO6dyOs8RjzQRxuzfa+epTGRwSah4XXu9Cbt0Y0TaC7Xb+2fon
X-Gm-Message-State: AOJu0Yxn5Sq9XAdFA7TJjMW4zaUyFFNU2lUO7lVekeahInegwr9uER9v
	a3Bj9a2qocFPpFOWqFVi26A0TrXu5IRxMvpflh8wxBj8VpGvoHIlqjbCTvo7
X-Google-Smtp-Source: AGHT+IGaAw0v43P4yymHmYxWfNvG4PvOHUDBuo4I6kgZW9he8mlZmkIEs63qjBNAuCnPDoUTxc7rjw==
X-Received: by 2002:a05:600c:1594:b0:426:6ea2:31af with SMTP id 5b1f17b1804b1-426708fa7dbmr48517195e9.37.1720686646936;
        Thu, 11 Jul 2024 01:30:46 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 0/8] clang-format: add more rules and enable on CI
Date: Thu, 11 Jul 2024 10:30:35 +0200
Message-ID: <20240711083043.1732288-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of my series to add clang-format to the CI.

The series was mostly inspired by a patch sent recently to 'include
kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
run the formatting on CI and reduce some of the workload of reviewers.

We have a '.clang-format' file to provide rules for code formatting.
The commits 1-6 aims to add more rules to the file while deprecating old
ones.

Commit 7 enables CI action on GitHub and GitLab to also check for the
code formatting. Currently, it is allowed to fail. This way we can build
confidence and fine tune the values as needed and finally enforce the
check in a future patch. I'm not well versed with GitHub workflows, and
I mostly tried to copy existing work there. Expecting some feedback in
that section!

Commit 8 fixes an existing issue with the 'check-whitespace' job, which
is failing as success in the GitLab CI.

1: https://lore.kernel.org/git/4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de/

Changes against v1:
* Fixed a lot of typos.
* Added more details about the warnings specified by clang-format for
'RemoveBracesLLVM' in commit 5. Added more details too.
* The last two commits were modified to use "CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
and fallback to "CI_MERGE_REQUEST_DIFF_BASE_SHA" if the former is not
available in GitLab's CI.
* Use `!/bin/sh` for the run-style-check script.
* Modified the last commit to remove block around the && check in the
whitespace script.
* Use `git rev-parse --verify --quiet` to verify the base commit.


Karthik Nayak (8):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: ensure files end with newlines
  clang-format: replace deprecated option with 'SpacesInParens'
  clang-format: avoid braces on simple single-statement bodies
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided

 .clang-format                     | 42 +++++++++++++++++++++++++++----
 .github/workflows/check-style.yml | 29 +++++++++++++++++++++
 .gitlab-ci.yml                    | 24 +++++++++++++++++-
 ci/check-whitespace.sh            | 10 ++++++--
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             |  8 ++++++
 6 files changed, 106 insertions(+), 9 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

Range-diff against v1:
1:  6cf91ffc86 = 1:  6cf91ffc86 clang-format: indent preprocessor directives after hash
2:  beb002885f = 2:  beb002885f clang-format: avoid spacing around bitfield colon
3:  3031be43e7 = 3:  3031be43e7 clang-format: ensure files end with newlines
4:  bc1550e300 = 4:  bc1550e300 clang-format: replace deprecated option with 'SpacesInParens'
5:  cb6097aa22 ! 5:  840318a4c9 clang-format: avoid braces on simple single-statement bodies
    @@ Commit message
         Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
         braces for single-statement bodies in conditional blocks.
     
    +    This option does come with two warnings:
    +
    +        This option will be renamed and expanded to support other styles.
    +
    +    and
    +
    +        Setting this option to true could lead to incorrect code formatting
    +        due to clang-format’s lack of complete semantic information. As
    +        such, extra care should be taken to review code changes made by
    +        this option.
    +
    +    The latter seems to be of concern. But since we only use clang-format to
    +    verify the format and not to apply formatting, we should be okay here.
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .clang-format ##
    @@ .clang-format: IndentWrappedFunctionNames: false
      PointerAlignment: Right
      
     +# Remove optional braces of control statements (if, else, for, and while)
    -+# according to the LLVM coding style
    -+# This avoids braces on simple single-statement bodies of statements.
    ++# according to the LLVM coding style. This avoids braces on simple
    ++# single-statement bodies of statements but keeps braces if one side of
    ++# if/else if/.../else cascade has multi-statement body.
     +RemoveBracesLLVM: true
     +
      # Don't insert a space after a cast
6:  c4b6e1e82f ! 6:  0ecfd8d24b clang-format: formalize some of the spacing rules
    @@ Commit message
         clang-format: formalize some of the spacing rules
     
         There are some spacing rules that we follow in the project and it makes
    -    sen to formalize them:
    +    sense to formalize them:
         * Ensure there is no space inserted after the logical not '!' operator.
    -    * Ensure there is no space before the case statement's color.
    +    * Ensure there is no space before the case statement's colon.
         * Ensure there is no space before the first bracket '[' of an array.
         * Ensure there is no space in empty blocks.
     
7:  37f1e5c702 ! 7:  11a9ac4935 ci: run style check on GitHub and GitLab
    @@ Commit message
         this job to fail, so we can validate if this is useful and eventually
         enforce it.
     
    +    For GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA' variable by
    +    default to obtain the base SHA of the merged pipeline (which is only
    +    available for merged pipelines [1]). Otherwise we use the
    +    'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.
    +
    +    [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .github/workflows/check-style.yml (new) ##
    @@ .gitlab-ci.yml: check-whitespace:
     +  before_script:
     +    - ./ci/install-dependencies.sh
     +  script:
    -+    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++    - |
    ++      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
    ++        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      else
    ++        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++      fi
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
     +
    @@ ci/install-dependencies.sh: ubuntu-*)
     
      ## ci/run-style-check.sh (new) ##
     @@
    -+#!/usr/bin/env sh
    ++#!/bin/sh
     +#
     +# Perform style check
     +#
8:  c6d07402af < -:  ---------- check-whitespace: detect if no base_commit is provided
-:  ---------- > 8:  caccbf8264 check-whitespace: detect if no base_commit is provided
-- 
2.45.1

