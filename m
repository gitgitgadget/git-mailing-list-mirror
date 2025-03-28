Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11E1D61B7
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192451; cv=none; b=guEWA+pUJD81pyYM9OlURf1Y1TzhaSYwfjjhPXTgRyMmtOpQM3zCkvkHRVfARHVFKf1ZHppKz3Apum+YcgSxitMqGvlUyKIwV6c5I89/bVsFvrbySv0vM9bnRgBEY3y7r8Ugnguw0COIWGrUsp7PqxdBYt7c6i53XFEiZW78hko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192451; c=relaxed/simple;
	bh=h4ZOqtdSJAbbZO9z5UbxfF23nw3f9T2smsQVUZG1Wc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m81oOY88SbooCfP4Qpds5shk/VyZSciRmWy41yr2eB+iHFGcVB4hFKdj3E8n7b5ThQlhseP7HIkjSS9UYj/wn/LcobvZz9VTTXVqNHZDQPO1Zu3bM0yf/lVvnowhirsbpRl9KSL7Eo8ltTiDzapJ9s2CCw8zDZYXL4WaoyiTRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/pE4QOH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/pE4QOH"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso3435379a91.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743192449; x=1743797249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3GZNywEdeJc/Q4LzT45gwl/0KDoqnVuJqCIvcgG05w=;
        b=A/pE4QOHhQO/kuBz82XjyjhpVt9CvPcS53HnZQAJMMRrEF26AZNasTWCtCoZW+XvUM
         tyLafyePOy1pHzzj6A7rpum4haSkQNaRcJ9QiXmG2WoPHJLYlxkF0SVdPvcPhjlz+Goj
         8KALbye3g4aQyj4wonlJtWtpDlj8yvbqL0R43G1wdbww+7ObkMbjFbYxaif8SNInOSXf
         XMC3HZvlr96oPpCadoWQR9AntSJ/06o8veT+54wEYeWsGPXNQR7R3NX3t4i3Z78w7W5+
         ddXhiRN86apUcVbufqmutaA+wn9uom6Ifn2onvEffwXH4f9Poe5s8EeYdkxIfJW3hl1V
         0feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192449; x=1743797249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3GZNywEdeJc/Q4LzT45gwl/0KDoqnVuJqCIvcgG05w=;
        b=aYALNWQWqh0skelPM2h/rybRct7EwR7R//HNXQ7+HnZQooelxKcDna4a0DKiwsXsbZ
         188yiAn+tl1eReP3bDG70BnPqm3MDW3M3NuEgS3RSnWDSOSHCLUpVJxGPk3lf6R+CsJk
         0qFMPkX8Be07mOH7XShEgIhy56ac/qYHKTYnrGg8bqMolhzH1gF+gXa2NSpTHhI099Nm
         2YDvkbsGBH01WuHENE7SifRxitolu23PtC5HS3g7VrUUVgyTMNuyZdwtsYZ/zJfrjPjl
         iPn9g91CauTq2VIcwYQdSLK1EbKo0DtZVqutZxovHFI/4Zq6pd6tJZLbkItBEsFToM3W
         esXw==
X-Gm-Message-State: AOJu0YwK9PH3XuC6fTRJT0TBKlAN75iANRdyMjpR4B21fx//b9byzOVw
	KbqXhBwu3dg2vBbgTd4pmvM+p++6zSadNzLIRhyYVOvfIZogS9krI/67Og==
X-Gm-Gg: ASbGnct5TgKb+L7wNFKy0sKYlVm3OYNnWm+ntfcQ4qSC4MBhNoJefrm6JGAZoLYSrOi
	9NZ5dz7NANRPD/tgTPPzJTtVGpNIFoSxA+Q50TuaRRECwvPV+Lo1ARR4fw+dafNqnS/CFmFthcZ
	No/qOtmIQ3zt7nHROc+SnFr7R9gQ/EoT2K/c2oT0T3kcivnMV5sBz5VIsRmdscSviTmOFnyFDgM
	6iTitQFgdz7xjXcbeEYEw5n5Xju3RHEhL4rs1YzDfrN1jmfQ90+PPaNa7PoaDdJAJq2/i4NtbEK
	dyn8ded0RmRE3UWFoxz9WH1t+lxE7I16cwGjmwD+c5uxR4ATLttD+bL8dvzamMcpAfk=
X-Google-Smtp-Source: AGHT+IENRUF3a/HDIw5FiAgO03FtSQYNgBIsSdfAaMSMoCh9Al1BuZfhDdTzcT3neanf1zd3uwvbuQ==
X-Received: by 2002:a17:90b:17c3:b0:2fa:e9b:33b3 with SMTP id 98e67ed59e1d1-30531f7e2eamr742998a91.6.1743192448584;
        Fri, 28 Mar 2025 13:07:28 -0700 (PDT)
