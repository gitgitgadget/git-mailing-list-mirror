Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BD3A6B66
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991383; cv=none; b=XsOtXJ3uvdYme3Su/VIqmcQMMdo2l1LmoEKnESjUwwkaCOkeSx6FWImb0u006gQEXE+lRzhDtj1xSQHPgW6cXUbPRJxcvtjZqcpN8qNXajjsfSKpxAiCG3KvMbM/k0Bjf4Ii2WDKyTV1hpqDlN/Xj3SRib2R5p+hvFMy2HqTdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991383; c=relaxed/simple;
	bh=umLy2Ix/eol02lnSl/igagJgvPYt2td3AYK3KYHeEew=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Qg7pnDFo7HQ6InnsdUFu4eYcP4/kP1b6Rlh/alUOLUTzg1zJ2NSP/UQreg05wCsOYAbobOap9MZPZJlRCfXOixeMUQLMX51eF1cxtyQRVRlfOWDyJczCftfVV9GJLjvZ0qIl5040npcVAUiluDY9yPJnRzdZ/kXoYI0MV63wIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJtT4P1N; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJtT4P1N"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46a63c34533so3290860fac.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789991380; x=1790596180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=81hmd7Iq/UHdJwunmy3fya/QUqsntT7GYoYIwJ2d58E=;
        b=EJtT4P1NlwsCcI/MVXmkOTCZ9czNCfmqBKKrW8UQAlWsDywiXXJBkWIJjtAOhqp5Zv
         XM2lOq8GcBcHF8Go9Ste3d62+aa7v1LNkeDa7ITj6tSPvPH9JsMSNRW3f8YXc4Juicev
         sbhDbEjqeNYJZvWfRfVuS7oBOKQfuQBJoOo3x8GOjrmyPrp/sd6QvdoKR9Rg3N/PgwYK
         6PubfJkArWUIRHZjfu5LWTrQzcvt3eFwlqMHT5PpOIbW+pCR43vyGxwNGxHpJs+9mEl8
         18j2Y3CKmVGXABi03yag92bhopDkZS3+Hx6ry4pVsOkzR5SI4oDGqp16afeKF8g5yvZ6
         vU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991380; x=1790596180;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=81hmd7Iq/UHdJwunmy3fya/QUqsntT7GYoYIwJ2d58E=;
        b=mu0wJdUrIecQYrWBrR5Fg163PHqTNQ/aQ+mh126XOZmKli9Dx9cgxScj6a5X979r0D
         m3YoqaM0obQ65sD19vdeLE7Fn0QxHFEgqJbThGSGdZN61uLik4aiNQ0OrSbCZKDl5lwb
         Vg8OETY9bVRciC3X75siAn/E6xC3KaR0E+kTAqFgO9yyQK5LsBB0swlio48d2oqFcwZt
         nDFXyM39BBDP7nUwzFl9xc/iYVg8UaByFFNBtxDJIKgfwVzegZC5CxkE1lXZHtYJiO0E
         f/Qmb+XgBkCXaQq8QsHaLllqma/Zw+6p9a5Vfk18AXZNnfzcvH64MR5UqQDek/t1JtXh
         FBIA==
X-Gm-Message-State: AFuF++k7FrTsQz8mcEPSOknS4CBmYdl/14qb/2u6c1nxQ6S2M/Aj2Cnm
	CHQMqEvmfQCDGTIjHbF7/mo4yheiMHzg0E3f6Fkz/VMYhPfHh8saOgnFol0vTg==
X-Gm-Gg: AYBFou2ZvfItt6w2ZUcxlMylTbTd5KRV5a9q+yQUxXSZH5aEMy40jx+oKqGmX5VVq/N
	0ffqtfWzvDYYQg63VWxORsUcY9nFMg5c1gszp2dPJPgnPlbog0Cr0X37KVl9U/uTebuFC830pIA
	LnsmsUPZqG31AOiYsfyfoVRhcst7gypVVVmD1ItxMoC8On7k1dqRFsuplXtfSZvDPqLteOZqvbK
	Az+RHmX05uOONTttKd7zUzLQATmJD2BX7AH58jjzX6qcTaSnSEPSPEerjgDU28/UXTb82Nezj6y
	w7nsqO91rSxgjHgTp11v5t2PvZ/DIZAEmLk+3lo9dZct0TsxZU1REgiHyicRh8qTQgQXDMBZLGb
	AAbrobRsiP2h13B2j5synG1G6qXToREaFD15NxQArhQvI2jFrxVmXGRF44OF8WFOsMMb0uYHWLz
	kT62wBdU7PFq8+mDI/JVKiigwrZo38uSQcPCRdSP33ovw7fJICeD9ycEK/Ag4A93IsxAmKdvhA
