From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 09/12] ref-filter: align: introduce long-form syntax
Date: Sun, 31 Jan 2016 23:12:53 +0530
Message-ID: <1454262176-6594-10-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1m-00005d-EM
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbcAaRnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:43:06 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36378 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbcAaRmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:39 -0500
Received: by mail-pf0-f196.google.com with SMTP id n128so6395465pfn.3
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DH//YMAwTCLEkg2eZWhkAZGFIPe/QZUfdxQQOlUeqTo=;
        b=b7hK3coCjodo2TMTPUhVZJVVebQmRJr8Hq++xZ9HOaOscXCF6zUNjxr7pgo8q5Lbcg
         ZZMnsg+APC/V+0+Uir+UoyRcAtVhvBA+90njPRsxnjRonTEHxUxb9Tspwvu4qJispSZV
         HC46xBhQQieYMWxnUuHboRJ1GVGbUGg6ZArxfZ1vUIAoOCL0q0dHlxkz24cy0tiB9c7Y
         c+EWQEzOW9p7llwxd/zZbwsaW6h9m2J7kz/tXDK5YNLw6VRUS1WgGbirNMLVmN1tM5Wp
         9rsABLne4MQ/xXoe68BKWq3UdAUJbjvKc/M7h2R2jTVOHjZkjFiwv3nqUKkeT2+WV+CP
         y3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DH//YMAwTCLEkg2eZWhkAZGFIPe/QZUfdxQQOlUeqTo=;
        b=POvBRRlopOqr2qLsktD4NLozoBrcsKktWM5QTkuTM6RLTOo11AQHS6F5lWs5quEZZu
         26nNa0/7DmpXMNi7Pd7Lzvq7fAz0YwQI3/QDDaNvv9y0wSoLekuJH21G028g6MKFkakt
         2kzN1/PciQtVwUmsoRhHPvkxqwpYkASaUMf3vCo9Ehi8IjbNO2CTX35TJ8djgEwSPTqm
         RpebQpisK6MGV8iak6/OWlbCazlnwClKSUI0ND0LohIUXMhsm+VEig6s6yNDi9ELF4rf
         Zvf3zmo7E9FvFXV6TiCAdrP/7u+8zHWw1tnYCnj8eOLoUoa/FdxvuVgMbZbTaMhs1Bzz
         aenA==
X-Gm-Message-State: AG10YOSNx6GYJlExihQLNR8JzIMYWXD70dJjBgDqVtfFcidFV/7rLjb9oi+AFgGZnX8pGA==
X-Received: by 10.98.16.12 with SMTP id y12mr7996887pfi.6.1454262158881;
        Sun, 31 Jan 2016 09:42:38 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:38 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285162>

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
index 79a7e07..58d433f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,7 +77,15 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 		int position;
 		arg = s[0]->buf;
 
-		if (!strtoul_ui(arg, 10, &width))
+		if (skip_prefix(arg, "position=", &arg)) {
+			position = parse_align_position(arg);
+			if (position < 0)
+				die(_("unrecognized position:%s"), arg);
+			align->position = position;
+		} else if (skip_prefix(arg, "width=", &arg)) {
+			if (strtoul_ui(arg, 10, &width))
+				die(_("unrecognized width:%s"), arg);
+		} else if (!strtoul_ui(arg, 10, &width))
 			;
 		else if ((position = parse_align_position(arg)) >= 0)
 			align->position = position;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..f79355d 100755
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
+		git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
+		test_cmp expect actual
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
2.7.0
