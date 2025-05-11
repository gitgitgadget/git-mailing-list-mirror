Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CF286A1
	for <git@vger.kernel.org>; Sun, 11 May 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972793; cv=none; b=qd8FFqoqJecojbyNQdrMkubkxGBWe24uRdU9kGICJ3eP4sSe6POzgwS9ALK7CfE5wL/S64YIgQZ+NgUcwinfUnNYYasmnB/Dp5pqpwl7Q/uI5kv38kr2+cG99nWKTx0l82+2V1kaa/5t/BuMdUciDn4R1XE4vHBWpRCQPKrkrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972793; c=relaxed/simple;
	bh=RzDL/rn2UJDRrGL878Qz33zU2qyA7eUBkN5SudXdnoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWNCEx6P56jG6JIqJ8u0kGbwTLws3HgBr6I+wXBGqUzJbke9P+k0DnAVMnY9N3Yh511XGUoYwwODusedAJSHWTzEwPn3EaSdhNJWk4p98bBx/MelvcpFAdA1Wr7lqQZ0UvGH2AIT6n+ZIYn7iIu7uz4ntQ6Q5PZoLDQAupAIbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHGzYeVV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHGzYeVV"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b200047a6a5so2602385a12.0
        for <git@vger.kernel.org>; Sun, 11 May 2025 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746972790; x=1747577590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv886oZD725UASZkwqlMcuqO6OlgVQEGpaEOSLzqBFk=;
        b=BHGzYeVVN79P36lnW7vhmfrg2PepqxygNflzuKpWH6qL7fVLwSYWYQ9BHCcd80h/JH
         LI9fNUpeHcp44BdrCfjOUxCEuHpi76HX09983X8n5JnYOklWMh9JKNjmAjGBXcoXg9rB
         wAGpyqnpRKku6jVHFTCKwBdDU/zYGAfnU+mm6gSqmtt22VNsk1QtN4kd4oqlDXXvOuPP
         Ewd9W86TXM4PKLh3slrM0b5NU8Ggviulo7gTkBwg/GyR1W1Ocd6NBVyf9eErwvtYIARK
         DmMSPNqf0SXDdvQN2X1mbAqJNvAZilFY297PI9Oa0aAwqDe1agh8zzdCrOAknNUBTilb
         /7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746972790; x=1747577590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv886oZD725UASZkwqlMcuqO6OlgVQEGpaEOSLzqBFk=;
        b=ZM1g92gNEJISo89U1SwHBnoYeAyCaNQsMPVbapUREGr3Tk01Ez9/iVhljSNa2Eam6V
         n44D+Vma/lED6jB5G2SR5rk/WVrrWhYBFtKX2WSchQ/dHlfUpM9wYEIaLFvcP16budZs
         O5ui7i9N6pREV5bWTh1ftnt4iyrxSjp9rK+ge76n2lsR6UIKRYf4zFzAgBXOw/kD0MRg
         7yoJi3hsQ6RX1B7ETyuRZrlnT24zDBfG+fv5ohfi0Ie+J2DTYE8JPjrdrzJzLs/ifj1i
         xt5wbmYOSgMkX/l+NmDs21aYrxnCYrTe7YoLbSz69oy5VgacZSuGWs//p8ppuvS4Glsw
         1BQA==
X-Gm-Message-State: AOJu0Yx9RjQvFAoKqEuSTTTj3eFdn6iquyA6g2AulZjc7kV8xvZ0fwNr
	aMQEKrnnv1WmAp6XlyHUBKyhiRyzfqkPsBlMrD/rYJhX2+ASqRfUE2XjLw==
X-Gm-Gg: ASbGncsiBnVBHvyQmJIepbYx7EVrYyKUTL5Pd/37YBKBGxll0KUPceyP+y7LNdqqTQd
	nzBrhK/XvKFKcA8hjoQJtO6HlsnCK6GCNO6Ee1G9gqRxrVU/2wQMi1JpU1EuwY7tifU5gKfBndC
	Mpggl7JhqNxlffJwtX1zIJI3PSAQ6Axln8rMAc9e07eLl21ueWeoT9Ys2C2+X+u0Ho941Z15BXz
	UPqJniha4Cs0WNyccObgrdtgGmarcQ40k965wvWqO6YVwvlEFNQkZnEIaKzYpX5shlOKWGueoKB
	vkGH5dYItFxDihVxOVcLmS9y2KSBPbFwAXvFdN87pLb3/LlGj23iL32BQW4h9UfHcw==
X-Google-Smtp-Source: AGHT+IHrGFl7VifM43/Okd71qsyc9Wxf4OzAJWFiT0ENZ+GHvhyYgWywtw+RIRpKd3JhrDhmVNF+hQ==
X-Received: by 2002:a17:902:d4c3:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22e8475b0b8mr231671065ad.14.1746972790427;
        Sun, 11 May 2025 07:13:10 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fc1sm46688675ad.46.2025.05.11.07.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:13:10 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more shell function forms
Date: Sun, 11 May 2025 19:41:01 +0530
Message-ID: <20250511141101.18450-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511141101.18450-1-dhar61595@gmail.com>
References: <20250511125809.14180-1-dhar61595@gmail.com>
 <20250511141101.18450-1-dhar61595@gmail.com>
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
index 0000000000..b56942f322
--- /dev/null
+++ b/t/t4018/bash-hunk-header-complete-line-capture
@@ -0,0 +1,4 @@
+func() { # RIGHT
+
+    ChangeMe
+}
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

