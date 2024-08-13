Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA998189BAD
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541528; cv=none; b=V7dGKMjwNs73bDikAGKJ387LwM3PfBA08nY0RcB9N5o6FcbhnN7pRJIsxS51wVZ77M+Igi4e8mJRtQj+y1HzRLNXYyqaswyZg65rCSZxxoauptJhHP6QUO6LpM6nG4A6VOUdveWohC/X+ao/ZNSy8HoJ5WcTtgYnLu9MOk9oFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541528; c=relaxed/simple;
	bh=MTmI9pxDD+BIgfRH0tEiTus53HHC8zaBM+E+NsUt7KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKQtOmPSq7bGSBSWVTi3eHTlry1K9mYAUj3m4tv4Km88wYC+plJ3MgMLCprHvQeC0VIid6Y/imG08wVhLQgLzyqbhae0XBuFdJ44Maa9RZxpat8+1RpLYdTTn9FbwshikQf1ui5w8aZAVD5lVtvg2kn1gjxQtXj1RD/hNCMhH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EGAttZ3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Knj7XG6j; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EGAttZ3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Knj7XG6j"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29AD4138FCEE;
	Tue, 13 Aug 2024 05:32:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541526; x=1723627926; bh=pxJ7Lou9Tl
	vLoYOK/cTN1a+8djtyHLHLa3xQtvwLL8M=; b=EGAttZ3OW9gUYcVCdBon3WHyrc
	p4UzyidH5UJK+xzmhyeML9vizdL5Hub3ehYsBgVeKK6w+/BxjMXk0Az8quZ0QIjW
	DoyxiZyxzvJdtSVVTeOjZ/8AVVDPpQRzGans/dLTbwXfthAdK8VOtDITIdwqKNsE
	rJZWCc82Hs5Auaa3WJvDmE7+R83O+HbU5C1Zh2YWAbSDGILkAAs8687aVpcp0URR
	f/TOoCg9hByYrtK9BKwueQbPvxsS4Jb04JqW1ZucGU+xUbLDBxcngbQfVNnVqgET
	5gv71i/lA5ctfO5XAi4azCXWMe8j6xqbbk4x7kE7SOOz2uNwxmnXKGTZO2Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541526; x=1723627926; bh=pxJ7Lou9TlvLoYOK/cTN1a+8djty
	HLHLa3xQtvwLL8M=; b=Knj7XG6jpQ4kdDkCvY8HBd4aAPkcQSNY0XQnS9pEe968
	tnQCvFzInzDNAa/XDmthTqF6Zqms2ABV6Zdtja8u2W+A2Kuuc99uCcD8IJgOXNRX
	gzaREn3hEBh5K0crSvjlNzD5LpK9nmSF/bj81cz0XyIUDc5oVtLBA2+oO//Eudn/
	jA3GpZScWj9Fuh9dlbTbGsK3FGm4XrvbJCntChz85NgWPOLwfiopYafVBp956kiN
	6/a0laWTYh8nuVy6KOMiJuDwgMAf7BC+cCkj+6dN8Ei0lB8iiKN9Es881ALTmOCZ
	hdRU4q22Y3yghAl1Pp2w4oQq8KSUqGd+4+AiQ1KK5A==
X-ME-Sender: <xms:Fii7ZvQOrIR2a44Xv_9DcfqZ2dws9BIRhi11fz_StWzPcfAPs53-UA>
    <xme:Fii7Zgyyl7sr36iPH1cvPHJi9FDHa5tJLakBNF5IFH_31-VCRr28fkq7WCNqiEuE6
    t_Ujb58sND6_BjMmQ>
X-ME-Received: <xmr:Fii7Zk3v_atw8TucScUjBbGh9PbCEiYJQdDaROyFT81ejghFEfMkNZbj2q29f7dLwVc2VEQO4O5GmiK81pVdvpkp1leWrIlgZc9nBb6pbIxASw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfefueeltdfhfefgteehfffhffegieeukeevteefvefg
    udelgeegueevudfhveeknecuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Fii7ZvB9_QVwC-w4aYa0KGvMscpIFfB5YCSHoOs5A2FYEwBVYkzWnw>
    <xmx:Fii7ZogDmMHK38doGxi98fU362oauZQgeQjjxlsKNu4K3hOx1rnRow>
    <xmx:Fii7ZjpNLLO-bBkRpavaWC05JB6DBQyPS7stqiwzqdqBoiGHFu22WA>
    <xmx:Fii7ZjiPVAcAEj_kZqYDxkHqBWE8daPjQhl-IyvP8cb51odpjR987Q>
    <xmx:Fii7ZjUZy_mmllg8ICDL9cenANr6uON6hNpArC4uDNEgTFzj9McgLjSz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47fca038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:47 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:32:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 18/22] builtin/format-patch: fix various trivial memory
 leaks
Message-ID: <c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

There are various memory leaks hit by git-format-patch(1). Basically all
of them are trivial, except that un-setting `diffopt.no_free` requires
us to unset the `diffopt.file` because we manually close it already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c           | 12 +++++++++---
 t/t4014-format-patch.sh |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a73a767606..ff997a0d0e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1833,6 +1833,7 @@ static struct commit *get_base_commit(const struct format_config *cfg,
 			}
 
 			rev[i] = merge_base->item;
+			free_commit_list(merge_base);
 		}
 
 		if (rev_nr % 2)
@@ -2023,6 +2024,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *rfc = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
+	char *signature_to_free = NULL;
 	char *signature_file_arg = NULL;
 	struct keep_callback_data keep_callback_data = {
 		.cfg = &cfg,
@@ -2443,7 +2445,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 		if (strbuf_read_file(&buf, signature_file, 128) < 0)
 			die_errno(_("unable to read signature file '%s'"), signature_file);
-		signature = strbuf_detach(&buf, NULL);
+		signature = signature_to_free = strbuf_detach(&buf, NULL);
 	} else if (cfg.signature) {
 		signature = cfg.signature;
 	}
@@ -2548,12 +2550,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
 
@@ -2565,11 +2568,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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

