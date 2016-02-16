From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 09/12] ref-filter: align: introduce long-form syntax
Date: Wed, 17 Feb 2016 00:30:12 +0530
Message-ID: <1455649215-23260-10-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkr9-0008UQ-RI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227AbcBPTAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:00:09 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35721 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbcBPTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:00:07 -0500
Received: by mail-pa0-f42.google.com with SMTP id ho8so109314575pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 11:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gj+Au3icQ5EuC5Xu14fBGZnVxrBiYPIWLzkxzj8r4mg=;
        b=IJaj2+OJ+nxxM0u6z9AcnTVMPJai1kNx4IIVFRg3jth0jsacNwuOvVJ1JAwks4HoG8
         7UbNX/frTiNjuZP8L0QJuTQnB5UrABRFfbZZvriJ/kujbkZB/sP0FPnIh1zEIT6vD5SO
         7nnWCtoK+Azv5li6jgqRUeZIRmNxkOUip/X+myZRKG2LsIutSzgJ1ikKP0YmJqrPLEVY
         dd3G84Z3ikRShuMtkrW+IZiAd9bweECZWffe1peECvdrIrZE/LmL6qXw/8p+r9Cp7a6y
         QKQK6gI+dIvDwm/ihwSXYEaZL+LKnuhKRHs7h07MQiSM6ITRLqkDDGQdTXI0PAZSSlKr
         u2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gj+Au3icQ5EuC5Xu14fBGZnVxrBiYPIWLzkxzj8r4mg=;
        b=WpJi00WWDrx2h/7Ku8y8NvVfc+SuHyiO+7enA+I62Y9V6kJi9x+nLdI3P3L50F6up4
         ZIHW/pyhYsN3H4isoCGyOf0cF3+mv516VQ14a9h+w8RQdh+2zpvv1BtT42iyL0LoGj4K
         GuRWmImzA12EsvTuzbjIZT85jMh+JrBGxkyKN5dC0jxwe+p06v1l5/gzz/nNDasVw5Bg
         LDSGcHFUhMKv2Y+PJVpcs11ZqNUr9paYgD97H2KQoE3TdnKXUhF2jjaoy00zcWrYgfXk
         x9cnJ4wKgkRL4xRv4tFEloFIT1tX5BVEp6gxoJk1+lL/sWkBUDeURho6crNa56ZmWb8y
         lwxw==
X-Gm-Message-State: AG10YORNqSpkk7OZciFTpsXSOS7HuvrMvcIo8WQ3bBSzANa+c3zXdFg70mtetYgyMes0jA==
X-Received: by 10.66.235.9 with SMTP id ui9mr33168723pac.135.1455649207047;
        Tue, 16 Feb 2016 11:00:07 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.11.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 11:00:06 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286423>

Introduce optional prefixes "width=" and "position=" for the align atom
so that the atom can be used as "%(align:width=<width>,position=<position>)".

Add Documentation and tests for the same.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 20 ++++++++++--------
 ref-filter.c                       | 10 ++++++++-
 t/t6302-for-each-ref-filter.sh     | 42 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2e3e96f..012e8f9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -133,14 +133,18 @@ color::
 
 align::
 	Left-, middle-, or right-align the content between
-	%(align:...) and %(end). The "align:" is followed by `<width>`
-	and `<position>` in any order separated by a comma, where the
-	`<position>` is either left, right or middle, default being
-	left and `<width>` is the total length of the content with
-	alignment. If the contents length is more than the width then
-	no alignment is performed. If used with '--quote' everything
-	in between %(align:...) and %(end) is quoted, but if nested
-	then only the topmost level performs quoting.
+	%(align:...) and %(end). The "align:" is followed by
+	`width=<width>` and `position=<position>` in any order
+	separated by a comma, where the `<position>` is either left,
+	right or middle, default being left and `<width>` is the total
+	length of the content with alignment. For brevity, the
+	"width=" and/or "position=" prefixes may be omitted, and bare
+	<width> and <position> used instead.  For instance,
+	`%(align:<width>,<position>)`. If the contents length is more
+	than the width then no alignment is performed. If used with
+	'--quote' everything in between %(align:...) and %(end) is
+	quoted, but if nested then only the topmost level performs
+	quoting.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 4a9711f..13a8280 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,7 +77,15 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 		int position;
 		const char *s = v[0]->buf;
 
-		if (!strtoul_ui(s, 10, &width))
+		if (skip_prefix(s, "position=", &s)) {
+			position = parse_align_position(s);
+			if (position < 0)
+				die(_("unrecognized position:%s"), s);
+			align->position = position;
+		} else if (skip_prefix(s, "width=", &s)) {
+			if (strtoul_ui(s, 10, &width))
+				die(_("unrecognized width:%s"), s);
+		} else if (!strtoul_ui(s, 10, &width))
 			;
 		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..bcf472b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -133,6 +133,48 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
+cat >expect <<-\EOF
+|       refname is refs/heads/master       |refs/heads/master
+|        refname is refs/heads/side        |refs/heads/side
+|         refname is refs/odd/spot         |refs/odd/spot
+|     refname is refs/tags/double-tag      |refs/tags/double-tag
+|        refname is refs/tags/four         |refs/tags/four
+|         refname is refs/tags/one         |refs/tags/one
+|     refname is refs/tags/signed-tag      |refs/tags/signed-tag
+|        refname is refs/tags/three        |refs/tags/three
+|         refname is refs/tags/two         |refs/tags/two
+EOF
+
+test_align_permutations() {
+	while read -r option
+	do
+		test_expect_success "align:$option" '
+			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
+			test_cmp expect actual
+		'
+	done
+}
+
+test_align_permutations <<-\EOF
+	middle,42
+	42,middle
+	position=middle,42
+	42,position=middle
+	middle,width=42
+	width=42,middle
+	position=middle,width=42
+	width=42,position=middle
+EOF
+
+# Last one wins (silently) when multiple arguments of the same type are given
+
+test_align_permutations <<-\EOF
+	32,width=42,middle
+	width=30,42,middle
+	width=42,position=right,middle
+	42,right,position=middle
+EOF
+
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "
-- 
2.7.1
