Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634E3E1D05
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928603; cv=none; b=T0y9R4sPX4KGFyXLOQ0MRJG2HUpX050hAavOkgjkliqTsZ+jRjFm1AMBh+K6ZiMTIYmXQNAWN5HkQDYXzaU1WfVoLreBxlj9yUWxciJ6IYBSgUyOLkenCDFH3TQ2lhRPhf8X+iuFdFsFFbCUhTwC7UaBfXpXogdrcTiKXguJmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928603; c=relaxed/simple;
	bh=GpM44uguJwmw+pqkZirKGAnFqP1NrNxe2a2SoXWdFPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svwndHiB4bWmMDq12OaOgCiXigGgRGYUH5VWGDiJM/h7lNSZJIC0S8ZZDhR5H6lgtB7EgKFIh2bp6FnP5jpEK50drEP4IdDrBAY+RjA8IlCW58+6D78KqUPq9IIlgTFdyl1JfE8Dbv2+Y4gv9iGNKuF6JPvxPIJtI5etLPYt76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZXwP3bpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pj5XcTE3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZXwP3bpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pj5XcTE3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 942E61400090
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:10:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 04:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790928600;
	 x=1791015000; bh=Ivs7qpVJOjNYyjK6Xq010v8fozVFfYE/RhLYFKqNL48=; b=
	ZXwP3bpB2XPB99T2rNRY7uASHyVAgXCDLA+eD5Oic2xYMqw+svprz/6pIxj8V6mr
	RoJe6Yga7MCkiy8GON+2BMBMv5DgW8M2LSoFnJHGpoYJjeLNTXXAEjXE8YSfDma4
	G4vlZ8DIaCByb2HuugFJSvzfauA+879TP0I/PmvVw+46vC7LqWTzik2kxD0Yfw0j
	3SUWCLzZQYuY8319Poc+foWDNCSbU1FZUh+iJ8obhtKzvCkuYe+M0Pz8vaOXDshZ
	E5d38BQ0jbNpVhRS4vpYQqj/dKfYlT2E268CxFHF+qj1Q/4BJURLD7EXQ9Ag6pMI
	bpDmmjZE4Q37HZ2KDxvZEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790928600; x=
	1791015000; bh=Ivs7qpVJOjNYyjK6Xq010v8fozVFfYE/RhLYFKqNL48=; b=p
	j5XcTE30taSYtdv73zW+3K/ZHjYLpKXOHKNBl4xBhF5qShmYpN9b7wiB8zR7oO3p
	Ih9OHFhkvNVrEYKZPiNS4P0wWrxvYWMAMOlHfdtxxjHOCdrv7YJvHFz4/bo8RhKp
	jyaTArDtSu9keSf1uc/75vBb4uc5HnTHSRe5aShVXbfhr6TXwnKua6qcTW/AbLCR
	dSmgQ+Zv2Av97oakIku5jUwKwSQ+Fjovm8aizFAuLhtVfXxxDMjrRzhQ4iOip7fL
	GQ1odGTorxoe3f+JiR31W5DOQnLgmXDEOE7scVTpNyfQS0dp3oCCi+cefUW+mrKS
	1AhRc9zd5VAqbfEzTQAHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928600; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZPUeXHrcc1I5Jhtt/mG43TQhCpGejequ0BGs0Bw2hTRYAry
	jpBa+TyvXlH9otftxfy4LLa9TM8vzr6r0Njm1nnkxdVQs8OB2gsNFsYpxDYUMZe8
	24HZjMaWWksVdp5L/SumTIP81p9LKzOpP5MZv4t22GRoqUg08bLmcbvHWo4uPzI7
	V0NMNQrlbSVG2rXvWUxwGoTK18tkHphF/Zhq3aXS5U8tmJ+T5nAJM8N96D2Kvhai
	DbnEAGEXbDct5D1CN6OGhpwqcbSVXsntrEd8nTlIpfE2B9xrVB0menEuI6l6HJS9
	ESnp+5/JPHOtAIZS4eYD1+aKxa9CMg7mm8u/ZdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0Y+SIjoYRyvMjJRdltPhjyfbQFVk439KP4Di58uAAJQ=:GpM44uguJwmw+pqkZirKGAnFqP1NrNxe2a2SoXWdFPs=;
X-ME-Sender: <xms:2Ga_arlhGwG-qxmsM1RrSTO_vFnoKpBPjJDGtczWw0QHjxl8sVEheA>
    <xme:2Ga_ak1xlG9TxLHVFGx57NqMCYa3GpdtGhfsD4-HRoH4Ie7infM-pkwUPtwsRPvw7
    Mof35eIktVU18pNeZcDodpkgvctaArvSGuR7B2PCxyXUmJqcbUKVxU>
