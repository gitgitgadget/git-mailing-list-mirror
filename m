Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B3C125
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949876; cv=none; b=OZzna1Csk0rqBbNjE0Iwr4KfhEbGgrHvSvN7nQ0R6AKwqvN66Y1c13hgDyR0UrS+/mJlMZshMhIdb3BBNzOFMqASjmBdG2gsB9DoPllFQqoXajDnZS2ai8ah3vI30dVOfKw+OitYN+V+z6PwvFDKNODFhR4jovQq16y1ARJmEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949876; c=relaxed/simple;
	bh=vWPeP1eWXNX1ZVMrZfGU97roP68PUDZD64cQj5SMw50=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fjOJzzXXptcGOXLqyasxsHlevNZ3rr+SS1Qt065eRUtUTYFftoN5c7oAMaF3A4Eu2COBz+QK1DK/dcNKVJBQQIzjxsxPsavukjOqzNHsOwNAZ0+/UmjU0Iz1X2HIbEjO1jWlcXpf6vka7LYFsqOp8r+kdVSrkQSv2ww2RD5YBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnX62mGb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnX62mGb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso6929620f8f.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 16:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735949872; x=1736554672; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6Tj6wVWxvXTUUk1g17oBFuEHT0Z9RSe2j2syYHCImU=;
        b=DnX62mGb5tmc7fWUXtX0MLnHPmEHcK/PBjEplKMnNw3R7A68EeAy7lC9IgqargBtXd
         TZJMXXdLJpLHWTXYlUIF/9H76jZdBJZYLb7yB/lXEyyVKFYTPiU0HVIjmrUAcgdiEOsw
         EeTyWhbcuZhhD1hQaigRYCx4BIZeFz03M71CatlOZdHzGhd7R69FNAsLM0prD+2F1SbJ
         Q6ALZQENSBgkd9Mq9IUJogBzdZuXgoEgXcci/YUn48sOITgg6T3PZud+4cb9Ni28bZku
         gY0rgtJftRlqGJfkotKvMel0xm/sXOKPMb9eU7k4KNJtODPBZOWT+2rcdgn6xtsIlsy4
         AOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735949872; x=1736554672;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6Tj6wVWxvXTUUk1g17oBFuEHT0Z9RSe2j2syYHCImU=;
        b=KtKTJH+x8JvvplV5NBN/2Rr5SRkmHmkSkvswV8UwHTdedxaWGlhNlIHUrJxHXvxyD6
         WHff4w3wkv9biqY9aVWGVisnC904MhyHw7bQ/creQzMV+4H/ORki42bGgg1m5PdEkWDk
         qjuEGU0kbw0GK0VUNUxaTBRjsCJMc46ZpoaB7ul8Np54fUWKMCbD3mxEWEWHP/pNt1Y+
         M1J4skgEs0sUF6zqvXfOfQUxyPSrz3RO3DTr/ISr8VjteCI3gM/p8djs4HNwxFNoxpee
         YHhSoypA/A9/yeXFw7LP1CCYRyppGcEAAxyVN3Cmi1mHeeqpIy74/swdwOGPyY1WFuh9
         grbQ==
X-Gm-Message-State: AOJu0YwrUnqVh4pD6BerD1dEzVb4D6igFssz8FMvL4Iy4IN0tZKFU36T
	ilbJ2PQb8AzRfo2VXvA6f4FLNalRlyUbuid9PW0XgbNdpmbuVMD4HoA45A==
X-Gm-Gg: ASbGncuqXCDn8NlPiFFNZhuqomcjH/9b/VoWhItuNhuN29VrfYwj9oFTNomwppW+dKB
	exOYENAhheOy1+WVFh9ifz2Ha6rd7Q5qsd0rR6PNAgWignpyQufO5MSKGe/+kSQFVhuY9Mit2gU
	NGk5UMiZ2EbZMGQjHGNQ0OWq5r/roHsvyFi4p1bEz2FfEiVMx+6HzLIRCpy2WRGfEELiyDd+ZZC
	O/k8iEqz5DvGCNjwOCPxWYoT2fKyxzlwIJV+zpsU1dLw1GWNOwOTgW3cg==
X-Google-Smtp-Source: AGHT+IF8ZyTk4dvjP9SlPZiuztLQs1+aSwciHeatphEu+OMq5bfiI0esixWlZXClyAFxoNlZIZLq5g==
X-Received: by 2002:a5d:5985:0:b0:386:32ca:9e22 with SMTP id ffacd0b85a97d-38a223ff477mr34590109f8f.41.1735949871933;
        Fri, 03 Jan 2025 16:17:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833155sm41375750f8f.24.2025.01.03.16.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 16:17:51 -0800 (PST)
Message-Id: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 00:17:48 +0000
Subject: [PATCH v2 0/2] object-name: fix resolution of object names containing curly braces
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Maintainer note: these bugs both date back to 2006; neither is a regression
in this cycle.

Changes since v1:

 * Covered the ^{...} cases, and added a testcase for those
 * Added a second patch for another bug discovered by the same reporter,
   where branch:path/to/file/named/major-gaffed is interpreted as a request
   for a commit (namely affed) rather than a blob. (At least, assuming
   commit affed exists)

