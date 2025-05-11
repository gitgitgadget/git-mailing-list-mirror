Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B792576
	for <git@vger.kernel.org>; Sun, 11 May 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746968399; cv=none; b=JynQtJjC+xq0ube+kSpvV1+mnFZ+EtmCGeZLkVO3WQRX+swXLcSwkjM4BbzHc34ZI2HTAf5F9PyIrm6MeSxEk4675gwAGw70Ux4mv5cMYO/a8OyxL0M0QA1alYrfK0aVHodM8sj8zpUORfbQR2eKQezr1T2TxqzQ59SH/jQRR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746968399; c=relaxed/simple;
	bh=SfQu8CUGXC96wXZ1ZHXRD81DFe/x/62yvxPuAjzAWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrpOXsKON36SuZV1K8recgpetA/JDhEzrtj49g62ne5KB3FW8nD7+WQNFYm4rGXVyqCYw8wKFiz9fzdKZj2QAZ5QtamPM7DtWcdMV6hMWJZVUYvBVT2gJpyrQXJEaaaJ2Ua/52xoYMRW5B2MvaxJtb2G3uuqAoE8VXnkNrn8u84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XujBlXVx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XujBlXVx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so3513730b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746968397; x=1747573197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H50sf2D4XmDTAS2yUTNd1zI3fnP6Vv8pYk5nNpVEQXs=;
        b=XujBlXVxdPu0xDLD65oRSvOjQnpZgI5uBw4BElTBtrwxCFiq5Dp7jSIB25uTN7yVB3
         aGfgXIVM0HijBt+4UYGLuoGMT9T7b+/oWwv+fJpbjfdsF35ooJ6NdNkcNsu2fbVNJ1yD
         dvQcbdYsT4T175A7+Z1tCvOY4MnRQp+GBbYC4Ipfm2KI5JoeXC8k50IIqZ6lJhByr1T3
         zmt7Ub5SyS4ikASNl5z7pVfomr4kVAsSm2lrkRyKC1Xpl5IJiawbsckv4AmYm2zV8l9t
         cgKUdUvI0tplEDhjVYz+c2BPPqSQVL1gsqohPF20/FiHRfHfnp1jkYpYvX5aBgzWFzwu
         0NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746968397; x=1747573197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H50sf2D4XmDTAS2yUTNd1zI3fnP6Vv8pYk5nNpVEQXs=;
        b=ohbqTILbWLdsgcKHY0cHY77kprt44UV2vO6qRUUCIdaU2gwYUkhGZG7+bZ+2RjNeLD
         3z0v57kxY8fQYE6ek1Fs+rFFwVvawEtLaY+hH84FH4Cww786jDrIEK8wG9Db8nEKloQr
         SF+NoxorlxRIq//gdTFHCYM0P3UyWMe//nx3CYmIH0k8UWSxvHNu7J+1+HHC2zfaFQp1
         17tLRAsR+xZ5RMFQxm0l6Ty9V/wYh6TziXShPZTw7XtfTAx8jdBkqGojroFXU50wqJTx
         AGs82mcvCK2HnuT5tpeoJ7AgxtQzm2qVbabK/cEWe2eJcTCG5DvUl/TrKM0YRDs6JQ2l
         3Y3g==
X-Gm-Message-State: AOJu0Ywoul4qKJarA9t6lhqaYwQguwwnSDUgiJ09zPngSHS0qOhXjOri
	mWcPjkV8oF9qLXSDeWPI4CMYGoIPjo7V6/oRLDKyiVE8Ihh+GxFfLdD4PA==
X-Gm-Gg: ASbGncvSjGpQM9xL8gxlDwiC4Ck+kxCdrmJgcFhaVdoDcEHM2bEtCmex9/5Rtx3LlIA
	pw94uYtz1wPvGYM/MyQsfmhZ0zb04Rn8nQXKBTVK/YzXUB1fC4a3J0s/nGikzJLvkC89MAa2QMv
	v7oKmZ858BSyifzztH8uk/EJN6STA+gTg5llOOXF31LKfS/cH9w0yLq7E2sCHNorVZNHXjuT+tM
	MsxCgaXPju/JVilvW5hbuOd2M0crSF0CbjJUeXmNwwteFd1PN0nlDHs/eCNJhe3VMIS8W6ri+Ev
	iPsRhY4q+5vQpFmMBK2noTz7C3KJJgqf4qFfy5PHWaIyKCI22RcgHU5Vns5cLzZDEw==
