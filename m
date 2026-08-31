Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52C3E009F
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170557; cv=none; b=psWYKQhtT78wv/MuHXeIwTrQ9cmXcYU5T+WiWCMR9l4ksK/bvmWYjYhLdwcLkx4slyQmnS4W88iykGazq1dMgkeURKZCF7Gb9WASWGs3O/7NEFYAcytkFqzcNkgPM0r57yv2gVrfyzlrTM1X272wP4fumK8JjrNyx5KBfEwWzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170557; c=relaxed/simple;
	bh=nOS1afCDIlcqc9KFoMFV3YKYDzRU35FSWr5Ah7IglBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzgfhC2nLWnkr/NYXqVzMEeBSbRz57QbtgEhBOJW7/68D6Nm1Lhm+T7+ScwjaL0Yj0QHlX0aVMIdXYBVgPrRgNxQURuCx42gSCmR1MVuAskEO9H+1jncRAPMhVH637M733iuR/BnqPN0y01lRkvSYrTjk70hg2rUCdqpZPJYaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=abizDJ6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFXXfkXe; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="abizDJ6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFXXfkXe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D0117A0199;
	Mon, 31 Aug 2026 06:02:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 06:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170554;
	 x=1788256954; bh=zgWC6wDS/v5mcfVosIP9cELJCxBKzg1BRGpMuON7Psk=; b=
	abizDJ6DUpv1/88eSACrsevOad9+wI/ynG25EdQAyi3B1SfTPnbynoQSXYk93lzq
	kn+igSHwmaXTj5A0dWpgfTejrQecLlKydAQpBuo6qs+shb4817gulJf0AuJJLebB
	ztJXzGDdfruOKI30bmXvKz7ogbTC3vlMbd6YpvWidGZw7WXctNhGEoO/Yp2yi/gK
	WvhsO9n/FqmHvoi5KNUAuhiS/r6aHIxE30rBDlPdYrI1qxPkWQ0dHslknrTMPfjc
	CBxdbdIOL3J8WMlPEwy44U17tpqMaOrJvcqjAUqEJtl/0cYy2rIyKo1eSQXxynPL
	hlAcMRYYEN30jDldBI7vRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170554; x=
	1788256954; bh=zgWC6wDS/v5mcfVosIP9cELJCxBKzg1BRGpMuON7Psk=; b=M
	FXXfkXefkUv1xgQqTlC1OZyjDe99/2puDmUBO7TIZxU2Tx9FkldQBTieIWuiMEuZ
	4dLp9Ddd+XBy7n94JWyQuZNUx/8IxWF5qnEPOfq5ZoDRleuxDmRdili9lyvH87YB
	jSd+nbZLEoIp8TCFyag2gHWwePOUJf/5HBVTxnPf3HSV7GnET3P92koU973bxI47
	Yvb2nZjWCo0XmkKVOLSQYQd3eVl9pUBWqs5hCQkq4QHHl/maxaGPzgORffny5YI1
	Oj95t0909+WgJxTZZ25fgRLUxftcznKHOcaXjvBAuqmJs3JWeuMqRg53J4evzFwX
	vu4e4n85iwBaELvdjUZeQ==
X-ME-Sender: <xms:OVGVap18Ty8BDx5qdrqp8Nwge6cSOBlWkkEL6pQV2tuyU5rewz3-Pw>
    <xme:OVGVangUW0cTlq2wlWVfhwGtWbOVzUVLgAUIsiL201bUiSq3kx2NFr6HkAaRVEyzG
    r1GlN6JH9yOnB60r5jGDBrwGmiKi0puOtP00Gty243dJO2uDs5HoDM>
X-ME-Received: <xmr:OVGVanSPSVmi8I-xWJG6GBKaSF_0vWQhVGjf-Hbqm3DiOYdVrik3cWiOVV1bfTJ9d_ouXQ>
X-ME-Proxy-Cause: dmFkZTGHUA7KqT16GbV2AYtUMBXxZvbu0kHMHaGO2coG/xVALTL8GSgyyIm6N4JdTXGfGp
    fZgPoMuN16ezFPjkmTXw3ziS2HXJgeJN2u7RxLp4/LgPv5xacW5PfCcKnb5b4BL205mE+I
    LPzc7ig+H/7vlqOlBDYFsxEqoSVhsqlhJXzerLQAQubOaj+1f4HSzWEz4Wp3WhiIFLKi8v
    jJ/q9MY7B2IaedZpcYmNkRiuikA0csHZ7Dh/n05pQ0EdCKVmkWbFPiTuI2XkI6P0vvpmyU
    k8dQQ2PDEWJ6sYY8TYIz6BCO8Q6LquTNE350JkEmKCAN/krpBthd+MbEaRYqTa3EANbHgx
    0h+2tRQYgmcsZUWvWHSG2aE4SR+eJBmnsTdk01IBLA9UU6iyLBMgLBBipxXebmpRa7Oc5q
    477IfjBCJJp3sQ8f0GOgLkGGrNAjMRSRH6HHGQScfuPKROUdOaKRKVpJYuhihahmFFDhCG
    SFwkxVY9UQMthQwZzK265do7ZHjj3x5poIN60sTnZNI/Dy6OgWYCp9jG6f/AzZxmKNU0BV
    NpyXhRYuictoPpQGVR+qh3HG2WEJcBt3IWzsBfFhbqgJECTMR1pXBkONx7e4YcQeAn6IiY
    TwikPDsq+UTj6lmkUuqeCafB69Ptpioxe86ZHhZ+O6LMyI5RCKideTxIe1Jw
X-ME-Proxy: <xmx:OVGVagjQ7tqHbqfSi6HkT0fi0eBt-sNPJ2jaCVeMOvh6ErXAyr2I8A>
    <xmx:OVGVav4-V-g9IiV885s_HQfV5epeCEoIGDeHwp6VtY7L2WrF1L3aSQ>
    <xmx:OVGValCHd7A-Vty9-M6UQCXSpgw69XGB9f80W3_hvRDUTe4kCl9QAA>
    <xmx:OVGVauaGCRIVLEvn6NbJOABNGcffj5bz48GMDdLZj9W0VefIljf6ng>
    <xmx:OlGVatKshujkeH5qKv582y64nBn5zpjwpZO2mDGet-gF_hCAYT_wrJIl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2935a38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:11 +0200
Subject: [PATCH v2 7/8] builtin/clone: write alternates via
 `odb_create_on_disk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-7-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

