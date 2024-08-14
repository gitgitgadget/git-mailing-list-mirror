Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B113CABC
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618372; cv=none; b=lrnuLXTKSwziGCYwyLaeKG/NyJYofoQmLfbmYjPBnpQ8wjcKJqJF6bwxjV8aYxl2ua9z7M1j5bix9KAgvf5Uq++OFGe7noeuDyvWCcscR3agsgodo9TvmrXQ+C3SVTHRMuYGqpeesP4MHh6eki9BdBR2Ry5Yq8h53IlZNw7GVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618372; c=relaxed/simple;
	bh=YAEW1CzQIjBpQAIUvMZwiDeu1HYykspVabBY7cybMuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir2FhlarmXubSYd+cTGiGwM5g0maqOImENvLn9isJRYjL8gX8+YWygB+ZrAhTbNc5z3SOzfOEAeGnE60jJciT2MdtjnXuCG9BWC4N4DYtHofRumBv6KUSLmENZg72pNtqRCEzK2cSJkGlrEhV0EewEfnPWtN3mibXmlmeNex9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j43wZK0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vE/TRmny; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j43wZK0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vE/TRmny"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E2E9138946B;
	Wed, 14 Aug 2024 02:52:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 02:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618370; x=1723704770; bh=fH93M4K9L6
	TM8thyERojgUQU2JM4w2+iXKHYGOQpLo0=; b=j43wZK0Xdww91YN8pX/JSVwxkf
	9TKvkzEq7eX5REa/dwMTIwYbiQtkhPPmHE4RZMZrrAMaPWiEEfoBbRrSHIusZS6f
	IsZ9p2o+q4/Zpz6wwZTMRm117QZvWdWs9O0KnWNkXSTE1QVwYKDHU0ifx1drHrH9
	SrxCdSfz+fflJakCJpIT62wO+FK3dfS0zb3vF6P5iX2XAGpM52+YPUmh5n376hVo
	Qg1/gkWW/lNJeYay86pifuS0hkiUAxo1d1hfpyfYcVR9GGKygz+SkhU/wKsE//mS
	m9VbOJvoGXpLrBg63WiVPcC90+1bHqyk2zhWk6qQPbdR8bSuSc0cy9Zei4XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618370; x=1723704770; bh=fH93M4K9L6TM8thyERojgUQU2JM4
	w2+iXKHYGOQpLo0=; b=vE/TRmnyOowlapd/r2Hz84WtJUEAeEUKQjM/SQiGPeVi
	O99QWRGpy3mDvSHOPfD/AVXi1mCdeGecdCchnGfwDK8zZb2iDOqt+33YJd1OJfI+
	J3tBcNjdTJ/zvO+qduW5MPB6CxPJPA7KJynWND/h6ZlzbR4kO3zJNxl1Ax02aB6b
	JWx0Cx39atU/tPzBPIcL3ERvCX1NFlYQiCTG5XlqBQayZIpvM51VnEByp+K4RE/m
	Y+weu4KgNnTBEhkW+EEQ2ElDNKEzPlFQ33T4NiKTxxuHnpxkMhEtYgouxpCB/pWs
	ZoMO4Rj7IdJLHOSPXEFFSnmjmhlJ/TSmfGbkDi6Wpw==
X-ME-Sender: <xms:QlS8ZvREiljVLqfArkZNehFh-rlc1nMiP2yxHEfiCq52KPhGhmXD_g>
    <xme:QlS8ZgywuF0vhaiH341HCM1djkN8BQOk_NaAHQCe_Au_4O2uPm0oQCYUq5NIaCs2I
    BLtC8IgidMCrUvSSQ>
X-ME-Received: <xmr:QlS8Zk0VPoCShhV9gJAfZvatvY47zANWUUQDO1sYVuaQQW84dV2DKhC8Fq5dEZ8hel46jMP3SbDr08nlhMqaW32QzyZFb2C-nrFiLtlXofJgGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgfeeuledthfefgfetheffhfffgeeiueekveetfeev
    gfduleeggeeuveduhfevkeenucffohhmrghinhepughifhhfohhpthdrnhhonecuvehluh
    hsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjrghmvghssehj
    rghmvghslhhiuhdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QlS8ZvCrcQ_qFKLPSPWA7jmKd9_ERUKhDTbW7T3tUWhS36Hzz2I7yA>
    <xmx:QlS8ZoiZY5Gf7jal6IPgHPnYosnb130WHU554p0_6PD5uUShGOBqjA>
    <xmx:QlS8Zjorn11ISt7Ez2kLRkq6Vj-cWCw3k5IqY8hMsFRE6ROPBGtjsQ>
    <xmx:QlS8ZjgVsXUXnq5jDfeMds364HE4HnTHZfkEU2AnxMDL409C_WSibQ>
    <xmx:QlS8ZjXPovkhE2Cx3NzemrKt101fjxpvTq74ltEO1wfc2hebrJq7sQ80>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26faee76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:30 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 18/22] builtin/format-patch: fix various trivial memory
 leaks
Message-ID: <e00aa1ef0677175b4d276607f7b28de0e0491fc7.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

There are various memory leaks hit by git-format-patch(1). Basically all
of them are trivial, except that un-setting `diffopt.no_free` requires
us to unset the `diffopt.file` because we manually close it already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c           | 13 ++++++++++---
 t/t4014-format-patch.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a73a767606..f5cb00c643 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1827,12 +1827,14 @@ static struct commit *get_base_commit(const struct format_config *cfg,
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
 				} else {
+					free_commit_list(merge_base);
 					free(rev);
 					return NULL;
 				}
 			}
 
 			rev[i] = merge_base->item;
+			free_commit_list(merge_base);
 		}
 
 		if (rev_nr % 2)
@@ -2023,6 +2025,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *rfc = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
+	char *signature_to_free = NULL;
 	char *signature_file_arg = NULL;
 	struct keep_callback_data keep_callback_data = {
 		.cfg = &cfg,
@@ -2443,7 +2446,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 		if (strbuf_read_file(&buf, signature_file, 128) < 0)
 			die_errno(_("unable to read signature file '%s'"), signature_file);
-		signature = strbuf_detach(&buf, NULL);
+		signature = signature_to_free = strbuf_detach(&buf, NULL);
 	} else if (cfg.signature) {
 		signature = cfg.signature;
 	}
@@ -2548,12 +2551,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			else
 				print_signature(signature, rev.diffopt.file);
 		}
-		if (output_directory)
+		if (output_directory) {
 			fclose(rev.diffopt.file);
+			rev.diffopt.file = NULL;
+		}
 	}
 	stop_progress(&progress);
 	free(list);
-	free(branch_name);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
 
@@ -2565,11 +2569,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff_title);
 	free(description_file);
 	free(signature_file_arg);
+	free(signature_to_free);
+	free(branch_name);
 	free(to_free);
 	free(rev.message_id);
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
+	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
 	return 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 884f83fb8a..1c46e963e4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -8,6 +8,7 @@ test_description='various format-patch tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.46.0.46.g406f326d27.dirty

