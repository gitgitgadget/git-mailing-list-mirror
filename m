Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21936B935
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932950; cv=none; b=MuwxZXqgEsUOTCP9mudgo36ZnHK9ztIrZHvrXHv6G0rfGE2yECBropl+vYplBvymobO7OBH2Qo5FJOn23NVOopdx1g6XE0NV/ykYZ1Gd8QD1/O/svwF5q8cI7BwuT8xhAUubBWazDHlYNU6CKkELUhCv1X8SqurXqbYSBN2hPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932950; c=relaxed/simple;
	bh=DqD+QLYo6+hbg37i7ik+VEt4JRpKy5GYg81vNiSeMs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0cZPH2AkGpFxzo0sfN63chwcMDbDi4/y0i3vBWL9NGa7Mxxl65G7aC8wUcMJtZG7fOx+nzg/8UXduTregG1MyEP/QOATw8O55Hc6PFINLX0YoumyU9mezCOi+IsK9Vf/Td/Y8W+qGa8hH6F2M8LPfaEzhLLXQUvalkqlecmSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDo1+lxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gf5FwnoD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDo1+lxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gf5FwnoD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1952F1D00109;
	Wed,  9 Sep 2026 01:49:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 01:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932948;
	 x=1789019348; bh=KyOE73jlYO/vfEpqcIqwXiZCp4EMz8CM+qYND2t79r8=; b=
	UDo1+lxBbl0Za9kCt76VxyIp+p8bGxZsj4Q+Bhhydk6ydTGvkWo7Kuxzmqb61W0k
	+eAe/3B2cLpnHJFJn3o468wIuxqL6HA1jm2YCeAQ5nQMhIMil6PGTJEGlzEAJTyh
	VRgjBfoK72z9LYuxnSHVSIFbbcGL3UnWDk4WYLW+jXzRlgPXYfGTLKj7Z+woHWFY
	f5cXqDwmUvYoQPgAOzGba9oXSHyAVVCBdA10keRVV9KN1UpzuO8iiy8ZLP79zAa0
	HO0RAc1WcYiT1qydfqiwjMCW0JQsLec+SYUEYMuAnD50Y7mlMq/7brkzrvjkmTRu
	pi6sATGfKC6/bFvcG+hZyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932948; x=
	1789019348; bh=KyOE73jlYO/vfEpqcIqwXiZCp4EMz8CM+qYND2t79r8=; b=g
	f5FwnoD+V6YlHmHak5YzB7dQL4uD7uysx1daRDtyIZlep1nI1vHDEqAKoOfwZKDU
	06BiETNKhjexK9yNyMU6TVja+NqxBcba2gxydUCVJQDcLevaLPfCE1I3bc7GGkK8
	1YV8IUfzVvhPUiRuQ03bOIT7uCwJhP1us7RQ04ieduMWhTnZp7JNWXq3gKOEkYHW
	x+wQn6F2oFR6S54ZETH5sOzAxViQ/ptQ5H4FvLjjB2W5Ly+UnLamo8bj7bWFoHBN
	yFrYK2Simti4HykjorEqkRgtkwYL5THG0jSNPFFvkspwK7UXKtiX9uPrj6oqKv5B
	sIUWxyUmXa+RecGkx0DuQ==
X-ME-Sender: <xms:VPOgaobZQsa0ivzp64RCh8rtn8_eC5Ma3mFJlYRqwGjT41F7JGv2-g>
    <xme:VPOgaqbCm5g5BUtTl2IR44mESsKuXGKYCWfvJfifxOTK8QV-p_9AGQJRDrb00h4J_
    hKCoxgL5pNHvmgsDm66dAtyD6uWtB6jksywj7jwa_REDddmczVWixU>
X-ME-Received: <xmr:VPOgan8SJb6VcmipnPouHbv9Ux23NEr8Ve2GEUc7Y26doqk42dyrHp-isDNfk4C0T-B4qg>
X-ME-Proxy-Cause: dmFkZTG1CINsrlCLE066OZ3ijbBwqoeUUN09bRGu96X0zkQSgd/gEVbZukEtx7Kwdq9E2G
    zrFeDcdFjYBCbur9cy0XX3McPG9k1yUfiKPdHiAEWQN3M/mpMHwDwSR09US+jxy3td6K8v
    b6c+epXkHoDtEVAkiug4cZHOVNMras52zzK5fdeon77OPHdWW49hinKSU71Nv8ykCeGMt1
    zjm3cEIHwpv+L5KlY3IxtjmYE/VBl8iX9/md6c4CuvQ5FbghOuBYh0flgpcc5F8OVhPEAF
    XKBfFaodFzpFzlfUaV8Wgm4duj6IhzkSksjeRoyKFJWjSfhh8X9gejMy2dZDszGqNeghXj
    UlhqBXHxQ6IiKOkrwERGH2nAz4bpHhyRoBAPfJmxksDh7sUrZxCV1DtvhyycsNyBfGIWGk
    7gSpS1p62t8Imhd6uf9HYDZ/hVTQxnv9MxyKz5O/IRgHK7hY8ylLr7uxKUIjvjdSYYyszG
    XORSuuaf7sVjjPBZ5k6xFB/sJEeF6kfYYlXtUOocWNQwPGGx4Js9csLy1xcEgYHOK4Qa9S
    XPi56KG6dCStw7WMOQtcHB6T0FaxxbrAYyV88DHo1mYDCYP+NVhOGdxATVwN/gqhniSCm7
    kAcXGSdZ406KX9a+Q4W9SDhsAxSAgMttwRqWlvp2U+DS2ycygvnxO1Ct0K+Q
X-ME-Proxy: <xmx:VPOgahgIm0yNgPHUF9LNrPWk5qtIehnsF8CprJLtpNq5vwOiHrhhAA>
    <xmx:VPOgavc3qdp2DU5nACt3N07Ow-cE6k1MiVDzcYmIVrREWx7d7yC3pA>
    <xmx:VPOgagoMnzo4ZfZkNoBoEECSnJR8C4hjv05OnHS4nksDrOKJcI4__w>
    <xmx:VPOgasAvrCc62YQfzGKsBdPnnfhvgPbI2pqsNnt31BAZt0a8xJg24A>
    <xmx:VPOgas-5IsSArqIcG446ElOzdQWceeTM4ywLVmUoBHhkdcHDaMl8epuB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a5af669 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:47 +0200
Subject: [PATCH v4 5/9] builtin/clone: move setup of alternates for shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-5-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When cloning a local repository with "--shared" we add that repository
to the new repository's alternates. This is done in `clone_local()`,
which is responsible for performing local clones.

Move the logic into `collect_alternates()` to unify our setup of
alternates. Furthermore, this will allow us to set up alternates right
at creation time of the object database.

Note that the logic for cloning a local repository with "--no-shared" is
not yet part of `collect_alternates()`. This will be handled in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8786a49332..011fc867c8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
-static void collect_alternates(struct strvec *alternates)
+static void collect_alternates(struct strvec *alternates,
+			       const char *src_repo, bool is_local)
 {
 	if (option_required_reference.nr || option_optional_reference.nr) {
 		struct add_one_alternate_data data = {
@@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
 		for_each_string_list(&option_optional_reference,
 				     add_one_alternate, &data);
 	}
+
+	if (is_local) {
+		struct strbuf commondir = STRBUF_INIT;
+
+		get_common_dir(&commondir, src_repo);
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
+	collect_alternates(&alternates, path, is_local);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);

-- 
2.55.0.1074.ge7621b4bad.dirty

