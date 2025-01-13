Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA922980E
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788423; cv=none; b=tccjYUWr+xclAgNOdNCpTGxXr4DhiF/3B3RGDb2mLLmFD/OHCQLIoVWEsnLCuPCavADmNRHAnQouNJE+o3xoE5z1frgZFoWfJUmA+2NErSQGN9swZRPlWsOxJ87/xI93pyuaJgpF3fPoQmYQuDNObIiHUUywv0lBY8pbt6cGWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788423; c=relaxed/simple;
	bh=ZNhduBEMBHGpmsnR7ir6HjPBFgVM6eCzACiEEOcxRjg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M3v/bpPaVflA7/hV7Djv0fhU3XTCQq/qGW7o0GpCuVqd8OS3Ctryt7kQQA1tZX9dSLdRIpy84tIXW1KaRsnfWhCy1cOXIB2mWZ8bZtP/LF0HUdxH9tvmZkmTt3MErAL8rTatyqhy9IgGVEQgWysuY6VjQisp0w2k5gVxics3MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvULFQFe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvULFQFe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43635796b48so28429995e9.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736788419; x=1737393219; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i6lJmmkVFhs3YDmBn695a4u3mL3QE2Hl01E3yV3wL8=;
        b=dvULFQFeEUEpJhMHj8UO2XqQSk93izI8Z6sLjm6A9bbCty2xLrgjd2HtC8nWo/wnf6
         Xz5iF5a2lmkOv3HzvmXQfWTCEpL1dA3xAxrsDug1yPDKLVLcaHydv+ncHBkwbmGLkVJ+
         PR0I+Qi27qGuORsM9glyFHbjhTxsR8u8SSinEMrk5mE6A8WDWlKmBTAivT7SbY8b3m5M
         lzc6WVDbI53QR/6gFmMKlikyFsCZ496r20NTWLd3AP2BoqHnmBYZ4jTgskoZ2pDBPRm9
         fCCn3vEsfipRYkzsexft64hnl3dEeaKwmETRkKOIgkUsTkGbzDNGO3hV4IU0bQvGr7/x
         lpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736788419; x=1737393219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i6lJmmkVFhs3YDmBn695a4u3mL3QE2Hl01E3yV3wL8=;
        b=azz4hTGmJbvxXhIptHxgqjb0u++ys/Vr159ghf8k18G6dSSTM8pVJ4FBl1bBCoKZ5h
         HuTtlRZebOz/a7/EQybVxBTDk1QUJU+VUiiMuTY5IeVyWBjeMnCbrsw55OeG2MngLjHX
         bDqWbfa1ztqbzIEKuUjDn/pLlY2S2jcBvtKIbNGDYzf9gnFxpgGxnBwG1jIVHxk0LyGv
         OnMCYDbYluxH9STQ8qk2tcXOop+4RdFhnHq0af9LIqpxjl0u74qlRWl/r5EjDmp/V1Lb
         bUvv9UUVm6QvN62qqhCkEkzVvfrjF9fP6PiXidHMRiY3ZXO3uK3PWYf3VJt9HtWSHkrR
         lvFA==
X-Gm-Message-State: AOJu0YwWI37T00CrDZiLuffS6vtgohGwmuZgOuwOYLOxkR8j73jsXywz
	u3Bp8AqGFJsWUhaqznVkehCobA3+u5w+7mDdbftB3jczAXiW0l9o8hN+5Q==
X-Gm-Gg: ASbGncuV+bhGwdfw1j1g2JeQfH+Plfn0R5o694RYvqJkWcqLAeVtWbKpVFNE6Ls7Ysq
	hpXRqn46tIU9ChJrgeRsxpE6G23ET33Hz4qoEqjxPT2L8yrp2O05ao/n53cx83yZCioNtRXIL05
	Dtql8NeFYmakgsDumWnIlyr9GkYG0v1AYPDtQ2tPmGghgT7sZqW+b5zgY1LmB/PMUL7wmDPwiPk
	mYeXgjVU2NzQZ10XADI7Qt6Qwq0WkP+kFtCYu/q1wdwNytvKrzCms6eQQ==
