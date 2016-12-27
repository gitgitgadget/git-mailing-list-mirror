Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F52200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755438AbcL0QXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:30 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35139 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbcL0QX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:27 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so18329201pfk.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mhe2wush6JT5ZqzB+TSPDOX4ClR6zjqQ0LSp8ypHQ1c=;
        b=jPRhGLg7QPbKhgKliWrD3rUy2bvSZWSi8T0O2oxRrtHyUL3HM/DhsozzDqyyFX7uqb
         Ux4gHNoum61KjxKK47YV3Coo7gsiDb7m5CjS8JbZq8uM1SK/GX6VtwtGujsZ/maGgktH
         f4qGeggbeMvOH/BeU5W+k5uIOVg6Gq2mU9Y0zCJxeAKjaCcIJirJYRRSoTt0up0Pn65h
         hH5Ju1GMeeOgryUpDeuoaS/2JQ+GH+3KaMQxbwPR01yxq2kf0ZmTPQR74fuVoJL+cobu
         FdCyQsFSmH8DLsIxQVafvsm7ro5YJM+KWLUTGRhNL9arKT1X8ldQ2C2WWLIwABsPvhJd
         e7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mhe2wush6JT5ZqzB+TSPDOX4ClR6zjqQ0LSp8ypHQ1c=;
        b=dZvVh5Oe/4UDYp4cQmRRxCJSgYvdzHUZ/n/gx4L0Enc707ooa0UOGaQt7ral6L9nVp
         +ZsizabaffjaMxi+kpm0uGPziWT3FzDFv4MmRjb9kKUY0fFbqpxe5ZFxcvgsSr0nxnPr
         g+lxjaggdEQktgLn76UprJ4eRDHiK9uEPj9ujhpDq2FUcWAWuhfzBgXr9hQEj2mrOXch
         r4Zccv0Wi6JG2ATm+bAGCWPixoD9XDGP0aKpx7mvXpxe2Ucr8LHxKJDv9iQUHkJulA6k
         QSCKz8u0T1vdF6VS0e5/xZzWhRVntZ3WNn5ydd3DfavI8mCQjrTGS8bUwbDjEUiWOqu4
         l2og==
X-Gm-Message-State: AIkVDXIFVS8WbgwcJrCDg1PlH/tNjezbLhut2W1GyZmARiqo5cW0JffetwDmrwkqiQu6Pg==
X-Received: by 10.99.99.195 with SMTP id x186mr22768772pgb.75.1482855801332;
        Tue, 27 Dec 2016 08:23:21 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:20 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 04/20] ref-filter: modify "%(objectname:short)" to take length
Date:   Tue, 27 Dec 2016 21:53:41 +0530
Message-Id: <20161227162357.28212-5-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified, the length is 'DEFAULT_ABBREV'. The minimum length is
'MINIMUM_ABBREV'. The length may be exceeded to ensure that the
provided object name is unique.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 25 +++++++++++++++++++------
 t/t6300-for-each-ref.sh            | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 39aab09..c2cc03c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -110,6 +110,9 @@ objectsize::
 objectname::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
+	For an abbreviation of the object name with desired length append
+	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
+	length may be exceeded to ensure unique object names.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/ref-filter.c b/ref-filter.c
index e002629..385fc04 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -57,7 +57,10 @@ static struct used_atom {
 			cmp_status cmp_status;
 			const char *str;
 		} if_then_else;
-		enum { O_FULL, O_SHORT } objectname;
+		struct {
+			enum { O_FULL, O_LENGTH, O_SHORT } option;
+			unsigned int length;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -129,10 +132,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		atom->u.objectname = O_FULL;
+		atom->u.objectname.option = O_FULL;
 	else if (!strcmp(arg, "short"))
-		atom->u.objectname = O_SHORT;
-	else
+		atom->u.objectname.option = O_SHORT;
+	else if (skip_prefix(arg, "short=", &arg)) {
+		atom->u.objectname.option = O_LENGTH;
+		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
+		    atom->u.objectname.length == 0)
+			die(_("positive value expected objectname:short=%s"), arg);
+		if (atom->u.objectname.length < MINIMUM_ABBREV)
+			atom->u.objectname.length = MINIMUM_ABBREV;
+	} else
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
@@ -606,12 +616,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
-		if (atom->u.objectname == O_SHORT) {
+		if (atom->u.objectname.option == O_SHORT) {
 			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			return 1;
-		} else if (atom->u.objectname == O_FULL) {
+		} else if (atom->u.objectname.option == O_FULL) {
 			v->s = xstrdup(sha1_to_hex(sha1));
 			return 1;
+		} else if (atom->u.objectname.option == O_LENGTH) {
+			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
+			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index aea1dfc..e67c694 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -60,6 +60,8 @@ test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
@@ -99,6 +101,8 @@ test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
@@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
 	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
+test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
+	test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
+'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.10.2

