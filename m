Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C9C7EE22
	for <git@archiver.kernel.org>; Sun, 14 May 2023 13:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbjENNUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjENNUR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 09:20:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91882D48
        for <git@vger.kernel.org>; Sun, 14 May 2023 06:20:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 623145C0075;
        Sun, 14 May 2023 09:20:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 May 2023 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684070415; x=
        1684156815; bh=10NzY3raI+Scjpw7pySJ9k4C4P260Yu1s4xB62S8ewo=; b=Y
        h23bDaqWZ8cDmS82wQiKcr9mklvp2yQRbZJUVAwNERTjlLoduIACc0PF7S4pgYbX
        rokT9925ifuNMlKBaH1fx+jM5N284CbHHu/Me5unpw0/mfXMwM5Xf3fs5AGl3JiJ
        ORQ/EgX/d8tCAJMeHSl1B8qIYSnWhCL7CiQ5IjHN8pg/tjBThM9ihcW+QL6XHPUg
        3jrp+0tGWJPVFMhitqmbvE9To6wrwlk+nzv3QU1BpusFRBfS00QGJ/usGI1eBH7B
        tgcBhrJJVR0itV3v+Po+FM5Gr+D4nx1K5HwyUIyY4T0L2kOgCbn22MK1tMlUZoYb
        WT/5dic5eFHEaQKiHZ/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684070415; x=
        1684156815; bh=10NzY3raI+Scjpw7pySJ9k4C4P260Yu1s4xB62S8ewo=; b=K
        HMUPUx5loOn77XxTgkYVTVIRqSOJQvcMkkIioJkIF+WpgROPprQL+zyfThK9D8hw
        qDB1P7EW8ndkDgMYhxdH6elKtxJS6eJs1am4f+N8rtUfYUdZrSgt9AhXVr1Ptk3Q
        er0h3wB0if49QMqEtCavn6GH4sik/T48A+YlZJ+YU4bKAwma0O4B9F5QbEjBgN0T
        fEm8uWD7XEx1WCB0x782SgHeB7QEVWPmtsUMMVY5NtW2uYt/jfGLsu5hO9BrxPF2
        zRuFZnJBT4tLfCvLLKzNvJcC46SSdtCGBtBx+1oHDgqN2XsKWFmrqA+8rFuq6F8j
        Te8s/tmNawnsS6OnqsXNQ==
X-ME-Sender: <xms:D-BgZL9MPRPSbx7ZjDQScRiyL8SKoL380RpQUXlPxN_r5WUW5ixCpT0>
    <xme:D-BgZHtjF-4GL8T_d1viIZQbu83ba0hklKjpJ54lSp5KbiOMKKYwCdpUxynJ1WDYg
    Eztfhjqn-LLdE1Sxg>
X-ME-Received: <xmr:D-BgZJA1GrqAdzch96if8Xxwi6tqxVpksnhAUFRVISO-xaudq1vbC_pctigQ3tnDszlyZLODfdUFrpE-ens0MVR-Wr7jmzfghCtBEZ5KnQal_LJjk9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:D-BgZHea6075bdlqJQCdMYQ8bHTilSWn3iqEKzK2IH4CSNoHN5brmg>
    <xmx:D-BgZANzDxtne-JLe8twbqJJ9JA6JZ1zkZFGCqFX5GnP7rXTHIkKnA>
    <xmx:D-BgZJlGk4ikTj4rFgoItXOk7Ic7eiVryt82IKnJXTFn3uNqG5T81A>
    <xmx:D-BgZK3d2NiUBQn4x1cbFUp-qm6ofeHCm8nP0Fcpx8jI9BRRgrlcXA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 09:20:14 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/3] tag: keep the message file in case ref transaction fails
Date:   Sun, 14 May 2023 15:18:00 +0200
Message-Id: <999af290af4c6850aa3faa2cc95adbac3b7a3984.1684067644.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref transaction can fail after the user has written their tag message. In
particular, if there exists a tag `foo/bar` and `git tag -a foo` is said then
the command will only fail once it tries to write `refs/tags/foo`, which is
after one has closed the editor.

Hold on to the message file for a little longer so that it is not unlinked
before the fatal error occurs.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I tried to maintain the proper formatting by using `clang-format` via Emacs on
    the affected lines.

 builtin/tag.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

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
-- 
2.40.1

