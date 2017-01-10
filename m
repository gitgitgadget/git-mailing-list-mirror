Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3530620A99
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760341AbdAJItB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:01 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35315 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759217AbdAJIs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:48:59 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so9037059pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2IkialHoY0meFPUeC+Y1dbeJCy5CnvPdafL8q6mGoNk=;
        b=qgDMO4LIp9u5MQYMPIKsLdojAnFCuJ7jb6fzEpYEl06y2JPD+PCsrD2lvZs6uTA9ls
         qdniHoy69XWHGr7PR3ZlYjGp0dpsljTPMpJ3vlpOYod6robk7RAWU2EsWCb81i2pI2l0
         K+g1KazdzeB3ply7rZ8QNr4h4ePid/Jbis0kOgeh9xUfyo0n249kXOCdjUr5gNbt97r6
         +aw9xnGuQtT36az6cLJp84FZ9MxqGeV2xvZo/uf0KduEcMpMoZfhFk7Xue7C9MOTy6Sy
         n9SegWhkmKnWQGL9l8vLZPpe/7yaljp4zEgY2rVYaS006nnZNglxlnaPGyp3KggRJ33E
         L31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2IkialHoY0meFPUeC+Y1dbeJCy5CnvPdafL8q6mGoNk=;
        b=OWBzMlOXEhfwsIzIUP4Km2KB6giZQfa8sSUtfQYFUnJTvMEIM7ooAWyWJH+0tM+U6h
         0PZKAJ1f6pYhCTuxTGc7Z98uXER/kILYi/cKtRMuTeHjsEB0xYDc1mKYCbfnB0AhdIi0
         FiD8bXIfWB1XsyNF8MRUnlUKfELnfXvg0AfPXUY6n2zJwS2BhpmRPPKhUSYfMDlPA48S
         hBD14dfhn5CXv77jLSBsaLF1a2PFRDoCE0CJvyvXfQ3N3dWAbR6o198hRqTgT6cb0ojJ
         IcaUFLha03vMJFLJYg1U6T4snC+zuzcy2vgXX6FLMYDdt4DlZ/8QoQIq1oWhW2+NJw/D
         YdlA==
X-Gm-Message-State: AIkVDXJVs9Q1wbAGwf5opgypQiufQjT2qdRTOESIoBkPCNTRsffyvBJag4SbARtxS9r8Yg==
X-Received: by 10.98.212.23 with SMTP id a23mr2493801pfh.94.1484038138522;
        Tue, 10 Jan 2017 00:48:58 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:48:57 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 04/20] ref-filter: modify "%(objectname:short)" to take length
Date:   Tue, 10 Jan 2017 14:19:37 +0530
Message-Id: <20170110084953.15890-5-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
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
index d5be41973..d7ab4c961 100644
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
index e002629ff..385fc04d0 100644
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
index aea1dfc71..e67c694c3 100755
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
2.11.0

