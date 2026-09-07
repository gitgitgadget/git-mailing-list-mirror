Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07443E9FE
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769563; cv=none; b=kWM3l0XjoIZ0XhUIOSuBCCPb8B0gNXJocEJNoi0S0i9Fl3jZ9JDppB8CBrm1lSRUub1iUxOBQuWhnhw4869BxO05ptG7aH/WMQPpa6w9R5SYUOlVrcaIVjTSwmTPGF7ub516LcUAT4gNAUBOhnL9QpDuqo7uJyr12vuSQlpb2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769563; c=relaxed/simple;
	bh=FaOUNVp5kiAAcLU4n7x4NBVmGpIRj1M8sCaQ+xzMUp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVnOmJEn6QO6eqIPC0r1Oe7T+OeOkRtlOAxgrwU8n3K3E2gQXl0xKX9qEnKKg2DVz2FLlSMlgmfP0YpaS95aOlhM9jS/AO1vkLP3dmUKecODDKK31P3lZb1uBU4NIH5ME8dfx+c6dH89KvQsbBaquD3qFUUwoTP7JkZVj6sduss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPxltn78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AyusI6xL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPxltn78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyusI6xL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56C951400214;
	Mon,  7 Sep 2026 04:26:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769561;
	 x=1788855961; bh=0s9/71cGSkjcebsq9E4Nkr8msATItKMS2K9gX+KnzfU=; b=
	RPxltn78FYD00ZR1hZSzwdSDAhQaeurTbXs8fopO8cTKmDJ7QbxgrCrLfUYM7ejh
	psglTVckoMpnYHzUFiaEpjpBLo9RfqZwBB/W5OZnRyxD995yWuRk5kGVlB/JpyVa
	rwykprwIrBmgrIWK4TrZzfVJaPd9z/m1qvCQXJtp2Y1/7uVViSxJbz0meVWEY6fq
	NV5OaGdW2BpZLsjyd9TzImp3Uuh5/JzEMlWf2mX/FOKdYnOt05Aw8pm4yZ0dc4VM
	E+lKu5XcshY+QOuKdvKzCUVLftdj+X/zsNhy/RUFePoem8a5VrEU0dW2eM43dMMG
	br4Nj6S9oNJO00q4vBVqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769561; x=
	1788855961; bh=0s9/71cGSkjcebsq9E4Nkr8msATItKMS2K9gX+KnzfU=; b=A
	yusI6xL+RzYl+O7QEcDZEzDWoGJxYFl1w/0YB8KgmGa2k8zKEoDgtTwCO9MBar54
	3YzJt3odI/wijvk2aEZVz9MaC8DMvvM1QK/lvueDEUZq08mLA8H6T7UWA8VBHlx1
	pHdePwq/EO2PXlb4FaBqOzSpf5ih/+jH1JP/3h/P+ac1SFETpCnwlvOLmp4fQg12
	bO1RBHiokzoG1vX3GjjbC8WrQHuRS/mYXMTZWhj8uSwwxU6smB9hgCpNSzabQXt/
	z6l4C0T4hIuDFtLGGTGEggWvvFvmENmqB1MNBbCMQncNfeNiP40KmkpfCpb3HFeB
	3Sz/n4bFQ2IjCFLBah2xQ==
X-ME-Sender: <xms:GXWeasHl_uEp_5VuskM-2etS0CLptNzok00f1vhyH98TZxfiIWovrw>
    <xme:GXWeasX5Dcun9yoVfJ1deHeB9Gk6gmCTnV8e-w81r9m5w3BI91cugnecaKscDxwKp
    wWXqMvnUUsnYu4FjW883JKB2_-JbmNTHbZ7MNsB2BEQEIfqXQJ1dc8>
X-ME-Received: <xmr:GXWearJk4IgrwPz1w7B4rL9HERA60J1_VTBc92jKk91wb6PnlZIfdw>
X-ME-Proxy-Cause: dmFkZTEfmZyRBfCPgpRXrOHZMugmAA1Kksd9EQwfqXIYFNW3uHnh+CRTgT+7mW4adVoEqy
    OG7sX3hQg8YkLy7nzsZvJlQVp08mzQz32XLKV2cXYQxEIUtn7YBP29RKd+ja/D3QsS2+EP
    Q9PgS2JO742RKRQEwvCTcHbeIRg4RhNN7P1wr2Wm+URjI+K/k8ETVzQQPyF9fwBjb5C9T0
    z3bvElAKH/JdolXgR8vQ8+MSSF0p7ELx2sV/5ZsjBwHzJlzAfgbzBggTiQ42UTCHu2hqnX
    M0vV6kScc/I7B4uBBkcf+yPQHedeKL19rxsJA0ArV0s2J+PclL+9K9Iyq7QzTrF58/99aA
    w5ZtXJLhTc6I0Zqt03cO/di340aAlEk4HdQyMrto3sfodWyKoda3qv16DqsFioM64ufnqj
    yuDDYqTsE+1KaM9C8w+zxYmL4q4bL8pUBRDfZZUm0FR79OlojIJcXJcVNZCI6QB0LZVKQy
    2PQToczGO+ft45acP//zd+ojazQmzs6oXRbRJaYDJhpsszFn5fMTjnOl2K3Vd1BQwQDsOi
    Is/wa4IeZGNttkN8SZkzcRkPawe/y9PbOGIkBwgyNoc9z7ruJe7S+r4iIBYBYq3a8BlElp
    r02n6DVxfJNDHDNJX107RCYjzVl+22wny9CnuXOxGUXGxa+DXm/XzEh879mQ
X-ME-Proxy: <xmx:GXWeas_ZOutHcvxMhPffuTvKrwh8IZvRgqZySnrIldlj7uzoTiDb1Q>
    <xmx:GXWeauLs0wHTvzsfkTeQwO9y4xWg77w0oBU7hL59suKCJRei1WZekQ>
    <xmx:GXWeahk2_dieNK3rHNDWxxnKM_6ACECAR2JnS7OrZr5NSPuLx_DEtA>
    <xmx:GXWeaiOSYfeAEliFH5BSv7LtP-mGFdoKe-a3O7SO5D0Pwa17Vr7Zkg>
    <xmx:GXWeapFQrxraRvs2x92G5VMeV5abthTBEITQ6O1eQ7IPnfO0cfphlAE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:26:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70e4213e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:26:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:42 +0200
Subject: [PATCH v3 5/9] builtin/clone: move setup of alternates for shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-5-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
index 8786a49332..011fc867c8 100644
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
@@ -1348,7 +1353,7 @@ int cmd_clone(int argc,
 		warning(_("--local is ignored"));
 
 	create_object_database(the_repository);
-	collect_alternates(&alternates);
+	collect_alternates(&alternates, path, is_local);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);

-- 
2.55.0.1007.g17ff1f9808.dirty

