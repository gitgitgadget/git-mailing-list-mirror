Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0424BBFD
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380770; cv=none; b=rnmoNDmTDe9vAb3mofcuXe/1YTrWeqGcSKSSh1GXtLSABHc56xljsTt/7266bnTt5PU/c+VG+rj3XwDqVIdyhCOiIthV3A64pq3jjDWMgD9SZg4887Dr3V6H10/9wkiIDtkEe9HKraRaFrdqSQ3OA9E1oeMhs1CHmUugXZtBie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380770; c=relaxed/simple;
	bh=yb9Ane3wTfmZjTBBpAOXQvfp1WgBIIMmr/QaoapE2CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmI4O7xqYTT5EltFmFuhfGyUWVYvZP0Fh6tJ2deYy3x/+AvIUij0Uc6XqPY2QiMAfxmxr83MBaVJyy1N2z+t4c3mQTam31Mrs9PUEVFWwD4i3inehmr9vWit+UJb7TDFGETqNkQqypMkhf1Cn/a13g3p+4gwPtD9LbUNE6y+Ak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K+fhnU5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTU6nrDM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+fhnU5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTU6nrDM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BC681400009;
	Wed, 10 Dec 2025 10:32:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Dec 2025 10:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380768;
	 x=1765467168; bh=uVTYNwcV/gDUAxifNjYMJHxZPBb7cnnYh+XxO7Ntbtg=; b=
	K+fhnU5CFR4ZLv5GpHqQuYvFemov1Cz/MEofocXiYq2EYegGhAiueMwKgc5U8TWr
	TUljhSG4z8qu1MgKSEt+9u3FGgVpUuQ4qVOMdf0nI4VG5s/4eBUfB/bst+jFdArD
	6siMXYudRaEcb2lozSNJSrqxQmokPZ2zzbrJNTBvj9py0AT7hfgX3DokChvx8UP/
	IdmJ7+yl/6gWDsJDuOy9YgSzyNWd8mpi00FumR9bLP4kmhRFRhLxFQ0nizjzpkqQ
	+j3ZvME/wxmhulMm7TvY3ZTZlJlSI/a8ItevKkpwPLvAlQ5T8/Eo6NLuHcIq5K0s
	0SBkdUgCXFTU3MRkV4VVWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380768; x=
	1765467168; bh=uVTYNwcV/gDUAxifNjYMJHxZPBb7cnnYh+XxO7Ntbtg=; b=j
	TU6nrDMpdKSxDqjPVOn46GoJfkWUlgz/RrXDkBnCkIX86C9E1XaE7nn1B0isf1as
	lszvcRtmyQfKHQ5rD8yrJTr0Ska59BaELo4nYOYdAiKqkJItnXYiyDpzenWgK+IC
	cPWpDkC1ZBhaBMazKaMkJf+eHszkGww2A5WFCUo2ifAHTPvx29rl8YCE3K8CUK29
	I7D3PJfnTWvlfJWGZkuTnK+fp9t3wgjQxM+eoIckliq8NYjc/+dtM3KgVg01KaYT
	p1aBr6uSiMoy0fy4oNjU/49YaMm+ZtIM9n8nOdiG8KGbgEjeQRs5l3LaaWuv3rPb
	96ytkME7fxXI7sRrehW5A==
X-ME-Sender: <xms:oJI5aXZ9Q6_4pbTEt4p6JbpXTuob7AjUzDAvp8S9EPUNiXX3tkBN-w>
    <xme:oJI5acYO0BesR_aZa8xNjiA6goXjV95ASpmyl3a-8HsgegIkj0jc2ZvrQ5176MrGT
    hLuRm8PAEKfp0VtO2W08ZFkL7aCnClxMFPDhRxjZvRwMgF-IKB4cQI>
X-ME-Received: <xmr:oJI5aXkkrZfkMpG7Y9a5RurJSANXsRRfba_cAbW7KjLpJNHjr1BYi8zug_oCDHtlPF8tvFmt7huR7QAkisHxYwz1FsCN8nPIt6f5m-cofI0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oJI5aYyG49jeH4FZueIPH2spxlwDTperqRtwlDQRIGpVkKEztBdXPw>
    <xmx:oJI5aVOPmB6kKd3XzbXf5i-AzpNO4QCDEG5HKpoXVSsHx6mbBFNHhw>
    <xmx:oJI5acSD1c9wC9-GJby0bJ71N32nHusjopIreaTW7hXnXONw6MAZaA>
    <xmx:oJI5aTblj54lydwrY3xWSrxBWjSkzqT7n8aQuSH1uUN2cT_xAQzFfw>
    <xmx:oJI5adLfYghiAdrv_yl1Qv_Fi0Cy2fies2BZP7V1Mj82i1ZaRCVoRaBQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 013574ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:36 +0100
Subject: [PATCH v2 3/8] odb: move computation of normalized objdir into
 `alt_odb_usable()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-3-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The function `alt_odb_usable()` receives as input the object database,
the path it's supposed to determine usability for as well as the
normalized path of the main object directory of the repository. The last
part is derived by the function's caller from the object database. As we
already pass the object database to `alt_odb_usable()` it is redundant
information.

Drop the extra parameter and compute the normalized object directory in
the function itself.

While at it, rename the function to `odb_is_source_usable()` to align it
with modern terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/odb.c b/odb.c
index 699bdbffd1..e314f86c3b 100644
--- a/odb.c
+++ b/odb.c
@@ -89,17 +89,20 @@ int odb_mkstemp(struct object_database *odb,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct object_database *o, const char *path,
-			  const char *normalized_objdir)
+static bool odb_is_source_usable(struct object_database *o, const char *path)
 {
 	int r;
+	struct strbuf normalized_objdir = STRBUF_INIT;
+	bool usable = false;
+
+	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path);
-		return 0;
+		goto out;
 	}
 
 	/*
@@ -116,13 +119,17 @@ static int alt_odb_usable(struct object_database *o, const char *path,
 		kh_value(o->source_by_path, p) = o->sources;
 	}
 
-	if (fspatheq(path, normalized_objdir))
-		return 0;
+	if (fspatheq(path, normalized_objdir.buf))
+		goto out;
 
 	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
-		return 0;
+		goto out;
+
+	usable = true;
 
-	return 1;
+out:
+	strbuf_release(&normalized_objdir);
+	return usable;
 }
 
 /*
@@ -164,13 +171,10 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 							int depth)
 {
 	struct odb_source *alternate = NULL;
-	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 	int ret;
 
-	strbuf_realpath(&tmp, odb->sources->path, 1);
-
-	if (!alt_odb_usable(odb, source, tmp.buf))
+	if (!odb_is_source_usable(odb, source))
 		goto error;
 
 	alternate = odb_source_new(odb, source, false);
@@ -188,7 +192,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	read_info_alternates(odb, alternate->path, depth + 1);
 
  error:
-	strbuf_release(&tmp);
 	return alternate;
 }
 

-- 
2.52.0.270.g3f4935d65f.dirty

