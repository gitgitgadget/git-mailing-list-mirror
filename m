Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A47485CEA
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133259; cv=none; b=ZUA2vTScZtYWCRwWkp6/r7rf2eMQybnwQugfxHiRzb2GIK4Hahfhm5clLCBMqrn8JpTpLWrzMsn/PvvvTJlxLpT531TLzFWxRvhn8dKNDS4sC0Yzo+h1QDAuxQF25i1F1vnh8rEOXDBJIR5IW0QeoSqfi1fvCQ33S32PNo8eGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133259; c=relaxed/simple;
	bh=encLz69yoHzl8xY2H/mx5HL7Db93rq9sd8BRcA/SaNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZzlrDJLbN9sqKGthRRkaxZY7sgEjH5xvQg4AVQnF//DqDWgliBwrG7vraJZ44ac4+c+j0UK2KsutYRvrAxjidI80RvsPMsa/xpnZ/f2jZ2iXe4Hos/mkzs7NzCagjzpgVcHjE5lnDDfZgPb+tm2mlVJP1mUDKDZBHAfJH3uwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EJwKv/gE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSM404To; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EJwKv/gE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSM404To"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 80733EC0237;
	Fri, 11 Sep 2026 09:27:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 09:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133257;
	 x=1789219657; bh=OSzV/5ASpcbTgF5wcki/y+vK9CEk1erp2quyNir/Imk=; b=
	EJwKv/gEVmLOqpGBx/sskmLQqe0CQRpxod2aWhKReoFmoei5enBJ6gVGFpF9aeDI
	kiSyz76mpQj8nkVta/7Ijz6teVirO7TfAXYJoSP+AgxiE49kkYn2KqzGY2kRAo+3
	O0XwVJW2S+zao8/BqNg+l90W0cbuQWxKw9b29NLUsbDIdxNG4eATIYm7CiaN2Fh8
	5PRgEbHGCxu9JEVRWg3VXDM5oR7TrHuoxunyVvMTrd9Joo5yvKEzAjWkHJLUxuiM
	IdChhwLvlG73KunpPr3gJM60vvbjDtjDuCVhHDem7YS+5d1ObDCQsJI3M+sTozWW
	qCo5x2y6J0r3RobtDtjITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133257; x=
	1789219657; bh=OSzV/5ASpcbTgF5wcki/y+vK9CEk1erp2quyNir/Imk=; b=d
	SM404TodSjQ3qjEyDkTuyZSaX80Y3668tN0kLpJRI7xNN6krDAABZ/VBLKBSr2Ht
	lZDdLWNYytvf6FChKvgf6m0VBiFzE20gN8LO6YBoJIwjkJ2GuzwQLWcuXNbf+FbC
	KYG/p7XEgL7JId2OzZOuomNQRS6i1o7o4Qzl9rf+bM+sPTBmEdEfzFbu22ulnHJN
	WjR4OoujxBMqyB88uOJJXfqRisDxjiyGpKu68BZIyqj4GnB67AQoiJE9AhHru0I5
	8ymdjT/ZF4aHFLS+sCIa39ZU+3oPLYqZzUE3ShGgToq/Mc/PgegV2ZRanZQYtGmw
	39EMOV0oqpQkEUpfQOaNQ==
X-ME-Sender: <xms:yQGkama7hfAQx9gUg9qcsL1noUS3KQ15qbHFwye6KqdcwA5vQjj7lQ>
    <xme:yQGkag1mKHdOWpqK9xOyqB9FgdJ82HdTZ20BGNCwNoQwLnNbr-IpK1zDflu7_fPLl
    EGzdaO5iafPOkcM9oOEpCpj5PYPP6FYtLkqiX8nqKuMr1a2MyIUM34>
X-ME-Received: <xmr:yQGkauUpXZbWCqSx8x0sSq9UatQAfDh3RuvLfa4x-0eWLOCbsY0L9NzwFDeUUTK8M8hYQQ>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9jo
    EcQAGWa/PPEDKJgMjIy4+nXCWzvMgzAXc/scxIw605YWLnh1ECUmxACbd35Mw1wbZ2qdCF
    wl24hBfU+NLO+3E68N5aJqi1QddeBkeHdspZshMSw7ZhhfeHhIVHKlJ1HoULIXM2C3rfR4
    74iNVmp2ZbTql+VQePU1GlwbK08r6qMz3NAFaXzDGcAHW6gD17nZ43uyOL2JK513TkGI2E
    4IOREmcNXTFn2igYKt/YzBhWkVhuY6UR1HGbFgtieFbdaDsYNNMqDbbdXt74I4JYuovlcd
    4g9Y+adHaj2Fh/AmL3WEQB64bB1UhIsq5u/aBG6tTYsdpdF+e+p0nHlU2mWA
X-ME-Proxy: <xmx:yQGkaiUYNde52KdfbQnwnCYLJcp9HmVGoEc0jNJy2ntiemwS2UNe4A>
    <xmx:yQGkalcByhfUHSj-9N6aljyXqhAuDPMR5HyqyLNmpuNLZHc7fL1Uqg>
    <xmx:yQGkajU9_FYJFo5UQoMkEWOHnFiH9odEraqWgAITuCWbzlFHFEfRVQ>
    <xmx:yQGkame3EnmPk1X4OH4ESq4G2tnKN1vtZew7C77pSnqPsBF0D7jD5w>
    <xmx:yQGkao1CYIGitAA7aR4hqHIcNikaJA8V3PtknBF9lFQ59sS3kuZu-2Ut>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2474eb1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:27 +0200
Subject: [PATCH v3 03/10] builtin/fsck: de-globalize option handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-3-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In subsequent commits we're about to rework some of the option handling
in git-fsck(1) a bit. It is currently a bit of a mess though due to lots
of global state that makes it hard to see which flags are used where
exactly.

Refactor the code by moving the fsck options into `cmd_fsck()`. This
allows us to convert some of the options into function-local variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bed8481893..5132ff0f15 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -37,10 +37,8 @@ static int show_root;
 static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
-static int check_full = 1;
 static int connectivity_only;
 static int check_strict;
-static int keep_cache_objects;
 static struct fsck_options fsck_walk_options;
 static struct fsck_options fsck_obj_options;
 static int errors_found;
@@ -48,8 +46,6 @@ static int write_lost_and_found;
 static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
-static int name_objects;
-static int check_references = 1;
 static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
@@ -964,30 +960,33 @@ static char const * const fsck_usage[] = {
 	NULL
 };
 
-static struct option fsck_opts[] = {
-	OPT__VERBOSE(&verbose, N_("be verbose")),
-	OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
-	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
-	OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
-	OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
-	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
-	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
-	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
-	OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
-	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
-	OPT_BOOL(0, "lost-found", &write_lost_and_found,
-				N_("write dangling objects in .git/lost-found")),
-	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
-	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
-	OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
-	OPT_END(),
-};
-
 int cmd_fsck(int argc,
 	     const char **argv,
 	     const char *prefix,
 	     struct repository *repo)
 {
+	int check_full = 1;
+	int keep_cache_objects = 0;
+	int name_objects = 0;
+	int check_references = 1;
+	struct option fsck_opts[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
+		OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
+		OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
+		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
+		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
+		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
+		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+		OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
+		OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
+		OPT_BOOL(0, "lost-found", &write_lost_and_found,
+					N_("write dangling objects in .git/lost-found")),
+		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
+		OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
+		OPT_END(),
+	};
 	struct odb_source *source;
 	struct snapshot snap = {
 		.nr = 0,

-- 
2.55.0.1074.ge7621b4bad.dirty

