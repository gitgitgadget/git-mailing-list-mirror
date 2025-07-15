Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B72D9EF1
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578976; cv=none; b=SKT0VxS9ib/IKO7WRmscsbKR4HXW0ZclDaMrB+APgrXlxfcXHxNBPoRSzdH5zT8p+yMA1cfKsjeSmXN+YFXwbuGOWPOllXIZVnfyNKt/GTaxZlhXb0oRaGJ+b0zXy4iHvu4igqKiAWv1qF8Hk7rSO6DxSaRgbi1gTBkspvay8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578976; c=relaxed/simple;
	bh=Fo3KNiKYIwZCtXJTntyehPlJjMVsETk09+RwImm3uH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sg27yLXrTUyU44jtI04pvXgqxuANb+jRaIUH5sXHPu5As4SFL1OilykTgUfvJS8ytgwgTccb1qnax9OPMPSR3LpwigvZyOv/KI4rexzs5N5HAmcnk9WWStiNmV7fkt3vXjn7u9M562Akf9DjwN9aR+4+C+h1dY9ClaXNQoeDdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S7yePxJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEtfFi5B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S7yePxJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEtfFi5B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22CE714002D9;
	Tue, 15 Jul 2025 07:29:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 07:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578973;
	 x=1752665373; bh=FRhPY6k7uZS9aXyemhiAt23f8SChHg1pLSe/ARiWvME=; b=
	S7yePxJ2WUqXffffterzrk1+Ty91t2QGIMNdOVyHdaT6ixZ+ik9NZIZhMhCnZPxC
	b7cBnV0PpOECsAKECdeaADPlkebqS8HL2VLK2iCx9vmVybLv7e4qRL1bg3smNGQa
	87xLllJSlRYK+TclPt6N9xIQhQIcqq/Sc/OWCfOlADcS/s7G9woVrFzlyqNv84I8
	U7ZSup63O2IKnxBKGhgMk8mu+6WU2Jx8CwghcL59Dxj5EJ2K+1x/YZfuUXaEnzGR
	QSbY2lLhDvBlPBqU/dozfG5TBIw/jKeSw/Vz2lWh14Ly2b1PivCU5pMpRSDZDsLJ
	EXfC7LHouA8ar4ubZXtvSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578973; x=
	1752665373; bh=FRhPY6k7uZS9aXyemhiAt23f8SChHg1pLSe/ARiWvME=; b=S
	EtfFi5BiQxmbLEhey3UIxR35igjiAkqimHn98r9nnzp2fIpmBgTvZtTKT91S7D9w
	IbmrXAWanukWhsLK/sNGAPt76gPz2K1o4oiu0vS4lCSerRLpvOQwSkBqzHb+HQao
	uo0t5oMgGurs1jIfpwqpeXuD+8+Is3L2iqRLX7wkgi+jutvxPfERB07ZfOhs2ubQ
	1R3EdCbTEN8AdmZmB3tpN/0+d33IV/VNRk8qDkBu1akjXisDP+5YQtLjKCf8INfc
	LNfOYoOhX8YRM4l5CE2gZe7D95TSjjZXzGjuGKzpUTfjLq4SNB+lPb5BXJgBRjf9
	jkiI9dcgpzEwYZDn96Xiw==
X-ME-Sender: <xms:nDt2aP2Nby7I9u8AJ-i30NtipjsgY6v0YU5Jc6QpdiYM3ujLT0-N8Q>
    <xme:nDt2aIrQNrgYAIv00GvTmEQn5yDHaMD6XXU7QvLVVo1Wkw7bvLsagFrk7cBtu3JZ1
    z-v3wq07mf3zXPX6w>
X-ME-Received: <xmr:nDt2aMfUCnMcW4axonq0qNFfYDiIfvnfyXD_XNOF8iFxFmet_bDwbRcqjp9rZIf9hkndNjNQfQnTpR2rZnwYJ-4OtsOEltxETPCL36kZca7jmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nDt2aHqYfB0DQ5rWRK6So5v0XwB6b1F7BrkHo2Bl_zLj6kEkkEJI3g>
    <xmx:nDt2aNHVGCoGfQhLCmRvtmcLQnPtNKNzgisMytBwvj08FWBa0iu-TA>
    <xmx:nDt2aHvjQx-ZB4txwMPhiMWtlUdAxyAzWRtg-dgMWQtwSgUJtcGXZQ>
    <xmx:nDt2aPVD2cgx2XQKiEkHYQ7nR-qeRbcYS9iWmflpoRZ2V1U1ZjXBbw>
    <xmx:nTt2aDblrHy5xswCkhy7newhH6nfKCjDz9NHonow_7i-hP9L0oKpWQPL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f18e2997 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:19 +0200
Subject: [PATCH v2 2/7] packfile: refactor `prepare_packed_git_one()` to
 work on sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-2-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In the preceding commit we refactored how we load multi-pack indices to
take a corresponding "source" as input. As part of this refactoring we
started to store a pointer to the MIDX in `struct odb_source` itself.

Refactor loading of packfiles in the same way: instead of passing in the
object directory, we now pass in the source from which we want to load
packfiles. This allows us to simplify the code because we don't have to
search for a corresponding MIDX anymore, but we can instead directly use
the MIDX that we have already prepared beforehand.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8bdd85fc7e7..0b3142973b6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -935,22 +935,17 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
+static void prepare_packed_git_one(struct odb_source *source, int local)
 {
-	struct prepare_pack_data data;
 	struct string_list garbage = STRING_LIST_INIT_DUP;
+	struct prepare_pack_data data = {
+		.m = source->midx,
+		.r = source->odb->repo,
+		.garbage = &garbage,
+		.local = local,
+	};
 
-	data.m = r->objects->multi_pack_index;
-
-	/* look for the multi-pack-index for this object directory */
-	while (data.m && strcmp(data.m->object_dir, objdir))
-		data.m = data.m->next;
-
-	data.r = r;
-	data.garbage = &garbage;
-	data.local = local;
-
-	for_each_file_in_pack_dir(objdir, prepare_pack, &data);
+	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
 
 	report_pack_garbage(data.garbage);
 	string_list_clear(data.garbage, 0);
@@ -1040,7 +1035,7 @@ static void prepare_packed_git(struct repository *r)
 	for (source = r->objects->sources; source; source = source->next) {
 		int local = (source == r->objects->sources);
 		prepare_multi_pack_index_one(source, local);
-		prepare_packed_git_one(r, source->path, local);
+		prepare_packed_git_one(source, local);
 	}
 	rearrange_packed_git(r);
 

-- 
2.50.1.404.ge9779f6434.dirty

