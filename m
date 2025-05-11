Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBA2576
	for <git@vger.kernel.org>; Sun, 11 May 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746968377; cv=none; b=q5swZ8UdrqxCJGkt0c5Xa62coNs1QvJh1dmY08eH6qclctZiNmQ+Gbg2W/1yvlto3uHGJJl6K13hs1eNRxvNVcXhx8jqw+DXvQT5AhItBOB6MK+FdsyMDQWiuNaF+Gu6hMXCASvvrtnQnKnbtIGezSlmgSknHrU5cKT7gjxK+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746968377; c=relaxed/simple;
	bh=3TKlS967UnaT7ltxGr46N5kvor7VkISOaXpNUBVufNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMss7kvVwbWxwYDoGfdnD6NWBXcuBUjX9JaMgPd/D6Nffuf5JFrpaZo1JXJP4ECm+gMeYhpTT9WJ/2GxjSoZ+GGK30+CiZUvtZpsDIN2ZabILC5UArTqfqBa8K8EUZAv/EA1F/c5cmKi4jFQmZjcxf/JxmfHn+QGTILguCZuLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEUl/TrQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEUl/TrQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7370a2d1981so2987402b3a.2
        for <git@vger.kernel.org>; Sun, 11 May 2025 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746968375; x=1747573175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/RuRwK0C3+tkEH7myW+M8SvrKi98OmApSLxgzi9ReY=;
        b=iEUl/TrQizgFLCYvPqd3aee8sguOZMAzQUoaQLd/YHjyKELwRM1Sivtz9l2USb6KYn
         Kq418JGcY4sRvBUFtTYlo50OLXnLtddpocYi5DeWZzkcgPuYj1+F8JC41EknVRu3Qhw0
         Xzf3kCVBsmQcDqKTCEA/wefRB5ZgAGXbgS0k3Jk2WomEwbwzmFQo2v12KvS1Ilt0PxFh
         ilDOouUeOl9bY3aNfVVJDoggEAuhgxUbpXNixSqqF7DBK8cPVp/oY0U+pdepbE2zHwDC
         UmELUE7vc4twQa5T8lO1tPSCLQqTbg/H0BMAzCE9EinBX/aSrhstxESz6ianuYgncFBy
         6C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746968375; x=1747573175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/RuRwK0C3+tkEH7myW+M8SvrKi98OmApSLxgzi9ReY=;
        b=j+DduhhCh/t13ekuAjsg5aRbwL0R8kvvw/rMs6F4xr1i5XNbMX++JUCt3s3ma4d42O
         ErfV7djY9xZ6zl084kcXsJAI2t9hSS8NcJvaIoYwbYsbwFTkY5wzeitohKmqVBofqhlr
         XTrTh/8Aig2Xy6CdDRUXkWVmWuG7cqGtFom4wS8uzSSkwbCmeYlCum5ZjEpIM3Sk6N3P
         KCjtJzzHjken8qu6zhIwXheL85zJ3HHFW4NLZeToAeNZzUH85P/fxrbR81K6DR6lOsAj
         f/7+/LSiEQVOY8OoI5f4AO9ogeMd9Z28mfoZLcuzanpJEhrkBJMnx3MmkwgNwPrCyqZL
         1Scw==
X-Gm-Message-State: AOJu0Yw61q5ls39dqo2atTN5Woge7gVsrIicNbByNuM452PCD5X8KZ8Z
	dbGQq0PV2b+k96foTGCqYH51SMyg8WLvrkc4AGjTaf7QjmirexQPPNzsAQ==
X-Gm-Gg: ASbGncvJo1IgOYM9g4mczyQe6pshfeF3/8VSYRSJRLJhE3AHICwBtKeY3Ot46v8fdvx
	74J4zkFOpKARd9VznO28GYHFZVvHtyBBTvKh7TAjszL9I+kthRK9w/hZBCNGWtxBjC9G2aZ7PDp
	ST8f0Sg+GkZqlRmpVztTquMmtr6t5gqFX7AG7I5WxYwDYIf9H0YjFXNc+YNxq6jTst3RXTm3Gls
	zqzMA/e5l7HQyWNzzNvx4n1wiXbe0z34x9DH/HPdKupWbdGKBb650W3up0FZSh8rexCTWVsOGf6
	8VLrWWVyf5HEGTMOnJ/HquhPH8urrhWtbA9CKeYaOff6lVb5Q+tp8NWEg/rKKwW5Pw==
