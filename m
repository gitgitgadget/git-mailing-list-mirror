Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A01481FD7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667174; cv=none; b=UCAYL/7kJtpTLiBXuLzI7ozahAILv80aO2TJvNc8m6qj9vI0TLhf3upb+N6PzMvJXjGyryGlhWii4mvK0mF5jRsulnfJajwyQWFOkCkpD/1b833o+1vzg/bkXCPFiI53M9kbzYZmENqYLYSWndaPxk1NtnqNcWODNaR9O5k+eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667174; c=relaxed/simple;
	bh=39lEgfa2yenceNCdFHd/FkfWCvi24rubZmNIVi9hYwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxXPxerfCE+u3Rh6uRRXQ9mEeAG+RLdO3GKhf6KkqsL+hDNYnwGaMB2XesQf3F3ZZLjf+y1uPFMx/QuOLylQGJ++Yrj2Rbf1VzQC+L/PSx/3FbEIu6p0OQkOO4SS00aYdEz12rN4TIiVHz3KkkuGBUhI10ajTn1zwlKrJUIRNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EzTPO2Vh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNvaIM2V; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EzTPO2Vh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNvaIM2V"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFC287A00C3
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Aug 2026 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667171;
	 x=1787753571; bh=fPAQmWX/Dkauw/yX0Ul/QOv0uRldcGNuUjWJCDnAVA8=; b=
	EzTPO2VhcLzyKSrMJHS1K/6uOl5KkXbsVsZ/KWtc0Jm+peNRGR5QzeoJhDGs96mL
	0TC2oeo8n6oU76r2HE4IiB/RK/JH1k/PSpZuYFt5eeSTyUEHq1S+LY6LHLGVJfGQ
	tjggli4BYUvFAbO+IyW+OIeJCwSDLigPzFNBTfe/8kUBc7bYfVnp/cztLAfjHZSY
	SSxYEHLom936ZI5UrfEr1U4rM8fM90y8oohc0X0pbXSVxKVex9ChrC1rKTkJ2Mpx
	SCxxE461UdxxksObRL4Wky8kXQxSmpaAFqhXXwlQ5HjFPnqoRCmGAXMWXwHTSpj8
	ZweUwO2ymaWdh04I2NnRsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667171; x=
	1787753571; bh=fPAQmWX/Dkauw/yX0Ul/QOv0uRldcGNuUjWJCDnAVA8=; b=e
	NvaIM2ViRBgKAgnAp7E1bwYoe++Kt9sXSD9gGRY7MIsJWi5DS5cLmamk2ui7rD8X
	9r3fv+tfp0jXQHrMY9enSzIbyhR0gLBwg+P2NInMehRl9ZrfMFM3z2E2YDYXPgGw
	dNHtbN22fbckQxZ7rLyWp6Aebpk69jWCsaIgdhDirWsJqI+Sf24eHVqSes+iTmGL
	i9NS2wsYbzPJo5LsgnJjDSTsCbdwoMnzF8uOJhUEHr7U7bw2osn7s633XXoDcv+9
	Lap6EBJ+7gF2JLI4JCoCiwcrRBJwBuhDiHkHKMi9vv66Hiu4QW3oak6dFYiqH7jw
	5YY31Ie4NnYfKOk2U6cdA==
X-ME-Sender: <xms:46KNamncNEbvOIK90EwLubXCm2hFPq3tyKf5er2pd-h_W3Y0uD4Dew>
    <xme:46KNakxD9EfpJh4dTEZCCyOHUHoHgk2rADbOIkBGHiA_bW0L6t_I_fCkEcz8g_gzJ
    LZw3W4K0K88FtXX_yr0-UZmAd47shLSCgBLlRmARgsIJNcza2RiFYM>
