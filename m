Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B53E1CE1
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170549; cv=none; b=KoomIfGIUvi06kvQljNqK57q3QwOYOtwLenKrHqLIMKkdTd8jgWopPGNf2rsRzFvrQerV2ZxDAg71i9dDDJiBXXbHY168JzHtCObg7zBl6TfJQ8EJF2+9B5JhE+ioMLh29KadHD73kAVLmfzPi2mCNpIflqWNh6mBgMYDKsJ7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170549; c=relaxed/simple;
	bh=f4QowEEEPrgdizJsQzaKZlhB3MaJ/bHzRARxOygrWp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFUhzjABjtGX1gdaGciugkPxbSTPjPLEAGJwXLJVcRYT/YRMc7knuLWIIjI7buHg6z+ouxAL+9IsL3QVY3CPC9cWalVVdH7kSWavOek36wymmhbWp/XAhYf20NBzTV7E7Za10tg4Kg+l1/O8+LvPqrfA3YJHlj/QPzI9n89x98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lItelEKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2HjYKz6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lItelEKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2HjYKz6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 32CB61D000D7;
	Mon, 31 Aug 2026 06:02:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 06:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170547;
	 x=1788256947; bh=bWvOfX/PVQ+f2kaca66+k5gwPbX2SOOF6NwHK6FoP0k=; b=
	lItelEKaB6MVxMQ4pYn3RJmr2maRz00KHiPQJz54kaUbH7KDq/Hm6j9H5yBv7Uli
	39s/1oUaa6wZl1cn3ajXpA73+u9RF05VhEmXpTsSN5fhFinwjxi3HPhUBZTQLn+c
	isyFt+Xky1AnD9tN2S47BexiSL9WluMiFb4ntsoUyY4slkuMdArs/qQWjTi1WuXW
	VDCdYLnsxBCpn26O/Gpav8xFwUhDPWeWStn0qlQZMEIYuPisJJJIaP18V9aHHwRA
	5HHRQh7rjteKivnZGRYe1nY2Vfnzy6uIvjX6h9UYjHgTWSQGy0/YyYd4hyyMA82L
	DcO8eI3HBEBFp1OYXDeCeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170547; x=
	1788256947; bh=bWvOfX/PVQ+f2kaca66+k5gwPbX2SOOF6NwHK6FoP0k=; b=O
	2HjYKz6wX/sYKItLmHG3McHLq92GG4TRHGVN2TUeWVtLH0I5z4N5zcxxoVneCFUg
	qlaeIkHu7mu6CEOO9HGlGeFMluwne3JGAqMqXymj5Q+sVRG79FdeQUUUvP7qf1FL
	t75+JQDXJDhSk0kNZxkq2rBFmIXf7Cp+nnZSVPZfJRbDzl8BTVK3wZas1HNJ0W2L
	8EBzx5DG05pLETQW9qbIw5H0My+5OQm7i+F4PR8wd34kbemza+Zzypv+QOQmbXho
	l8xQsptwpX4m51Owg5p7ZNfmNx4s4l5SfegcYPCjjk0O+rwj0PC3n1fdXI1DcvLi
	Ytxhv5VW3lgZlQliBMbUA==
X-ME-Sender: <xms:MlGVavcmy5KrfJsirWYwaf-ldguVDvK2_9r2h9eFr5pI_3MyDQLonA>
    <xme:MlGVasp4B9UgbWpgOZkWzwGTl8Uhfh7IjNMbM0K42LsQVRd4u34a1lOjb9SuwXr5R
    ro49ACSB6t1Kpe3BeBFa1_Lvdys85Q8C5pji1qELQcGKBzbBOdY_w>
