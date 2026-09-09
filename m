Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C72D0629
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932943; cv=none; b=uis35vYEo0uk6A8n9LB3czsxgrZ6J+5Wy+D7GClQWhO0MRTmjybx2JKRj2bI9g5GeFxJKEks43bGvEtuOv6o0MbnVuuijoDQ4fYP93wlUPDwAnsWeVBaXWIc+/FZ15mgwf7q/UTwiujLSq2Zc7fnS565NHP6/VlQES2Yu7oi8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932943; c=relaxed/simple;
	bh=reMEh9nd8Hc9/dg3ELgVrhoLk4TNh333ZLlykamzBcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6TPaHnLj43lJpUKekZPrmsyYmo1b+EitPmFJmF+A3eZfmhN7q8oH2L0gnBFllHGZdQdiQkpKbBkFBhR3Kjqd+ojV90x+lbi4yDYN3CVRwlZOEY+JtTfkhJUPHiL1aJQ3fOPNwra+c/iaItTUV9rxN6wDusn1Wnkyl3QutVNI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqOfzZ21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/swCD04; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqOfzZ21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/swCD04"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 150477A0167;
	Wed,  9 Sep 2026 01:49:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 01:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932940;
	 x=1789019340; bh=2WU9+mTQ57EULgRfZ/d5A1TeTvuq1+Yg+qVlfdi7kE0=; b=
	cqOfzZ2130b8lCHQU+ruorhGZ6NAZJ0ZPxs65Uaycvh3cKJRZTHtjdI4hRfTVq5y
	hzADFlpUhWtB1qAiR5o246kjT+huttbahMHPDXdnlJy/EHR7zv5r082e/0ns/CtM
	KhpfBMQF8OJUsfXVBd/oXR69aSlMO9Pk5bbBvJE3gGaL3cT6Wdy0GfPKN56pr37f
	27mbw/hehcdcQPXW8o/23lSjKkXZPlg2v7Fj0PMw1zPZlon0Z6J7X4j6GCsg5G2+
	HHKFvxSgqpBKwYmDCwz8bsuLm+jMQpRLTRkocFySVIFVe2mVMEmo6E8spF2fZ0ry
	ejGZyNdjVOYlnhjn/F1QWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932940; x=
	1789019340; bh=2WU9+mTQ57EULgRfZ/d5A1TeTvuq1+Yg+qVlfdi7kE0=; b=O
	/swCD04NshtRQPIeczhMsRmVge/tmP5yygghOpEKjIkqEgDmH2vv+Wg/atAjVZj+
	Qb9k5eXy7QaOJZM0IEedyrLialC8LsCIf1HOo0TiyGPDNdZuMFjE7JxhcHqiw+zK
	LdV3DK0ge6wJYjjpnkkRUpwX40UaJVDdmkFYO0/PQ/It+dnzWaGTeBthIB700el0
	1C2ubxP4S7d70MTi2Ktrg8BLt0qTboiwWrSSqLmlfCiHFFBn2POSBGEo/9+Pwz0n
	BRikMA1vShCGXk//oIVSTl71c3op+PD2NiN7EPWohYWaZdOF+QTAQ+k0P/GUEszE
	biFsVOj4DFVc1Vr6GGniQ==
X-ME-Sender: <xms:TPOganLMsHoSQ71G9vj7LX3XenTsiaJJt2dAaNB1uzO4krQkn3LAqg>
    <xme:TPOgaiI5PM1idQE9D6C0AMn9zwf8-s2uowtvvsxlRt19FqavEAN-26EXRdaPhmnpo
    W2_lRfw-95MAvROBMw4FMDXkmfvjMQCXjBcVSWNQulnhxFVbMC84G0>