X-Received: by 2002:a05:6820:1992:b0:6b7:46fc:1d4 with SMTP id 006d021491bc7-6ca9cb5fe7fmr9808562eaf.51.1789991379942;
        Mon, 21 Sep 2026 04:49:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.40.214.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48821db449dsm7219266fac.15.2026.09.21.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:49:39 -0700 (PDT)
Message-Id: <pull.2234.git.1789991377413.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 11:49:37 +0000
Subject: [PATCH] line-range: skip trailing empty lines in funcname range
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Nikita Makarov <n.makarov@yadro.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

git log -L :funcname: includes trailing empty lines in the
function range. This boils down to parse_range_funcname()
extending the range forward until it either reaches end-of-file
or another function, without skipping empty lines at the
boundary. Including empty lines is inconsistent with how it
works for git grep -W.

Fix this by trimming trailing empty lines from the computed range,
with the same goal as this fix (though with a different approach):

    8e5dd94e68 (grep: -W: skip trailing empty lines at EOF, too,
    2024-07-30)

Reported-by: Nikita Makarov <n.makarov@yadro.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    line-range: skip trailing empty lines in funcname range

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2234%2Fspkrka%2Fkrka%2Fline-range-trailing-blank-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2234/spkrka/krka/line-range-trailing-blank-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2234

 line-range.c                                  |  5 ++++
 t/t4211-line-log.sh                           | 26 +++++++++++++++++++
 t/t4211/sha1/expect.parallel-change-f-to-main | 18 +++++--------
 t/t4211/sha1/expect.simple-f-to-main          | 12 +++------
 .../sha256/expect.parallel-change-f-to-main   | 18 +++++--------
 t/t4211/sha256/expect.simple-f-to-main        | 12 +++------
 6 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/line-range.c b/line-range.c
index b99f0d9895..44b52d4e34 100644
--- a/line-range.c
+++ b/line-range.c
@@ -233,6 +233,11 @@ static const char *parse_range_funcname(
 		(*end)++;
 	}
 
+	/* exclude trailing empty lines from the function range */
+	while (*end > *begin + 1 &&
+	       nth_line_cb(cb_data, *end - 1)[0] == '\n')
+		(*end)--;
+
 	regfree(&regexp);
 	if (xecfg)
 		xdiff_clear_find_func(xecfg);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0a834ed8f..3f2a889e76 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -781,6 +781,32 @@ test_expect_success '--summary shows new file on root commit' '
 	test_grep "create mode 100644 file.c" actual
 '
 
