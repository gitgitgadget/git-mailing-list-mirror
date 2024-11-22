Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB81DE4E4
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305029; cv=none; b=eW2s7efsILElQTkkclZd05P9sezfV8sAOdlGF0gk5ICBqCsGpo9FQ/2dG8/lC8JRNU80xdMDYDQRhtfIQka9pfitn6vA7j/rP2z2n3y/Y+OL3SIXB1/VwbcxV62Ezp/dLccv1G4zmP6VXMj3AnsGA/V5RetWWHGnca+9Rfc4ewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305029; c=relaxed/simple;
	bh=44ROOHZHpriYEbElarUpDo5fH/PpjqI7vw830O8Fr+M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NkMcqCi+r//6VwkHKueGL/0fO7KRXw1xYFuppfUAR1puvBz5YXfoei7IwFTgpVOl6qKMn5ZqOZSyfsPf+Kpg/BpYyDiEvExoEsZ66aQHfuZe6jgQm1n/Ddl+9Qggc9xdmpGTP6Mm01SCKGoXTY4tQ3Ap91NKWEKa14PNaD9YSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BagM7g0J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BagM7g0J"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431ac30d379so22338225e9.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305025; x=1732909825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqWZdW+WTe4/qdgLOEO+vfwYeXvXRRF0WD4O0q+WVaQ=;
        b=BagM7g0JeZTVCSyiGpbQO/YH5t1fL0BSusxBe6QRkKWWXHVuwoOlJS2bOP3dMk6zgD
         Vm71ahy1CAnAKr+lGalcvK9WWE7tQo2rV4px/C0bQwMExZjRNMI6KS4/1HBc231YSaEl
         DBgaw46/shIKIde52Uk3r76lvajIU4LV8yRJCg5eYDD/2U8FUAfGrU3OPCvHinB2PDKj
         ScYlXKrvu32BMnPJgVLOIfgHPTxCghiuqPa6sbgkwgBOVgsliwA7a44oHFH4ilRtGKnD
         S1Ho36OsvVREAguVCOZqz6W1DiepXuunDdJz2VUra8H1Shl74+/odb6kg3Jc2VBrBELu
         1UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305025; x=1732909825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqWZdW+WTe4/qdgLOEO+vfwYeXvXRRF0WD4O0q+WVaQ=;
        b=RYmTdO+rl7lda8Vyx0QOFXxyUpLUJ4wl8ygrxNdY+pII12gEfg6YNN0AhNDnX8ToSo
         1RNcDcsqxuZ1SZV5yQ9yRlnCAQ4jiKwxMc+iuH7gYNTOG5vda9IkfN/UmVsGVv2+Axzm
         wzSXnVnBZD4DnlVj/jjSRc0mv2I+ED+4KR0iIx78zJc9UBdnnoDtcARPejezom9CJ6M5
         SVglNkUSrj7e11ZZUL31c2E0dNTdtAVzzhyD5y/mH/uZRChmtwkJxDDSEWN9/2ZD5Fc9
         x21uREYdKE4s7OpSAid9tsCNpis5zqy9kKj1lwMzlrEue47nFi2kjZGucUM9G6eehlwW
         CcNw==
X-Gm-Message-State: AOJu0Ywxi/AAaB8Dr8gOe9HNEwqcopW/pd5L1DyNYnF7ewZJRy4+Urkq
	K/x5+xF2EVdZu+U04oWC/rUOuTE+SwQmJO/oqgcLaRxGHxykew9Qzc57rw==
X-Gm-Gg: ASbGnctG3n0soPjPYSxo4097LKL8h3+MJN1lNfs83pVKa9KmUk0BFsH/MJ84O4tTkOK
	KJzMeLAffzzB6p6V+43fTUOoCUn3Ra2lWW+BwhU7nkFEDaT9l5Qrb7LMX5Fxsbb3lWUI10nhAls
	Gv/WnQw4C6/ic5ZQLumBJpoJ+raEUAMZMMVO1vfyJkNRXiU/wxj8uTHmHBHhz+4OaSv7d2G6CSN
	CJP8IiHuXTfXo4AmyQon3K9cpJRGefS8BVnlbtwSkRO2CZxwQA=
X-Google-Smtp-Source: AGHT+IG9gbPTg3aRgP09FosVcEoJEm1DQ7rTsBVjNaRvt442iopTWyOiijlL5YqO8XRJKKNDVwKdIw==
X-Received: by 2002:a05:6000:2cd:b0:382:4b9a:f510 with SMTP id ffacd0b85a97d-38260b455damr3881554f8f.11.1732305024435;
        Fri, 22 Nov 2024 11:50:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3b4asm3287468f8f.84.2024.11.22.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:23 -0800 (PST)
Message-Id: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:17 +0000
Subject: [PATCH v2 0/5] git-mergetool: improve error code paths and messages
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>

