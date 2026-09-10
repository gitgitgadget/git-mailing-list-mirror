Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6247369D6D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052978; cv=none; b=S/+kIk1XnZfNy8fklPZQqaAL58wRRXt9/BwZkxbMAvOfzLPKGGf1jqsJaRhKUjSlQ72RjuJn3YJRlchF+TsjN9GIlqmhbWWLZl55MA5ZldKj868GF9KLHdiOZIP25HELyR3r35pGR4xkGobtJ3GP6g50ZD0KQ0uVPt8bK8RFHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052978; c=relaxed/simple;
	bh=vMn6WUdHW+AwtW4KyZhDlzbVm4fqHAm2AAe+GnyImM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5VLKuMn9Mq+WPjvdbrlbXNLd3SD9FleZe6DU7XYsNVMjwovlO+wcmlqzyJ7tz3b3zyGN2dKbNP+TOtC65+LDLj3Kd0IvtjUDE5E++8mm6ps7RUf5ylIHA44q21Tes8e4nMGupvrhuGUyvSfLeNtvjwDiLZk68PLu6oAFcV8xDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NU6P/cQW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vV2GCgy+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NU6P/cQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vV2GCgy+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7703FEC01E3;
	Thu, 10 Sep 2026 11:09:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052970;
	 x=1789139370; bh=eqrHQdzx7qDYsoSG0Mbp+kXInHZJCpG3mOxJvftuchY=; b=
	NU6P/cQWgWcoHJKB4++YPHX+wVihoNtwAe9MvcyQSiUsg2/b1pKIFhdCu8E5aC88
	nw7wL0Phdxk70dhr3nGCAo2WU00NY1P6uja1BWxAkkd9epMW7VFde9UdPreTZdHs
	mxuQdwGrUpguOdioaa8bwCpwwzltk1POblRxnx+mWjIysjCVfj+63s6MXRDdugpS
	SCkS4MhTckJ1PWOmcZ/Q/6844WW5igD0C1dNSSIQO3ihoTbB/T4xIG1oI+xkHfa6
	TFY3qsxaHHf8x9ftovcSLrHB/qyWQrEuXCg8bmm0doBXhiKVwnRhW716YnGS47l/
	kqXwi/1pyyTvlA+xuXA2Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052970; x=
	1789139370; bh=eqrHQdzx7qDYsoSG0Mbp+kXInHZJCpG3mOxJvftuchY=; b=v
	V2GCgy+S9PejCtvRP39k9o81TugU0AJ2+PgN4E6Szwv8X+FDf1GwMc23TObF6J81
	bCdQ3lFixfRhNKQdfRmYcwNoXmXe2LzoVEMtNRQ13wCKyqFjQ8o+rr7lu/4ZmD5E
	fnT1us6enADPo8f+BcSs0l5jR+VLxoxusMc+KBvtOJXMQsb4j7Y63W6MxVP/my+r
	mTHOk7BWwWqygdNnT+zsBpDRis06oua5OXrIwXvM1bLliGBKW3p5UBevsa/bpOaE
	NU2GD/azwiLljWP8pbFTZzgwEfG3MtjsZFDSCH6Juc7kxlFrKA8TDXGhsH5Dhfb0
	J34PMhLuJs+/G9jS6a6lA==
X-ME-Sender: <xms:KsiiarfgB6O9OYVT5P_gMRHg40V3v9NjAMqOQtIDH3xGsw7VqR-6Pg>
    <xme:KsiiaoH-H3QxvmPWkapTgzHHEguqJQKd5Duy9jnOQso9hKj1scpUEAghiu_p0qK8G
    QSNJV7kKr5gQGlXJKfZBpYbaWhPrLGvE82D77gaOzv6Olm4eqQQ0MA>
