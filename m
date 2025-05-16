Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E4192B84
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406817; cv=none; b=cubmTAzHuhqmRLhGsZ6Ce2TUjffecFECKiVx4GdRAlTs88UFegvWJksX/JrYIfwb+14KTVLo/v3oS6XWCqU32w/b0VsnrUUH2tkmGzr+fX+D0v/R5GkWmAyHg3Ss+84+IkhFlyjTLapdNrs5ivle8ZquOksiFGbhV7QBRahk+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406817; c=relaxed/simple;
	bh=l2aiJ3PF89hch35qIiw2ycpcPSd2i3Wta+K2iACW6J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jovKioxeobTySwe+o+dAQ0I/UI0soih3gws8AqkeFkdmx6k0nVjsNE6XMy0sot+gjvkiW3wA6rfXrPe46z/8WlrT3OmuaTFMn8MyCo8IrgH4IQqjXC3I11wAioiCjpiOUedpCoQUXP5RXN3Bi+5mOog14QfcxmmhoN6tb96K7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl0MsAGS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl0MsAGS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso2094614a91.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747406815; x=1748011615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=074klEjjxL/dDUUUIQ//WU7KcuuVtIQEqPdSOujvFc4=;
        b=gl0MsAGST0RJh9Jaa4j6zMQvWT6jBu7dtpjRmgPU4mx3roykYvqNe2k4no7hcz/UXx
         xZfLmma6oqBYCvb5BeZDS7pnnsqlECBxGbbmAgwg8QJR82iy9rHwwJNZe7bVk0QSINWU
         Xbno1iG4PoRVHRDpsCLj/Jj7cqNGidAMhYjHmVuqN2/QzML4mgoAKQPb1JTDPY3hP2fr
         nM/lkIfaPrNKhCSylnZnRVC6S3q1ioNfWQatcW7ZarSRJf3BR9MNCSSbpzZAfz3hoL+M
         Byjwc8p8bnEE0WYc6d7RoMO+gsAtQAUDaZwrfw1A8C00kxp/8xdeGnwZJy+NUjETGXUb
         N2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406815; x=1748011615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=074klEjjxL/dDUUUIQ//WU7KcuuVtIQEqPdSOujvFc4=;
        b=M0Ox70z+T+9kU2Vg/e4gSQPyA5lBga+SjuW3xLcjWjEA2CDS1YrM3t/JsEMJLpFsql
         fXefZUfZkdsoXwxQO4E7wL7crkHV+Hq8T9p0NEd4MQWlBqPmDoAC37Iu2IrIWyIqbu60
         563lfriSPrwdvbvCkHPo+a6q/yxusRLFZ4wzFIRpQH2FJijccK486sRRGB5l4KBjlETb
         TKiLXJkeb1CrIurLGsbDoJ/J5ChNu9TiAe4jkEXadYd0Llz2UTj0cOJW0uCPTGZsxlTY
         SLP4EiRRjVIwyucVGkg4mohG8hk0dvXI30ZLEcaMp4s+gIlJLdr2ipCprFCYJtjonXDl
         pDiQ==
X-Gm-Message-State: AOJu0Yz6VeJi8cNU1RQCBy1BeKJdGoRsKszOWHKUyGyHx1vFvCMJyuNX
	Zd2RQF3I4VHCcZrY6GpYggyrFb0R8LtpelE4lOUQ5BTbcvzwYq3pRB03dofDCw==
X-Gm-Gg: ASbGncsngh1ju9ecz6HDCIT3vO4lFYqJObIjYzBllwSi0izv76zfcqd/uNTcQ7epXLa
	ybWhaWKQi+BHM/VsntBtlngIlM4z6xGtGuoi0kPDmpTApLOFvteHZZepMe+kV0AB5yVr/gGSkqs
	FiRWgZZe2yCgDziLU9MoceI8YAKvjwdvbHouSfjCeA7Zql6xuQbBTMjmKoNuEjM4IhQZpQmaqMP
	sGAlUTDtPf0GLyST5N6dkl380AaRhVnOVw1/CSbEaAYH9y3jJWVeGnjCn5hOTCntUfervYeyl3h
	e1bcs42JI38fP3xGgFRu7qArcQ5G5NB5ChhJv4tJFKB5Xquv5VFMPFtlOBi3y5PG
X-Google-Smtp-Source: AGHT+IGyqb8L103Ghhoz+xr9LtHz7XHXK26gya/XgESf372M3jXdXu8bzFMq3WXE1okqY7qLQ5nXPw==
X-Received: by 2002:a17:90b:4b01:b0:30a:dc08:d0fe with SMTP id 98e67ed59e1d1-30e8314fd42mr5081138a91.16.1747406815072;
        Fri, 16 May 2025 07:46:55 -0700 (PDT)