X-ME-Received: <xmr:2Ga_avRhRE1d1RsrfgCDyjQEy6QnIIOXjNLYW6umFNrpn40Fy206dg>
X-ME-Proxy-Cause: dmFkZTFiMJY6nxeo/jMccWltefuWy3cn6ea2g2QEG1GiX35x9x/1PEpsdmiCp9WYU3/3FC
    Lx3VCC7/j/MUylhq2vuiqaR+GJ8hE0hokZMHSIHuglPDy3SbjyR/3TkBILfy/DQc59DsE1
    sB8ckp1UHUSsuIwN+wEyB1HK3rStTd58Z3hy2qtRjP/ZyR2YZlUMU/6p2g32GbbIIBicsN
    aC12Dxlhrh+GBIwDkzs/sMQkLkAVa3pXZbBl3RapTLNTG9qbmLmuuzy/ZWykXO0fBK39Uq
    hV9htYxMjcGJ/jENaybjN6cyLjDTx/JwSZSTeWrzgvI74DM2CsHvizQSY7NsUK2Zh8T7mf
    2wgulp0iH3RVTYhV3luJedNTA+oWXrTAOrwyPlOU3mJItYaFpuL+AQsPHApumgm+J/XyCn
    wDzzL3dZ2ifj/XEfuYNzt0WcB0HIo9d5QIHX8UHej+rSn9YmEmuqavKsT5+HIkXh+UyTyX
    92XyNoORhkqMgXitW7Bb4T3qUYzbtld6GbI0u+puejAYwhYwoS8rtuXgzKgzd0RUDBbQ4p
    STcBCyZKwWhcBHIrn2gAwG9WUddHVdOQDkbNVbOhcdCo8UFMHj0WsvOPceS+QmJC4tKf3U
    ifM760brXNldZrFLii/8gVXv5DHUCVZShuDM+lxng2+hBGYvR48Re2EQqaug
X-ME-Proxy: <xmx:2Ga_aus16WKiOOVtOCp8zixVnREEYntMJDdC-UXCLkGQfW8PpglJcg>
    <xmx:2Ga_asaUJwz8xfCrtTgnX5nUD7wRJsHTu5dJrxllN-AOiWt9xcYR9Q>
    <xmx:2Ga_arsnpDR0BLsBpwQ5N8pbGlpMOxky0jAFDkkdKjUQz-QwnGrggA>
    <xmx:2Ga_amGfj4u3sxD1_flYThIM8MY9NZ8ZdcdsKk-5u5UPEKUKzOHvzw>
    <xmx:2Ga_am_ACMudJj21AGxFWJ1ZQv0lN0Q8BeN68RSkWReZA-FUQX4aZ0v5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:09:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 622e4f7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:09:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 10:09:49 +0200
Subject: [PATCH v2 4/4] builtin/refs: introduce subcommand groups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-pks-parse-options-subcommand-groups-v2-4-3299bee52dea@pks.im>
References: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
In-Reply-To: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The git-refs(1) command nowadays has a bunch of different subcommands,
which makes it hard to figure out what's what at a glance. Now that the
parse-options subsystem supports grouping subcommands though we can do
better. The commands roughly fall into the following categories:

  - Operations that span across the whole reference database.

  - Operations that read references.

  - Operations that write references.

Introduce these groups accordingly, which results in the following help
output:

  Reference database
      migrate               migrate the reference database to a different format
      verify                verify the consistency of the reference database
      optimize              optimize the reference database

  Reading references
      list                  list references
      exists                check whether a reference exists

  Writing references
      create                create a new reference
      delete                delete a reference
      update                update an existing reference
      rename                rename a reference

Reorder the usage strings to match the new grouping.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |  2 +-
 builtin/refs.c              | 32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9dc08cbca9..da7260c416 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
 		   [--include-root-refs] [--points-at=<object>]
@@ -19,7 +20,6 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
-git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
 git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
 git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
diff --git a/builtin/refs.c b/builtin/refs.c
index 5cd21c25fe..decccc4364 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -382,9 +382,9 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		REFS_OPTIMIZE_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		REFS_EXISTS_USAGE,
-		REFS_OPTIMIZE_USAGE,
 		REFS_CREATE_USAGE,
 		REFS_DELETE_USAGE,
 		REFS_UPDATE_USAGE,
@@ -393,15 +393,27 @@ int cmd_refs(int argc,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
-		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
-		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
-		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
-		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
-		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
-		OPT_SUBCOMMAND("create", &fn, cmd_refs_create),
-		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
-		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
-		OPT_SUBCOMMAND("rename", &fn, cmd_refs_rename),
+		OPT_GROUP(N_("Reference database")),
+		OPT_SUBCOMMAND_F("migrate", &fn, cmd_refs_migrate,
+				 N_("migrate the reference database to a different format"), 0),
+		OPT_SUBCOMMAND_F("verify", &fn, cmd_refs_verify,
+				 N_("verify the consistency of the reference database"), 0),
+		OPT_SUBCOMMAND_F("optimize", &fn, cmd_refs_optimize,
+				 N_("optimize the reference database"), 0),
+		OPT_GROUP(N_("Reading references")),
+		OPT_SUBCOMMAND_F("list", &fn, cmd_refs_list,
+				 N_("list references"), 0),
+		OPT_SUBCOMMAND_F("exists", &fn, cmd_refs_exists,
+				 N_("check whether a reference exists"), 0),
+		OPT_GROUP(N_("Writing references")),
+		OPT_SUBCOMMAND_F("create", &fn, cmd_refs_create,
+				 N_("create a new reference"), 0),
+		OPT_SUBCOMMAND_F("delete", &fn, cmd_refs_delete,
+				 N_("delete a reference"), 0),
+		OPT_SUBCOMMAND_F("update", &fn, cmd_refs_update,
+				 N_("update an existing reference"), 0),
+		OPT_SUBCOMMAND_F("rename", &fn, cmd_refs_rename,
+				 N_("rename a reference"), 0),
 		OPT_END(),
 	};
 

-- 
2.56.0.353.g0856645cf6.dirty