X-ME-Received: <xmr:46KNaqRaqYXdjMbh_4mD002Ie86hdU3iYtv808IoqLISo0NZLu0_aq6F34EdTKLY-nlraS2uuasJR5hV-htzdcp8VOxekZIwXagZ1jBoHA>
X-ME-Proxy-Cause: dmFkZTGeb4bxLdeGsZIHwBpNvHkBYVFqb0gPBRFQdjclKFZL9iepAsMrQPToqlL/TKVr+q
    N4zotQK8qWu/iZbZxMh9T+enbjab8RTI96+ANj5zdevsOZpx/k2kbDA/Ezij5R9InemX2I
    ieATfXIkvh0YiRX3YRriT1epVXzuvh+X9pcDU66Ymz3EVbvLlj2rZKEI0CELpv6/vw7ah2
    elZ11v6nTiFLLnUx3cpsB978r+ZIEPLEKCBDKbZEAm79gm+cy32vgIs/g1+gOLXs07WJ70
    65IHgmKSzOBkB+IYs7mYVzgUR2wQOS5+Tr0YSbucb929Tar/yOh4FpTSqzhx1xlgLk0Gif
    F4dNAK0LlzJfT8TRdJSvUXbQFWLe1nTIuGdCFh+JJnNgeAIQhnwn22pbGQTXbSxUc9GhO5
    Yqu78Xo3xu+qPnjceoSi613+tFybzGsnQpwxv1wb7GBA/V/4LiZ/ZZFzAoVDBY1a07k3t1
    EjluPh3VEDdqLBrE3wA3jI3iOvc91aukVCZ5EbSFqldRGZIYoMqkcc3XpTE2TfeMT2qw2g
    7u4R6oKowpDe3YDkypXtp6utrLSDtsgzukQINffgqcuOZmmrUD/wkmbxADmlMiHuKAY9Cf
    PoyzboJwomqPQ8V9s7XZLV1z+1xZ6B9GyaPrjocojwQf2km7IjaK30Snejwg
X-ME-Proxy: <xmx:46KNavtwMEBA3fGL5zjEXMafQalxa1N2Kwy88NbKSWkGN2zFxfbspw>
    <xmx:46KNakuSqkwKwNwbBbEe0E5BASSYIKKoRNgpcIBJ5AHtegzHRUSSUw>
    <xmx:46KNatyY3oxe3UxrAg0EqNiZ2HrFZ7Op5cHXpG9_9M5cot2dJAn23w>
    <xmx:46KNaijH67keep7tThqjGriSLPVURRAP5UVhD9oyk6lp8JwbUWJuCw>
    <xmx:46KNai313mB1bqa1b8AEj4TAwGMUVxmo93cUHp_hm-s9WodIy8890k0y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e7e0096 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:56 +0200
Subject: [PATCH 7/8] builtin/clone: write alternates via
 `odb_create_on_disk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-7-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When creating a repository with alternates we first initialize the
object database and then write alternates to it in a separate step. This
is unfortunate due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    unfortunate as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so having this
    callback is suboptimal there.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

We have thus introduced the ability to write alternates right at
creation time in the preceding commits, and we have unified setup of
alternates into a single location. All that's left to do for us now is
to wire up alternates as an option for the database creation.

Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 5 +----
 setup.c         | 9 ++++++---
 setup.h         | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2e3473fddf..48ac379b1d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1368,11 +1368,8 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
-	create_object_database(the_repository);
 	collect_alternates(&alternates, path, is_local);
-
-	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
+	create_object_database(the_repository, &alternates);
 
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
diff --git a/setup.c b/setup.c
index 426cc7dff8..cfa286ff59 100644
--- a/setup.c
+++ b/setup.c
@@ -2647,9 +2647,12 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-void create_object_database(struct repository *repo)
+void create_object_database(struct repository *repo,
+			    const struct strvec *alternates)
 {
-	struct odb_create_on_disk_options opts = { 0 };
+	struct odb_create_on_disk_options opts = {
+		.alternates = alternates,
+	};
 
 	/*
 	 * Create the "objects" directory in the common directory. This is done
@@ -2907,7 +2910,7 @@ int init_db(struct repository *repo,
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
 	if (!(flags & INIT_DB_SKIP_ODB))
-		create_object_database(repo);
+		create_object_database(repo, NULL);
 
 	startup_info->have_repository = 1;
 
diff --git a/setup.h b/setup.h
index 570ebcd150..34e86dad37 100644
--- a/setup.h
+++ b/setup.h
@@ -277,7 +277,7 @@ void initialize_repository_version(struct repository *repo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
-void create_object_database(struct repository *repo);
+void create_object_database(struct repository *repo, const struct strvec *alternates);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.822.g20453c30eb.dirty