X-Google-Smtp-Source: AGHT+IFpy7fbjWoJCt7JqmTQYPCiMgvLIoX2mLuSbx6OImVmFzmhiRL3I6iNNj8xIohbjVKG1nnpOw==
X-Received: by 2002:aa7:88d5:0:b0:740:9d6b:db1a with SMTP id d2e1a72fcca58-7423c05b18bmr12643648b3a.15.1746968374982;
        Sun, 11 May 2025 05:59:34 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm4347103b3a.45.2025.05.11.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 05:59:34 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v5 0/1] Added the closing ")" to make sure is not unbalanced and corrected the tests for word diff
Date: Sun, 11 May 2025 18:28:07 +0530
Message-ID: <20250511125809.14180-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250330134018.9662-1-dhar61595@gmail.com>
References: <20250330134018.9662-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wrapped the POSIX function pattern in an extra set of parentheses and added 
a closing parenthesis in the Bashism function case to balance the opening group ,this makes the grouping explicit and consistent
with the outer structure of the regex. 

Also I added the test case so that everything on the function definition line is captured correctly.
And corrected the word diff test so that the operators like '+=' are treated as a single token.

Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 t/t4018/bash-bashism-style-multiline-function |  4 ++
 .../bash-hunk-header-complete-line-capture    |  4 ++
 t/t4018/bash-posix-style-multiline-function   |  4 ++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 38 +++++++++++++++++++
 t/t4034/bash/post                             | 33 ++++++++++++++++
 t/t4034/bash/pre                              | 33 ++++++++++++++++
 userdiff.c                                    | 28 ++++++++++----
 9 files changed, 140 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-hunk-header-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

