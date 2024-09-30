Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE811885A1
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687618; cv=none; b=irnIk+rnfNkL3IId8/kv8iW+dNy8f/NcPplzHtXGm+TobpAEXdKVTiblJnjnejYvmS5GqJmx5adze9tAW2KM2iykUvy/4knvkzzvJeV2YLOK4nV531WbyKw/Dq5GLFMzhroOv8IH5cIWohtX1D2X0eef16SuZjke5zQqGS/eCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687618; c=relaxed/simple;
	bh=TK+u8+yPb8EYWHEpNbrAS4ap8pVP21kSGZE97EtiiEA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgUSsOlOpkQSzhP2UPQFAsmjsQ2sQenD3dzDK7iX/GwHGk1QtXL7O+ZLKK4IUm3LFgmp9dUGiQeUeiIhNv4r96JFdSwi7uYq1hxL1V0cMRWbA6p3vYLVeSObl5JBsMvLV3eSAnMU+e+g9I8Z6MrbE7tLH+ypnX0F8rCk57QBDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfUinpnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLsWB8zI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfUinpnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLsWB8zI"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E24C31140266
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687615; x=1727774015; bh=sHrK6Hq13Y
	wSAUEgUEHNJkxWC4KdFXF9bEh6SfEDwOc=; b=rfUinpnwzwd1gibl5cCsjTU6iZ
	W2HRtKzuuj3lwv1l4JC/y3RgDcEp7VrmGlmkI1+5fwn9oj6jm166pzJaUj/3gzGs
	c2g/G3kbA9vEeBefMXfrZQ7ds2aDGBQSrBgiQpMZrHbj/MGLwi/ciB/h1xBC/se7
	0QpYjU2eAFk4aPTqron9ffYDkeqiC9f9+i7Pl+oYtrVOIav5ChHixmfR2bdsV7dG
	+eT7Je3X16zKL60c9VeSh2VQuJVsLkFk5T+ApFWlOD3bY+Jx15FS2Y9mgZwdVnAn
	T+FtgeTc0Qe/Rcx1xHTSQ7u9SszJd/B37y1eitibYLXUs+BNsx0sXnWAiofQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687615; x=1727774015; bh=sHrK6Hq13YwSAUEgUEHNJkxWC4Kd
	FXF9bEh6SfEDwOc=; b=WLsWB8zIe8heiaR0287UpMYN43SYhKIq/mAbxtwS1sOs
	VepeW7XGs3WXlq54Zjq5nPORMiIiSdRn8NPG0hqE+kkh/Noz4JI7lNPkkH7fXlAJ
	qimREzvh9AWJSquYmbVddO8uEDX0X2vCDhC2OtohNUavCP/EcQ3hkHiIH2x7FYD1
	0NUzNk58hm47mZxc057eyCC1fag5pvKJ2bCyTlL0aVrb+lQ9jG225cDzg3PK85h+
	HwnNCsSJ9NfpjbQFJr+PQiFyhMGo1mcfrxWz/JeSAQwuy3iTUBEZ5bf71A6npozk
	pRXyQFKhmyAETz1jJkLLZjW7ldkZnaOQVCn3xbvp/w==
X-ME-Sender: <xms:v2v6ZnM0fdBGPNTRxKIyxzvffcPt1oKZu31RKVFCNv_33EgiI1DKUQ>
    <xme:v2v6Zh_DaJ6E7Auyg4A6R9HizlIjgkAQq5oc2VKTshYhy__MnKlL8_kn8OMv4kgW5
    fNj2q0FI29s1_OYzQ>
X-ME-Received: <xmr:v2v6ZmRG3UvPdO_NCVqQzkpFpV-sN1i2CMbe_rg26JRQa-HCvLjDsML1O2z-kz4XnAqfGg479X52aN_6YY3wjcmUsgWyJMnvtxtKtWg0R8BQ0Ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v2v6Zrs8iPve7pLqI--K7NIyhzr8QnNapoAD7PcxEcC1kEnlg8boig>
    <xmx:v2v6ZvehOeJEE2DgJXKmqbyYTymm5kefNw2z0-zkjTfZRy81IoAKRQ>
    <xmx:v2v6Zn18qBygVyhjPJyH3wu56C6kMkeqZ-RDIhLCUpu97-idLR-8cA>
    <xmx:v2v6Zr_gbi92IuJg80CTIdbtdKXfJEuWu4-1HsDkoP2byVVPFbUKvg>
    <xmx:v2v6ZnEEphFqrpKUhFRuIfIMLW8mba-Ia8e376NKyfGcx47aibD2tCS1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 531ca629 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:49 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/23] builtin/pack-redundant: fix various memory leaks
