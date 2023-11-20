Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHSuYHHo"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2AB13D
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 11:19:23 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso60529771fa.0
        for <git@vger.kernel.org>; Mon, 20 Nov 2023 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507961; x=1701112761; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmlFnBj0HFsqk0XzN1cFxZadVdwnIh5ZdkyvwEBFrCs=;
        b=CHSuYHHonnXkbAE6hKElnx19/K4X0nvmO451KwTUd5wm0CC1rrvaH52Sv5GYRbuQdz
         Ng2ocfETqk6v2fYLhjxiFh2mt5fVZk/2TBGLVj6FEwAJDi+TFPPVRwIpYRYej5EGaeCr
         Xdbqyyca33JcCufBBYEFhpXf+id2O8J84RuRzh2w7RxwHEDnCacV4UqjSiOc2POzZuxP
         0qfdiFuUQPIc3n/PzOAEnLB++UDRG51Hea1EKGOpXMjPKPqGDzQxe5/B0pppdtI1ANt2
         idLNFf+eWTXgnCDjIKJ9QqvvFw4tWAAl2XUXhE68WQmvBzPfxEsA2jVnmBdqNASvbkWX
         Zv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507961; x=1701112761;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmlFnBj0HFsqk0XzN1cFxZadVdwnIh5ZdkyvwEBFrCs=;
        b=PkW69JvhK93af+NvOd9KP43Vnet/7kZ23DwPnL8Atdd2hemFX+P3q4L5eDr8Z/4XEf
         alBFA5mwYTQSNhbdgmdD9szmRfq9uSOqdac8v9LmQyWl06nb9/I6Ud/602qeYPW7Sqhf
         undm6JlFH/IHAgfUb7r5d2juJ8MMyu1BiyftIDMe6kF9w7JzNcIOxa00z9/FBFWnG/5/
         KHUlDX8lhI/djzaQRrToH/pIfLmD9Lk8IasFDAGzxb4rk1iWOb30deHIVMyQkq3rsGVQ
         2fSDgH09+LsMFpXoI8pLDyF87D3a1XBEyhO1fKQDeIGAuHIKaB+46259r8/6otxKJyDX
         Zffw==
X-Gm-Message-State: AOJu0Yy1e0AKQfM+oiqfoEgNn7ehrM1IfZJISFRbhouoryvumXJ61V2t
	c7di7HGhSSuJUX/qJNhfJs+0ILIkDZI=
X-Google-Smtp-Source: AGHT+IGWNb6P0xYnRdh1tQ4DNjcyWZ4kxsAYCzGKWZ5C/h8yczO3NV7VZ5MqEMWX3dLgDpQRw9+gEQ==
X-Received: by 2002:a2e:9157:0:b0:2c0:7d6:570a with SMTP id q23-20020a2e9157000000b002c007d6570amr5682790ljg.33.1700507960359;
        Mon, 20 Nov 2023 11:19:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b0032f7e832cabsm11993367wrx.90.2023.11.20.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:19:05 -0800 (PST)
Message-ID: <pull.1606.v2.git.git.1700507932937.gitgitgadget@gmail.com>
In-Reply-To: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Nov 2023 19:18:52 +0000
Subject: [PATCH v2] merge-file: add --diff-algorithm option
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

This makes it possible to use other diff algorithms than the 'myers'
default algorithm, when using the 'git merge-file' command. This helps
avoid spurious conflicts by selecting a more recent algorithm such as
'histogram', for instance when using 'git merge-file' as part of a custom
merge driver.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    merge-file: add --diff-algorithm option
    
    Changes since v1:
    
     * improve commit message to mention the use case of custom merge
       drivers
     * improve documentation to show available options and recommend
       switching to "histogram"
     * add tests
    
    I have left out:
    
     * switching the default to "histogram", because it should only be done
       in a subsequent release
     * adding a configuration variable to control this option, because I was
       not sure how to call it. Perhaps "merge-file.diffAlgorithm"?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1606%2Fwetneb%2Fmerge_file_configurable_diff_algorithm-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1606/wetneb/merge_file_configurable_diff_algorithm-v2
Pull-Request: https://github.com/git/git/pull/1606

