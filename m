Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F18286A1
	for <git@vger.kernel.org>; Sun, 11 May 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972775; cv=none; b=MSnhRKh8bNWJtxhFfQgllRavUJzK1hKpWWvSDG6qULkCTfMP+07Oo3/0Uo0JdUM0THQ2wqGmW5jALXhz0zlRNpTKXTRfyiLJdPxIeCmqbjduwokuYYaMHem5IzswL/F1E8he44/TB0IU991XCevRZp0TxQLz8UugUEiOSsyTbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972775; c=relaxed/simple;
	bh=1vayY5IMX1K93Qhpj0/WkZtjAP0PU0Ii5ZHULZH5QlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNQyMHtoO8/hINZVohJmF/loBpVPKnjp/MFu2cRk+3IbFlJQJAAEbxLYRD7KmDPfQJTpCHL1yMuLRaT0Mc24vTP7PoLkwYs0anW5ibfJf9cL/mAVxIHqNFr6nOUnMb9KDd2N4q9OlH3NBhI3UPkskg8cJPHtOEEFpBSeYHU0thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkIksBpr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkIksBpr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af908bb32fdso2821108a12.1
        for <git@vger.kernel.org>; Sun, 11 May 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746972773; x=1747577573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+ddIiCK5xdrCVhEv2ElL79c8fFewZKA9JAScHoGP7s=;
        b=VkIksBprxtB/tvdGCPrW+Z0QS0zZNk3IDCAduCvhEO1cMoVXkE4zz7UyZoE5lEftx9
         /ExKZdWax8BYuWRs6Ze2OWpZKf3Q03wBdywiyv+bOqnyKnm1WIZmHOJ0xTG/a/aT44zO
         HqGpRikOOYKPAfE4FE6cAC/7/U01HSjVMnjG29ck5+Ui5ZPA56TicIKBM5vzGGgHpd+2
         S7H4qj+tPPOfsX2sPxB4RTlwzcUoUb7ZgCpn6k2F/7RhW9OZOjaVAAzRD4pXr0Pp3w7h
         9G9jVjtcrwaKhnbDogagIsMIEfGRsr3NhRxw1u7JEvqZ/9HKx4SAVkPvfqrU2Iq8KfkE
         jDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746972773; x=1747577573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+ddIiCK5xdrCVhEv2ElL79c8fFewZKA9JAScHoGP7s=;
        b=JU1Zb4BArYun6hwtyli7vLewhdKtv85m9qK4mk0wK9/4OQqET9W9TPPArS+xBIN2Vb
         RI1D5U3Hq4qABb1kgb6rYuTShihEl9rMDuLvSgZAUmvfSjQVUUWtCd9JqWBz8uGvZfOM
         5+u86DrBnyLq5uk9ZhdcIAPGrzbUMqCyXIk2NLBPeRFm6uEeZH1W4snPeyVdCO5evXTp
         q6qy8Csdg6Kh2Lgu/x8R2iVjwK9vkWnzdWXUCEvzg6OFSTL5NKCQFLmxYOnVepcbGTaw
         PN3oTB4cJtcs05Q+qbj83tM20j1NjFpO36JlDPpWXytWp2C5ndQulQE57LVYgl9yCPOO
         +BDA==
X-Gm-Message-State: AOJu0YzkdOgu83F6tnDfXrCHkWfiQDLFsf/yejqqQjOv6D+Dbn4YabK3
	n4rJCiTBNAzNq1Vfe43eX8Ri1wd2Z9eIJfqTzZZpN2FRn9bC9A0KaeNRbQ==
X-Gm-Gg: ASbGncsLtsb7jeT4Hw63ZYoRMJpn741K0Fc/k3p/0Xp2A1GGGKRTIR9yMPpJ1jSlMdm
	F8dTUyRIP0ALqtBSqk2cq0HBvtuQpgIDO7t8MLBNnRc4sJCaQWdbFZXEbahW7ssPO3L15oVTn/s
	Ppdm2/VK5PYB2Sy10U2vP6sE/s4bik5wCbWWGxhfirz9+dOiMhNgB8yrxCjNtz1/QI+2qSn/IHa
	o3NOSY/X45YjtTly9nzEZFH4J5wLi0BoHn9N3PwZAiVMdsN/XWxHew8oLmr+X91cl/fihfTZJ/9
	GCv0TG6Kh1bKmRlJHbg+80yI4nbGSUTv5ke7c7z4Zrnn3U3p6QHdqvRfsZS5VtSx+Q==
X-Google-Smtp-Source: AGHT+IGH6iTbDNtkU69Oqfun+M3FFtikfANAzmaPsImyTJ9GLYxohyaPaLkmJUG1wqyZ+FJlDrGpHA==
X-Received: by 2002:a17:902:d505:b0:223:807f:7f92 with SMTP id d9443c01a7336-22e847ad1fdmr197877495ad.20.1746972772961;
        Sun, 11 May 2025 07:12:52 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fc1sm46688675ad.46.2025.05.11.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:12:52 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v6 0/1] Added the newline after the test in t/4018
Date: Sun, 11 May 2025 19:41:00 +0530
Message-ID: <20250511141101.18450-1-dhar61595@gmail.com>
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

Sorry I forgot to add the newline after the test in t/4018 again so I had to send the patch again.

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