Range-diff against v4:
1:  40cffd3b4a ! 1:  478b77e0c8 userdiff: extend Bash pattern to cover more shell function forms
    @@ Commit message
           `x () echo hello`.
     
         Replacing the function body matching logic with `.*$`, ensures
    -    that everything on the function definition line is captured,
    -    aligning with other userdiff drivers and improving hunk headers in
    -    `git diff`.
    +    that everything on the function definition line is captured.
     
         Additionally, the word regex is refined to better recognize shell
         syntax, including additional parameter expansion operators and
    -    command-line options, improving syntax-aware diffs.
    +    command-line options.
     
         Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
     
    @@ t/t4018/bash-bashism-style-multiline-function (new)
     +    echo 'ChangeMe'
     +}
     
    + ## t/t4018/bash-hunk-header-complete-line-capture (new) ##
    +@@
    ++func() { # RIGHT
    ++
    ++    ChangeMe
    ++}
    + \ No newline at end of file
    +
      ## t/t4018/bash-posix-style-multiline-function (new) ##
     @@
     +RIGHT() \
    @@ t/t4034/bash/expect (new)
     +<BOLD>index 09ac008..60ba6a2 100644<RESET>
     +<BOLD>--- a/pre<RESET>
     +<BOLD>+++ b/post<RESET>
    -+<CYAN>@@ -1,25 +1,25 @@<RESET>
    ++<CYAN>@@ -1,33 +1,33 @@<RESET>
     +<RED>my_var<RESET><GREEN>new_var<RESET>=10
     +x=<RED>123<RESET><GREEN>456<RESET>
     +y=<RED>3.14<RESET><GREEN>2.71<RESET>
     +z=<RED>.5<RESET><GREEN>.75<RESET>
     +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
     +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
    -+if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
    -+((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
    -+((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
    -+$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
    -+$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
    -+${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>##*/}
    -+${<RED>a<RESET><GREEN>x<RESET>%.*}
    -+${<RED>a<RESET><GREEN>x<RESET>%%.*}
    -+${<RED>a<RESET><GREEN>x<RESET>^^}
    -+${<RED>a<RESET><GREEN>x<RESET>,}
    -+${<RED>a<RESET><GREEN>x<RESET>,,}
    -+${!<RED>a<RESET><GREEN>x<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>[@]}
    -+${<RED>a<RESET><GREEN>x<RESET>:?error message}
    -+${<RED>a<RESET><GREEN>x<RESET>:2:3}
    ++((a<RED>+<RESET><GREEN>+=<RESET>b))
    ++((a<RED>*<RESET><GREEN>*=<RESET>b))
    ++((a<RED>/<RESET><GREEN>/=<RESET>b))
    ++((a<RED>%<RESET><GREEN>%=<RESET>b))
    ++((a<RED>|<RESET><GREEN>|=<RESET>b))
    ++((a<RED>^<RESET><GREEN>^=<RESET>b))
    ++((a<RED>=<RESET><GREEN>==<RESET>b))
    ++((a<RED>!<RESET><GREEN>!=<RESET>b))
    ++((a<RED><<RESET><GREEN><=<RESET>b))
    ++((a<RED>><RESET><GREEN>>=<RESET>b))
    ++$((a<RED><<RESET><GREEN><<<RESET>b))
    ++$((a<RED>><RESET><GREEN>>><RESET>b))
    ++$((a<RED>&<RESET><GREEN>&&<RESET>b))
    ++$((a<RED>|<RESET><GREEN>||<RESET>b))
    ++${a<RED>:<RESET><GREEN>:-<RESET>b}
    ++${a<RED>:<RESET><GREEN>:=<RESET>b}
    ++${a<RED>:<RESET><GREEN>:+<RESET>b}
    ++${a<RED>:<RESET><GREEN>:?<RESET>b}
    ++${a<RED>#<RESET><GREEN>##<RESET>*/}
    ++${a<RED>%<RESET><GREEN>%%<RESET>.*}
    ++${a<RED>^<RESET><GREEN>^^<RESET>}
    ++${a<RED>,<RESET><GREEN>,,<RESET>}
    ++${<GREEN>!<RESET>a}
    ++${a[<RED>*<RESET><GREEN>@<RESET>]}
    ++${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}
     +ls <RED>-a<RESET><GREEN>-x<RESET>
     +ls <RED>--a<RESET><GREEN>--x<RESET>
     
    @@ t/t4034/bash/post (new)
     +z=.75
     +echo $USERNAME
     +${HOMEDIR}
    -+if [ "$x" == "$y" ] || [ "$x" != "$y" ]; then echo "OK"; fi
    -+((x+=y))
    -+((x-=y))
    -+$((x<<y))
    -+$((x>>y))
    -+${x:-y}
    -+${x:=y}
    -+${x##*/}
    -+${x%.*}
    -+${x%%.*}
    -+${x^^}
    -+${x,}
    -+${x,,}
    -+${!x}
    -+${x[@]}
    -+${x:?error message}
    -+${x:2:3}
    ++((a+=b))
    ++((a*=b))
    ++((a/=b))
    ++((a%=b))
    ++((a|=b))
    ++((a^=b))
    ++((a==b))
    ++((a!=b))
    ++((a<=b))
    ++((a>=b))
    ++$((a<<b))
    ++$((a>>b))
    ++$((a&&b))
    ++$((a||b))
    ++${a:-b}
    ++${a:=b}
    ++${a:+b}
    ++${a:?b}
    ++${a##*/}
    ++${a%%.*}
    ++${a^^}
    ++${a,,}
    ++${!a}
    ++${a[@]}
    ++${a:4:6}
     +ls -x
     +ls --x
     
    @@ t/t4034/bash/pre (new)
     +z=.5
     +echo $USER
     +${HOME}
    -+if [ "$a" == "$b" ] || [ "$c" != "$d" ]; then echo "OK"; fi
    -+((a+=b))
    -+((a-=b))
    -+$((a << b))
    -+$((a >> b))
    -+${a:-b}
    -+${a:=b}
    -+${a##*/}
    ++((a+b))
    ++((a*b))
    ++((a/b))
    ++((a%b))
    ++((a|b))
    ++((a^b))
    ++((a=b))
    ++((a!b))
    ++((a<b))
    ++((a>b))
    ++$((a<b))
    ++$((a>b))
    ++$((a&b))
    ++$((a|b))
    ++${a:b}
    ++${a:b}
    ++${a:b}
    ++${a:b}
    ++${a#*/}
     +${a%.*}
    -+${a%%.*}
    -+${a^^}
    ++${a^}
     +${a,}
    -+${a,,}
    -+${!a}
    -+${a[@]}
    -+${a:?error message}
    ++${a}
    ++${a[*]}
     +${a:2:3}
     +ls -a
     +ls --a
     
      ## userdiff.c ##
     @@ userdiff.c: PATTERNS("bash",
    + 	 "("
    + 	 "("
    + 	     /* POSIX identifier with mandatory parentheses */
    +-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    ++	     "([a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    + 	 "|"
      	     /* Bashism identifier with optional parentheses */
    - 	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    +-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    ++	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+)))"
      	 ")"
     -	 /* Optional whitespace */
     -	 "[ \t]*"
    @@ userdiff.c: PATTERNS("bash",
     +	 /* Assignment and arithmetic operators */
     +	 "|[-+*/%&|^!=<>]=?"
     +	 /* Additional parameter expansion operators */
    -+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
    ++	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
     +	 /* Command-line options (to avoid splitting -option) */
     +	 "|--?[a-zA-Z0-9_-]+"
     +	 /* Brackets and grouping symbols */
-- 
2.48.0

