Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146D3A1B6
	for <git@vger.kernel.org>; Sun, 11 May 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970139; cv=none; b=by7ZfeJqwAe3cpB+uXW73C9RmoybXgsxzqJ+FiED4Cl552R440MmLx67vBuOWPoeoiMRUh3VFicPSTJP1nBUD/m55qzXc+3pOLK3AWATdwpD33oInFVBPGgqGYksJUv6tQCk65QcIj0PJoTBwwDJTtm32gNtKWDDqQBUyk3k9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970139; c=relaxed/simple;
	bh=irGi4QySuwhHqzNaYOsxse6lBC2Gqe4oGXPvTP3nHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvRCLvCU2eNlGIpSC7jCd5MxpfNXCrEGuGz87I2No/IzgNWwx9hXex8Rc2FYoEDahvoCsNg5xohgpuOhTP3+1xdG5MZ4Z3Po5zswOX4AO9/SuihpB9293k8+d/3wL5IFKJr8ElO+xPnYZEizAjIp6SDGBxwDzGob1zfcQdGzTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1aPKoIX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1aPKoIX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74019695377so2619624b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746970137; x=1747574937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMrOYLawAKnECrlVscLaQGSIhi4mdVNCj7pUrql6tZk=;
        b=f1aPKoIX+layR3QbT3wd7V/v91oPPbH4/NmP7AAogwjePUk12+wXquWmDXzMu10jB4
         vAEeowtVlEwwDyFg2GGzgT6YYI8iJcK2e3pHrirEUQ+A77gkyibNyaOk5EKPviGdOuUt
         zXhj3Hmty380QygMvutzLI61ocoPAIgXZdGoCHpAlCBktEKJJWETryuD2U0NM97hkscQ
         MHLKU+n5lEyfjSyD5KvHWo/RU/yZr9N4rw6O9aqfHlOB/mL6JCrNXnLDeK29ER3KpHgK
         R7unPchD3uUUcDwmnJwK8Cih2/dRHAswdRj5mtiMYWHZUngNBT45kvFsw1nYch97zSV1
         3yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746970137; x=1747574937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMrOYLawAKnECrlVscLaQGSIhi4mdVNCj7pUrql6tZk=;
        b=rVXrxcdB5XNLbIy0YKfht0F04sxEgkuVtcyt6DXmpgCBtRDZXc1oU5cuXs/Zm7BW+0
         gbQ6QmfHsvbZd1bPa5DFV0T9uKFDkn7ujuGxOIiWWvM3UUYGXWpoX/HndaIVBwnDTFie
         4O9nT6qBpoMDvZBXm9QNIBgI/AndD6wGJrkRvDJdrA6ERVOlwAofaE85ijVaQRxs5JXN
         gZmXEWsufgV3QoM7VwI+2rEh6i5ZWt5ee5Xx4rFlfjPsN78li0o3fK6arjOLZ66xRyfc
         W8pIP4CyWqRIRwAWEkqHm5kUXsXmI1u0BmG3WhK+R8/7SslzKUfWbMByU0Yn6rtqAnZG
         8oew==
X-Gm-Message-State: AOJu0YwOAT3t6EI+l3dhhMoeO1gs8Zzz1tcXBpC0vZOK+D6i3BOAPv4Q
	1Q955aDCpSbl2te6SDj26NU/HXmMQvE/ZpJhDyYz6XWp4YrOFuVvbxH9pQ==
X-Gm-Gg: ASbGncvA2S+gVZrsUwaSpXEdcEyFApIc5j+I4MN4xsI5EI8XEp9xKKDIfVGQLdPbUNm
	2UrlWGLNKcdLkg38LErGaVfhdgtW+RNoBYPh4Q9UF94l2/I/Pj2SVVs789WjYtaYwNPXYKHJJdT
	cdmkJQeIAjaJ+yh4F8cghAqVc9bMtZBAvgCy2/huzxx+KEly9uEjDigEnRyjjXKwHxd5tvlQE6B
	sN7e9koco+1oCsQPhuXrCRdV6epV8K56HoG7ivx3dURhgFhZib4bDbG/pya5aCmEkacKmknvURa
	Ogx8GIri2onJVaq3wZJ3dtwUKs9Ad0w9/eiWD5XU9LEhzSmHSP4zXl2KMnintNKErA==
X-Google-Smtp-Source: AGHT+IHQ+2LLoogZ3heEWcBBQ2LNqtXc8jRl//DGMho+tUvSpueVDcmaCl29CT9dFlDWVPOrnCvFYg==
X-Received: by 2002:a05:6a20:e188:b0:1f3:194b:30ae with SMTP id adf61e73a8af0-215ababd056mr14071618637.1.1746970136900;
        Sun, 11 May 2025 06:28:56 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb42fsm7778088a91.40.2025.05.11.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:28:56 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: 
Date: Sun, 11 May 2025 18:58:01 +0530
Message-ID: <20250511132802.16338-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511125809.14180-1-dhar61595@gmail.com>
References: <20250511125809.14180-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v6 0/1] Added the newline after the test in t/4018

Sorry , I forgot to add the newline after the test in t/4018 again so I had send the patch agaain.

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

Range-diff against v5:
1:  40cffd3b4a ! 1:  464cb8a1eb userdiff: extend Bash pattern to cover more shell function forms
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
     +function RIGHT \
     +{    
     +    echo 'ChangeMe'
    ++}
    +
    + ## t/t4018/bash-hunk-header-complete-line-capture (new) ##
    +@@
    ++func() { # RIGHT
    ++
    ++    ChangeMe
     +}
     
      ## t/t4018/bash-posix-style-multiline-function (new) ##
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