Received: from localhost.localdomain ([223.237.147.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e24f8sm5321322a91.30.2025.05.16.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:46:54 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v7 0/1] Updated the word diff regex for Bash scripts
Date: Fri, 16 May 2025 20:15:11 +0530
Message-ID: <20250516144515.49514-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511141101.18450-1-dhar61595@gmail.com>
References: <20250511141101.18450-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I cleaned up the parameter expansion regexes to avoid matching single-character operators like `:` or `#` that are already tokenized. 
I also removed the `:[0-9]+(:[0-9]+)?` pattern, which didn’t have a clear use case.
Variable matching now supports `$1`, `$2`, etc., not just `$foo`, by relaxing 
the first character requirement after the `$`. Also I removed the '?' after the second 
character of double character operators.
There are two test files in t/4018 which test the capturing of the complete line in the hunk header in the cases of both
posix style functions and bash style functions.



Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 .../bash-bashism-style-complete-line-capture  |  4 +++
 .../bash-posix-style-complete-line-capture    |  4 +++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 36 +++++++++++++++++++
 t/t4034/bash/post                             | 31 ++++++++++++++++
 t/t4034/bash/pre                              | 31 ++++++++++++++++
 userdiff.c                                    | 26 +++++++++-----
 8 files changed, 128 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

Range-diff against v6:
1:  464cb8a1eb ! 1:  314ac45fa2 userdiff: extend Bash pattern to cover more shell function forms
    @@ Commit message
     
         Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
     
    - ## t/t4018/bash-bashism-style-multiline-function (new) ##
    + ## t/t4018/bash-bashism-style-complete-line-capture (new) ##
     @@
    -+function RIGHT \
    -+{    
    ++function myfunc # RIGHT
    ++{
     +    echo 'ChangeMe'
     +}
     
    - ## t/t4018/bash-hunk-header-complete-line-capture (new) ##
    + ## t/t4018/bash-posix-style-complete-line-capture (new) ##
     @@
     +func() { # RIGHT
     +
     +    ChangeMe
    -+}
    -
    - ## t/t4018/bash-posix-style-multiline-function (new) ##
    -@@
    -+RIGHT() \
    -+{
    -+    ChangeMe
     +}
     
      ## t/t4018/bash-posix-style-single-command-function (new) ##
    @@ t/t4034/bash/expect (new)
     +<BOLD>index 09ac008..60ba6a2 100644<RESET>
     +<BOLD>--- a/pre<RESET>
     +<BOLD>+++ b/post<RESET>
    -+<CYAN>@@ -1,33 +1,33 @@<RESET>
    ++<CYAN>@@ -1,31 +1,31 @@<RESET>
     +<RED>my_var<RESET><GREEN>new_var<RESET>=10
     +x=<RED>123<RESET><GREEN>456<RESET>
    -+y=<RED>3.14<RESET><GREEN>2.71<RESET>
    -+z=<RED>.5<RESET><GREEN>.75<RESET>
    ++echo <RED>$1<RESET><GREEN>$2<RESET>
     +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
     +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
     +((a<RED>+<RESET><GREEN>+=<RESET>b))
    @@ t/t4034/bash/expect (new)
     +${a<RED>,<RESET><GREEN>,,<RESET>}
     +${<GREEN>!<RESET>a}
     +${a[<RED>*<RESET><GREEN>@<RESET>]}
    -+${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}
     +ls <RED>-a<RESET><GREEN>-x<RESET>
    -+ls <RED>--a<RESET><GREEN>--x<RESET>
    ++ls <RED>--all<RESET><GREEN>--color<RESET>
     
      ## t/t4034/bash/post (new) ##
     @@
     +new_var=10
     +x=456
    -+y=2.71
    -+z=.75
    ++echo $2
     +echo $USERNAME
     +${HOMEDIR}
     +((a+=b))
    @@ t/t4034/bash/post (new)
     +${a,,}
     +${!a}
     +${a[@]}
    -+${a:4:6}
     +ls -x
    -+ls --x
    ++ls --color
     
      ## t/t4034/bash/pre (new) ##
     @@
     +my_var=10
     +x=123
    -+y=3.14
    -+z=.5
    ++echo $1
     +echo $USER
     +${HOME}
     +((a+b))
    @@ t/t4034/bash/pre (new)
     +${a,}
     +${a}
     +${a[*]}
    -+${a:2:3}
     +ls -a
    -+ls --a
    ++ls --all
     
      ## userdiff.c ##
     @@ userdiff.c: PATTERNS("bash",
    @@ userdiff.c: PATTERNS("bash",
     -	 "[^ \t]+"),
     +	 /* Identifiers: variable and function names */
     +	  "[a-zA-Z_][a-zA-Z0-9_]*"
    -+	 /* Numeric constants: integers and decimals */
    -+	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
     +	 /* Shell variables: $VAR, ${VAR} */
    -+	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
    -+	  /* Logical and comparison operators */
    -+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
    -+	 /* Assignment and arithmetic operators */
    -+	 "|[-+*/%&|^!=<>]=?"
    ++	  "|\\$[a-zA-Z0-9_]+|\\$\\{"
    ++	  /*Command list separators and redirection operators  */
    ++	 "|\\|\\||&&|<<|>>"
    ++	 /* Operators ending in '=' (comparison + compound assignment) */
    ++	 "|==|!=|<=|>=|[-+*/%&|^]="
     +	 /* Additional parameter expansion operators */
    -+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
    ++	 "|:=|:-|:\\+|:\\?|##|%%|\\^\\^|,,"
     +	 /* Command-line options (to avoid splitting -option) */
    -+	 "|--?[a-zA-Z0-9_-]+"
    ++	 "|[-a-zA-Z0-9_]+"
     +	 /* Brackets and grouping symbols */
     +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
      PATTERNS("bibtex",
-- 
2.48.0

