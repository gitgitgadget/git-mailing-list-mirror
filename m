Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC991DE2C9
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417863; cv=none; b=DZKtSkL39RnPnbtfMX3ihjuAECGDWtLf2pyQej6TF0eJ5UtnbUD0P+ROKfeEu+P/ZII2aBk5drAogmG1t/SF7PluZlVosb8IK6nFtokRGBnLaNpOMkoPSS00V1nJUD0sf3N/GNwvjqKIdO/sdSQ8e4uan2aAqG+HYuTpI/Y/hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417863; c=relaxed/simple;
	bh=bDyK/TqpZCyeeqqH+w1Hh69b5q7vRA5xvcmxTKUtFVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/5Dbx+8ra2eBmhk9DI/IbgiEadrT2HJGaGtnA2wMhL46cNUNs3LUDJchh4nakAv1l0hV2KedGCQI34Wbt6OdUR9darJtQKwumVDq3nWUrD5pt3xw2uhgenfR0CyZ5PNSKl6USthXLnvK1+UjOchuoH5H6kQ3aB6P0Ba5AVTyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b6nG8Vuw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2MZQZaOF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b6nG8Vuw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2MZQZaOF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DD0DC13801C7
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 17 Dec 2024 01:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417860;
	 x=1734504260; bh=IuVol64cSOrsqOLovb8qXHLetYoglsuKswANwpDlxFY=; b=
	b6nG8Vuw4efjGWwKLWq0AlM8rUvpENlM51cx0vjVAh9jkXRmbWmhV+qt8o2RxW6a
	Uvhu7TSSVlTefMVLUUajdbqYsHmmi0n7wEYS56jZcBaU8lI+ylja8u2isMxY9YU1
	zSB1b5BhLGfVPNsuSqGMjo8+aXqeQ/e5gD/OnEBzJOdXTV4o1cOdJTi7SxsNMYxZ
	AuSm4jr9akbo7vA3Y+7FWSA15s1W/a2PPEK/C+dOSNkto2AvmlieUTKzMBNU5+DP
	QLjhOzFR6kHZpa0RZkrXeYsMvNXcWDac49yKXnLIa4/qmh07AQVNmZcDUphvLR7/
	FnX3xrknomaXMdry4Muvig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417860; x=
	1734504260; bh=IuVol64cSOrsqOLovb8qXHLetYoglsuKswANwpDlxFY=; b=2
	MZQZaOFmklxV6m24LHUzDnV7XzOCN5ZNM4WyLIvFYI4euAZ1yV/nuneyqXTI7IrN
	Hg4fWLMAlcACRQ0tgrOlsrEHK38E+uoDM/IYO/WYmss2ikVNWTEWlso6POiVhuZM
	DyUhbameFdqbBB3bbeI7dWiF9Ow53gRfK5kVajiyK8pcij45uVHfDmkrJ8ptG3AM
	DDJSmjf92JUCWGirFCtxfiNAGh8pHv1/gfbbFVlt2WAq5RC1N1QsEVEVhgWFC9Lg
	l459GfNLI5JZowdz4G95Q0Scdu52i5TSWie8D/8N1KGDicSNqOO49zhSgX/OeA2d
	P0poS0SHvngJTiNyn90zQ==
X-ME-Sender: <xms:xB1hZ6vpglyOrg72CAd2UQnGI9Hy9MRebS2JfT2mv7UCBvdQMaFSRA>
    <xme:xB1hZ_c7R_2L2VVy6yzhVPcTs__4Evk3-u1qT6igqFNVpN1mdarIdBkAB3jgm9LZq
    mGxNEHJVQn8oAcw8w>
X-ME-Received: <xmr:xB1hZ1zKSEgX8F37yHQgxaeVGr6Vj-8_7bkugDwqNkV64y3cIi585utZeUAVNAXh0wPGIheS9Hx8Noslb9Y2A4_NapCLEUNnn4qag4grMGANwHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xB1hZ1M9gMYC_An6CivvJdRtbeIJNp8bvoWHBA4NWGkedil3MWIzsg>
    <xmx:xB1hZ69yenpGZ8jFkJlLRj4cYiVxy7JjiLidkf0lviLl_BS06ayRSA>
    <xmx:xB1hZ9WqZiUqUqjMKancxgSJpoAPLJuV2zIbeIsyEbCjyikL7tPoUg>
    <xmx:xB1hZzesK8-PYRuBtK96l3-2tPyex6RjGzZtIu6NqSTZjxGLxYQIjw>
    <xmx:xB1hZwmA9MGpskxN6o4HdI6C8QI_tIyv-mh-ssbkHadT0hQli8f5fbaT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d73ae9b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:54 +0100