Message-ID: <31480f336a151e1b7dd984368a5cd54ced40b4ac.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

There are various different memory leaks in git-pack-redundant(1),
mostly caused by not even trying to free allocated memory. Fix them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-redundant.c  | 40 +++++++++++++++++++++++++++++++++------
 t/t5323-pack-redundant.sh |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 81f4494d46..5809613002 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -69,6 +69,15 @@ static inline void llist_init(struct llist **list)
 	(*list)->size = 0;
 }
 
+static void llist_free(struct llist *list)
+{
+	for (struct llist_item *i = list->front, *next; i; i = next) {
+		next = i->next;
+		llist_item_put(i);
+	}
+	free(list);
+}
+
 static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
@@ -206,6 +215,14 @@ static inline struct pack_list * pack_list_insert(struct pack_list **pl,
 	return p;
 }
 
+static void pack_list_free(struct pack_list *pl)
+{
+	for (struct pack_list *next; pl; pl = next) {
+		next = pl->next;
+		free(pl);
+	}
+}
+
 static inline size_t pack_list_size(struct pack_list *pl)
 {
 	size_t ret = 0;
@@ -419,7 +436,8 @@ static void minimize(struct pack_list **min)
 
 	/* return if there are no objects missing from the unique set */
 	if (missing->size == 0) {
-		free(missing);
+		llist_free(missing);
+		pack_list_free(non_unique);
 		return;
 	}
 
@@ -434,6 +452,8 @@ static void minimize(struct pack_list **min)
 	}
 
 	while (non_unique) {
+		struct pack_list *next;
+
 		/* sort the non_unique packs, greater size of remaining_objects first */
 		sort_pack_list(&non_unique);
 		if (non_unique->remaining_objects->size == 0)
@@ -444,8 +464,14 @@ static void minimize(struct pack_list **min)
 		for (pl = non_unique->next; pl && pl->remaining_objects->size > 0;  pl = pl->next)
 			llist_sorted_difference_inplace(pl->remaining_objects, non_unique->remaining_objects);
 
-		non_unique = non_unique->next;
+		next = non_unique->next;
+		free(non_unique);
+		non_unique = next;
 	}
+
+	pack_list_free(non_unique);
+	llist_free(unique_pack_objects);
+	llist_free(missing);
 }
 
 static void load_all_objects(void)
@@ -565,7 +591,6 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
 	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
-	struct object_id *oid;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -625,11 +650,11 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	/* ignore objects given on stdin */
 	llist_init(&ignore);
 	if (!isatty(0)) {
+		struct object_id oid;
 		while (fgets(buf, sizeof(buf), stdin)) {
-			oid = xmalloc(sizeof(*oid));
-			if (get_oid_hex(buf, oid))
+			if (get_oid_hex(buf, &oid))
 				die("Bad object ID on stdin: %s", buf);
-			llist_insert_sorted_unique(ignore, oid, NULL);
+			llist_insert_sorted_unique(ignore, &oid, NULL);
 		}
 	}
 	llist_sorted_difference_inplace(all_objects, ignore);
@@ -671,5 +696,8 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 		fprintf(stderr, "%luMB of redundant packs in total.\n",
 			(unsigned long)pack_set_bytecount(red)/(1024*1024));
 
+	pack_list_free(red);
+	pack_list_free(min);
+	llist_free(ignore);
 	return 0;
 }
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 8dbbcc5e51..4e18f5490a 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -34,6 +34,7 @@ relationship between packs and objects is as follows:
     Px2 |         s s s                           x x x
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 main_repo=main.git
-- 
2.46.2.852.g229c0bf0e5.dirty

