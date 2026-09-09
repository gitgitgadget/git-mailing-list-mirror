Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF7390218
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932945; cv=none; b=HqznKi7aYEr6ALoum/bGcJwt2Ehn1snNKxvUnwwW+P/r4VoyQSy8P/5jvDdAxRBXYnxK78iVpGe4ubhjbJ8RBrD4GL9Vgek3sizPKJlcfS3CzVaigBidJODyCGywnGtOXyzxqApb5DFDya3jEhbLQXlvbuGORyW5+s7VJ+tWTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932945; c=relaxed/simple;
	bh=+VE8+YCDezKsP4dnIrSnN4dWSWQ0iSVo63eNy2cDSCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHfX/POCMbdAqnrnYIpO1JS18KSg6dCr0S+stcDYi01R2vsLE3JxhrGz7UhMf7UkBaM0AnKptV1ULeMdjCeitldOn/b1mWun7FFpNlRe/h25B8JP+odv4+5giP84JovpWrpJ6Wr03XipeW4cx/lsiLExSwsgYX/D7oImPH0OMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fUVqKs0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrlpZeH5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fUVqKs0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrlpZeH5"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D8881D000DB;
	Wed,  9 Sep 2026 01:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 01:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932943;
	 x=1789019343; bh=j4sXwgH9ZxIakiSIYcmiSscvVEz4QlbALuL6jLg5Soc=; b=
	fUVqKs0nJpNqPyblXImgvSwa2gaYojSzjGPakj0DkkBbryhbXTJMkPOelFszaId3
	C81yWwX+0tVU9GCBcvBNFt9Buh2UEw4UBjx5EaHrBW0LIUTS0XbValIkg1G3NLUk
	OjXzTURai8rDpjRPoOGGr33jJu5cSPWcVItlWiqJXr8FCW5Lx6piq8BBdl35xV25
	V8YkPVUYIVVzdfVx8GYGGpXK4nFxyysxOrbpGK9SregGF5ESAKqsRTxYCqcnHgRd
	GPBk1dRJ7h5rctrG927ialFsvz0D/eEZ7GhWeA4vlzf1+unF3IvxfApTjJi+HYv+
	ImOmJV37YslsF9/C3uOwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932943; x=
	1789019343; bh=j4sXwgH9ZxIakiSIYcmiSscvVEz4QlbALuL6jLg5Soc=; b=Z
	rlpZeH5qGs6iFcgosGbBWGSrtzNlYtw6yEEWmrbt2xJ+iywWK1dvVjEDmc6qpNPL
	Zv1mgXDD7pZU9CY7O8s69XW5YSaezMNZaCOxZrMtwhxeZxXxE/pqLz03lref1K2N
	onqm4dx75xwG+/3FgtPKT+TSvDuTmrfrXVCgUuik21vcchcBUdXco4NnjddT2UaI
	fE6J1oIgTptGLZtTZoxyYV/LpD9leitKXedeH422dfRggBKPzX1HbNHBopRsbfKL
	j1FWP8Gz5una80vm50g6bzqjUrItccRUJtC0w17DDvprmTSCbHrOKfWo3yZHDDG2
	hCuwEkcKkDaBL/9wwP/EQ==
X-ME-Sender: <xms:T_Ogapt58sz80rCjdstC7HHIrMRlevUHgxBf9YVoaBhkcbavjBbFpg>
    <xme:T_OgapfJkQSGs5sKZzPnLfdPwSm9PcoMNJov3KW5htNDRJ8_T0kjlRoAftSeFp5Nf
    h1AyRNVMfstpS0Op9DVWyoKIbp4WvN7es-gz0ev-QZmt-RMERzr5aQ>
X-ME-Received: <xmr:T_OgahyNTiQISrIQJkEjKfrEwzuyfL9wdjCRtBox6MNZ1AhZHe8-fthrmrnQ1IeWGZnVIQ>
X-ME-Proxy-Cause: dmFkZTEFFU8idspVfyLIe6saGYD1I0ME0R+k/NC3wSpSRdGDHpnjztj62yzgKd2h34NDVk
    zx1tnKp9zwXXU0IjjTO5p5iG2UZVVYDn6PUEaEDJVSjyyehBfETD5aszbPaDs13jeyVlFO
    Qe2vl/2aNQqm6LOl3MYF0/WcYGo5+xvu69mU0MeMCuX5tbuKok2dI+TY1qkuzJkv4pZcY3
    dinoGgkDFFnHKTu1UrHY2HengjfTbEtFky54CLqy3/0N4VLEbfJ2W/QPZtdm2WBt8jq1+0
    329VTl9C1RY9m0SGzWJGm2aeIhcsNDJ73NC76/OL7pICzy0E4VD33Sxa6CRezkPFJM+dL/
    3PFVUA1rMAk9SyFMhPJDFfBS1tnL9yb+KlINYMELwdFAMlcHKwXpv9B9aahd1s3VslcgEk
    3f3a+QNV+m7et9k4P75JAJrOZGl8EqKZZ3X7XkzFR5MT/dnr11P9aKprpn4W9RYml66wpv
    fF2Ci6P2n5lxlPiFRYuFzQ0pbEt73tu8s/sT1kViSTa5faAv9ddqK0iyXcB2yukCMw9C7N
    +HTqayZuNs4lhzKEfp2rnMaVkTgYXA7OSGdklQfCf5SFQDDpgYkQMxRNJToVdp75ffYxZv
    u7KMFRZMdnlKidb64EYDI4CvY6mG6/wB4I/X/J9W/Rl3YW2DK4bwkM4fSTcQ
X-ME-Proxy: <xmx:T_OgavFKKT8FT5-Zw0NDJ5iDweapF0wbzO2bHh2hb6E5i21HugrgOw>
    <xmx:T_OgalykVr9gya1xC1Uj824aFqBFesHRmE6OYgmqLnfQGLM2mAA4Bw>
    <xmx:T_Ogagvx9OpHUe2IBujo4J1QtQRyZxW9rm_0Xd4qAsbt0JDUmG9MmA>
    <xmx:T_Ogai2X6WIXqCtyJm1DeWA2KnPHyE7h20WhBiLC0jvk00wfs3PNzw>
    <xmx:T_OgapNOAJdPnSoQPSWs8X-GC_7j2eGGHlhEkdHr2uY1FsStOBhQAlUm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 526a612f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:45 +0200
Subject: [PATCH v4 3/9] builtin/clone: move around `setup_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-3-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In a subsequent commit, `setup_reference()` will start to call
`copy_alternates()`. Prepare for this by moving the function further
down so that we can avoid adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bdcbd7aa1b..ac5843d7b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -179,16 +179,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
-{
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
-}
-
 static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
@@ -228,6 +218,16 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void setup_reference(void)
+{
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
+}
+
 static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
 	struct stat st;

-- 
2.55.0.1074.ge7621b4bad.dirty

