Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAA1C5F39
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743342118; cv=none; b=mMXjdbSzyEnKQXZNjloBiShGQeabpzS6Gkepx0vl5hIFKFbLkIPTzubiMIhWGokJcmp8YHjYZ730VSMUdmb9MMuLaSORzhKetVyJ584NibhyUMyXxI3gTOIUY0+9szvG5g2frPCu4kQ98YiToH3p2wqTGrLyILxvKSffHX0ho+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743342118; c=relaxed/simple;
	bh=HFbUbl1CXyebgJhz90hPL/2JlYoQ06/O8La2q3A/a2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyb5Lcb0nWn2YmzXGtTsVvKtbTHLIu+FkJ9vvwmn552taANAl5WD7oFyuSHr4efRbbzJqeuCEl2eW7N4RpW8Pdrboo/EyVnyy991Rq29RdK1iuDgPt2+fC9dKLkU6tYCo+xGt4/SG8/YPZ0021Ma+iBf3SCXxw4CJoajIcBSrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4HHVMNF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4HHVMNF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so79532025ad.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743342115; x=1743946915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no2dyp4xSWJik0abe1HZG/nao9aHWbw345eONzODZZ4=;
        b=E4HHVMNFTzJFpZt0k0eobQaPqUjs0JWaUJ1L69NX0MSYVwVBpFkpcRNPciQ+xCeRCY
         qJH2mR5SKyvhnJ2xSWcBVy6AdfPMfoVmkuBseH1I3G2CDJm0MpfXmdZBcliapGxscQ+y
         sqxMGEO1Yejjtrej0Jb6cFPVtK5Yz0msy+LWjA1KzHXMQX1IZP3B9v2qmf1JGWL9Nr3b
         fN3ujc/bbhRt31lU+XwOhrlAgPxDJ261vDzU6WpQdWZItzGPO5m0482BqoqfJ+4KqPXg
         q7Li6EYciSuDTL1tjCQworYnTTKuzmYAPK1EhrFXnwSYsPv50wVS0xm7Kr/IAVshvpX3
         0TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743342115; x=1743946915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no2dyp4xSWJik0abe1HZG/nao9aHWbw345eONzODZZ4=;
        b=Cz9Dxjdludpi9VZp9CALLR+mxSl3oBxbW98et+7SNTdN1261oP4vq+YZNyU9xmWtkJ
         MYS8rddDxCP0HZ+qB0i4tLvTBov0SyhrUJU6eV061EdQqtuNfSPk5TStsv7XwinC2vBP
         BgiDtIOC0zk/SrDa34z+DQYnuxob1TjEKPAj3/s4nPTN1A8KzNGL6LmNuolhzf4qKYGR
         64v2Yl38zL0p93SqA/efQzlxVmhV4jK7qI6+cWAlWpUsqnJPAi/CHz3wKs2kTfVtB4yM
         AsGgf/cZU/XJMr+K+PpUQ+df9Xa2k6vb1XQavOCuOURVeoVIFOtiTKkrQtx5NE2y7sgF
         R+bA==
X-Gm-Message-State: AOJu0Yzd8uZbusMdzrVMeKQ6DZ8NDUJH9LClsZJXNQi6swKxnvQeH5OZ
	Ibcto+LZxab+zVjv7cmOD34ZUXRojC82TopVCAKqVYKDy/EfzYuJ1OyCVw==
X-Gm-Gg: ASbGncuVdbtyHxeT61GyaQp4KBjvBsblYXyz3nroEd+Gbvl1YbvGmdFeyBnvp3Fkl1g
	w7QAz0v/2HzY/duLoLba0qhqKQ7wVAZtsoho22IAUNa1JLmR6SMYZb8MJeQtoMCQpPlaOc1340n
	ha6RS4KRFCcGYqkQWiPVh39WSAil9V9i1P68Cc8fFXJCuyeflih6tI+GFXkfbGlSGPLdWDROxOB
	t4DuLhLEbhqQ0ybtKjDOcPmPB2fVya5vwMRQmsHvEUOwE39/k77Zet79jfgsDjGmbx6nWAcXOOh
	y7i+AGUv6w1rL3NdB1DEEpE9WywYVOx9pP7L0s7FLIt6NUolCjxuIfjgWuKMLv9e1FU=
