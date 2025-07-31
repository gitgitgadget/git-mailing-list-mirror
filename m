Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA72BD016
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947732; cv=none; b=QGF1fo9X/kaG3CIrlOXxJnHH5dXGKQKyr40sqvyeLMo4fj+O+5HENDdMRnA2BWQtPQibSah6X2cQHyS03gD1RzsKNdWKF5LoSpkkK8P3CA+K2ITMUVX/sQg1OLdqcg6ENxxTAZDEkJ2wH/27gX1qj6snWcJUhgCpRe7DUBqjLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947732; c=relaxed/simple;
	bh=Gw1GLa4yEKENFvmfCKyQBNG9bC8wVl0QRJ74WNrWhN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etc45vKtvIh1R5rep8CLSmE6pemGtyzw+a5DRZme+CpkTCAsSbBsH/KXvBPoqPkX91m4iPyqStD6niLYjzRVgefSJq8rdEG+MNeMdSMKSpHr4PPr/bWgg5XQGgS1aRuwvzQ0bD7lhaM5IOTaUDjkc+r0ynsMOqxWpU3uDuuUETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HOClWmjw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/ZGqrSz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOClWmjw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/ZGqrSz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E84C7A0B88;
	Thu, 31 Jul 2025 03:42:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 03:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947729; x=
	1754034129; bh=m+Fu7w13I0i3+cg5B3HnT+avJCAdzYOIpR2oVwC4tNc=; b=H
	OClWmjwj1Fsk7nSiNNij/34wNF86yLBodVd1H9ebb+J4aGtXbsiIP49A8CHF36Cc
	XOBQSDFu1y6B2Aq+Q0SjdASnhKQUu76GNnH/F8U6HdJpMQGAQd6BE2q9OOkU0kSU
	BOGuafU3dE6wGo63g9PPtKyGlCIVDULRB9bFa0ujvBCko87CE+DFZlvYqDjU+xqZ
	i0JAArTiEs42Ugz1Ot13Zz4tKxmwgsk1CkyiQdp50mkOVxr1XehLnWscFRD6gdSj
	35RZYIy+Za+bcJDE8XcnhkUTOL1bBAdaDAiqyQmIthtlfL1JmtnVMqAR4d9eTBwV
	BEeHmPSjuzkbpyQQwxvog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947729; x=1754034129; bh=m+Fu7w13I0i3+cg5B3HnT+avJCAd
	zYOIpR2oVwC4tNc=; b=m/ZGqrSzbTmQwDOgml4XqhfQ3BQGvAZ4aIba7ikaCyab
	1NP/LSR1Nt7VRAx0MBPJpkiGkNsPyhSlpI01qBvvPyKkaDfdEaHwkhYoqV4hnfns
	GpkKfTJY6PvPcqAlHfkWIVm1Zgjkm6p4/UQ/OQbbmQvPdPXIBomNMrDJRKF8/OP3
	ixRsaoz2i7/eGWtJcHSdun4A3ytps21i1tPueZ4ztwdgmFh/hzZn4cQXKrGDMawt
	c9IemhPhGmKsEb9vZyS+Zi9dS/yk1aa8YfoGYS3wOoMK+FG1tqAXEXYQUeA0XzDR
	s/n2e7R3CFu1m7C5N7eizMoCwiqidPYqWRlXvob4Zg==
X-ME-Sender: <xms:UR6LaJkgHY3qjR5qX3_Qkaos2pBlDYJUTBdebVSHg23UGrg5ehtP9g>
    <xme:UR6LaFBNBTB7_ib3acdeqeKQQ1m4TEfPGa1p4ZL8E0hRHgMdp8QKQFhB_sY7YEUfE
    n6Of4svOKm2LxLH_g>
X-ME-Received: <xmr:UR6LaBcUUgPJSaSiqUyFaubfDyWWwBqfHY9j3ktoSC-EGB1l66fgfGMgLuZOrgBZVo1AJRd6pnTVySG4dSaniRtswzBKqRaQK9YmsvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:UR6LaIK1-YgyQ3tlkvFuyiEy7sf8r5Uoj0b7EnoEkWmmiO3iEJjlzw>
    <xmx:UR6LaMf_1FhduIcB1-XwMuvmU4wNP3MNfXI_4k98EUB0X8Qc6VNV4w>
    <xmx:UR6LaH1khmmQ6swLR9tSfD2Ld4Hqh80qsrCTI6CHhITmJRKBg-NcvA>
    <xmx:UR6LaNgOj2eZOA4XLh2C7s8AGNiE1V0AxPZIvuG7bA5h1Dr7oxfgIA>
    <xmx:UR6LaMJcj1cOFW8oGdGg90Hu4qzLCrRKAuY04kBnxP7WkypA6UYFL5fP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 8/9] environment: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:53 -0700
Message-ID: <20250731074154.2835370-9-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

environment.c:get_git_namespace() learns the raw namespace from an
environment variable, splits it at "/", and appends them after
"refs/namespaces/"; the reason why it splits first is so that an
empty string resulting from double slashes can be omitted.

The split pieces do not need to be edited in any way, so an array of
strbufs is a wrong data structure to use.  Instead split into a
string list and use the pieces from there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 7c2480b22e..ab3ed08433 100644
--- a/environment.c
+++ b/environment.c
@@ -163,10 +163,10 @@ int have_git_dir(void)
 const char *get_git_namespace(void)
 {
 	static const char *namespace;
-
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
 	const char *raw_namespace;
+	struct string_list components = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
 	if (namespace)
 		return namespace;
@@ -178,12 +178,17 @@ const char *get_git_namespace(void)
 	}
 
 	strbuf_addstr(&buf, raw_namespace);
-	components = strbuf_split(&buf, '/');
+
+	string_list_split(&components, buf.buf, "/", -1);
 	strbuf_reset(&buf);
-	for (c = components; *c; c++)
-		if (strcmp((*c)->buf, "/") != 0)
-			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
-	strbuf_list_free(components);
+
+	for_each_string_list_item(item, &components) {
+		if (item->string[0])
+			strbuf_addf(&buf, "refs/namespaces/%s/", item->string);
+	}
+	string_list_clear(&components, 0);
+
+	strbuf_trim_trailing_dir_sep(&buf);
 	if (check_refname_format(buf.buf, 0))
 		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
-- 
2.50.1-612-g4756c59422

