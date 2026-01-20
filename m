Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65514779B4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922778; cv=none; b=dqNh2hGOim35BJpogjHFTOYlWsQx3pS2K0j+EZzGOEPMQMKPoPNjJaNK7qjsVninVK5cA1f1DBk+aDDNX7iPgFwktaQgfm9cF4FUYKeDsxjNLIodHZSBmHW2Xy/AEvOkXzLRqCTwGHhPiKqOApyj++gv3XGcn04mxmeU1Jbz1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922778; c=relaxed/simple;
	bh=J9pj0UsE6cJ1pElIurA29+w1o4xlRk/CWYqduo1PK8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYHR9npC/o+7djqAtLenNXOlc8W8eGFajcCYlttqRN4mi+z+SRIVB8zDXBJQHiBeXl3nZLgYqknWDwqPhSbvZ6pqbqApcj4l/DjEHxMD9hCTCEC+4SyjvjdOQJ+UHfBU8pkXCWomspY6vzZnWjIvGAmKKEc2wFJEATqwM3nRsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cWTLRtGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VUzluo49; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cWTLRtGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUzluo49"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 871A27A00C8;
	Tue, 20 Jan 2026 10:26:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922773;
	 x=1769009173; bh=+lGnCwRXIBfZPpF4G00X2HO26xJ7etwGgoR6SRNlKmc=; b=
	cWTLRtGBVxcf9296iuc1yd7y9u+pvOIOQJMKL0azKmFoiG5Q6vaksTI+U5Bml16R
	FQ1oR1tKYkwmU9hEBqXYRuqsUT3DPEDQiTjf7wOo26zD2OAQyyHqMIaVU/U2frnC
	O2+R8aM3NpZbJ59vScpVIjKEeoNmGYoKmffuMRYIrhXaPhjZIUMAonVSvpcI1yPc
	34PWJqmfyZ+ZcFnyux3VRN/HudL4tUTE4PMzm15fGPi6hc7X8UoJvJs4gAmSbEEX
	+xVIxVZ0Sm3Nilw8/AubDlGQKqKZSVg6L4FKXWPaTBsk0t6ple4SycE5TJsxFbl1
	f0xwHhOcAITMlWuwlRjj1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922773; x=
	1769009173; bh=+lGnCwRXIBfZPpF4G00X2HO26xJ7etwGgoR6SRNlKmc=; b=V
	Uzluo49jK8/xib46Fgyn52IPaa++9h3Al1fS3rpXOfwMEUiGlm4RTGf5H7hOUil+
	qaWmZpS7uLEcw05G13jCVPgzSNGnHyISGKIAT4QbYMR3eX6W5LKuczmsJBpgNadt
	8D/AlxbGyqd1syO5nvWQBRIH9F1ial+oGMy0nHTsJ2pJWrT5yXgvk8GvBgDnkD5J
	gXj0LCpXe36Mfq8Gwzs0PIRx0W1Noc7t9tIiZW/m65p+LBWp6REjrkNsZ+xo/+Gf
	XfEax5a1CAetoI1tWQ63cMMrfpN+8pQ6UBg2JasIPE16SySrdDbsTXyJa3x2JY2Z
	+Ab2EpqFL1sBI7TBmvQbQ==
X-ME-Sender: <xms:lZ5vaU1RLY2UTRhTLBgbd06v-aCZj7BHzfCZuee_5vGlkH5arUR2cA>
    <xme:lZ5vaWGMge80Q7jPe7P3TVEVDp37zR-DgDY74sZdi7QdyiGmaz4Rq2co3D44Ex8iS
    E9cI9dnXBbAY1XGE0AZKSImDbblpSIs9jJoHpv-nBJmvF2NwoEL8LY>
X-ME-Received: <xmr:lZ5vaR75nVNk0GTo2U2dghosinpzzFa_ni6Kwb4W-zNZLdlZ21K3bgOn7OkKkObMlZair2IC7CrS4bC6fjgNeN31Xj8ADm17_uNB3fTz3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lZ5vacsT3AxaVK2VrcXwesOKvX2wn3WCxCZ_KssjtVM-AibZ-00vnA>
    <xmx:lZ5vaS4F4ikm5JnVU5p0_dg8InIirxeivhhrD46mVu0eLQjmiiL1Aw>
    <xmx:lZ5vaXXW4d6qAzfFMNnyf2jGTfK85xCwYv6FYnGnxPAtcDLueZm2UA>
    <xmx:lZ5vaU-BnH6Pv-Fc-3flnsW2kxwj8SQQZL6hU4Bk3nowOO0SnVXl5w>
    <xmx:lZ5vadZwKvo2wymkadAic9rw-dKKVRqouaWZhwnSuWqbfvzumbpVvDyc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5d6a83f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:25:58 +0100
Subject: [PATCH v2 02/14] odb: fix flags parameter to be unsigned
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-2-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The `flags` parameter accepted by various `for_each_object()` functions
is a bitfield of multiple flags. Such parameters are typically unsigned
in the Git codebase, but we use `enum odb_for_each_object_flags` in
some places.

Adapt these function signatures to use the correct type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 3 ++-
 object-file.h | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 64e9e239dc..8fa461dd59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags)
+				      struct object_info *oi,
+				      unsigned flags)
 {
 	int ret;
 	int fd;
diff --git a/object-file.h b/object-file.h
index 42bb50e10c..2acf19fb91 100644
--- a/object-file.h
+++ b/object-file.h
@@ -47,7 +47,8 @@ void odb_source_loose_reprepare(struct odb_source *source);
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags);
+				      struct object_info *oi,
+				      unsigned flags);
 
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
diff --git a/packfile.c b/packfile.c
index b65f0b43f1..79fe64a25b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2259,7 +2259,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    enum odb_for_each_object_flags flags)
+			    unsigned flags)
 {
 	uint32_t i;
 	int r = 0;
@@ -2302,7 +2302,7 @@ int for_each_object_in_pack(struct packed_git *p,
 }
 
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags)
+			   void *data, unsigned flags)
 {
 	struct odb_source *source;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 15551258bd..447c44c4a7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    enum odb_for_each_object_flags flags);
+			    unsigned flags);
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags);
+			   void *data, unsigned flags);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