X-Google-Smtp-Source: AGHT+IF3GGfggqVzEQOGMqdpQ0VqCWmjy8Vyymsft73K7bEZbzeHqgJyPj8mGfGBhupOTiXhJw2xpg==
X-Received: by 2002:a17:902:d507:b0:216:794f:6d7d with SMTP id d9443c01a7336-2292fa058c5mr104130145ad.48.1743342115368;
        Sun, 30 Mar 2025 06:41:55 -0700 (PDT)
Received: from localhost.localdomain ([171.60.225.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d5786dsm5996620a91.11.2025.03.30.06.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:41:54 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Atharva Raykar" <raykar.ath@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v4 1/1][GSOC] userdiff: extend Bash pattern to cover more shell function forms
Date: Sun, 30 Mar 2025 19:09:57 +0530
Message-ID: <20250330134018.9662-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250330134018.9662-1-dhar61595@gmail.com>
References: <20250328200525.4437-1-dhar61595@gmail.com>
 <20250330134018.9662-1-dhar61595@gmail.com>
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
that everything on the function definition line is captured,
aligning with other userdiff drivers and improving hunk headers in
`git diff`.

Additionally, the word regex is refined to better recognize shell
syntax, including additional parameter expansion operators and
command-line options, improving syntax-aware diffs.

Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
---
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
index 0000000000..a0f7cbd5a3
--- /dev/null
+++ b/t/t4034/bash/expect
@@ -0,0 +1,30 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 09ac008..60ba6a2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,25 +1,25 @@<RESET>
+<RED>my_var<RESET><GREEN>new_var<RESET>=10
+x=<RED>123<RESET><GREEN>456<RESET>
+y=<RED>3.14<RESET><GREEN>2.71<RESET>
+z=<RED>.5<RESET><GREEN>.75<RESET>
+echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
+${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
+if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
+((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
+((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
+${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>##*/}
+${<RED>a<RESET><GREEN>x<RESET>%.*}
+${<RED>a<RESET><GREEN>x<RESET>%%.*}
+${<RED>a<RESET><GREEN>x<RESET>^^}
+${<RED>a<RESET><GREEN>x<RESET>,}
+${<RED>a<RESET><GREEN>x<RESET>,,}
+${!<RED>a<RESET><GREEN>x<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>[@]}
+${<RED>a<RESET><GREEN>x<RESET>:?error message}
+${<RED>a<RESET><GREEN>x<RESET>:2:3}
+ls <RED>-a<RESET><GREEN>-x<RESET>
+ls <RED>--a<RESET><GREEN>--x<RESET>
diff --git a/t/t4034/bash/post b/t/t4034/bash/post
new file mode 100644
index 0000000000..60ba6a2e75
--- /dev/null
+++ b/t/t4034/bash/post
@@ -0,0 +1,25 @@
+new_var=10
+x=456
+y=2.71
+z=.75
+echo $USERNAME
+${HOMEDIR}
+if [ "$x" == "$y" ] || [ "$x" != "$y" ]; then echo "OK"; fi
+((x+=y))
+((x-=y))
+$((x<<y))
+$((x>>y))
+${x:-y}
+${x:=y}
+${x##*/}
+${x%.*}
+${x%%.*}
+${x^^}
+${x,}
+${x,,}
+${!x}
+${x[@]}
+${x:?error message}
+${x:2:3}
+ls -x
+ls --x
diff --git a/t/t4034/bash/pre b/t/t4034/bash/pre
new file mode 100644
index 0000000000..09ac008a83
--- /dev/null
+++ b/t/t4034/bash/pre
@@ -0,0 +1,25 @@
+my_var=10
+x=123
+y=3.14
+z=.5
+echo $USER
+${HOME}
+if [ "$a" == "$b" ] || [ "$c" != "$d" ]; then echo "OK"; fi
+((a+=b))
+((a-=b))
+$((a << b))
+$((a >> b))
+${a:-b}
+${a:=b}
+${a##*/}
+${a%.*}
+${a%%.*}
+${a^^}
+${a,}
+${a,,}
+${!a}
+${a[@]}
+${a:?error message}
+${a:2:3}
+ls -a
+ls --a
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..4c77c7e0f6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -64,15 +64,27 @@ PATTERNS("bash",
 	     /* Bashism identifier with optional parentheses */
 	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
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
+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
+	 /* Command-line options (to avoid splitting -option) */
+	 "|--?[a-zA-Z0-9_-]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

