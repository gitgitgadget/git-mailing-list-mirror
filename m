Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC32BCF65
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697260; cv=none; b=BCjfH/120JPFhyrt8/H2RJ8bWNV1cA8RrKv6udzYrUZq4yBjp1VnpeJFSDlgRomSvgD/P5Z2G1T8EFjINRkhlqMcCFXLnmjawm1s3FIu0ORnjewUDw3XD1kSeq4+yyBles3lKgYuxmyuQqWEUIzMW96Is+vHJaRxBA2e7YJtbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697260; c=relaxed/simple;
	bh=WhyzrFqvZMETzVPkeEaU9Mj3gOjF38PBtxBHIUopxtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XXd0Yymr468AVyyIOaS/PvK9pcjve37MgTULliDCouzWI2jRrgNSJphSwxIkeXTcilH5gAhcRqgohfUQA2ji+zYdKYFm2bz0ewTBQLZsrTWMth+BQB5raqNiX8Vc7TZCPGtnyZDqpQKfoWmt2tq+6haGXOrrq4n8N4L5MSYjjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=azGzePr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHOrkSdM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="azGzePr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHOrkSdM"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 40A461D000AC;
	Wed, 16 Jul 2025 16:20:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 16:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752697256; x=1752783656; bh=IIhBo1BVrq
	XkVZ2uuOAYP9+gLHhxK6e1fKY2twJV5kc=; b=azGzePr+2uGb2ew6QO9gPa6bZm
	8M0Vx48NdT9g9Z+F9aExsjH1RMIv7Sfg95MGDUs5EeM9MIbRS+6297jAoYcFBijw
	ueBHktM/jWy2CtLFxtx9DcaZqCfh4QLt2NAMM78tXQJ+LikzUISrc3t10Ffb2HLW
	527IiXl+pzruaFUpJDVY3hNAF1Dtm2OVnW7faO0gOIcuDK0+x0jOBMg5LYhS9Hf8
	X5dMV4tCu5DwFPxjIjHAFaD0mAUEJ3Wo3c5x6Sc0toz8e8Jcx7ORbolpNmno2iPu
	ijmRg8dijFzV4ZAU5gY6WA+7Cu0V8NdcgqesVU/h6QFzP4Op4tDIxBvdp+KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752697256; x=1752783656; bh=IIhBo1BVrqXkVZ2uuOAYP9+gLHhxK6e1fKY
	2twJV5kc=; b=ZHOrkSdMtJ8j79ApsHNWg1k30R0oEP/CRbM5dLIeUSE1T2jO+JY
	1566XZquXdMydM/D/+X0AoKBCyCjdzI/XfikikLS+TPLPFVmkESSZQ2MSRayGVNw
	FVA2i5+FpcQPJ5q9/7e2IYlto/FhXvLpUNhnNraAi3aNBnxWr6nvyec2gRHZ4ze3
	Y/WFhA1Q/Z0S6QTQwoOU5cahdK+htAGN5wb/UZ51aX698YvxQ4QRI6YstBr7FPxJ
	MNnDBR9ailSxr/a071NubhVnzSyX9bxO4tG2Lw1fgGFelk10Z0HnGCDLRdqC/mT6
	JkgZ2f7cSZGvwd9GDyXo4sLUMXAGDMo7tng==
X-ME-Sender: <xms:pwl4aBj7MTamJbDMbOQu_bogrlMePoEgSsGxHQ6ux-NHZsOM0u6mRQ>
    <xme:pwl4aLMHPm3GGx1s156ZglCPuCcGOLLkjJW7tflPE_yvGJFL4KfilAXikfOFmC6xI
    pDLq1XwZVM77zjWyA>
X-ME-Received: <xmr:pwl4aB8XEHIRPD9DQJpKDHNrvKcsHrOPyosVzVr8o-C0DtD4agJ4IE4Zs5g0Np1o2WDv2XnBagVP4eqoCfOd7QVHg29KuZ-YOahCBVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegkeevtdeiveekteejteehtedvtdehtddvvedvffffgeeftdevieeifefgveeu
    vdenucffohhmrghinheprhgvphhordgtfienucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghssh
    gvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pwl4aMcC97rKRrzjx4PNOfSJTVSxD4QkWrXwQ496zUK20h9iS1Nlkg>
    <xmx:pwl4aAzZ0tugymeqEGhFboBK5invYRj8mkdZXo5YNo788vqXqk8sfQ>
    <xmx:pwl4aBIH9Q2-ZSfXEMcrtrgwRGSpG7MnkpuWlENoCNrH1Pe8cRUPYw>
    <xmx:pwl4aCHk0kMXT0pxi3setrlWFkO6auFv4GHSyLzukBVgt4kjdnNyjw>
    <xmx:qAl4aD86aHmdJJ0IBREq5_imeJK7AMgujEph_cIt84WFPpkvyqGTfO1i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 16:20:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 14 Jul 2025 20:52:27 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250714235231.10137-1-lucasseikioshiro@gmail.com>
