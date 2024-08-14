Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7313D539
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618348; cv=none; b=HQ2CarQ51DJjM7KZ/qPmsDPWpBGruoKsAkKjGoav44QRyUIjcUX0U1/n7AuDST2jgLP+xJvnSl9q1gIjptuLkZRCDDRgeqI8hC5lCGsapeb896AyZJGF6kkPmmsRzdUFl9TGnBf9L/sdzTozK8Kjgj1L8TuzHeWMOWuHunqIeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618348; c=relaxed/simple;
	bh=fHENi47NfIkPY9uLaYewiOQkaHaL1EyfTnxV+ewbN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN3XPhVEEPAmS0F3aSwy3j72xau6X2TkRaEUq7JcU4kixr5JIwpTkHwfwk8kAuCc3wQbVp5Ztabcqsr1bx9y0UD939cHE+VXl/IQMAwK1GYj6z00lv28hjC+c5Zrk6C2u1cuW8DUFjQGcHOQQCVTWyV4B33cY+SyQRX1TpE3GXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1XWpjmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TcAOqUab; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1XWpjmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TcAOqUab"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E47721388210;
	Wed, 14 Aug 2024 02:52:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618345; x=1723704745; bh=Iavsl7yNoX
	i27c6wjO4COJj8MMmnHYhMC7QvatEYelk=; b=J1XWpjmkTVu1MQUgTus3AFUMcS
	i15fwnQcjyppdLDU4fmc7vF8FRkTwQIv1V77K/5A6U6fA3vT8XDfvrjm4ZNUXmQz
	156nIJfjF3AD5KRArK8UG/DS/thcitgZSoEx+08Ko3XnXT9gwJ18grNmeI89Vst3
	C8KrRIsRNFMrlHgmeTqmZY0HNoEi/LglAfo9FDfgfZ+t9wGA9psoZJo9h0BXMBSY
	dTCa2V/8TFRJpfpPzgFirX79oW3OhKhRkMW6lk1cgywNpHpmKnt1T+dBKmM7m1gn
	DTjQHDRVaEqPMSIoAUOle7zhKyY5ESp0TTVDbP8nP7SkzV3B5fyID3203BDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618345; x=1723704745; bh=Iavsl7yNoXi27c6wjO4COJj8MMmn
	HYhMC7QvatEYelk=; b=TcAOqUabSD5TI7rja8dQjPIa8htK88VR5NqjZzPl0nFc
	oHLDyfxy4dMscG3/mT6pQsXLUBh9pwb88UYtXOM72M6/fPFyo3mAJUIRo6EsV1eX
	jkf/L7+xB1awD66pxaZe1OnxbxCWj2YaW1ChgReGj5qjwHX+Du5VZgeGaQNlNRIj
	6mjjdUGiNnsYgoSgyteQBifu9Ex20Qiv2CajHyHQj1+0LEzDnWz9wcurb83i/Ode
	ahu4uYe+2eLDxL9t23y+4VU/Jme+EGqjIsYlhT2YjDMQ9yRADrZa6K8sgPhKCwLM
	OLS/FJaZfiWkLj66T6ecp9xpllqMWK3JqvE/+zphPg==
X-ME-Sender: <xms:KVS8ZtR81Mh46NWlGoq6IYVUmsIVe7iA_VcJNEywt33kNoirKxxPBA>
    <xme:KVS8Zmy6BZ5Mh1RHerJ47GrF_lSUxfF6y8pLcN1RuQUTQ-H2p-PynF13f2QrCoZv8
    ph8GPmDPZ5a8SWyOg>
X-ME-Received: <xmr:KVS8Zi3A3ehVLF3a14lXGx5bZLeFlKGyAGYyvRW28DpWtoiMnZO-5HTyXVYgkvhlUZnYamsGh3lX8o8h445psfMMk8cuGG2oFMRnVbuAozkr2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KVS8ZlCtctURqkTZrbwmfvk-UPoWJ9PeXOU1sl_Trzihwpmflq-fYg>
    <xmx:KVS8ZmhvjUtRPC_NdlbDkPgQ5-BQb8Gzbj58E9a0xu-8QF_TYQj5zA>
    <xmx:KVS8Zpp7FqKQVZBFt3v87N_Jl8xeRboqzAXDN9wsmKDsjcmw-w-WEw>
    <xmx:KVS8ZhiONCfvy1yRhXKM0O6Ppt-hpkbQMawsLhRmvEBjr9yd0M_Muw>
    <xmx:KVS8ZhW_amJ8tP6AUsyd6KJ7icerwshqGCfx6s7o9iNCr9cM8WPESt57>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00e5d62c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:06 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 11/22] builtin/fast-import: plug trivial memory leaks
Message-ID: <30d4e9ed437b70a46d9b625cdb9bc4230aca298f.1723614263.git.ps@pks.im>
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

Plug some trivial memory leaks in git-fast-import(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c        | 8 ++++++--
 t/t9300-fast-import.sh       | 1 +
 t/t9304-fast-import-marks.sh | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d21c4053a7..6dfeb01665 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -206,8 +206,8 @@ static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
 static struct hashmap object_table;
 static struct mark_set *marks;
-static const char *export_marks_file;
-static const char *import_marks_file;
+static char *export_marks_file;
+static char *import_marks_file;
 static int import_marks_file_from_stream;
 static int import_marks_file_ignore_missing;
 static int import_marks_file_done;
@@ -3274,6 +3274,7 @@ static void option_import_marks(const char *marks,
 			read_marks();
 	}
 
+	free(import_marks_file);
 	import_marks_file = make_fast_import_path(marks);
 	import_marks_file_from_stream = from_stream;
 	import_marks_file_ignore_missing = ignore_missing;
@@ -3316,6 +3317,7 @@ static void option_active_branches(const char *branches)
 
 static void option_export_marks(const char *marks)
 {
+	free(export_marks_file);
 	export_marks_file = make_fast_import_path(marks);
 }
 
@@ -3357,6 +3359,8 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	free(f);
 
 	string_list_insert(list, s)->util = ms;
+
+	free(s);
 }
 
 static int parse_one_option(const char *option)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1e68426852..3b3c371740 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,7 @@ test_description='test git fast-import utility'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 410a871c52..1f776a80f3 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test exotic situations with marks'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup dump of basic history' '
-- 
2.46.0.46.g406f326d27.dirty