Received: from localhost.localdomain ([171.60.232.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3ea84sm2346421a91.8.2025.03.28.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:07:28 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Atharva Raykar" <raykar.ath@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 0/1] userdiff: improve Bash function and word regex patterns
Date: Sat, 29 Mar 2025 01:35:24 +0530
Message-ID: <20250328200525.4437-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250218153537.16320-1-dhar61595@gmail.com>
References: <20250218153537.16320-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves function detection in userdiff for Bash scripts.  
The old regex tried to match function bodies explicitly, which caused  
issues with line continuations (`\`) and simple command bodies. Instead,  
I have replaced it with `.*$`, making it more consistent with other userdiff  
drivers and ensuring we capture the full function definition line.  

I also refined the word regex to better handle Bash syntax, including  
parameter expansions, arithmetic expressions, and command-line options.  

I have  added test cases to cover these changes, making sure everything  
works as expected.

Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 t/t4018/bash-bashism-style-multiline-function |  4 +++
 t/t4018/bash-posix-style-multiline-function   |  4 +++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 30 +++++++++++++++++++
 t/t4034/bash/post                             | 25 ++++++++++++++++
 t/t4034/bash/pre                              | 25 ++++++++++++++++
 userdiff.c                                    | 24 +++++++++++----
 8 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

Range-diff against v2:
1:  de2e8f9792 ! 1:  3d077fadc4 userdiff: extend Bash pattern to cover more shell function forms
    @@ Metadata
      ## Commit message ##
         userdiff: extend Bash pattern to cover more shell function forms
     
    -    The existing Bash userdiff pattern misses some shell function forms, such as
    -    `function foo()`, multi-line definitions, and extra whitespace.
    +    The previous function regex required explicit matching of function
    +    bodies using `{`, `(`, `((`, or `[[`, which caused several issues:
     
    -    Extend the pattern to:
    -    - Support `function foo()` syntax.
    -    - Allow spaces in `foo ( )` definitions.
    -    - Recognize multi-line definitions with backslashes.
    -    - Broaden function body detection.
    +    - It failed to capture valid functions where `{` was on the next line
    +      due to line continuation (`\`).
    +    - It did not recognize functions with single  command body, such as
    +      `x () echo hello`.
    +
    +    Replacing the function body matching logic with `.*$`, ensures
    +    that everything on the function definition line is captured,
    +    aligning with other userdiff drivers and improving hunk headers in
    +    `git diff`.
    +
    +    Additionally, the word regex is refined to better recognize shell
    +    syntax, including additional parameter expansion operators and
    +    command-line options, improving syntax-aware diffs.
     
         Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
     
    + ## t/t4018/bash-bashism-style-multiline-function (new) ##
    +@@
    ++function RIGHT \
    ++{    
    ++    echo 'ChangeMe'
    ++}
    + \ No newline at end of file
    +
    + ## t/t4018/bash-posix-style-multiline-function (new) ##
    +@@
    ++RIGHT() \
    ++{
    ++    ChangeMe
    ++}
    + \ No newline at end of file
    +
    + ## t/t4018/bash-posix-style-single-command-function (new) ##
    +@@
    ++RIGHT() echo "hello"
    ++
    ++    ChangeMe
    +
    + ## t/t4034-diff-words.sh ##
    +@@ t/t4034-diff-words.sh: test_expect_success 'unset default driver' '
    + 
    + test_language_driver ada
    + test_language_driver bibtex
    ++test_language_driver bash
    + test_language_driver cpp
    + test_language_driver csharp
    + test_language_driver css
    +
    + ## t/t4034/bash/expect (new) ##
    +@@
    ++<BOLD>diff --git a/pre b/post<RESET>
    ++<BOLD>index 09ac008..60ba6a2 100644<RESET>
    ++<BOLD>--- a/pre<RESET>
    ++<BOLD>+++ b/post<RESET>
    ++<CYAN>@@ -1,25 +1,25 @@<RESET>
    ++<RED>my_var<RESET><GREEN>new_var<RESET>=10
    ++x=<RED>123<RESET><GREEN>456<RESET>
    ++y=<RED>3.14<RESET><GREEN>2.71<RESET>
    ++z=<RED>.5<RESET><GREEN>.75<RESET>
    ++echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
    ++${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
    ++if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
    ++((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
    ++((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
    ++$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
    ++$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
    ++${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
    ++${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
    ++${<RED>a<RESET><GREEN>x<RESET>##*/}
    ++${<RED>a<RESET><GREEN>x<RESET>%.*}
    ++${<RED>a<RESET><GREEN>x<RESET>%%.*}
    ++${<RED>a<RESET><GREEN>x<RESET>^^}
    ++${<RED>a<RESET><GREEN>x<RESET>,}
    ++${<RED>a<RESET><GREEN>x<RESET>,,}
    ++${!<RED>a<RESET><GREEN>x<RESET>}
    ++${<RED>a<RESET><GREEN>x<RESET>[@]}
    ++${<RED>a<RESET><GREEN>x<RESET>:?error message}
    ++${<RED>a<RESET><GREEN>x<RESET>:2:3}
    ++ls <RED>-a<RESET><GREEN>-x<RESET>
    ++ls <RED>--a<RESET><GREEN>--x<RESET>
    +
    + ## t/t4034/bash/post (new) ##
    +@@
    ++new_var=10
    ++x=456
    ++y=2.71
    ++z=.75
    ++echo $USERNAME
    ++${HOMEDIR}
    ++if [ "$x" == "$y" ] || [ "$x" != "$y" ]; then echo "OK"; fi
    ++((x+=y))
    ++((x-=y))
    ++$((x<<y))
    ++$((x>>y))
    ++${x:-y}
    ++${x:=y}
    ++${x##*/}
    ++${x%.*}
    ++${x%%.*}
    ++${x^^}
    ++${x,}
    ++${x,,}
    ++${!x}
    ++${x[@]}
    ++${x:?error message}
    ++${x:2:3}
    ++ls -x
    ++ls --x
    +
    + ## t/t4034/bash/pre (new) ##
    +@@
    ++my_var=10
    ++x=123
    ++y=3.14
    ++z=.5
    ++echo $USER
    ++${HOME}
    ++if [ "$a" == "$b" ] || [ "$c" != "$d" ]; then echo "OK"; fi
    ++((a+=b))
    ++((a-=b))
    ++$((a << b))
    ++$((a >> b))
    ++${a:-b}
    ++${a:=b}
    ++${a##*/}
    ++${a%.*}
    ++${a%%.*}
    ++${a^^}
    ++${a,}
    ++${a,,}
    ++${!a}
    ++${a[@]}
    ++${a:?error message}
    ++${a:2:3}
    ++ls -a
    ++ls --a
    +
      ## userdiff.c ##
    -@@ userdiff.c: IPATTERN("ada",
    - 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
    - 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
    - PATTERNS("bash",
    --	 /* Optional leading indentation */
    -+     /* Optional leading indentation */
    - 	 "^[ \t]*"
    --	 /* Start of captured text */
    -+	 /* Start of captured function name */
    - 	 "("
    - 	 "("
    --	     /* POSIX identifier with mandatory parentheses */
    --	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    -+		 /* POSIX identifier with mandatory parentheses (allow spaces inside) */
    -+		 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\)"
    - 	 "|"
    --	     /* Bashism identifier with optional parentheses */
    --	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    -+		 /* Bash-style function definitions, allowing optional `function` keyword */
    -+		 "(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?"
    +@@ userdiff.c: PATTERNS("bash",
    + 	     /* Bashism identifier with optional parentheses */
    + 	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
      	 ")"
    - 	 /* Optional whitespace */
    - 	 "[ \t]*"
    +-	 /* Optional whitespace */
    +-	 "[ \t]*"
     -	 /* Compound command starting with `{`, `(`, `((` or `[[` */
     -	 "(\\{|\\(\\(?|\\[\\[)"
    --	 /* End of captured text */
    -+	 /* Allow function body to start with `{`, `(` (subshell), `[[` */
    -+	 "(\\{|\\(|\\[\\[)"
    -+	 /* End of captured function name */
    ++	 /* Everything after the function header is captured  */
    ++	 ".*$"
    + 	 /* End of captured text */
      	 ")",
      	 /* -- */
     -	 /* Characters not in the default $IFS value */
     -	 "[^ \t]+"),
     +	 /* Identifiers: variable and function names */
    -+	 "[a-zA-Z_][a-zA-Z0-9_]*"
    ++	  "[a-zA-Z_][a-zA-Z0-9_]*"
     +	 /* Numeric constants: integers and decimals */
    -+	 "|[-+]?[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
    -+	 /* Shell variables: `$VAR`, `${VAR}` */
    -+	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
    -+	 /* Logical and comparison operators */
    ++	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
    ++	 /* Shell variables: $VAR, ${VAR} */
    ++	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
    ++	  /* Logical and comparison operators */
     +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
     +	 /* Assignment and arithmetic operators */
     +	 "|[-+*/%&|^!=<>]=?"
    -+	 /* Command-line options (to avoid splitting `-option`) */
    ++	 /* Additional parameter expansion operators */
    ++	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
    ++	 /* Command-line options (to avoid splitting -option) */
     +	 "|--?[a-zA-Z0-9_-]+"
     +	 /* Brackets and grouping symbols */
     +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
-- 
2.48.0