Date: Wed, 16 Jul 2025 13:20:53 -0700
Message-ID: <xmqq7c07c2fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This patch, then:
>
> - Renames the command to `repo` instead of `repo-info`. All the functionality
>   of `repo-info` will now be under `repo info`. The functionality of `survey`
>   will be moved to another subcommand of `git repo`.
>
> - Removes the JSON support. Given that after the previous feedback we already
>   have a nice machine-readable format for outputting this data, JSON would not
>   be so useful as it seemed to be at first (when the "other format" was just
>   returning the values without the keys). This makes the code far more simpler,
>   as we don't need to deal with the details of both formats.
>
> - Uses a simpler representation of the fields, based in their keys instead of
>   declaring multiple enums and using nested switches. This new solution is
>   based in a table mapping the keys and the callbacks for retrieving the data.
>
> - Provide a simple infrastructure for extending with the second command.
>
> Given that this v4 is almost a rewrite, I think it isn't worth to send a
> range-diff.

OK.  If it is almost a rewrite, then perhaps we should tart by
making sure that it won't have too many irritating style gotchas to
discourage reviewers from reading it ;-)

The below is from 

    $ git clang-format --diff $(git merge-base master HEAD) -- builtin/repo.c

I removed some obviously bad suggestions but many were improvements.

I'll follow this message up as if I were reviewing what clang-format
produced.

Thanks.


 builtin/repo.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git c/builtin/repo.c w/builtin/repo.c
index d75417a48b..e8cf465da6 100644
--- c/builtin/repo.c
+++ w/builtin/repo.c
@@ -14,27 +14,23 @@ struct field {
 	add_field_fn *add_field_callback;
 };
 
-static void add_string(struct strbuf *buf,
-		       const char *key, const char *value)
+static void add_string(struct strbuf *buf, const char *key, const char *value)
 {
 	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
 }
 
-static void add_bool(struct strbuf *buf,
-		     const char *key, const int value)
+static void add_bool(struct strbuf *buf, const char *key, const int value)
 {
 	const char *output_value = value ? "true" : "false";
 	strbuf_addf(buf, "%s\n%s%c", key, output_value, '\0');
 }
 
-static void add_references_format(struct strbuf *buf,
-				  struct repository *repo)
+static void add_references_format(struct strbuf *buf, struct repository *repo)
 {
 	add_string(buf, "references.format",
 		   ref_storage_format_to_name(repo->ref_storage_format));
 }
 
-
 static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
 {
 	add_bool(buf, "layout.bare", is_bare_repository());
@@ -45,11 +41,11 @@ static void add_layout_shallow(struct strbuf *buf, struct repository *repo)
 	add_bool(buf, "layout.shallow", is_repository_shallow(repo));
 }
 
-// repo_info_fields keys should be in lexicographical order
+/* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
-	{"layout.bare", add_layout_bare},
-	{"layout.shallow", add_layout_shallow},
-	{"references.format", add_references_format},
+	{ "layout.bare", add_layout_bare },
+	{ "layout.shallow", add_layout_shallow },
+	{ "references.format", add_references_format },
 };
 
 static int repo_info_fields_cmp(const void *va, const void *vb)
@@ -60,12 +56,13 @@ static int repo_info_fields_cmp(const void *va, const void *vb)
 	return strcmp(a->key, b->key);
 }
 
-static add_field_fn *get_append_callback(const char *key) {
-	const struct field search_key = {key, NULL};
-	const struct field *found = bsearch(&search_key, repo_info_fields,
-					    ARRAY_SIZE(repo_info_fields),
-					    sizeof(struct field),
-					    repo_info_fields_cmp);
+static add_field_fn *get_append_callback(const char *key)
+{
+	const struct field search_key = { key, NULL };
+	const struct field *found =
+		bsearch(&search_key, repo_info_fields,
+			ARRAY_SIZE(repo_info_fields), sizeof(struct field),
+			repo_info_fields_cmp);
 	return found ? found->add_field_callback : NULL;
 }
 
@@ -77,7 +74,8 @@ static int qsort_strcmp(const void *va, const void *vb)
 	return strcmp(a, b);
 }
 
-static void print_fields(int argc, const char **argv, struct repository *repo) {
+static void print_fields(int argc, const char **argv, struct repository *repo)
+{
 	const char *last = "";
 	struct strbuf buf;
 	strbuf_init(&buf, 256);
@@ -91,7 +89,7 @@ static void print_fields(int argc, const char **argv, struct repository *repo) {
 		if (!strcmp(key, last))
 			continue;
 
-		callback = get_append_callback(key);
+		callback = *get_append_callback(key);
 
 		if (!callback) {
 			error("key %s not found", key);
@@ -107,19 +105,14 @@ static void print_fields(int argc, const char **argv, struct repository *repo) {
 	strbuf_release(&buf);
 }
 
-static int repo_info(int argc,
-		     const char **argv,
-		     const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
 		     struct repository *repo)
 {
-
-	print_fields(argc - 1 , argv + 1, repo);
+	print_fields(argc - 1, argv + 1, repo);
 	return 0;
 }
 
-int cmd_repo(int argc,
-	     const char **argv,
-	     const char *prefix,
+int cmd_repo(int argc, const char **argv, const char *prefix,
 	     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
