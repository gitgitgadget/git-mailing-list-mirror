Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A894405C55
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820156; cv=none; b=gZ6ZZI9OzNRUcGkIgYwhRZZugn7o+bmaTRJ/mi0CTU0zq8CvgSJ7ROyuKMjDkZqYi4CDE4sXWB1sAjshQLAJy+12YAa265LRyRM9TzyVjovF+fI0DwaZDGMfUbddwPLxVs7+Eoq9+db1pAMNFMTwG3u/qBCRP172pgw+qAvBK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820156; c=relaxed/simple;
	bh=0lM5kNcTgsU4JbDoTlJNVMaW2/Rwubr1SqbyF2SjVh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQ9uk9PhWGw3ijb1x/v1Ruo4X9c9KiwpSTAw/tU9EtAbwQRFE2bBfIlgiyaniiQA6axGHG4rnIRDm9cpvsv000oc3xQAytYSuwSeVenJVIXaMLGqE3gVBdRWUZVWRQcK3TFU7lt38UJhSYK9QU0erAHtgfVUPSeZOxDMVgas4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m2tSOK+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNknoXQn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m2tSOK+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNknoXQn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D7B0D1D0012C;
	Tue, 30 Jun 2026 07:49:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 07:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820154;
	 x=1782906554; bh=yxLIIH0g8jmlhDsdFYVigKr15qaZnSQ93Krkkb7vIhs=; b=
	m2tSOK+9loPklWm4iJ32fJzJ1FXiF/1Lfz6BFOlHvD0INEXXBja+aJAslltfAoQd
	R/NbrBm1KR9Y1Gat15Xt4I+vecM53bhkMWtEGlRqpsUZ1YXaUDL6WPvsv9ZTlJtC
	QiVfpV0Z6O0ZVAbC2+LxgSYRYFio7aZic2utekplU6RlR/gOM0/jrv7CkV1KEhFb
	NK2erCBsJkoi77IV3AkX9Gmv6u5OEv4nTFBpq3Ezbd66GTg3DIfyXM+6KI+b6cAk
	mJg/epqcYsZOuTPgvwuFmDE0TlvaiG0AAPICvCqLESICJd9dhtrfD6hjdnjqMC9a
	0atPhkQvlOUqVhWL1es6rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820154; x=
	1782906554; bh=yxLIIH0g8jmlhDsdFYVigKr15qaZnSQ93Krkkb7vIhs=; b=G
	NknoXQnrZpvZWM7gl6S5vU1KiKiZEGLowJRTaO33gpuxHIAcVUsuuhduTnzHJl6K
	xyG0PjNns4czxEuTYQtJFn4m1LXnNCKWFWO7NgCjp5GL3nCN3b2mgqz+mlgLWEwO
	cWa/yViQ6zrfiouFC0e4MHm6P+pvsoOETUoaxRaSDzKjltg3B1uBcjWILSmOENZu
	koC20LThNOdxTqF1GbvUkwdVpd7yO4fNkAcPxUBzY2uZhv1V+d1gQ4f+lI2d3bLM
	WJuNECqhb8WdE3XaVzG0NfifklXSMj6byRBGrq6ssE/S/3PGoWEuqTcUdts+ahyK
	zg7y9Z6C3HwhfRUmuzLPg==
X-ME-Sender: <xms:Oq1DasrgD4-oihRQw1dRlJf1RvBOHOoKAwQrcR1YtdSXSvUXTo9eYg>
    <xme:Oq1DaorRg2yPg-b5BNVXly_shBtzc93boOAIWNM-MubxuYCrX48iLm7ZD2rqDigE_
    Z8oOkIYjx6SKyhge4zID4dY_pWWzIHbDX86kjzIUnvPcCl8YYmB>
