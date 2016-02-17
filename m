From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 08/11] ref-filter: align: introduce long-form syntax
Date: Wed, 17 Feb 2016 23:36:16 +0530
Message-ID: <1455732379-22479-9-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6UD-0006tQ-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423526AbcBQSF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:58 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34992 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423505AbcBQSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:56 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so15548409pac.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a+aF+rlYHS7nkv6CHEvl5GP1nUWJWsu5V1NuZk+wMh0=;
        b=dnwq/ZJtFwtbF9P002UEKH7k3amvsA66S+7Lz+lCe26Jmu2iEKYEXJgnnFV5EzMfF2
         zaCqKeBfCMx9AgxIrpHkJY44Uq5plkRm3ZP6+7FspjP0pW9aEcqEZfEM4/7ww5QXm5NY
         d1kfEm2se+fPNAzNgIgkJbAv/2HbOXGk1yfWkz4zC3AObakRxt+a7mUsI7LYPLSS9ee2
         fsvTC8Z6qmz5TxXc3kD+fggCcHy5KvOMB9NoLN7XSBmaQnmv/GUL+IJg9d796GLHhRUz
         QjLz9Yqc2zCDGAzheutgmZDYJ1zXLFu8ZlaK8uBEgKm+kvnLTJv3/mRxXMnDFJeSSKM1
         vSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a+aF+rlYHS7nkv6CHEvl5GP1nUWJWsu5V1NuZk+wMh0=;
        b=D2RrzGRyUnYdQiNXkI2SI0IuHvsLWxAEz+sBg37sDcqeSBTPth9HrtkGOgaBO9YC3o
         67rCKPg8j8m7GWING+j8B7nuNCZsQYVSeQnKnUwdhjWeiuyRaWS/igKLhlNMhf1DIIG1
         IqC/y6iyg3XLJxr0z2ztkf/tBiWFjjimtn+YsVM3iE5S+7pxZwKZ8t10ptqYI8daEKTL
         fGYsYLbWa8SvwJYNl80hnC0edjpqiRB1RiFOEr9iuOsosFz6EFncnTfAEt7ntGNJbok8
         TCfSsP7TN8cW553y14kGcZoBw+BpelerPT086YLabnfjiE30f1YiqnkRuiAPtM5lCoAp
         O4sQ==
X-Gm-Message-State: AG10YOQDXL6DSrh4Zgffeg9mPQvkfsr2/LuboN1pNGeB0AwXt5wHZFsuXQrYlJPxOaWM8w==
X-Received: by 10.66.102.104 with SMTP id fn8mr3977705pab.129.1455732356082;
        Wed, 17 Feb 2016 10:05:56 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:55 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286525>

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
index 797f9fe..2255dcc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -78,7 +78,15 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 		const char *s = params.items[i].string;
 		int position;
 
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