The second patch has some backward compatibility concerns. People used to be
able to do e.g. git show ${garbage}-g${hash}. I tightened it to
${valid_refname}-${number}-g${hash}, but do we want to allow e.g.
${valid_refname}-g${hash} (allowing the count to be omitted) or maybe even
allow a subset of invalid refnames?

Also for the second patch, while the repository the reporter found the issue
in was something else, I found two open source examples:

 * lore.git: git cat-file -t master:random/path/major-gaffed
 * git.git: git cat-file -t super-invalid~///\\.....@.lock-gfd0bba94e

Elijah Newren (2):
  object-name: fix resolution of object names containing curly braces
  object-name: be more strict in parsing describe-like output

 object-name.c       | 63 ++++++++++++++++++++++++++++++++++++++++++---
 t/t1006-cat-file.sh | 31 +++++++++++++++++++++-
 t/t6120-describe.sh | 22 ++++++++++++++++
 3 files changed, 111 insertions(+), 5 deletions(-)


base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1844%2Fnewren%2Fobject-name-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1844/newren/object-name-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1844

Range-diff vs v1:

 1:  1671b773fcc ! 1:  13f68bebe90 object-name: fix resolution of object names containing curly braces
     @@ Commit message
          should succeed (assuming that branch had a README.md file, of course).
          However, the change in cce91a2caef9 (Change 'master@noon' syntax to
          'master@{noon}'., 2006-05-19) presumed that curly braces would always
     -    come after an '@' and be paired, causing 'foo{bar:README.md' to
     -    entirely miss the ':' and assume there's no object being referenced.
     +    come after an '@' or '^' and be paired, causing e.g. 'foo{bar:README.md'
     +    to entirely miss the ':' and assume there's no object being referenced.
          In short, git would report:
      
              fatal: Not a valid object name foo{bar:README.md
      
          Change the parsing to only make the assumption of paired curly braces
     -    immediately after a '@' character appears.
     +    immediately after either a '@' or '^' character appears.
      
     -    Add tests for both this and 'foo@@{...}' cases, which an initial version
     -    of this patch broke.
     +    Add tests for this, as well as for a few other test cases that initial
     +    versions of this patch broke:
     +      * 'foo@@{...}'
     +      * 'foo^{/${SEARCH_TEXT_WITH_COLON}}:${PATH}'
      
          Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
          Helped-by: Michael Haggerty <mhagger@github.com>
     @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct reposito
       	}
       	for (cp = name, bracket_depth = 0; *cp; cp++) {
      -		if (*cp == '{')
     -+		if (*cp == '@' && *(cp+1) == '{') {
     ++		if (*(cp+1) == '{' && (*cp == '@' || *cp == '^')) {
      +			cp++;
       			bracket_depth++;
      -		else if (bracket_depth && *cp == '}')
     @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct reposito
       		struct object_id tree_oid;
      
       ## t/t1006-cat-file.sh ##
     +@@ t/t1006-cat-file.sh: test_expect_success "setup" '
     + 	git config extensions.objectformat $test_hash_algo &&
     + 	git config extensions.compatobjectformat $test_compat_hash_algo &&
     + 	echo_without_newline "$hello_content" > hello &&
     +-	git update-index --add hello
     ++	git update-index --add hello &&
     ++	git commit -m "add hello file"
     + '
     + 
     + run_blob_tests () {
      @@ t/t1006-cat-file.sh: test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
       	test_cmp expect actual
       '
       
     -+test_expect_success FUNNYNAMES 'setup with curly braches in input' '
     -+	git branch "foo{bar" &&
     -+	git branch "foo@"
     ++test_expect_success 'setup with curly braches in input' '
     ++	git branch "foo{bar" HEAD &&
     ++	git branch "foo@" HEAD
      +'
      +
     -+test_expect_success FUNNYNAMES 'object reference with curly brace' '
     ++test_expect_success 'object reference with curly brace' '
      +	git cat-file -p "foo{bar:hello" >actual &&
      +	git cat-file -p HEAD:hello >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success FUNNYNAMES 'object reference with at-sign' '
     ++test_expect_success 'object reference with at-sign' '
      +	git cat-file -p "foo@@{0}:hello" >actual &&
      +	git cat-file -p HEAD:hello >expect &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'setup with commit with colon' '
     ++	git commit-tree -m "testing: just a bunch of junk" HEAD^{tree} >out &&
     ++	git branch other $(cat out)
     ++'
     ++
     ++test_expect_success 'object reference via commit text search' '
     ++	git cat-file -p "other^{/testing:}:hello" >actual &&
     ++	git cat-file -p HEAD:hello >expect &&
     ++	test_cmp expect actual
     ++'
      +
       test_expect_success 'setup blobs which are likely to delta' '
       	test-tool genrandom foo 10240 >foo &&
 -:  ----------- > 2:  31f1c37b31a object-name: be more strict in parsing describe-like output

-- 
gitgitgadget
