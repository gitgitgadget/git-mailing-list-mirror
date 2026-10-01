Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE87429CC6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827923; cv=none; b=jMyusl5mMixv4hTky8ZmwlIEwGfSvAPD63VmCm6kljoH/twa+NWXgK1Pt3H1K5Q52xu/wC8OOYsVen9RCjME8peev3ohFdd+UegVcD9Xl3x29dAe9tF8Qkgj+eRN3pyJ+aOP+2r0oYRJ8Ets2B3twf4cS93/JWGtr9sk7oxg6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827923; c=relaxed/simple;
	bh=131gQJBGmsnpBfVdjB+99DXV29HqtSj6FTA9zpvNwLI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbgBmxCuYqk9CgRBaWHTdHij/YXCviWrGSAsf1X8yTMRVmdo3U2HEicf8LVjtUeDUQXOFv8mMrvjMN/sk5aUDKHdBUVP8bTg2Gpq3jpN5DIi1LHgJhZJ2wyb+e7NU4TLusryO4dStj1wIKVOjVjpJaVZ7Jq80QG9mh2Bkx5KshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Mk7Msgha; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Mk7Msgha"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f0c89e34so4302236a34.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827921; x=1791432721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=raAZHks23qH7+b6I95t11127rskpweFy3KXhXBCYm5k=;
        b=Mk7MsghaSLn6iIR/uHRQybmUeFtA5NC4oZHxuA+kjmHqwq7qP95ph7kR32o2cjVLZW
         J+NG4a+Zq5KgLmRu3CmaJqtomVPbT0aOzhTbZLsqcaXG9p4kwChnJ6lGn1Y2QyXU5aPB
         FLdR/wcH1maE4PaSx/vdvNFAsBEHsAsFhkMts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827921; x=1791432721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raAZHks23qH7+b6I95t11127rskpweFy3KXhXBCYm5k=;
        b=xHxOgRS6n1NftTmx40MIq/VAY+mUafGtVmry7u5e/jAbM4JTE02MGvwmlO0zhXqroT
         RoEbxwaNs0p0+T63fGiR4RwLoILQ9s/vJr+nIWUbrG6j0JFpIBobtwGq6HQReCa8BjNl
         ol4V/c7pJBxnV8LipXMDih9hHqXcAWuq+KEjxDVsYdZWpuFkYfzd8+gRJyY/AHTadao7
         xJNbo5K+swzIc5Kn8J/eNwkkPKWTXmK1OjqhvREdzebXwl8V7pS52fpwckACpK4nvGkT
         ouF5K+l3XTXgihwtvr/okp1TrgG1R4zlt5zH9LO6xxzdSMb3b9RIn+tWU0I7icgv4eHw
         2vPQ==
X-Gm-Message-State: AFuF++kh8VES6bnWnLRm+9yNZaThkE7G6MRD58EzQVIrVwK62HVAf6Q9
	0BZULx1PBTx9M5K0L2ESm6gp/7+scuRY56633sknifld/tU4g/QoN8L1vTiP7oBJu1PaGVnb8El
	yVh26kfA=
X-Gm-Gg: AYBFou0TaYXei8lRkLsYRlTzLQRE5zkw7sNbSFyOluJjFsWQfOjj+vLxYftiW9M+hV3
	8kY9SrNv1Hqipdo8Ng+MkHIojxe3bBNvSG/uUDOubsHpvBT+F8NN/nN1lNmSS0bhhjZOakHViRW
	HoWOdrwBH+HyiLQ4kI7YpMhVcQX+d0I3h02cwm0WEL58r5DZPgHDDSofdtwdy9aTAFnrf6kkSlc
	lINFGxuPN/3k3nI8bkugBAPUiRzFh3nLlvYbIsETg1dXv27N+WeVm9VqAUlivW//Mt+ujc2jh6m
	T8ZVC4e86kig8sx5UjETkN7V9BIaS4BEdqnTxdD8VyrIDNYVf4iME/4Re/g1hLiO3G0GwRO6Yto
	6P4bg2uhL8yr9UB8i7pi49meerQqvgpdZ9DWw/MBcfvCqdmk4Tvj9D4vB24c4XI0snW6O+ztTVw
	jXX0ndzk18sCVDYnTFJ+vSczUuEI2FRLKhf3Vb4FNMeV/bNPemc9bHgiwv7DFmDHUBunGazxPiJ
	w7D+hTyp4m6McCZyMM1OjgSm+T4tIdB9xvyvlI8nNcO0uxi1SzcRxFnu9TVDRXhQ89adJmVXRcz
	NFNci9tp
X-Received: by 2002:a4a:ee05:0:b0:6d9:8fe:844e with SMTP id 006d021491bc7-6dcf4c6c383mr4365166eaf.17.1790827921232;
        Wed, 30 Sep 2026 21:12:01 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a910174sm1914380a34.10.2026.09.30.21.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:00 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:58 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 6/8] repack: track the preferred pack explicitly in MIDX
 write steps
Message-ID: <a85dbcd04c7957756848e5f3102744d20b509fc4.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

A MIDX write step marks preferred packs in its string-list entries and
chooses the last marked entry when executing the step. That makes the
choice depend on list order, preventing the list from being sorted for
membership checks.

Record the last candidate directly in the step, borrowing its name from
the write list. This preserves preferred-pack selection while allowing
the list to be sorted without changing that choice.
---
 repack-midx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 9f7786aaac5..61832114671 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -404,6 +404,7 @@ struct midx_compaction_step {
 
 	uint32_t objects_nr;
 	char *csum;
+	const char *preferred_pack; /* points into u.write */
 
 	enum {
 		MIDX_COMPACTION_STEP_UNKNOWN,
@@ -441,8 +442,6 @@ static int midx_compaction_step_exec_write(struct midx_compaction_step *step,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list hash = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
-	const char *preferred_pack = NULL;
 	int ret = 0;
 
 	if (!step->u.write.nr) {
@@ -450,19 +449,14 @@ static int midx_compaction_step_exec_write(struct midx_compaction_step *step,
 		goto out;
 	}
 
-	for_each_string_list_item(item, &step->u.write) {
-		if (item->util)
-			preferred_pack = item->string;
-	}
-
 	repack_prepare_midx_command(&cmd, opts, "write");
 	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file", NULL);
 	strvec_pushf(&cmd.args, "--base=%s", base ? base : "none");
 
-	if (preferred_pack) {
+	if (step->preferred_pack) {
 		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_addstr(&buf, preferred_pack);
+		strbuf_addstr(&buf, step->preferred_pack);
 		strbuf_strip_suffix(&buf, ".idx");
 		strbuf_addstr(&buf, ".pack");
 
@@ -719,7 +713,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 
 		item = string_list_append(&step.u.write, buf.buf);
 		if (p->multi_pack_index || i == opts->geometry->pack_nr - 1)
-			item->util = (void *)1; /* mark as preferred */
+			step.preferred_pack = item->string;
 
 		if (unsigned_add_overflows(step.objects_nr, p->num_objects)) {
 			ret = error(_("too many objects in MIDX compaction step"));
@@ -797,7 +791,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 
 			item = string_list_append(&step.u.write, buf.buf);
 			if (pack_int_id == preferred_pack_idx)
-				item->util = (void *)1; /* mark as preferred */
+				step.preferred_pack = item->string;
 		}
 
 		if (unsigned_add_overflows(step.objects_nr, m->num_objects)) {
-- 
2.56.0.8.ga42f775cbe2