X-Google-Smtp-Source: AGHT+IErXf248BkjDQ6KhWGV8IpQlIGE+ptglNb/vvZSV2KX7QNWZQVdTIJ9AEeW7iOmt7XQ7pO4VQ==
X-Received: by 2002:a05:600c:1827:b0:436:199e:8458 with SMTP id 5b1f17b1804b1-436e8849de0mr150963085e9.14.1736788418539;
        Mon, 13 Jan 2025 09:13:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82a4sm12800841f8f.72.2025.01.13.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:13:38 -0800 (PST)
Message-Id: <pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
References: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 17:13:35 +0000
Subject: [PATCH v3 0/2] object-name: fix a pair of object name resolution issues
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

Changes since v2:

 * Readability improvement to the first patch, which fixes object name
   resolution with refs containing a curly brace
 * Fixed the second patch for cases like OBJ-COUNT-gHASH~13 and added a
   couple test cases for that. Also, extended the commit message a bit to
   discuss the cases brought up on the list.

For the second patch, if folks want some open source examples where it could
be triggered, I found two examples:

 * lore.git: git cat-file -t master:random/path/major-gaffed
 * git.git: git cat-file -t super-invalid~///\\.....@.lock-gfd0bba94e

Elijah Newren (2):
  object-name: fix resolution of object names containing curly braces
  object-name: be more strict in parsing describe-like output

 object-name.c       | 63 ++++++++++++++++++++++++++++++++++++++++++---
 t/t1006-cat-file.sh | 31 +++++++++++++++++++++-
 t/t6120-describe.sh | 24 +++++++++++++++++
 3 files changed, 113 insertions(+), 5 deletions(-)


base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1844%2Fnewren%2Fobject-name-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1844/newren/object-name-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1844