Changes in v2: As suggested by Junio:

 * 3/5: moved the error message to setup_tool itself, and adjusted the
   commit message
 * 3/5: made the test more robust
 * 4/5: adjusted the error message

v1: These are a few improvements to improve existing error messages in 'git
mergetool', and make sure that errors are not quiet, along with a small
completion update in 1/1.

Philippe Blain (5):
  completion: complete '--tool-help' in 'git mergetool'
  git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
  git-mergetool--lib.sh: add error message if 'setup_user_tool' fails
  git-mergetool--lib.sh: add error message for unknown tool variant
  git-difftool--helper.sh: exit upon initialize_merge_tool errors

 contrib/completion/git-completion.bash |  2 +-
 git-difftool--helper.sh                |  8 ++------
 git-mergetool--lib.sh                  | 12 +++++++++---
 t/t7610-mergetool.sh                   |  8 ++++++++
 4 files changed, 20 insertions(+), 10 deletions(-)


base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1827%2Fphil-blain%2Fabsent-mergetool-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1827/phil-blain/absent-mergetool-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1827

Range-diff vs v1:

 1:  24933ba7130 = 1:  24933ba7130 completion: complete '--tool-help' in 'git mergetool'
 2:  6f7f553b283 = 2:  6f7f553b283 git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
 3:  79c3a6ffe8f ! 3:  1d9e95c6cb1 git-mergetool--lib.sh: add error message in 'setup_user_tool'
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    git-mergetool--lib.sh: add error message in 'setup_user_tool'
     +    git-mergetool--lib.sh: add error message if 'setup_user_tool' fails
      
          In git-mergetool--lib.sh::setup_tool, we check if the given tool is a
          known builtin tool, a known variant, or a user-defined tool by calling
     @@ Commit message
      
                  git mergetool --tool=unknown
      
     -    which is not very user-friendly. Adjust setup_user_tool to output an
     -    error message before returning if {diff,merge}tool.$tool.cmd is not set.
     +    which is not very user-friendly. Adjust setup_tool to output an error
     +    message before returning if setup_user_tool returned with an error.
      
     -    Adjust the second call to setup_user_tool in setup_tool to silence this
     -    new error, as this call is only meant to allow users to redefine 'cmd'
     -    for a builtin tool; it is not an error if they have not done so (which
     -    is why we do not check the return status of this call).
     +    Note that we do not check the result of the second call to
     +    setup_user_tool in setup_tool, as this call is only meant to allow users
     +    to redefine 'cmd' for a builtin tool; it is not an error if they have
     +    not done so.
      
          Note that this behaviour of quietly failing is a regression dating back
          to de8dafbada (mergetool: break setup_tool out into separate
     @@ git-mergetool--lib.sh: check_unchanged () {
       	cmd=$(get_merge_tool_cmd "$1")
       	test -n "$cmd"
       }
     - 
     - setup_user_tool () {
     - 	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
     --	test -n "$merge_tool_cmd" || return 1
     -+	if test -z "$merge_tool_cmd"
     -+	then
     -+		echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
     -+		return 1
     -+	fi
     - 
     - 	diff_cmd () {
     - 		( eval $merge_tool_cmd )
      @@ git-mergetool--lib.sh: setup_tool () {
     + 		. "$MERGE_TOOLS_DIR/${tool%[0-9]}"
     + 	else
     + 		setup_user_tool
     +-		return $?
     ++		rc=$?
     ++		if test $rc -ne 0
     ++		then
     ++			echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
     ++		fi
     ++		return $rc
     + 	fi
       
       	# Now let the user override the default command for the tool.  If
     - 	# they have not done so then this will return 1 which we ignore.
     --	setup_user_tool
     -+	setup_user_tool 2>/dev/null
     - 
     - 	if ! list_tool_variants | grep -q "^$tool$"
     - 	then
      
       ## t/t7610-mergetool.sh ##
      @@ t/t7610-mergetool.sh: test_expect_success 'mergetool with guiDefault' '
     @@ t/t7610-mergetool.sh: test_expect_success 'mergetool with guiDefault' '
      +	git checkout -b test$test_count branch1 &&
      +	test_must_fail git merge main &&
      +	yes "" | test_must_fail git mergetool --tool=absent >out 2>&1 &&
     -+	test_grep -i "not set for tool" out
     ++	test_grep "mergetool.absent.cmd not set for tool" out
      +'
      +
       test_done
 4:  74b83caa1e5 ! 4:  f234e965543 git-mergetool--lib.sh: add error message for unknown tool variant
     @@ git-mergetool--lib.sh: setup_tool () {
       
       	if ! list_tool_variants | grep -q "^$tool$"
       	then
     -+		echo "error: unknown ${tool%[0-9]} variant '$tool'" >&2
     ++		echo "error: unknown tool variant '$tool'" >&2
       		return 1
       	fi
       
 5:  be0b86f0890 = 5:  c16e9229ebb git-difftool--helper.sh: exit upon initialize_merge_tool errors

-- 
gitgitgadget
