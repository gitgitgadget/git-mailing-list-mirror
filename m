Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAC4E2F20
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849636; cv=none; b=AMaEdL3+t1aIjeh76qvNqsPLeEGPWErk316F1LS/7a+IQORPhfOzhOoueg8xjQNghxRLfQkHVsP3xviySBFZ7xiMkV4McNp1pe/TFwclVMD61Wk7y9FR3n7Sf4w+P7qE668EZFuIW9Y/cp9jNS4f4et+TbuXkrZ1aLJbTzEs0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849636; c=relaxed/simple;
	bh=cGIcAVwH//JH7sDGitiLNP0l0zU1FbFuvow3N8ELQ9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhjCENARoQECKEQti3XwTUtdZSA4J181/KNwNp9Cfd9G5yVU0b9xGhClESaMUXmAdc4JyNh52isDBaHolrs4pujx9Xf4AICpYuavnpmLBaGdT6+i9c/Er2UYtwCdeh+mymLO74D3Ao9/tgAeWp8zr0i4rDKlAvxaV9y3IIzCgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DcKnJMTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8gM/WZt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DcKnJMTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8gM/WZt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41FC97A00F8
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:13:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 06:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790849626;
	 x=1790936026; bh=A/BGRttBQQeRFH8xjSp8gmdknt2IKosZLmohueHASe8=; b=
	DcKnJMTEAHWLbX6GbbKEwUJZQkzrFMdM+2Y152UsZ2RAF/8zKoUx2QIEZqjgqTg1
	VhiqhUOo/+kbAB//jFWBtaHEAN68NaHzmp0+GRIf6n2FKrEj/qRuVjWOjt+urd4D
	R3T9OBX6HgfeYXolalF4PRXjMGJE8iyAa25s26JYlTy3e/Y6MSgFTvs7bheWJ9eK
	rN3WEqtnLlVWgaP6cgSboRL3PDORhbrINC+SEeDCZI9ggzV/QU9/Phi978/NrNgC
	NkKUKA2l5iOLb8qDvUI79Y+ykhRD2DkxQ7bjmVreNd7+8EdKJDvg0JjOmdYgS4ri
	9/NA3RBKY/oiizMK3SV6/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790849626; x=
	1790936026; bh=A/BGRttBQQeRFH8xjSp8gmdknt2IKosZLmohueHASe8=; b=Z
	8gM/WZtRscv7rov6FvLoCGjZ229l1+Rxs/u+W/xzmNdeTD922ZaTjAvwshT6uL7u
	rqj2CoHoxFAdadFs8o4JJ8m8RzpmQItUS0e+GfjpqbVMPzZ02gaIxFQSZbJ8kWPy
	fpHMaOiCEGXGoDcVO2bMAY+Hd3n4vDJlRapmnF/S4O0l8byjdsOHuIlZTu9XKQ4Z
	+o99uyfobpboBFQQuSPtB88DPZ5RtuTthhuDdQX+KfZO1RowIJKCNp9Z07BpJDes
	d3kXYUx9vVSTnJ4mjjZvcPGrRhHjxBWzamyscw/bspI131kT0XXqScrzThO0xZo/
	RB6R6yo0NrlRRc7O1Yg3Q==
X-ME-Sender: <xms:WjK-atY2L8GTCXVbiEwv1_B7cdxSlCz1VxGb0I1suvMKyeWI4IXG1A>
    <xme:WjK-arWxRnRF6sS3CZhImAc8cPqqq-HUvX91zCneFt2pKln9LFVOmVJQi1rtLrph-
    vaMOWfuaz-pZR69PmkqJGI8awDzaUvwEEndKTdT-5gp3eXHKq9YZ-I>