Range-diff vs v2:

 1:  13f68bebe90 ! 1:  b21b8fc5554 object-name: fix resolution of object names containing curly braces
     @@ Commit message
            * 'foo@@{...}'
            * 'foo^{/${SEARCH_TEXT_WITH_COLON}}:${PATH}'
      
     +    Note that we'd prefer duplicating the special logic for "@^" characters
     +    here, because if get_oid_basic() or interpret_nth_prior_checkout() or
     +    get_oid_basic() or similar gain extra methods of using curly braces,
     +    then the logic in get_oid_with_context_1() would need to be updated as
     +    well.  But it's not clear how to refactor all of these to have a simple
     +    common callpoint with the specialized logic.
     +
          Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
          Helped-by: Michael Haggerty <mhagger@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct reposito
       	}
       	for (cp = name, bracket_depth = 0; *cp; cp++) {
      -		if (*cp == '{')
     -+		if (*(cp+1) == '{' && (*cp == '@' || *cp == '^')) {
     ++		if (strchr("@^", *cp) && cp[1] == '{') {
      +			cp++;
       			bracket_depth++;
      -		else if (bracket_depth && *cp == '}')
 2:  31f1c37b31a ! 2:  19f84dfc9cc object-name: be more strict in parsing describe-like output
     @@ Commit message
                'g', and an abbreviated object name.
          which means that output of the format
              ${REFNAME}-${INTEGER}-g${HASH}
     -    should parse to fully expand ${HASH}.  This is fine.  However, we
     +    should parse to fully expanded ${HASH}.  This is fine.  However, we
          currently don't validate any of ${REFNAME}-${INTEGER}, we only parse
          -g${HASH} and assume the rest is valid.  That is problematic, since it
          breaks things like
      
              git cat-file -p branchname:path/to/file/named/i-gaffed
      
     -    which, when commit affed exists, will not return us information about a
     -    file we are looking for but will instead tell us about commit affed.
     +    which, when commit (or tree or blob) affed exists, will not return us
     +    information about the file we are looking for but will instead
     +    erroneously tell us about object affed.
      
     -    Similarly, we should probably not treat
     -        refs/tags/invalid/./../...../// ~^:/?*\\&[}/busted.lock-g049e0ef6
     -    as a request for commit 050e0ef6 either.
     +    A few additional notes:
     +      - This is a slight backward incompatibility break, because we used
     +        to allow ${GARBAGE}-g${HASH} as a way to spell ${HASH}.  However,
     +        a backward incompatible break is necessary, because there is no
     +        other way for someone to be more specific and disambiguate that they
     +        want the blob master:path/to/who-gabbed instead of the object abbed.
     +      - There is a possibility that check_refname_format() rules change in
     +        the future.  However, we can only realistically loosen the rules
     +        for what that function accepts rather than tighten.  If we were to
     +        tighten the rules, some real world repositories may already have
     +        refnames that suddenly become unacceptable and we break those
     +        repositories.  As such, any describe-like syntax of the form
     +        ${VALID_FOR_A_REFNAME}-${INTEGER}-g${HASH} that is valid with the
     +        changes in this commit will remain valid in the future.
     +      - The fact that check_refname_format() rules could loosen in the
     +        future is probably also an important reason to make this change.  If
     +        the rules loosen, there might be additional cases within
     +        ${GARBAGE}-g${HASH} that become ambiguous in the future.  While
     +        abbreviated hashes can be disambiguated by abbreviating less, it may
     +        well be that these alternative object names have no way of being
     +        disambiguated (much like pathnames cannot be).  Accepting all random
     +        ${GARBAGE} thus makes it difficult for us to allow future
     +        extensions to object naming.
      
     -    Tighten up the parsing to make sure ${REFNAME} and ${INTEGER} are
     -    present and valid.
     +    So, tighten up the parsing to make sure ${REFNAME} and ${INTEGER} are
     +    present in the string, and would be considered a valid ref and
     +    non-negative integer.
     +
     +    Also, add a few tests for git describe using object names of the form
     +        ${REVISION_NAME}${MODIFIERS}
     +    since an early version of this patch failed on constructs like
     +        git describe v2.48.0-rc2-161-g6c2274cdbc^0
      
          Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ object-name.c: static int peel_onion(struct repository *r, const char *name, int
      +	len = cp - name;
      +	strbuf_init(&sb, len);
      +	strbuf_add(&sb, name, len);
     -+	ret = !check_refname_format(name, flags);
     ++	ret = !check_refname_format(sb.buf, flags);
      +	strbuf_release(&sb);
      +	return ret;
      +}
     @@ object-name.c: static int get_describe_name(struct repository *r,
       				return get_short_oid(r,
      
       ## t/t6120-describe.sh ##
     +@@ t/t6120-describe.sh: check_describe R-2-gHASH HEAD^^
     + check_describe A-3-gHASH HEAD^^2
     + check_describe B HEAD^^2^
     + check_describe R-1-gHASH HEAD^^^
     ++check_describe R-1-gHASH R-1-g$(git rev-parse --short HEAD^^)~1
     + 
     + check_describe c-7-gHASH --tags HEAD
     + check_describe c-6-gHASH --tags HEAD^
     + check_describe e-1-gHASH --tags HEAD^^
     + check_describe c-2-gHASH --tags HEAD^^2
     ++check_describe c-2-gHASH --tags c-2-g$(git rev-parse --short HEAD^^2)^0
     + check_describe B --tags HEAD^^2^
     + check_describe e --tags HEAD^^^
     + check_describe e --tags --exact-match HEAD^^^
      @@ t/t6120-describe.sh: test_expect_success '--exact-match does not show --always fallback' '
       	test_must_fail git describe --exact-match --always
       '

-- 
gitgitgadget