X-ME-Received: <xmr:TPOgakvtOhPfESz7LcoG0Nca3vk2dbrOtEZrUKEq0ZcA3Yu29eKZmTRG4rArNY8PwMxi_g>
X-ME-Proxy-Cause: dmFkZTFXt+ytk4rlkNiuM5WrB42V+I4qeJ8jlsI0QV4Yv6YD6470gWTmbybr0T3TZ1Vr0c
    DNilgtxSLWygTPt9KmuWKyE7paPRRcCeOqJEV75x4jbTNhvk9p0eixXhmCcfYzzjqjoi0X
    xA83xZND48Rl6qoTT403R/Oc0x+DzxuRSR5+9K97jl7veaucM2r37NdRYP1E9yUc+LKF4h
    I41BFtzpc6Te9Fa7VyPhuxgLf2F2nCa9P8PlU5Y7wjchKQ14SuUwLrTp1VaF02fnZcY4Nt
    lzo7vLYDJoTGwCYR6ObBKaD8OsHvfkM+yl4rGb7S14qHAAQeSEwmSvQvLaDz/HiXOuZACY
    I4r4TfaiMQKwIqGbdZf4YaKfWVhy0fIZGUq+pFc5coZfd9H2Q/DMAxchJqPtux3exhDRKw
    dz4QRdmEHF8rhJxrs3M+88T/B+2L7MTxNDlv9TqCuSqOVO7ViQrvqLe0h8RD2kQV2gX8FR
    VE0Pljj6/YSuyQ5yzBjpRoZaedKvJ/vPDEeleoEFGvN4GRh+AwunLzy4AyEJww01U29h2W
    g7R3QhyeW6HtNmQLyFr3lTxzahiYUjmKPIh6RoSkVdsuWdublj73YjDaors0XH9oXYPbWu
    1KS4ESL2aAmCeUycuuUH9JZRApRjsdQ08ofLAcTLKItwDz+ZevktxJAyMOTQ
X-ME-Proxy: <xmx:TPOgavR4jMVCZIdROw6zmYOwnPJLQWdQbmYIDaFDmJZJvN1ha2vRPg>
    <xmx:TPOgaqPtqxfd6EQgiiw4QjS2Qflwl0g2_tx4S-u9fdy9q3VO3pCBQA>
    <xmx:TPOgakbujkabtjFR-aWspBtN23VuTAPxo1boQ2F_-CmvA2XtZ6Bh5w>
    <xmx:TPOgakxrYVlooIWy7PGTg39TRdb-l5q4t3LVVjNedJOTFOAtcA9Gdg>
    <xmx:TPOgatuh2vZI1_yKBazhrVnMWq1XVhcL0qT467v2AA2xaqWxE78Cnkfm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:48:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90bf679c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:48:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:44 +0200
Subject: [PATCH v4 2/9] builtin/clone: defer setup of the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-2-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When cloning a repository we defer initialization of the reference
database. This is because we don't yet know all details required for us
to initialize the refdb in the first place. Most importantly, what we
are missing is information about the object hash.

We don't do the same thing for the object database yet, but here we
essentially have the same problem. While the "files" database does not
need any information about the object format at creation time, alternate
backends are likely to require that information so that they can
properly set up their data structures.

Besides this forward-looking future proofing though, we also have a
second use case for deferring initialization of the object database,
namely alternates. When initializing the object database we do not yet
know whether we'll need alternates or not because this depends on the
repository we're about to clone from. If it is a local repository and
the user has passed "--refernce{,-if-able}", then we will end up writing
alternates into the object database.

The ugly part though is that we cannot determine where the repository is
getting cloned from before it has been initialized. While we of course
already have access to the user-provided URI, that URI can be very well
rewritten via "url.<base>.insteadOf". We can of course read the global-
and system-level configuration to resolve it. But we explicitly resolve
the URI a second time after we have initialized the repository because
it can happen that we copy a ".git/config" over from our templates, and
that file may cause us to rewrite the path.

In a subsequent commit though we'll start to write alternates as part of
the repository initialization, so we'll need to have the URI properly
resolved before we can initialize the object database. This is ugly, but
as mentioned above it makes sense for us to defer its initialization
anyway so that we also know about the object hash already.

Defer creation of the object database until after we have resolved the
URI.

Note that this also requires us to defer the call to `setup_reference()`
until after we have created the object database. While you might think
that this function has something to do with references ("refs/*"), it is
in fact responsible for setting up alternates. Consequently, we can only
call it after we have created the object database already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 904d2d859f..bdcbd7aa1b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1188,7 +1188,6 @@ int cmd_clone(int argc,
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
 			  do_not_override_repo_unix_permissions, NULL);
-	create_object_database(the_repository);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1311,9 +1310,6 @@ int cmd_clone(int argc,
 		strbuf_reset(&key);
 	}
 
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
-
 	remote = remote_get_early(remote_name);
 
 	if (!option_rev)
@@ -1342,6 +1338,10 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
+	create_object_database(the_repository);
+	if (option_required_reference.nr || option_optional_reference.nr)
+		setup_reference();
+
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;

-- 
2.55.0.1074.ge7621b4bad.dirty