X-Google-Smtp-Source: AGHT+IHet12vZFLtrATQfsttfD2atPidXei27wQbVTN3ac/wE/xpPo0FPGDwRyMV69mlom17dDwrNA==
X-Received: by 2002:a05:6a20:9d90:b0:1f5:a3e8:64c1 with SMTP id adf61e73a8af0-215ab884c75mr13551677637.0.1746968396965;
        Sun, 11 May 2025 05:59:56 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm4347103b3a.45.2025.05.11.05.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 05:59:56 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v5 1/1] userdiff: extend Bash pattern to cover more shell function forms
Date: Sun, 11 May 2025 18:28:08 +0530
Message-ID: <20250511125809.14180-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511125809.14180-1-dhar61595@gmail.com>
References: <20250330134018.9662-1-dhar61595@gmail.com>
 <20250511125809.14180-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moumita Dhar <dhar61595@gmail.com>

The previous function regex required explicit matching of function
bodies using `{`, `(`, `((`, or `[[`, which caused several issues:

- It failed to capture valid functions where `{` was on the next line
  due to line continuation (`\`).
- It did not recognize functions with single  command body, such as
  `x () echo hello`.

Replacing the function body matching logic with `.*$`, ensures
that everything on the function definition line is captured.

Additionally, the word regex is refined to better recognize shell
syntax, including additional parameter expansion operators and
command-line options.

Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
---
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

diff --git a/t/t4018/bash-bashism-style-multiline-function b/t/t4018/bash-bashism-style-multiline-function
new file mode 100644
index 0000000000..284d50dd99
--- /dev/null
+++ b/t/t4018/bash-bashism-style-multiline-function
@@ -0,0 +1,4 @@
+function RIGHT \
+{    
+    echo 'ChangeMe'
+}
diff --git a/t/t4018/bash-hunk-header-complete-line-capture b/t/t4018/bash-hunk-header-complete-line-capture
new file mode 100644
index 0000000000..818c8c5a5f
--- /dev/null
+++ b/t/t4018/bash-hunk-header-complete-line-capture
@@ -0,0 +1,4 @@
+func() { # RIGHT
+
+    ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/bash-posix-style-multiline-function b/t/t4018/bash-posix-style-multiline-function
new file mode 100644
index 0000000000..cc8727cbcd
--- /dev/null
+++ b/t/t4018/bash-posix-style-multiline-function
@@ -0,0 +1,4 @@
+RIGHT() \
+{
+    ChangeMe
+}
diff --git a/t/t4018/bash-posix-style-single-command-function b/t/t4018/bash-posix-style-single-command-function
new file mode 100644
index 0000000000..398ae1c5d2
--- /dev/null
+++ b/t/t4018/bash-posix-style-single-command-function
@@ -0,0 +1,3 @@
+RIGHT() echo "hello"
+
+    ChangeMe
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f51d3557f1..0be647c2fb 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -320,6 +320,7 @@ test_expect_success 'unset default driver' '
 
 test_language_driver ada
 test_language_driver bibtex
+test_language_driver bash
 test_language_driver cpp
 test_language_driver csharp
 test_language_driver css
diff --git a/t/t4034/bash/expect b/t/t4034/bash/expect
new file mode 100644
index 0000000000..17755e455f
--- /dev/null
+++ b/t/t4034/bash/expect
@@ -0,0 +1,38 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 09ac008..60ba6a2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,33 +1,33 @@<RESET>
+<RED>my_var<RESET><GREEN>new_var<RESET>=10
+x=<RED>123<RESET><GREEN>456<RESET>
+y=<RED>3.14<RESET><GREEN>2.71<RESET>
+z=<RED>.5<RESET><GREEN>.75<RESET>
+echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
+${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
+((a<RED>+<RESET><GREEN>+=<RESET>b))
+((a<RED>*<RESET><GREEN>*=<RESET>b))
+((a<RED>/<RESET><GREEN>/=<RESET>b))
+((a<RED>%<RESET><GREEN>%=<RESET>b))
+((a<RED>|<RESET><GREEN>|=<RESET>b))
+((a<RED>^<RESET><GREEN>^=<RESET>b))
+((a<RED>=<RESET><GREEN>==<RESET>b))
+((a<RED>!<RESET><GREEN>!=<RESET>b))
+((a<RED><<RESET><GREEN><=<RESET>b))
+((a<RED>><RESET><GREEN>>=<RESET>b))
+$((a<RED><<RESET><GREEN><<<RESET>b))
+$((a<RED>><RESET><GREEN>>><RESET>b))
+$((a<RED>&<RESET><GREEN>&&<RESET>b))
+$((a<RED>|<RESET><GREEN>||<RESET>b))
+${a<RED>:<RESET><GREEN>:-<RESET>b}
+${a<RED>:<RESET><GREEN>:=<RESET>b}
+${a<RED>:<RESET><GREEN>:+<RESET>b}
+${a<RED>:<RESET><GREEN>:?<RESET>b}
+${a<RED>#<RESET><GREEN>##<RESET>*/}
+${a<RED>%<RESET><GREEN>%%<RESET>.*}
+${a<RED>^<RESET><GREEN>^^<RESET>}
+${a<RED>,<RESET><GREEN>,,<RESET>}
+${<GREEN>!<RESET>a}
+${a[<RED>*<RESET><GREEN>@<RESET>]}
+${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}
+ls <RED>-a<RESET><GREEN>-x<RESET>
+ls <RED>--a<RESET><GREEN>--x<RESET>
diff --git a/t/t4034/bash/post b/t/t4034/bash/post
new file mode 100644
index 0000000000..669e218c30
--- /dev/null
+++ b/t/t4034/bash/post
@@ -0,0 +1,33 @@
+new_var=10
+x=456
+y=2.71
+z=.75
+echo $USERNAME
+${HOMEDIR}
+((a+=b))
+((a*=b))
+((a/=b))
+((a%=b))
+((a|=b))
+((a^=b))
+((a==b))
+((a!=b))
+((a<=b))
+((a>=b))
+$((a<<b))
+$((a>>b))
+$((a&&b))
+$((a||b))
+${a:-b}
+${a:=b}
+${a:+b}
+${a:?b}
+${a##*/}
+${a%%.*}
+${a^^}
+${a,,}
+${!a}
+${a[@]}
+${a:4:6}
+ls -x
+ls --x
diff --git a/t/t4034/bash/pre b/t/t4034/bash/pre
new file mode 100644
index 0000000000..ada8470bac
--- /dev/null
+++ b/t/t4034/bash/pre
@@ -0,0 +1,33 @@
+my_var=10
+x=123
+y=3.14
+z=.5
+echo $USER
+${HOME}
+((a+b))
+((a*b))
+((a/b))
+((a%b))
+((a|b))
+((a^b))
+((a=b))
+((a!b))
+((a<b))
+((a>b))
+$((a<b))
+$((a>b))
+$((a&b))
+$((a|b))
+${a:b}
+${a:b}
+${a:b}
+${a:b}
+${a#*/}
+${a%.*}
+${a^}
+${a,}
+${a}
+${a[*]}
+${a:2:3}
+ls -a
+ls --a
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..655c8fe0b1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -59,20 +59,32 @@ PATTERNS("bash",
 	 "("
 	 "("
 	     /* POSIX identifier with mandatory parentheses */
-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
+	     "([a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
 	 "|"
 	     /* Bashism identifier with optional parentheses */
-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
+	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+)))"
 	 ")"
-	 /* Optional whitespace */
-	 "[ \t]*"
-	 /* Compound command starting with `{`, `(`, `((` or `[[` */
-	 "(\\{|\\(\\(?|\\[\\[)"
+	 /* Everything after the function header is captured  */
+	 ".*$"
 	 /* End of captured text */
 	 ")",
 	 /* -- */
-	 /* Characters not in the default $IFS value */
-	 "[^ \t]+"),
+	 /* Identifiers: variable and function names */
+	  "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* Numeric constants: integers and decimals */
+	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
+	 /* Shell variables: $VAR, ${VAR} */
+	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
+	  /* Logical and comparison operators */
+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
+	 /* Assignment and arithmetic operators */
+	 "|[-+*/%&|^!=<>]=?"
+	 /* Additional parameter expansion operators */
+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
+	 /* Command-line options (to avoid splitting -option) */
+	 "|--?[a-zA-Z0-9_-]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

