Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764EFC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbjEOUbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245392AbjEOUbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:31:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9611B48
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:31:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 377D25C01C0;
        Mon, 15 May 2023 16:31:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 May 2023 16:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684182664; x=1684269064; bh=WtYdtNCHefV2vIR14lJ/cbXXI
        ZqGTNt6mOgVFIwPRCQ=; b=uefhX4QPKyJuodg7t+QLYRm7imf+a/gEmQGA7TExx
        J1bZfdjGT+IN9ScPoLeZjcAvuU1OdJsUBPr0hyrddGp/7hXsNVpUNdv/wisTKNo9
        ON79L23PsUTuI1QVNqjC9OeD/xIKb95tidQ66evfHozutXoCgrcHrnlt5HG0cw/r
        GwGqrpXAHVHXj57qAASTgECJxqxkGcTf5ipfc9UVUUrsHLUAhGro7TRSljpR3vfs
        vNrFSCUk6goy2ReWoarfnabljUM97aB9JYtIE6Rx+QX31zSZSUrvQLZE++LfUvMo
        AJIpMT7HpEy8Xt5YqTmdF9uxarAGYEaVimJ++6H3a3FFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684182664; x=1684269064; bh=WtYdtNCHefV2vIR14lJ/cbXXIZqGTNt6mOg
        VFIwPRCQ=; b=h3MwKH6BGliFfcqs/bz7uI3WcXXDhbgFkSuAs9s9ZnSXqfbE06H
        5H/+7ouxp6WN+Tj57kJIWTHA1SFbjKGMZ1DgMd7dZQ18cd1EftCqCIowZ+ouRjX2
        Trrm0suAPbjLQPoTWsTA9hxHm0EcZhDG1Rux1/o5MdfCG4z04Pss+ur+T5+jA56H
        9PNAePxNct5As/lUV6PohFxX8fBZJIhiI/X3W0bc1sflsbFrWnrpvMVEJVCCxEXb
        TtqgJYGf+KPS9llrvQkxjtIJ7HXt1hRBW7pEvsHZbErft4NS0QoFmLWqNqn+VX8M
        vkdgG/Nai2N4xcwXvODBsGTd1B26xFkystw==
X-ME-Sender: <xms:iJZiZDtlCrQVxMJ7XpXIg7F9cx76oytU2Alpk-z9LaGFAwXerSN_c7M>
    <xme:iJZiZEc4usO6Y6QVXU8gF6rOjEtBTERljEjDFTWc8dIFvkLilPG2XSxTg5Uoewshx
    4N7AuN9reniXeNFPw>
X-ME-Received: <xmr:iJZiZGwYrg_Aow_zsBbO2mJxo9_YwsCW-yutuPiEStnX2cULXlmLmsS5_ABUD_VP2S5x6ptpG5xpJkM2GMJLrGS8Zq5AjWieCYP33v0nrACDUbYYOa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:iJZiZCPahIewBYvfk6XGBDIZhMcjJfij9pfDVz_H6FWQZoRV_h1Fkg>
    <xmx:iJZiZD8XFL74BQ1S0qcfyLCXk3PMhBw4FhtbigaaGx6bK2LtgRmAlQ>
    <xmx:iJZiZCUca4y-vn2BU9aAz5q6RMP9SQUotMMBA4ZMGPdrFvByAi2GDA>
    <xmx:iJZiZFIt7TT3FsBkZpvlN2z-zrM48IaYhZu4qR3VNiMuWUl7g7JaWQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 16:31:03 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] tag: keep the message file in case ref transaction fails
Date:   Mon, 15 May 2023 22:29:35 +0200
Message-Id: <e67b6416b7ee05c3b39fad9ab74d4fb0bec4a1b4.1684181855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684181855.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684181855.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref transaction can fail after the user has written their tag
message. In particular, if there exists a tag `foo/bar` and `git tag -a
foo` is said then the command will only fail once it tries to write
`refs/tags/foo`, which is after the file has been unlinked.

Hold on to the message file for a little longer so that it is not
unlinked before the fatal error occurs.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I duplicated this message (this isn’t obvious in the diff):
    
        fprintf(stderr,
                _("The tag message has been left in %s\n"),
                path);
    
    Should this be factored into a static function instead?
    
    § Changes from previous round
    
    Squash (combine) the update to `tag.c` with the test so that the fix and
    the regression test is added in one step.
    
    This makes more sense than what I was going for since the test suite
    would fail on patch 2/3 of the previous round.
    
    Link: https://lore.kernel.org/git/xmqq4joeaxgw.fsf@gitster.g/T/#u

 builtin/tag.c  | 24 +++++++++++++++---------
 t/t7004-tag.sh | 10 ++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8..7df9c143ac 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -266,11 +266,10 @@ static const char message_advice_nested_tag[] =
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       struct object_id *prev, struct object_id *result)
+		       struct object_id *prev, struct object_id *result, char *path)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
-	char *path = NULL;
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -294,7 +293,6 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		int fd;
 
 		/* write the template message before editing: */
-		path = git_pathdup("TAG_EDITMSG");
 		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
 		if (opt->message_given) {
@@ -336,10 +334,6 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 				path);
 		exit(128);
 	}
-	if (path) {
-		unlink_or_warn(path);
-		free(path);
-	}
 }
 
 static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
@@ -487,6 +481,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	};
 	int ret = 0;
 	const char *only_in_list = NULL;
+	char *path = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -621,7 +616,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object);
+		path = git_pathdup("TAG_EDITMSG");
+		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
+			   path);
 	}
 
 	transaction = ref_transaction_begin(&err);
@@ -629,8 +626,17 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    ref_transaction_commit(transaction, &err)) {
+		if (path)
+			fprintf(stderr,
+				_("The tag message has been left in %s\n"),
+				path);
 		die("%s", err.buf);
+	}
+	if (path) {
+		unlink_or_warn(path);
+		free(path);
+	}
 	ref_transaction_free(transaction);
 	if (force && !is_null_oid(&prev) && !oideq(&prev, &object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag,
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cd454acfed..37bfa63fe8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2136,4 +2136,14 @@ test_expect_success 'If tag is created then tag message file is unlinked' '
 	! test_path_exists .git/TAG_EDITMSG
 '
 
+test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
+	test_when_finished "git tag -d foo/bar && rm .git/TAG_EDITMSG" &&
+	write_script fakeeditor <<-\EOF &&
+	echo Message >.git/TAG_EDITMSG
+	EOF
+	git tag foo/bar &&
+	test_must_fail env GIT_EDITOR=./fakeeditor git tag -a foo &&
+	test_path_exists .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