X-ME-Received: <xmr:Oq1Dau0p462ck0pIRtRfEAivXvxNYO32BHdrZGWHvg4tZiTXZbCLQ3LoGoEvSBkZh-Z9YcyEKePIAm2Nu9RiplnAqXpKDbW2Fisyl6h7VQ7BbQ>
X-ME-Proxy-Cause: dmFkZTGC2szVQkDaHMGWu8x0Spy+Nui0qUO65jcAzORicIj/uF2IQwm6PE1k+iEZ/mZgZt
    x3B7QknX1atPvT+D+QhChjmaAFmStw8wfoxzqXoRU+majWRzYp1dcWY1elHRcgoUtflQgM
    g1pEqIAgiwljjKYiP255ZcltSFPL+qawrWp1fneip6gJetr1+aXwhP8TYwmjQxigefmQ9g
    nEhmGWCjHrgf6kuTK/nZLI6VrK5iLlQxIxRPhk67rEHmx+XY9P8HwAex+ifmHnHhkq+duT
    nYJS1hzZGcgU7w7oTNJ302gliI5CIgfp+sxfp+4RVuBFMABNDTYIcH0V1Mifhy7sad0+TB
    s11lQYkGLVyzdOj7Wp/jH2TXsBx8kIY1Ixa/+Pyeu6h3vM05pX7Sp3utmSrY5qnr34gNAm
    LWKRCxTcIolVG2Pw1L9ROEPAhh69s1ll39qVweSDOizype+BHxoy8ATs9aLCyFMyWvbpDg
    /xGC9yr74DGWGxnRgBdLXL9O3mzalviA7stgz6Gux0irKolLOM+B5TtaFBSWEK4j5JWkCJ
    CtWyD7zgc6kLZbvcuAusOMVAtrHYMh1mLjPfH+HXBjvBsTmnHyjP/Uj2p1SIvZpb/6wiHp
    66OAGfbwzfdYVRd3POXYARdeoTGcvWuVCUogoilhnza69Jw+heWZwhrGphWQ
X-ME-Proxy: <xmx:Oq1DavAQunVsBJRsxztCjT0r1V6M1qaUEp6u_Mo2Jo-e9katubIkVw>
    <xmx:Oq1DaudTd_LNmSIfdoxqh3fajIo91T__5u0lKjXDdpCXObNkJC4w-g>
    <xmx:Oq1DasguvLo7dNInWR0wfsxFQn8Vnx_OuFrcsKfD0dHr17H2PvebXg>
    <xmx:Oq1DaupNHACEYR_hhq6hMSPGyqarpdOZRx2KpAOEIeMLwkeV4QtC0w>
    <xmx:Oq1DagAc53kfuXL5RThW5zmksX_9gEf80FoSEkuXQEeRNNkpQ-rg3lHB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 423cbb20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:49:04 +0200
Subject: [PATCH v3 1/5] builtin/refs: drop `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-refs-writing-subcommands-v3-1-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

We still have a couple of uses of `the_repository` in "builtin/refs.c".
All of those are trivial to convert though as the command always
requires a repository to exist.

Convert them to use the passed-in repository and drop
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/refs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index e3125bc61b..f0faabf45a 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
@@ -23,7 +22,7 @@
 	N_("git refs optimize " PACK_REFS_OPTS)
 
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
-			    struct repository *repo UNUSED)
+			    struct repository *repo)
 {
 	const char * const migrate_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -59,13 +58,13 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		goto out;
 	}
 
-	if (the_repository->ref_storage_format == format) {
+	if (repo->ref_storage_format == format) {
 		err = error(_("repository already uses '%s' format"),
 			    ref_storage_format_to_name(format));
 		goto out;
 	}
 
-	if (repo_migrate_ref_storage_format(the_repository, format, flags, &errbuf) < 0) {
+	if (repo_migrate_ref_storage_format(repo, format, flags, &errbuf) < 0) {
 		err = error("%s", errbuf.buf);
 		goto out;
 	}
@@ -99,8 +98,8 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
 
-	repo_config(the_repository, git_fsck_config, &fsck_refs_options);
-	prepare_repo_settings(the_repository);
+	repo_config(repo, git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(repo);
 
 	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
@@ -124,7 +123,7 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 }
 
 static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct strbuf unused_referent = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -145,7 +144,7 @@ static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
 		die(_("'git refs exists' requires a reference"));
 
 	ref = *argv++;
-	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+	if (refs_read_raw_ref(get_main_ref_store(repo), ref,
 			      &unused_oid, &unused_referent, &unused_type,
 			      &failure_errno)) {
 		if (failure_errno == ENOENT || failure_errno == EISDIR) {

-- 
2.55.0.795.g602f6c329a.dirty