Range-diff vs v1:

 1:  4aa453e30be ! 1:  842b5abf33c merge-file: add --diff-algorithm option
     @@ Commit message
          merge-file: add --diff-algorithm option
      
          This makes it possible to use other diff algorithms than the 'myers'
     -    default algorithm, when using the 'git merge-file' command.
     +    default algorithm, when using the 'git merge-file' command. This helps
     +    avoid spurious conflicts by selecting a more recent algorithm such as
     +    'histogram', for instance when using 'git merge-file' as part of a custom
     +    merge driver.
      
          Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
     +    Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Documentation/git-merge-file.txt ##
      @@ Documentation/git-merge-file.txt: object store and the object ID of its blob is written to standard output.
       	Instead of leaving conflicts in the file, resolve conflicts
       	favouring our (or their or both) side of the lines.
       
     -+--diff-algorithm <algorithm>::
     -+	Use a different diff algorithm while merging, which can help
     ++--diff-algorithm={patience|minimal|histogram|myers}::
     ++	Use a different diff algorithm while merging. The current default is "myers",
     ++	but selecting more recent algorithm such as "histogram" can help
      +	avoid mismerges that occur due to unimportant matching lines
     -+	(such as braces from distinct functions).  See also
     ++	(such as braces from distinct functions). See also
      +	linkgit:git-diff[1] `--diff-algorithm`.
       
       EXAMPLES
     @@ builtin/merge-file.c: int cmd_merge_file(int argc, const char **argv, const char
       		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
       			    N_("for conflicts, use this marker size")),
       		OPT__QUIET(&quiet, N_("do not warn about conflicts")),
     +
     + ## t/t6403-merge-file.sh ##
     +@@ t/t6403-merge-file.sh: test_expect_success 'setup' '
     + 	deduxit me super semitas jusitiae,
     + 	EOF
     + 
     +-	printf "propter nomen suum." >>new4.txt
     ++	printf "propter nomen suum." >>new4.txt &&
     ++
     ++	cat >base.c <<-\EOF &&
     ++	int f(int x, int y)
     ++	{
     ++		if (x == 0)
     ++		{
     ++			return y;
     ++		}
     ++		return x;
     ++	}
     ++
     ++	int g(size_t u)
     ++	{
     ++		while (u < 30)
     ++		{
     ++			u++;
     ++		}
     ++		return u;
     ++	}
     ++	EOF
     ++
     ++	cat >ours.c <<-\EOF &&
     ++	int g(size_t u)
     ++	{
     ++		while (u < 30)
     ++		{
     ++			u++;
     ++		}
     ++		return u;
     ++	}
     ++
     ++	int h(int x, int y, int z)
     ++	{
     ++		if (z == 0)
     ++		{
     ++			return x;
     ++		}
     ++		return y;
     ++	}
     ++	EOF
     ++
     ++	cat >theirs.c <<-\EOF
     ++	int f(int x, int y)
     ++	{
     ++		if (x == 0)
     ++		{
     ++			return y;
     ++		}
     ++		return x;
     ++	}
     ++
     ++	int g(size_t u)
     ++	{
     ++		while (u > 34)
     ++		{
     ++			u--;
     ++		}
     ++		return u;
     ++	}
     ++	EOF
     + '
     + 
     + test_expect_success 'merge with no changes' '
     +@@ t/t6403-merge-file.sh: test_expect_success '--object-id fails without repository' '
     + 	grep "not a git repository" err
     + '
     + 
     ++test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
     ++	cat >expect.c <<-\EOF &&
     ++	int g(size_t u)
     ++	{
     ++		while (u < 30)
     ++		{
     ++			u++;
     ++		}
     ++		return u;
     ++	}
     ++
     ++	int h(int x, int y, int z)
     ++	{
     ++	<<<<<<< ours.c
     ++		if (z == 0)
     ++	||||||| base.c
     ++		while (u < 30)
     ++	=======
     ++		while (u > 34)
     ++	>>>>>>> theirs.c
     ++		{
     ++	<<<<<<< ours.c
     ++			return x;
     ++	||||||| base.c
     ++			u++;
     ++	=======
     ++			u--;
     ++	>>>>>>> theirs.c
     ++		}
     ++		return y;
     ++	}
     ++	EOF
     ++
     ++	test_must_fail git merge-file -p --diff3 --diff-algorithm myers ours.c base.c theirs.c >myers_output.c &&
     ++	test_cmp expect.c myers_output.c
     ++'
     ++
     ++test_expect_success 'merging C files with "histogram" diff algorithm avoids some spurious conflicts' '
     ++	cat >expect.c <<-\EOF &&
     ++	int g(size_t u)
     ++	{
     ++		while (u > 34)
     ++		{
     ++			u--;
     ++		}
     ++		return u;
     ++	}
     ++
     ++	int h(int x, int y, int z)
     ++	{
     ++		if (z == 0)
     ++		{
     ++			return x;
     ++		}
     ++		return y;
     ++	}
     ++	EOF
     ++
     ++	git merge-file -p --diff3 --diff-algorithm histogram ours.c base.c theirs.c >histogram_output.c &&
     ++	test_cmp expect.c histogram_output.c
     ++'
     ++
     + test_done


 Documentation/git-merge-file.txt |   6 ++
 builtin/merge-file.c             |  28 +++++++
 t/t6403-merge-file.sh            | 124 ++++++++++++++++++++++++++++++-
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 6a081eacb72..71915a00fa4 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -92,6 +92,12 @@ object store and the object ID of its blob is written to standard output.
 	Instead of leaving conflicts in the file, resolve conflicts
 	favouring our (or their or both) side of the lines.
 