Subject: [PATCH 07/14] diagnose: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-7-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "diagnose" subsystem by passing in a
repository when generating a diagnostics archive.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bugreport.c |  2 +-
 builtin/diagnose.c  |  4 +++-
 diagnose.c          | 15 ++++++++-------
 diagnose.h          |  5 ++++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 7c2df035c9cff06f649c2b35394ea3db3d39f469..0ac59cc8dc5824fbc155674e9107bb845d8e054c 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -167,7 +167,7 @@ int cmd_bugreport(int argc,
 		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 		strbuf_addstr(&zip_path, ".zip");
 
-		if (create_diagnostics_archive(&zip_path, diagnose))
+		if (create_diagnostics_archive(the_repository, &zip_path, diagnose))
 			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
 
 		strbuf_release(&zip_path);
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 66a22d918e68a48a7c31ef3b75335f9a2bad7ab1..33c39bd5981f22d96b1b19e19ff83dec1c2873a6 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
@@ -58,7 +60,7 @@ int cmd_diagnose(int argc,
 	}
 
 	/* Prepare diagnostics */
-	if (create_diagnostics_archive(&zip_path, mode))
+	if (create_diagnostics_archive(the_repository, &zip_path, mode))
 		die_errno(_("unable to create diagnostics archive %s"),
 			  zip_path.buf);
 
diff --git a/diagnose.c b/diagnose.c
index b11931df86c4ba84f7aec77cb7965083f5aa31fa..bd485effea22ce400c4300a1e085b45204a3b42e 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "diagnose.h"
 #include "compat/disk.h"
@@ -12,6 +10,7 @@
 #include "object-store-ll.h"
 #include "packfile.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "write-or-die.h"
 
 struct archive_dir {
@@ -179,7 +178,9 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
+int create_diagnostics_archive(struct repository *r,
+			       struct strbuf *zip_path,
+			       enum diagnose_mode mode)
 {
 	struct strvec archiver_args = STRVEC_INIT;
 	char **argv_copy = NULL;
@@ -218,7 +219,7 @@ int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
 	get_version_info(&buf, 1);
 
-	strbuf_addf(&buf, "Repository root: %s\n", the_repository->worktree);
+	strbuf_addf(&buf, "Repository root: %s\n", r->worktree);
 	get_disk_info(&buf);
 	write_or_die(stdout_fd, buf.buf, buf.len);
 	strvec_pushf(&archiver_args,
@@ -227,7 +228,7 @@ int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(the_repository->objects->odb, &buf);
+	dir_file_stats(r->objects->odb, &buf);
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
@@ -250,13 +251,13 @@ int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 	}
 
 	strvec_pushl(&archiver_args, "--prefix=",
-		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+		     oid_to_hex(r->hash_algo->empty_tree), "--", NULL);
 
 	/* `write_archive()` modifies the `argv` passed to it. Let it. */
 	argv_copy = xmemdupz(archiver_args.v,
 			     sizeof(char *) * archiver_args.nr);
 	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
-			    the_repository, NULL, 0);
+			    r, NULL, 0);
 	if (res) {
 		error(_("failed to write archive"));
 		goto diagnose_cleanup;
diff --git a/diagnose.h b/diagnose.h
index f525219ab0cf9b36249892c847e731b952b081af..f7b38f49f5271ad00bf17d14e7b2aab3e9e174d5 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 
 struct option;
+struct repository;
 
 enum diagnose_mode {
 	DIAGNOSE_NONE,
@@ -13,6 +14,8 @@ enum diagnose_mode {
 
 int option_parse_diagnose(const struct option *opt, const char *arg, int unset);
 
-int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode);
+int create_diagnostics_archive(struct repository *r,
+			       struct strbuf *zip_path,
+			       enum diagnose_mode mode);
 
 #endif /* DIAGNOSE_H */

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

