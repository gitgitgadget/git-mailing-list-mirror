Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D73175D50
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351200; cv=none; b=DfIbjWDoZ2mhZu0gxbJnrHJVqKAMU/bDZO5UodCTQZzODrUgkDq/PcJbBzR0im2DSay7TafcKdgZixNrm/KLL8G9Qjoy3ODhvSDE7xSPNcJnQfhHsViWMYXIxLErJAKfqQuWEBktvlg8qRTw+NzqqHJzRIfutzWKJScy0qSydWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351200; c=relaxed/simple;
	bh=f/Cupn5tFLfVjJhT4mh8M4kPBZhe5YLHUYu8Hc/dV04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZv2irSEqsIINncsMxzZSXWp6l/IvfVgq1SmNPYr9TVvw1PC90TZRJUVz7TGAY3ei+CIwxOiS/cP+cqDuuZnhsPlCpvYb5zAKA0uemeCcK0k4l8MiT/+iyLMPafU9K1cOIOIZAJyCXTVz3UOvto3B6XuJd/eFIRV/3jURfED/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TWCpStQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HO9ugHaq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TWCpStQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HO9ugHaq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD9D611401B1;
	Thu, 26 Sep 2024 07:46:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Sep 2024 07:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351198; x=1727437598; bh=O9/B2pQ7AV
	/aXHE/IkvoS5tijV3doDeJK476AMQHrZ8=; b=TWCpStQRfY5DFd2uWQQEM+ybrx
	detQg/p6b+1CAOWlLg8jprGT9w0j0kN4iPQLXoLBA3cgiUGotCU4lUg2YEEco3Pj
	dAKlk5BufFACITgvXc9nmtxgERzyVSeyPhzlPY8TI+am8uU8zIR67cGsHDn8kuZ5
	l2BzIHAZ/eftMGuedaAK1f5wJJwlq/S15pnQZuzJmIFIeyY6GmqS9b8giRIvdXbe
	e+YUdV2pyNwy8r5XlSZsIvZ6LOWZ7fNhlOCg/Wiy79+AjPMNur/k8mwWlsBGoA8q
	QFiEZguwmH7BCe48Rgn9x5gTOenPPu/QDlY6YdBUUv0iXaZ8VJp8UutsuUnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351198; x=1727437598; bh=O9/B2pQ7AV/aXHE/IkvoS5tijV3d
	oDeJK476AMQHrZ8=; b=HO9ugHaqnn7DqmpV2SeLgHBiHcavzrxtsAxL12bJjwgC
	PgS3JT2Dz0np40JpKKl9e47JUNcbHz4D9rkO+cjUnJyxrKaBqIK7izCimPmA7sFR
	jWeLfhGvwNcRuEU3JV+3MVHjqLHT9ImSMzi09ymyRCj+HifO5658rH6/o1yyIol2
	g1subOaCEDmry9j+4Wgc3Bfyw/L4f8LsdBijbOnffGeCHCsj9HZVm4Org6WJKZtI
	lGvtZ2rUyr/j+Xz+ghQo2f/hkkfnjLd3mPyJxwg2VW5/A0BhqHETvHiyKNBOGqO0
	6k5tuGONmQE3TF2Fpl1IZsdewApDGLEFQgWZLMLbgA==
X-ME-Sender: <xms:nkn1Zn9Ju2kb7zsKmEk8pI-fvKKQpORM8H6demeTXa62LXjgJY0ntg>
    <xme:nkn1ZjuB0HO3pZhfbPHbeJwIeFoYnqRipwxgihOxT4GW_OerLxQyzteHfiPxUao6V
    mPq5QuUGi_GiPuxxg>
X-ME-Received: <xmr:nkn1ZlBgpuccBDUI7zRq1XOWw8QsD1oK9K5OsgmeZwqcLxNyNYVSYD2R3ZqUpZAiHUf5j-NaKcE-F6wDwLPln3-RR3bJyKlLqju2SwSUPaPnIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nkn1ZjdOAovsAf7xg_9fL_IpNFAIUgt6z2X9fiSl0RzJ0wRd6JVjhw>
    <xmx:nkn1ZsN7OEuPLboG7K3ZDUEwgMpueljeSxg0PMBS61iG9xNforkC4w>
    <xmx:nkn1ZlmA6HiFyrG2PH3OmmB5OhH1bnplGidR4pSuSIMYQ2bROTakcA>
    <xmx:nkn1Zmst-FBdr7wZyoK5KdNmo9C94VMFuw0BEW6HUmX_Fh4ro61aSA>
    <xmx:nkn1Zho4NbdWJ0gpPgZR3ATpCZ86KiTpROmvq26_w9f7AB8Au_BlLuCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69f2b28d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:59 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/23] parse-options: free previous value of
 `OPTION_FILENAME`
Message-ID: <650b89bcca8bec87718e791302adcd4aa35b2a68.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

The `OPTION_FILENAME` option always assigns either an allocated string
or `NULL` to the value. In case it is passed multiple times it does not
know to free the previous value though, which causes a memory leak.

Refactor the function to always free the previous value. None of the
sites where this option is used pass a string constant, so this change
is safe.

While at it, fix the argument of `fix_filename()` to be a string
constant. The only reason why it's not is because we use it as an
in-out-parameter, where the input is a constant and the output is not.
This is weird and unnecessary, as we can just return the result instead
of using the parameter for this.

This leak is being hit in t7621, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 30b9e68f8a..33bfba0ed4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -60,12 +60,12 @@ static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 	return 0;
 }
 
-static void fix_filename(const char *prefix, char **file)
+static char *fix_filename(const char *prefix, const char *file)
 {
 	if (!file || !*file)
-		; /* leave as NULL */
+		return NULL;
 	else
-		*file = prefix_filename_except_for_dash(prefix, *file);
+		return prefix_filename_except_for_dash(prefix, file);
 }
 
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
@@ -129,18 +129,24 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_FILENAME:
+	{
+		const char *value;
+
+		FREE_AND_NULL(*(char **)opt->value);
+
 		err = 0;
+
 		if (unset)
-			*(const char **)opt->value = NULL;
+			value = NULL;
 		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			*(const char **)opt->value = (const char *)opt->defval;
+			value = (const char *) opt->defval;
 		else
-			err = get_arg(p, opt, flags, (const char **)opt->value);
+			err = get_arg(p, opt, flags, &value);
 
 		if (!err)
-			fix_filename(p->prefix, (char **)opt->value);
+			*(char **)opt->value = fix_filename(p->prefix, value);
 		return err;
-
+	}
 	case OPTION_CALLBACK:
 	{
 		const char *p_arg = NULL;
-- 
2.46.2.852.g229c0bf0e5.dirty

