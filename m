Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D17208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 08:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHGKfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:35:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40523 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeHGKfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:35:16 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so13305936iob.7
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KehitOlzByqjqpN85DS011QTyeoh0louOB+p0nbJpXQ=;
        b=aPTI9IvOO8p3q/LI62H8YQkAYoRj5zo/OgUtlHqzHlHdYWMNR0H8Y2uE/p19GhencL
         RySRG0KPykR9iT/QW1zCFnrL7X8eJmCLlisVe0tfqt5oEIZrVGIh8Alc/2aJ/CiazZxj
         GZRp8NaiZdCww3bfSq3tOW14HRYJKZW/KqQDXKKc/FNK9laSbnCDLgLWirGbz+bBGuYV
         4ROnuLDs6Wp09z6p3YaB5UJWKAvStIOg9ZJiLNEg7k1rVLluM6oBa4vSSGoSgIpLL0mI
         oIQwgvW41kfLiLFNo12pqDYT/vwIr6zPTCmHZxWxljsBD9wn6qBGi3FaabPXlh76qXG0
         DxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KehitOlzByqjqpN85DS011QTyeoh0louOB+p0nbJpXQ=;
        b=I7GkcZduuxH7oU3OWKDjuQcogwS/98drqaF3LLcCYLUVRd+qflJmR0tHGjHt/x56MW
         x0IggQg4jRGaXPHZOKVdwETcipN1vEjmlh3/fzfTGnL8a9MlTT8hwnGR8RXTVwpGqhJr
         ZyqlgcvloTJrMfH9VaCa46IRs/QSZjNu5V+10cNnoOahddSflXSqImOebdS0VfQP3tRI
         AeaSnlgliGEHMmZ1QXaKfybfJnj7LdsVfxc+uK8qFlgP9YtGF61hdQdnwKoKvOt7lOYS
         1IYc3c3Ix8bKCHJQcby+gyP8ZYnTIuainPYArllqbNbYOBQ4TFe91EXfDfiTrKch2gby
         7k4A==
X-Gm-Message-State: AOUpUlFoQP9WyLwSbJ35uAqCNcV2rszKTV2BqFa6EDShGoShTvzM+N0c
        9zBN8Lo0Ac0p4huNHgvRQJ3NXAR6
X-Google-Smtp-Source: AAOMgpeM3gf22ErKupAWEEH+uXx64bD3VszOF2+hVxCfoZygCvH3OaDmBGwAmK7AWk4SQ46sAWLHkA==
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr18458900iov.56.1533630123598;
        Tue, 07 Aug 2018 01:22:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e19-v6sm210792ioc.46.2018.08.07.01.22.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 01:22:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/5] chainlint: let here-doc and multi-line string commence on same line
Date:   Tue,  7 Aug 2018 04:21:33 -0400
Message-Id: <20180807082135.60913-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After swallowing a here-doc, chainlint.sed assumes that no other
processing needs to be done on the line aside from checking for &&-chain
breakage; likewise, after folding a multi-line quoted string. However,
it's conceivable (even if unlikely in practice) that both a here-doc and
a multi-line quoted string might commence on the same line:

    cat <<\EOF && echo "foo
    bar"
    data
    EOF

Support this case by sending the line (after swallowing and folding)
through the normal processing sequence rather than jumping directly to
the check for broken &&-chain.

This change also allows other somewhat pathological cases to be handled,
such as closing a subshell on the same line starting a here-doc:

    (
        cat <<-\INPUT)
        data
        INPUT

or, for instance, opening a multi-line $(...) expression on the same
line starting a here-doc:

    x=$(cat <<-\END &&
        data
        END
        echo "x")

among others.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                      | 7 ++++---
 t/chainlint/here-doc-close-subshell.expect           | 2 ++
 t/chainlint/here-doc-close-subshell.test             | 5 +++++
 t/chainlint/here-doc-multi-line-command-subst.expect | 5 +++++
 t/chainlint/here-doc-multi-line-command-subst.test   | 9 +++++++++
 t/chainlint/here-doc-multi-line-string.expect        | 4 ++++
 t/chainlint/here-doc-multi-line-string.test          | 8 ++++++++
 7 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 t/chainlint/here-doc-close-subshell.expect
 create mode 100644 t/chainlint/here-doc-close-subshell.test
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.expect
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.test
 create mode 100644 t/chainlint/here-doc-multi-line-string.expect
 create mode 100644 t/chainlint/here-doc-multi-line-string.test

diff --git a/t/chainlint.sed b/t/chainlint.sed
index a0726d3e7d..6c891bf383 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -157,6 +157,7 @@ s/.*\n//
 /^[^']*'[^']*$/{
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
+:folded
 # here-doc -- swallow it
 /<<[ 	]*[-\\]*[A-Z0-9_][A-Z0-9_]*/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
@@ -255,7 +256,7 @@ s/"//g
 N
 s/\n//
 /"/!bdqstring
-bcheckchain
+bfolded
 
 # found multi-line single-quoted string '...\n...' -- slurp until end of string
 :sqstring
@@ -263,7 +264,7 @@ s/'//g
 N
 s/\n//
 /'/!bsqstring
-bcheckchain
+bfolded
 
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
@@ -278,7 +279,7 @@ N
 }
 s/^<[^>]*>//
 s/\n.*$//
-bcheckchain
+bfolded
 
 # found "case ... in" -- pass through untouched
 :case
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
new file mode 100644
index 0000000000..f011e335e5
--- /dev/null
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -0,0 +1,2 @@
+(
+>	cat)
diff --git a/t/chainlint/here-doc-close-subshell.test b/t/chainlint/here-doc-close-subshell.test
new file mode 100644
index 0000000000..b857ff5467
--- /dev/null
+++ b/t/chainlint/here-doc-close-subshell.test
@@ -0,0 +1,5 @@
+(
+# LINT: line contains here-doc and closes nested subshell
+	cat <<-\INPUT)
+	fizz
+	INPUT
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
new file mode 100644
index 0000000000..e5fb752d2f
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -0,0 +1,5 @@
+(
+	x=$(bobble &&
+?!AMP?!>>		wiffle)
+	echo $x
+>)
diff --git a/t/chainlint/here-doc-multi-line-command-subst.test b/t/chainlint/here-doc-multi-line-command-subst.test
new file mode 100644
index 0000000000..899bc5de8b
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-command-subst.test
@@ -0,0 +1,9 @@
+(
+# LINT: line contains here-doc and opens multi-line $(...)
+	x=$(bobble <<-\END &&
+		fossil
+		vegetable
+		END
+		wiffle)
+	echo $x
+)
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
new file mode 100644
index 0000000000..1e5b724b9d
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -0,0 +1,4 @@
+(
+?!AMP?!	cat && echo multi-line	string"
+	bap
+>)
diff --git a/t/chainlint/here-doc-multi-line-string.test b/t/chainlint/here-doc-multi-line-string.test
new file mode 100644
index 0000000000..a53edbcc8d
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-string.test
@@ -0,0 +1,8 @@
+(
+# LINT: line contains here-doc and opens multi-line string
+	cat <<-\TXT && echo "multi-line
+	string"
+	fizzle
+	TXT
+	bap
+)
-- 
2.18.0.758.g1932418f46