+test_expect_success '-L :funcname: excludes trailing empty lines at EOF' '
+	git init trailing-empty &&
+	(
+		cd trailing-empty &&
+		test_commit --printf --no-tag "add func.py" \
+			func.py "def foo():\n    return 1\n" &&
+		test_commit --printf --no-tag "add trailing empty lines" \
+			func.py "def foo():\n    return 1\n\n\n\n" &&
+		git log -L :foo:func.py --format="%s" >actual &&
+		test_grep ! "add trailing empty lines" actual
+	)
+'
+
+test_expect_success '-L :funcname: excludes empty lines between functions' '
+	git init empty-between-funcs &&
+	(
+		cd empty-between-funcs &&
+		test_commit --printf --no-tag "add two funcs" \
+			func.py "def foo():\n    return 1\n\ndef bar():\n    return 2\n" &&
+		test_commit --printf --no-tag "add empty lines between" \
+			func.py "def foo():\n    return 1\n\n\n\ndef bar():\n    return 2\n" &&
+		git log -L :foo:func.py --format="%s" >actual &&
+		test_grep ! "add empty lines between" actual
+	)
+'
+
 test_expect_success 'get_commit_action() does not mutate a not-yet-walked commit' '
 	git init peek &&
 	(
diff --git a/t/t4211/sha1/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
index 6d7a201036..cb2f6bcbac 100644
--- a/t/t4211/sha1/expect.parallel-change-f-to-main
+++ b/t/t4211/sha1/expect.parallel-change-f-to-main
@@ -15,7 +15,7 @@ diff --git a/b.c b/b.c
 index 5de3ea4..bf79c2f 100644
 --- a/b.c
 +++ b/b.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -30,7 +30,6 @@ index 5de3ea4..bf79c2f 100644
  /*
   * This is only an example!
   */
- 
 
 commit ba227c6632349700fbb957dec2b50f5e2358be3f
 Author: Thomas Rast <trast@inf.ethz.ch>
@@ -42,7 +41,7 @@ diff --git a/a.c b/a.c
 index 5de3ea4..01b5b65 100644
 --- a/a.c
 +++ b/a.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -57,7 +56,6 @@ index 5de3ea4..01b5b65 100644
 - * This is only an example!
 + * This is only a short example!
   */
- 
 
 commit 39b6eb2d5b706d3322184a169f666f25ed3fbd00
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -69,7 +67,7 @@ diff --git a/a.c b/a.c
 index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -84,7 +82,6 @@ index e51de13..bdb2bb1 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -96,7 +93,7 @@ diff --git a/a.c b/a.c
 index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -111,7 +108,6 @@ index 3233403..e51de13 100644
  /*
   * A comment.
   */
- 
 
 commit f04fb20f2c77850996cba739709acc6faecc58f7
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -123,7 +119,7 @@ diff --git a/a.c b/a.c
 index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -137,7 +133,6 @@ index 444e415..3233403 100644
  /*
   * A comment.
   */
- 
 
 commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -150,7 +145,7 @@ new file mode 100644
 index 0000000..444e415
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -163,4 +158,3 @@ index 0000000..444e415
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha1/expect.simple-f-to-main b/t/t4211/sha1/expect.simple-f-to-main
index cd92100dfc..99404cdc40 100644
--- a/t/t4211/sha1/expect.simple-f-to-main
+++ b/t/t4211/sha1/expect.simple-f-to-main
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -23,7 +23,6 @@ index e51de13..bdb2bb1 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -35,7 +34,7 @@ diff --git a/a.c b/a.c
 index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -50,7 +49,6 @@ index 3233403..e51de13 100644
  /*
   * A comment.
   */
- 
 
 commit f04fb20f2c77850996cba739709acc6faecc58f7
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -62,7 +60,7 @@ diff --git a/a.c b/a.c
 index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -76,7 +74,6 @@ index 444e415..3233403 100644
  /*
   * A comment.
   */
- 
 
 commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -89,7 +86,7 @@ new file mode 100644
 index 0000000..444e415
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -102,4 +99,3 @@ index 0000000..444e415
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
index c93e03bef4..49f1402e46 100644
--- a/t/t4211/sha256/expect.parallel-change-f-to-main
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -15,7 +15,7 @@ diff --git a/b.c b/b.c
 index 62c1fc2..69cb69c 100644
 --- a/b.c
 +++ b/b.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -30,7 +30,6 @@ index 62c1fc2..69cb69c 100644
  /*
   * This is only an example!
   */
- 
 
 commit b511694f5337663fbd697622993a5f8e1099eca84be4df313f2b3ee94a098b42
 Author: Thomas Rast <trast@inf.ethz.ch>
@@ -42,7 +41,7 @@ diff --git a/a.c b/a.c
 index 62c1fc2..e1e8475 100644
 --- a/a.c
 +++ b/a.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -57,7 +56,6 @@ index 62c1fc2..e1e8475 100644
 - * This is only an example!
 + * This is only a short example!
   */
- 
 
 commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -69,7 +67,7 @@ diff --git a/a.c b/a.c
 index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -84,7 +82,6 @@ index 75c0119..3a78aaf 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -96,7 +93,7 @@ diff --git a/a.c b/a.c
 index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -111,7 +108,6 @@ index 7a296b9..75c0119 100644
  /*
   * A comment.
   */
- 
 
 commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -123,7 +119,7 @@ diff --git a/a.c b/a.c
 index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -137,7 +133,6 @@ index 9f550c3..7a296b9 100644
  /*
   * A comment.
   */
- 
 
 commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -150,7 +145,7 @@ new file mode 100644
 index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -163,4 +158,3 @@ index 0000000..9f550c3
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha256/expect.simple-f-to-main b/t/t4211/sha256/expect.simple-f-to-main
index e67fa017a7..3dd225947e 100644
--- a/t/t4211/sha256/expect.simple-f-to-main
+++ b/t/t4211/sha256/expect.simple-f-to-main
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -23,7 +23,6 @@ index 75c0119..3a78aaf 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -35,7 +34,7 @@ diff --git a/a.c b/a.c
 index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -50,7 +49,6 @@ index 7a296b9..75c0119 100644
  /*
   * A comment.
   */
- 
 
 commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -62,7 +60,7 @@ diff --git a/a.c b/a.c
 index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -76,7 +74,6 @@ index 9f550c3..7a296b9 100644
  /*
   * A comment.
   */
- 
 
 commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -89,7 +86,7 @@ new file mode 100644
 index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -102,4 +99,3 @@ index 0000000..9f550c3
 +/*
 + * A comment.
 + */
-+

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