X-ME-Received: <xmr:Ksiias3VRVC7zus00yVlWNy_crRoidEfv5O-wz53W3onxzqPVWDK3w>
X-ME-Proxy-Cause: dmFkZTF+5Wy56B+Wx3ySnb5Cx59QKPLOQu236q+2W/W769TPaDnZkuuZ6ySVZ9pJSqX60I
    4KnoBOIFigUDciwRh5/L/RnGKTaoNEewuq0njqzCEJrAVeBHtLobMSK78B+3FkPz/ggIMU
    xsdVnfs4PMJwMJ+arLr5XiQP6/sGsYur6cm7OCaOVgBA33g+KiJVV+ugxArXrsWGshcu/l
    x9zxt9yXxZkS12K7MVcatieR8K8p2/XFAPtZI8wbyrgYzrTVG29lrkrjg3Gx/XNfNTsgx5
    OxmR1v95cylk+grcUqYbD44VqN0IFxxmM0WSX9o2us26bpuTNI0rP+P/UYLTgPd4ZQ2Fer
    0x0Mol8JOAdIMWy3Hbnr686kuaTqbjU5vmhI3zZ83eHlgv7wDcHetUoGnBMm1RkN5yzZSi
    SKleyZ5S7/G2qeEbYsTsTSH+b95ZMApuUFd2GSUX/vwvAIS5YRLAeEV2lEP+kF7nNjcz+K
    /4ayHzAwpJychNFFOUDU2MjUi6lat785dqmZO2gAcxDJZSk1lZ/D/HV7Dpzu/lOgD1Ua9U
    p5ZReOuASM4ryrmzE5yIp83g2Z/pWQQQMmEszXnwZtqWbNXeARpS459/DAAWK58hK9e5J3
    qGdqoGsWFNgpNwh0wpqbmrFgwTp20J83Dy+lzJ/D9UENmnXEM5Oxcdpk40qA
X-ME-Proxy: <xmx:Ksiiaolgb1B8xCMELUVkVMk9b9sZQEocLAqmsuodngbK5gzP86W0ZQ>
    <xmx:Ksiiak_tiFH8mOdEPPBy0kvgxhNUzIo0F-bUdTPuES5bLZOOVRaZlw>
    <xmx:KsiialpeUgdRD9L2pAzbZB-WnYr6qI7yXR1bUhM_ceMiu8hGs3onTA>
    <xmx:KsiiallQCHwd6XS7dXYQBKMlgw3DgAgSBD-BWMreQ-FTcAj9X2y7qg>
    <xmx:KsiiajRTFnvVWWk-eQdKvsS2wmYKG0lKqurGZZvnwH6UlNhrs_4ZsHqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfe9f043 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:15 +0200
Subject: [PATCH v5 5/9] builtin/clone: move setup of alternates for shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-5-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When cloning a local repository with "--shared" we add that repository
to the new repository's alternates. This is done in `clone_local()`,
which is responsible for performing local clones.

Move the logic into `collect_alternates()` to unify our setup of
alternates. Furthermore, this will allow us to set up alternates right
at creation time of the object database.

Note that the logic for cloning a local repository with "--no-shared" is
not yet part of `collect_alternates()`. This will be handled in the next
commit, but means that at this step, we may compute `commondir` without
it being used. It will become used in the next step though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08d913d306..d397fd36b2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
-static void collect_alternates(struct strvec *alternates)
+static void collect_alternates(struct strvec *alternates,
+			       const char *local_source_repo)
 {
 	if (option_required_reference.nr || option_optional_reference.nr) {
 		struct collect_alternates_data data = {
@@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
 		for_each_string_list(&option_optional_reference,
 				     collect_one_alternate, &data);
 	}
+
+	if (local_source_repo) {
+		struct strbuf commondir = STRBUF_INIT;
+
+		get_common_dir(&commondir, local_source_repo);
+		if (option_shared)
+			strvec_pushf(alternates, "%s/objects", commondir.buf);
+
+		strbuf_release(&commondir);
+	}
 }
 
 static void mkdir_if_missing(const char *pathname, mode_t mode)
@@ -357,13 +368,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
-	if (option_shared) {
-		struct strbuf alt = STRBUF_INIT;
-		get_common_dir(&alt, src_repo);
-		strbuf_addstr(&alt, "/objects");
-		odb_add_to_alternates_file(the_repository->objects, alt.buf);
-		strbuf_release(&alt);
-	} else {
+	if (!option_shared) {
 		struct strbuf src = STRBUF_INIT;
 		struct strbuf dest = STRBUF_INIT;
 		get_common_dir(&src, src_repo);
@@ -1348,7 +1353,7 @@ int cmd_clone(int argc,
 		warning(_("--local is ignored"));
 
 	create_object_database(the_repository);
-	collect_alternates(&alternates);
+	collect_alternates(&alternates, is_local ? path : NULL);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);

-- 
2.55.0.1074.ge7621b4bad.dirty

