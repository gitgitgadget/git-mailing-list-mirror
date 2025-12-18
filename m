Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB62BEC5E
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040934; cv=none; b=llzmV2FNOQyMnVhcmYoCg80B3e44c0m5oIcx17EBxfSQdwgYh6mZe8uyczNscN0Cw+Ad0s/WuaA50jYp3CUqZC43hetpFU2qMCJhCOLq72QVO6pbXroiU5Rks4DARgMJSwD9xw5k0bHFYx0rJPccYaP0jRPi2oaazGMKdOGRnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040934; c=relaxed/simple;
	bh=InIlYGS3wprgDvv9CqZNJi3poO+/rIbQcipI2FKJK3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9wcF2PQVqDdnxJRMtfGJrI6l8YVlyGIwXildqS+kInWeOeBnLEIZp6idsOrI2g9veR/b2/l+VU5RhwabGCrwd2EtRuzK/WwW7Yw+DLPa3LtlhD84Mr3bQODALFIGizMODG5Vk44WHDe6CyB3O/zmx6m5wKyKsY5pMcRsVi16Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYbBJ8u+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u082NE4O; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYbBJ8u+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u082NE4O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A7FAD1D0009F;
	Thu, 18 Dec 2025 01:55:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040931;
	 x=1766127331; bh=KZGzEo0k7+Pqn18eqoqnRYlOhhn6k0F1U6MYKpeLICE=; b=
	RYbBJ8u+Z7GjMSgLr7xTh1QLiyIfArHAtlGBYsiN4UIW5KL176ebkT9+QdR57BPO
	OL2kxFsCHJE2FWveGD250tgmRbwF9aDY7o02EPme7oaBW36s4a6RGjzCErL842Rw
	NchKqGMxgdTCrXG4lIyeMN54P2STC7ejdlJqcNr+Qj2VUll0QFciCRmSU5HLhHSm
	Pz87pYuujSNm3wumhDTutT1+p9FOZgnQgLOrnj3TYf2hbVqjxDD0m9UwBepNuIQ8
	Tknwyf/0ZJ9kpfEbSgyYt0P19b6n8Q2zpXagFuODcKXiPsTczp7PH9J1LpURU2dn
	qHBcRpAAwyT9soxbjw9X/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040931; x=
	1766127331; bh=KZGzEo0k7+Pqn18eqoqnRYlOhhn6k0F1U6MYKpeLICE=; b=u
	082NE4OUkiC0aNc4g3a05R7DJ2cXB8eIJRWCPihFjyhp7u0CRRbd569F6m1cGb0V
	F+yV6KoySTC+LqcCZM1rguZ1wg83XM6hSOb6nvKnGoE+EWH37TwMbKtZkvpWa1oK
	OZvSYUBA81gHMPGjCuiuVuzu1SYrpyc1iLCnxLHwd5tHzVTAvmzHMyyfqt7bjhr9
	C/FnLg+Um7HLcZNwANI+o3YmI1IzA373xDphRBtnlCgX6XQSnk0x+8PryVS0woSW
	15t+vd9QAAKrBFeX3eHb7IpsKMTlqp8Dfy7FSEQE9rMbWXpsr7rh1ScLHpeVb9SB
	6JwTIzyPDP6msOZGVFDsg==
X-ME-Sender: <xms:Y6VDaYGCE9_3yA2oIwIyTIRHjIHS70BAGpQcSMzkrPTEyxkLglMSvA>
    <xme:Y6VDaXUWDogVHfqBwKNB9WnoIlsoGAP0Zknsov_pQHH-BSLZZi2zx1IVbTbaYywQ0
    WhfSXycP947p6wI51I4lkBsyfp5ZB3MAHDROypOrOXcKO30wLxc-A>
X-ME-Received: <xmr:Y6VDafyjUfRa8WyTZuIWMLrqKZOehwR1oeEZRUzMEUja1KLbBo601z0BygY-wje6xDrG3Q_iqLrUnR9Qnv4HokAdHZ0R-mcYs171T2C5iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y6VDaVODQTy4t9pnqzftiLVmepo5mgTC2wEnkeUny6g9Rx7HnFtQTQ>
    <xmx:Y6VDaQ76K3gQnkCo_buKyx6wpdY3UZbfi48V0ntxI1hCTzUyNJYSyg>
    <xmx:Y6VDaWP34fNcGRFTipNREOUvmE1xF3eWGPhorenyAY3BUPEWV14AsQ>
    <xmx:Y6VDaen5UaBCTrThXJqSUXIiE-XH2hwTppEWHYLYpkZThAFTL4YQyQ>
    <xmx:Y6VDaY39xqSF-6szlt0UnL7YNS55S14j3jB95beTrk4n7cXSDSLZZuVx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9d935c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:21 +0100
Subject: [PATCH v2 02/10] packfile: pass source to `prepare_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-2-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When preparing a packfile we pass various pieces attached to the pack's
object database source via the `struct prepare_pack_data`. Refactor this
code to instead pass in the source directly. This reduces the number of
variables we need to pass and allows for a subsequent refactoring where
we start to prepare the pack via the source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0a05a10daa..ab86afa01d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -975,10 +975,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 }
 
 struct prepare_pack_data {
-	struct repository *r;
+	struct odb_source *source;
 	struct string_list *garbage;
-	int local;
-	struct multi_pack_index *m;
 };
 
 static void prepare_pack(const char *full_name, size_t full_name_len,
@@ -988,10 +986,10 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->m && midx_contains_pack(data->m, file_name))) {
+	    !(data->source->midx && midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->r->objects->packfiles,
-					 trimmed_path, data->local);
+		packfile_store_load_pack(data->source->odb->packfiles,
+					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
 
@@ -1020,10 +1018,8 @@ static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
-		.m = source->midx,
-		.r = source->odb->repo,
+		.source = source,
 		.garbage = &garbage,
-		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);

-- 
2.52.0.351.gbe84eed79e.dirty

