Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357537D130
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415229; cv=none; b=DcMYLiO0bgcTPfTbE+Ct02ggd8aYHi6jUdRjarxY+u7WaPeu5Zjg1aDJd2k7+mIaptFfPrcEUQ6wpem91bgCBI7A5gPFpxPm9YAMcVw23Qfy9ncPbhuBn6q7vG9jBPqUda1IdTpcqywfjrymjgoa1OsJRfIEvlSgqsXYcB9Prjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415229; c=relaxed/simple;
	bh=4U6QVcBwMbI2NUKi2kfKTisXqNAXJKOaFyiP+r1H2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en6kxyPcyocmPCYw8AN5G4Tr/bsiEu/e8mtNwGF87+fVUS20FItL/8Sr8DzCYtupeX2HqycViZPX/uNrIWRW5/zXp50tw9b0vY8OreA/5cEfHgd2M4poac0g7XZ2Kawteh0JZBBXoyiry69pf0ghoCxcfQA94icL1vzOEufnJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KW/7EMGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3Mob3Qz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KW/7EMGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3Mob3Qz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A273C7A0277;
	Tue, 28 Apr 2026 18:27:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Apr 2026 18:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777415226;
	 x=1777501626; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=
	KW/7EMGqY3xKt2qRC1vcAKcHwFa4YBHjcegrYg3CFuBrpgSUIUQVhAfazPjXlscT
	9+2S/eVBi0/AFjn7nvM5GHWzWrR1rDQALNqAKvH/70Zeoiy2Xoab3jZ1CG0EGBaI
	4g9Wt3qaoty418CWmIX0JDREsCgGc3pN78bpdrJ4hETeFybUxW40STacan8SEC4O
	EWfM15o28KmYndkA38nD0bQGC4BEFtYyiBz0EgAXcKhTrYIDr82ZEbUVmz2xiM5G
	HdwKQ+D3szfqVGE/ZkSiVYJBOR2Q6aAn0IK+hYvnoGzfKjNVUg81c+2oZK8KjhwF
	VCtvb0x8VWmIvMNMN2YpEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777415226; x=
	1777501626; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=B
	3Mob3Qzy68Tt6bbPon7y852H8sgt8qeAaZFq4EXIpqwX+ble5qrKkLfFyHXiY2kI
	f6n9CD1s0cDpQDZPJ9EGoH+zlIEAMZukAtPT4+UnY2jxJWAR5vwqJl4eqmxGYAPn
	RxIHy7q/0GH5wqXJQ/HsdxBLVATHKWcXGSDKqW+qiNsYpz284BNfyHY2f8z9VgQn
	0zti9Mc0Bp637GoW/FffFZeyJ6SNndJ8EAjQ+4oLFhE/5HaxcUCg00K2bUZdIHr9
	8ip4JQyB05zs/7NabYfv6m2qqehttJD75aQ1kI7fmirV8F5tSrEA/89/9hCQn/9O
	i4oP2GVkxdQzVsKwubsiw==
X-ME-Sender: <xms:OjTxaVdyF4VAXadGjRwFfBFTXdr1wDoY-nSot0zN7P-urQOTVNKxj-0>
    <xme:OjTxaarQu0dG6G4xtmLc5WJWj9QbSK2nyXDf8TD5Uiaml7FAeKMg-BAX18Hj2aUQf
    UQfY-aiWqX4GEBI9276UK1fBD_jJzd-Fl_lb13ne8CReINMi7_2ow>
X-ME-Received: <xmr:OjTxab6cpkVtvhZLXh0Ogfzi8Sp4ydgVoQZMEZusveH6DHJuKgkNYT0I23hQ5mAsGIpoGh_hpHIZm4eBL-56hb4u_b5RSEGnj_zEgoyWrgGdcm2klZVG2xZ4AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OjTxaYr0tYQpBoV_yefsax05NvGN65EwDXyHxYiskaAWmvRtnvHNeQ>
    <xmx:OjTxaViWxoAaSuVl10UX77zxZ_4XQ3JZ7knwSUkXm4kjHnisjSi_4w>
    <xmx:OjTxaaKUUjMLwAEoi-DxKoJ-6kUdJ8XdfWt_JmGM_c5D0XQyhPoxEg>
    <xmx:OjTxadDe3fonuwUd8hGir3KHUQpPAKCE-enG58BBduby1HULvd9fKw>
    <xmx:OjTxaWozq11JUbWnOPUt4qX1hHpEV_8GJeJzpYN2RzVLQPZYE-hgE8Iy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:27:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 2/5] name-rev: run clang-format before factoring code
Date: Wed, 29 Apr 2026 00:25:53 +0200
Message-ID: <V3_name-rev_clang-format.66c@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz> <V3_CV_format-rev.66a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to move code around to prepare for adding a new
command. Let’s deal with clang-format changes first in the affected
areas.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/name-rev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 171e7bd0e98..6357eaa76d0 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -519,22 +519,22 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
-			 !ishex(*(p+1))) {
+			   !ishex(*(p + 1))) {
 			struct object_id oid;
 			const char *name = NULL;
-			char c = *(p+1);
+			char c = *(p + 1);
 			int p_len = p - p_start + 1;
 
 			counter = 0;
 
-			*(p+1) = 0;
+			*(p + 1) = 0;
 			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
 				struct object *o =
 					lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
 			}
-			*(p+1) = c;
+			*(p + 1) = c;
 
 			if (!name)
 				continue;
@@ -571,9 +571,9 @@ int cmd_name_rev(int argc,
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
 		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
-				   N_("only use refs matching <pattern>")),
+				N_("only use refs matching <pattern>")),
 		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
-				   N_("ignore refs matching <pattern>")),
+				N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 #ifndef WITH_BREAKING_CHANGES
@@ -585,10 +585,10 @@ int cmd_name_rev(int argc,
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
-		OPT_BOOL(0, "always",     &always,
-			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "always", &always,
+			 N_("show abbreviated commit object as fallback")),
 		OPT_HIDDEN_BOOL(0, "peel-tag", &peel_tag,
-			   N_("dereference tags in the input (internal use)")),
+				N_("dereference tags in the input (internal use)")),
 		OPT_END(),
 	};
 
-- 
2.54.0.13.g9c7419e39f8

