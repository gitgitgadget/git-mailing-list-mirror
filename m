Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51476346ACF
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208592; cv=none; b=EVMpSfB/ID1JQq1I/zivDtsTmd0UOf4ZJ4FU4Ua2o+t29IDgKwJJrpglznG2kJYz7+yyEmzjh6Xh/+bMXbHs4Otr+QZrXnsXYFOvUKTdO/KK87NFZZ9PtAQXqO8/MvlaOutdmwhGeb2VB48AH4t3qRamy5bTT54bcwWNKQ6Nlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208592; c=relaxed/simple;
	bh=4itYaKqd3lzpLZSrZ7NrP274Dtvux2hrRwfuq0nd74c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvzuWZokFvx+reGQmZ6TpOdz2KDzlhUzuD+iyJknv2yiQYAaOHtEecA7dZ6gr7pUx1KufZyHFzudv0J5R6UNiSgo1G0ipGvc3LKphhPBa84TvP4CG2WEfgYoKACBUqg6KT6QVwoC/NepdZ5Kne21HmahoZsUjWYgPJN1gWw8YiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctfF74f6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJFRT9pb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctfF74f6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJFRT9pb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C83FA7A007B;
	Mon, 12 Jan 2026 04:02:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 04:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208578;
	 x=1768294978; bh=qDaOpVfYYpwgqsC92+1OxYpzMOgy2EHY8E+JD5i3EXQ=; b=
	ctfF74f6diDl7Cr13hJVfRHjEmEc3aYm/xAGjYpBQ14EnuMdWAJUePPzcp8RuNc9
	Nw8R4g8pw9yh6oisbrVhUkGLWmM0qUFwB/BVCXZI4eSuaYcOfpD1wql3P/sNiJk8
	Kt9uwBlKA4u+syr0Xjw10dfIC5WC6abCrbZTmBbUzvDUFF8djNR/L/GB2QeLeP5e
	kwJaMejLo1NWIMOcIbouq1CUkiSlsVbt0c8r7+7L/SLtJTUMVpX+/lrEH7HeWPql
	6mCpE4mq1z0uGSpRs/qCAE9baA2OXKmFVWlb9kRmyNjTUoLCV6cuzoyNFDmWQyWQ
	V5CIqAyTlqW2PbyTNmH4wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208578; x=
	1768294978; bh=qDaOpVfYYpwgqsC92+1OxYpzMOgy2EHY8E+JD5i3EXQ=; b=d
	JFRT9pb9CHdptK/YDEUD+6DYXKfWXdkqK+O46D+DiyN2QF0tpTAEC0MA4VbSfeHJ
	4mkoK5Oef+VjzsvoHnnMUDL/FKj/VOgTqw+BqHP/J25OC+kuAiy61MTO/1NxAkYY
	JrVTUlpFtCCv8s3SKRlndZrqrut6pk4HhSFgwY9XNUxt6n8FSBglY/1fzdtx81Lj
	JvaKyyB98vI9qxAq+VNbHLgF91ku4CZCRlUiyaMJnHk3vhOrOQJvPCr9mdpx/T0Y
	o1mNTkUKfH2LgEqc7wxJSWVZXxXtvKyr41V/q2WMCaAI0IkjCGyyvtnK9BfuY2H8
	0N6ti4OX24O9vYiRjH7Xg==
X-ME-Sender: <xms:wrhkaaDSafISIWAc7xkBlJ8Ph5tkEj4wFg9nsYUEzxRGPtt78PHhCQ>
    <xme:wrhkab9lnOdn8uQf9JMYtsbhLJiuvYSxM6B_3A4A9xBxl3T5I1gREP1HF0_lSRqQg
    PV32drpxAQN-3PcXq7J6DYeMfa8V9X4fAzyBdb-d3aD_vrUH3Xm>
X-ME-Received: <xmr:wrhkaa_0ksOORf6hdOFTfFtR_A6Nnb7nNXwiIy3qoYbbJbDEju1tX7-w24s5m6qQJwoIIMAQFZgVRF3sOc1ggTG-N0qa9hVdSnEG3uFKEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wrhkaSfshYnxhsBaCiqcbl6EEsVMfe1FDdfiyLwDEMlGSaN3DowSVw>
    <xmx:wrhkaTEShtCJ6o2hjMw7Thsv2aRBjlQKqVMEAB0v3334fG0hhPKE2Q>
    <xmx:wrhkaQdGK4tLhu8kMEaOv5MX5rGC2Ko7HYU8cLxG3pn9fieQbPST4Q>
    <xmx:wrhkadEknjCOFbRLMoSBnWC6_KMdzRK6IcAWuJiCgagZO0O16AE78Q>
    <xmx:wrhkafZB5Ni8bXIiE4n96Z6KvYXFQ9sgbJyYJ7vkeokUON8TBtneX4FU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:02:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b4fef35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:02:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:50 +0100
Subject: [PATCH v2 01/17] refs/files: simplify iterating through root refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-1-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When iterating through root refs we first need to determine the
directory in which the refs live. This is done by retrieving the root of
the loose refs via `refs->loose->root->name`, and putting it through
`files_ref_path()` to derive the final path.

This is somewhat redundant though: the root name of the loose files
cache is always going to be the empty string. As such, we always end up
passing that empty string to `files_ref_path()` as the ref hierarchy we
want to start. And this actually makes sense: `files_ref_path()` already
computes the location of the root directory, so of course we need to
pass the empty string for the ref hierarchy itself. So going via the
loose ref cache to figure out that the root of a ref hierarchy is empty
is only causing confusion.

But next to the added confusion, it can also lead to a segfault. The
loose ref cache is populated lazily, so it may not always be set. It
seems to be sheer luck that this is a condition we do not currently hit.
The right thing to do would be to call `get_loose_ref_cache()`, which
knows to populate the cache if required.

Simplify the code and fix the potential segfault by simply removing the
indirection via the loose ref cache completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..297739f203 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -354,13 +354,11 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			     void *cb_data)
 {
 	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
-	const char *dirname = refs->loose->root->name;
 	struct dirent *de;
-	size_t dirnamelen;
 	int ret;
 	DIR *d;
 
-	files_ref_path(refs, &path, dirname);
+	files_ref_path(refs, &path, "");
 
 	d = opendir(path.buf);
 	if (!d) {
@@ -368,9 +366,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
 		return -1;
 	}
 
-	strbuf_addstr(&refname, dirname);
-	dirnamelen = refname.len;
-
 	while ((de = readdir(d)) != NULL) {
 		unsigned char dtype;
 
@@ -378,6 +373,8 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			continue;
 		if (ends_with(de->d_name, ".lock"))
 			continue;
+
+		strbuf_reset(&refname);
 		strbuf_addstr(&refname, de->d_name);
 
 		dtype = get_dtype(de, &path, 1);
@@ -386,8 +383,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			if (ret)
 				goto done;
 		}
-
-		strbuf_setlen(&refname, dirnamelen);
 	}
 
 	ret = 0;

-- 
2.52.0.590.g1f87b77810.dirty