+--diff-algorithm={patience|minimal|histogram|myers}::
+	Use a different diff algorithm while merging. The current default is "myers",
+	but selecting more recent algorithm such as "histogram" can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions). See also
+	linkgit:git-diff[1] `--diff-algorithm`.
 
 EXAMPLES
 --------
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 832c93d8d54..1f987334a31 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "abspath.h"
+#include "diff.h"
 #include "hex.h"
 #include "object-name.h"
 #include "object-store.h"
@@ -28,6 +29,30 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int set_diff_algorithm(xpparam_t *xpp,
+			      const char *alg)
+{
+	long diff_algorithm = parse_algorithm_value(alg);
+	if (diff_algorithm < 0)
+		return -1;
+	xpp->flags = (xpp->flags & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
+	return 0;
+}
+
+static int diff_algorithm_cb(const struct option *opt,
+				const char *arg, int unset)
+{
+	xpparam_t *xpp = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (set_diff_algorithm(xpp, arg))
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	return 0;
+}
+
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
 	const char *names[3] = { 0 };
@@ -48,6 +73,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_THEIRS),
 		OPT_SET_INT(0, "union", &xmp.favor, N_("for conflicts, use a union version"),
 			    XDL_MERGE_FAVOR_UNION),
+		OPT_CALLBACK_F(0, "diff-algorithm", &xmp.xpp, N_("<algorithm>"),
+			     N_("choose a diff algorithm"),
+			     PARSE_OPT_NONEG, diff_algorithm_cb),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
 			    N_("for conflicts, use this marker size")),
 		OPT__QUIET(&quiet, N_("do not warn about conflicts")),
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 2c92209ecab..fb872c5a113 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -56,7 +56,67 @@ test_expect_success 'setup' '
 	deduxit me super semitas jusitiae,
 	EOF
 
-	printf "propter nomen suum." >>new4.txt
+	printf "propter nomen suum." >>new4.txt &&
+
+	cat >base.c <<-\EOF &&
+	int f(int x, int y)
+	{
+		if (x == 0)
+		{
+			return y;
+		}
+		return x;
+	}
+
+	int g(size_t u)
+	{
+		while (u < 30)
+		{
+			u++;
+		}
+		return u;
+	}
+	EOF
+
+	cat >ours.c <<-\EOF &&
+	int g(size_t u)
+	{
+		while (u < 30)
+		{
+			u++;
+		}
+		return u;
+	}
+
+	int h(int x, int y, int z)
+	{
+		if (z == 0)
+		{
+			return x;
+		}
+		return y;
+	}
+	EOF
+
+	cat >theirs.c <<-\EOF
+	int f(int x, int y)
+	{
+		if (x == 0)
+		{
+			return y;
+		}
+		return x;
+	}
+
+	int g(size_t u)
+	{
+		while (u > 34)
+		{
+			u--;
+		}
+		return u;
+	}
+	EOF
 '
 
 test_expect_success 'merge with no changes' '
@@ -447,4 +507,66 @@ test_expect_success '--object-id fails without repository' '
 	grep "not a git repository" err
 '
 
+test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
+	cat >expect.c <<-\EOF &&
+	int g(size_t u)
+	{
+		while (u < 30)
+		{
+			u++;
+		}
+		return u;
+	}
+
+	int h(int x, int y, int z)
+	{
+	<<<<<<< ours.c
+		if (z == 0)
+	||||||| base.c
+		while (u < 30)
+	=======
+		while (u > 34)
+	>>>>>>> theirs.c
+		{
+	<<<<<<< ours.c
+			return x;
+	||||||| base.c
+			u++;
+	=======
+			u--;
+	>>>>>>> theirs.c
+		}
+		return y;
+	}
+	EOF
+
+	test_must_fail git merge-file -p --diff3 --diff-algorithm myers ours.c base.c theirs.c >myers_output.c &&
+	test_cmp expect.c myers_output.c
+'
+
+test_expect_success 'merging C files with "histogram" diff algorithm avoids some spurious conflicts' '
+	cat >expect.c <<-\EOF &&
+	int g(size_t u)
+	{
+		while (u > 34)
+		{
+			u--;
+		}
+		return u;
+	}
+
+	int h(int x, int y, int z)
+	{
+		if (z == 0)
+		{
+			return x;
+		}
+		return y;
+	}
+	EOF
+
+	git merge-file -p --diff3 --diff-algorithm histogram ours.c base.c theirs.c >histogram_output.c &&
+	test_cmp expect.c histogram_output.c
+'
+
 test_done

base-commit: 98009afd24e2304bf923a64750340423473809ff
-- 
gitgitgadget