X-ME-Received: <xmr:WjK-almzwEocyQZy41aItaldYp2twk27rxONsL65yylkMBVkraprKD1-vlRPA29YPq_xIA>
X-ME-Proxy-Cause: dmFkZTF0h35Mue9KHmP8mMGW4ZegWvlnVie16JZ/OUm/O4CJZ3hjyFnJDlEtSwqdPkGNj4
    YcSPAPsLVCPLDg5/1Nw7H0KdO0Ff3jIpzIAf4Pszwl75qMiABMJqxbODbWGF6c3siOaumk
    P1BEEb97x56OYefJOHgySdEogrsY5wMeRcIs064fiS8yalNUdFLxWg87tX3sygwlrYa/i6
    EI9jRTWudpfTsXkoNkGhS6YanrhXcU6LKvDlL1yE5C7cXJ1J+qoc2BJlMlhVtIgyz8UeV5
    fB/BrLFUPqcGt2QRcdYzu4CJ2vOXFJYuyFavPwoZGFtjhKVKj2r/T2CPTKmJVZd7oZ9boU
    LnzSjlElei72ljjAKcgUQQskbBitoesAt5T1lK8vwBHCt2voLVdkMR4nv/9zNasiCX4zUp
    XmGiTlzl46x6OtIK1ZivpG1vv51gvj/MdPx2NK7Cd6Q4DPmseS/X3e24pjBTZ42P0ET3ls
    mh8PCoCJJjTdnLGMzqzE16wYFL2jaNFgQVJK85tjEMk2sIOYBy6Sbd5QuQge5skP/5daFN
    VztfUNY+c5THAo4YZL4v1TlmSV03ZZKwBAdYrENKsr1r58HVtNGOciiTkehEGCKn3uO4Yq
    0748yAVTI8wzQ0HaoyKvgqT0w/XbwyqgvQEB04eCPXlAFUT2muLXmLF3T7hA
X-ME-Proxy: <xmx:WjK-agzUr-FsvL5OjmBvydwxnyJykpC4BmzdIFbAJ5RLJ7TUkNCnAw>
    <xmx:WjK-aogGlZSK1-AyIXc6vNzeIDqb56R0P2dcBuPzYnAP5Z_UzKM9YA>
    <xmx:WjK-atXkXN4HvrvxHoQOPK_gu3OWwe3Bi30E33jtuYDp7YrHkmdyeg>
    <xmx:WjK-ai3Wf9y3v5kUtAwCIV2YQPkl3Dx8pC3KvVyQt81xO6hzzXJPSQ>
    <xmx:WjK-an4-saSZyH857i2uIxom4hDD04koT9W8aG_a8395DphTzZof6Qro>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Oct 2026 06:13:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2e252e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Oct 2026 10:13:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 12:13:30 +0200
Subject: [PATCH 3/3] builtin/refs: introduce subcommand groups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-pks-parse-options-subcommand-groups-v1-3-01eb2f4a4c32@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 5cd21c25fe..f46abd6268 100644
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
+		OPT_SUBCOMMAND_H("migrate", &fn, cmd_refs_migrate,
+				 N_("migrate the reference database to a different format")),
+		OPT_SUBCOMMAND_H("verify", &fn, cmd_refs_verify,
+				 N_("verify the consistency of the reference database")),
+		OPT_SUBCOMMAND_H("optimize", &fn, cmd_refs_optimize,
+				 N_("optimize the reference database")),
+		OPT_GROUP(N_("Reading references")),
+		OPT_SUBCOMMAND_H("list", &fn, cmd_refs_list,
+				 N_("list references")),
+		OPT_SUBCOMMAND_H("exists", &fn, cmd_refs_exists,
+				 N_("check whether a reference exists")),
+		OPT_GROUP(N_("Writing references")),
+		OPT_SUBCOMMAND_H("create", &fn, cmd_refs_create,
+				 N_("create a new reference")),
+		OPT_SUBCOMMAND_H("delete", &fn, cmd_refs_delete,
+				 N_("delete a reference")),
+		OPT_SUBCOMMAND_H("update", &fn, cmd_refs_update,
+				 N_("update an existing reference")),
+		OPT_SUBCOMMAND_H("rename", &fn, cmd_refs_rename,
+				 N_("rename a reference")),
 		OPT_END(),
 	};
 

-- 
2.56.0.353.g0856645cf6.dirty