X-ME-Received: <xmr:MlGVal7yaSVcmwkLtXox6BXpT--5IqriglVrqSQYX_62JnbE7z_TxD235yoDUCVUBwTv7A>
X-ME-Proxy-Cause: dmFkZTGDuprITTFCvdQGXthi2SvIkuEwgiYsa0DM0rB4tsKuOdYlJ8oNNTWsjgzLpSMxpY
    /289A45zc0HZlw7PTvH5R40vdTEb8HfS3zlaowJyh34vDBwAwTUAfLej/6vOrwvY1VQC0r
    ONG28ELuoHpwNOEH29xX7lXyDxSSEqip80ImkHPA0GK1ntqqyfbkbzZ/NLigVbWSX83RyR
    L6Z+r0Ghvf2Ynf2x+6d3pg17qhT+4P5YnwbTHd1Pg2Yvx7JAn5a/UkG2yNrn/fNzvARA3E
    kDCr7YKYQ2GxB/x4BinuYvp1AR1e5mqnKLT3KYWdtSAbKBFpuda07NF2E6J2qxCbbH6LaF
    4mOvr4Cg78j0YTcUnbcWdujc7XHr8U/4qyRTr7dg4TqaZCW6hk5Hs33kw5nYBjD+RKrIJ5
    VkdKIyBIlqYZ4klylTz2hUHnqUMsusy7/txBWl0WsmGNPNtbQqr31dqG7cGlnjzrHkc20b
    IEKOaXDST80UCC5lTm1FfizkOMyuT4Utd2I5gu7B5YQdCcCC+eZ/DckEvHdhYaFXIjOiOH
    5L/WQkkS4AF2te+JJlCrSF68eQ5fHg1wQN+qQ1sBgCTJ96FZn4Mn3TM9+4dz2F3azS2wc4
    zpSRtQGTG6hS/idMEHPxqf/0sIJegKPo5Xpok3ZG0c9qSJz6uK+HFBvf8vkQ
X-ME-Proxy: <xmx:MlGVaqopT_kA02754vLBcZ6LolZo8Vlt9c8d8oy26yRJbmn-X5hBag>
    <xmx:MlGVavj0PIUmpgKcLYmjmn0SHg4URQgm8njicdIPfHyw5VNa48F3yg>
    <xmx:MlGVasKePG7biSzTXZxQ0p_1yKJDAOjlUQYwZeuQHMMJcLDV-vWI9A>
    <xmx:MlGVanDuHGuWe5y8xGu7Fo9DDzBBHS8ZLU6ApiSxUDM1BjxjaYpUdw>
    <xmx:M1GVaoRBNgezajhm3a54ey31l4oCDH1pV2xfW5gl9lCQ1F0rEGr3Vf9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dc1b4e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:08 +0200
Subject: [PATCH v2 4/8] builtin/clone: move setup of alternates for shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-4-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When cloning a local repository with "--shared" we add that repository
to the new repository's alternates. This is done in `clone_local()`,
which is responsible for performing local clones.

Move the logic into `collect_alternates()` to unify our setup of
alternates. Furthermore, this will allow us to set up alternates right
at creation time of the object database.

Note that the logic for cloning a local repository with "--no-shared" is
not yet part of `collect_alternates()`. This will be handled in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8eae3ac7d9..08c8f5a94f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
-static void collect_alternates(struct strvec *alternates)
+static void collect_alternates(struct strvec *alternates,
+			       const char *src_repo, bool is_local)
 {
 	if (option_required_reference.nr || option_optional_reference.nr) {
 		struct add_one_alternate_data data = {
@@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
 		for_each_string_list(&option_optional_reference,
 				     add_one_alternate, &data);
 	}
+
+	if (is_local) {
+		struct strbuf commondir = STRBUF_INIT;
+
+		get_common_dir(&commondir, src_repo);
+		if (option_shared)
+			strvec_pushf(alternates, "%s/objects", commondir.buf);
+
+		strbuf_release(&commondir);
+	}
 }
 
 static void mkdir_if_missing(const char *pathname, mode_t mode)
@@ -357,13 +368,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
-	if (option_shared) {
-		struct strbuf alt = STRBUF_INIT;
-		get_common_dir(&alt, src_repo);
-		strbuf_addstr(&alt, "/objects");
-		odb_add_to_alternates_file(the_repository->objects, alt.buf);
-		strbuf_release(&alt);
-	} else {
+	if (!option_shared) {
 		struct strbuf src = STRBUF_INIT;
 		struct strbuf dest = STRBUF_INIT;
 		get_common_dir(&src, src_repo);
@@ -1352,7 +1357,7 @@ int cmd_clone(int argc,
 		warning(_("--local is ignored"));
 
 	create_object_database(the_repository);
-	collect_alternates(&alternates);
+	collect_alternates(&alternates, path, is_local);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);

-- 
2.55.0.979.g7e5102b832.dirty

