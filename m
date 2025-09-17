Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A741A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140777; cv=none; b=aOxh2tRa3gzV46RRLxXOJfGcDG33CfVnPHTbFrScXOCudq5Pp5+naa4zyaXcZVh8XMKqf9yyMJyEks1a0IuJD4nML749DuWE7dc+Z8oWJQGmA5YfMUQhKX9m5WkAcCq1NvvtOSkkR46jJ+YXBTGP7vOhY4a0pB6PBYdRl/qmkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140777; c=relaxed/simple;
	bh=PDBwpQAzbHj2YKkWDyskxiVapQiSavvIvBlDUVw+72s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoQVY2TMn1xew+/NDSNUnd5PKV2Qhq7QBTMxKC4q6Z+awQtIA31m2Toq0cFbLxSPdx12ZNkssDKgiDV+LmeT8ipYjACRdaPB4G6eKnoubPzWf+IyYilEjfCxVFCeCI0LAqGKNkLHJWptIAA7Wu/9KLFaZ8R9Vhbs0RTF2TVdN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SEzG0q83; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQERVYvG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SEzG0q83";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQERVYvG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B3C2CEC022F;
	Wed, 17 Sep 2025 16:26:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 16:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140774;
	 x=1758227174; bh=rBwhcoxRn6Kv3aI4W57RuHodyNdHdCRZLTrcGIz52YM=; b=
	SEzG0q83mH+ptrN5jyXuYNCkI6gXoT3Izy810Ieu9cSr2a7qB6soPAwBoLWjHWZW
	/fRYYXSIL+23gq3ekRYRLZcyoZs0nCVTqIxY1QhbRy7ZyBKdeAdE08aAK0/C9gm9
	cXX9Ao3corTKI9AtodYpCFsxn9/m/AN8WJzRIA0jB5PxJG6qsGMNGxQcdwj8OeUQ
	alFbi5sMg4PM/6SoBWaBLIFGq2tcZf3qFh2goxK2KV68fFfmKNpLG6X9aCtxhZaP
	KGpb6sG1t2wmVxilytKytRrXfqPL7dnnKOrV42e+SS1Szrl+WCoMOEmnktgjr2O3
	bSlMxITVKifK0I68NE73Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140774; x=
	1758227174; bh=rBwhcoxRn6Kv3aI4W57RuHodyNdHdCRZLTrcGIz52YM=; b=S
	QERVYvG3bLByWQ0t1nDY6/8cnUtGjwH/UkZBvussfzZ0Bt7YS1pmmhaIe4qRs8P3
	yK3xjLRJSIHnnL/wFg8uVi62zQrYAADml5plzWRYbsgNa4GFvC7+54L9ihdzjDkb
	pQCmPeeREkZOXvGzqf1j8CbHXcXSI5fvDqmrOzn2JgwT+RAYnUOYCc18pNWSQWn6
	7R4oAGoxS4/kKpHTyqqEJgItrD5soibKqrRul6/vSY4PSWT/0VEgJ7lXCEVPXPlo
	wQu77xm+h7Bdiu2trW+zw5TxoqP2N9Wx4NvdYrlKFqMoGkE6hRQzqHTapHFZjvAX
	vEW1Tb6CEO87L2zv1Mv6A==
X-ME-Sender: <xms:ZhnLaFmvm6En4RlEH0rMyYevQBks8vfzeOqYEOpT4talxINJPEYAeSE>
    <xme:ZhnLaJT5ossfqOr50B-UAZJCHnnpmilpXFTNFdUQ6G3llzXyACeKM-7WHRT4o7XJr
    Rx6r_XuuSKb22cgTA>
X-ME-Received: <xmr:ZhnLaMGr_HCbEj6RRUzIOvBgPOf-ZV3Np9H_v-ml9qmK2ubm3CwsEyR9v-nJreOK2g7ru8-raGMJhV7FsMGSFKk7vifdbppWvA1oeyfZIK-4iGpNnPIJz94rlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ZhnLaGFWRjjWGRvi_tZMvbr6KMRxv5zSj00YtUgm8mPoCszC6a-VFQ>
    <xmx:ZhnLaCQMKnbJoQS6BMZiy3Ln38BGbXE6n4p_3ni3Z68lTOCALmVuZQ>
    <xmx:ZhnLaPL5B44Hf6o8PEOfUoCQ2yFZVv0neGAop7hKE7bDEnaeLnAYXg>
    <xmx:ZhnLaFbc2unc7kE3oob3ON0GxOl6HnxayEtpeZFGsRqa1t7LMxop-A>
    <xmx:ZhnLaP8ctvChnGGSKh8Xi9LTEnSRDoGzXYQB85O0vu25gADfFYwRDAnN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:26:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 3/9] git: move seen-alias bookkeeping into handle_alias(...)
Date: Wed, 17 Sep 2025 22:24:13 +0200
Message-ID: <90e35.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to complicate the command handling by allowing *deprecated*
builtins to be shadowed by aliases.  We need to organize the code in
order to facilitate that.[1]

The code in the `while(1)` speculatively adds commands to the list
before finding out if it’s an alias.  Let’s instead move it inside
`handle_alias(...)`—where it conceptually belongs anyway—and in turn
only run this logic when we have found an alias.[2]

[1]: We will do that with an additional call to `handle_alias(1)` inside
    the loop.  *Not* moving this code leaves a blind spot; we will miss
    alias looping crafted via deprecated builtin names
[2]: Also rename the list to a more descriptive name

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v6:
    
    Apply Peff’s patch[1] in order to get rid of the extra output line.
    
    Drop the footnote from the commit message now that we don’t have that
    problem any more.
    
    🔗 1: https://lore.kernel.org/git/cover.1757446619.git.code@khaugsbakk.name/T/#mb3ac9c32c8527675a1f9cdf7709f2c74b3dd2a6c
    
    v5 (new):
    
    Do a preliminary code movement in order to avoid loop aliasing in the
    specific case of alias-shadowing deprecated builtins.
    
    Link: https://lore.kernel.org/git/20250911204302.GA1907101@coredump.intra.peff.net/
    
    As noted in footnote 3: you get one more line of output before the loop
    aliasing is detected (and see the next commit):
    
        'whatchanged' is aliased to 'pack-redundant'
        'pack-redundant' is aliased to 'whatchanged'
        'whatchanged' is aliased to 'pack-redundant'
        fatal: alias loop detected: expansion of 'whatchanged' does not terminate:
          whatchanged <==
          pack-redundant ==>
    
    This is an informational message specifically for `<git cmd> -h`.
    This output can be gotten after the next commit.
    
    The output in this case is very incidental:
    
    1. You are aliasing deprecated commands in a chain
    2. You are using `-h`
    3. You are going to get caught by the alias loop checker

 git.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/git.c b/git.c
index 511efdf2056..ef1e7b205aa 100644
--- a/git.c
+++ b/git.c
@@ -365,7 +365,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return (*argv) - orig_argv;
 }
 
-static int handle_alias(struct strvec *args)
+static int handle_alias(struct strvec *args, struct string_list *expanded_aliases)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	int count, option_count;
@@ -376,6 +376,8 @@ static int handle_alias(struct strvec *args)
 	alias_command = args->v[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
+		struct string_list_item *seen;
+
 		if (args->nr == 2 && !strcmp(args->v[1], "-h"))
 			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
 				   alias_command, alias_string);
@@ -423,6 +425,25 @@ static int handle_alias(struct strvec *args)
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
+		string_list_append(expanded_aliases, alias_command);
+		seen = unsorted_string_list_lookup(expanded_aliases,
+						   new_argv[0]);
+
+		if (seen) {
+			struct strbuf sb = STRBUF_INIT;
+			for (size_t i = 0; i < expanded_aliases->nr; i++) {
+				struct string_list_item *item = &expanded_aliases->items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == expanded_aliases->nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
+			die(_("alias loop detected: expansion of '%s' does"
+			      " not terminate:%s"), expanded_aliases->items[0].string, sb.buf);
+		}
+
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
@@ -806,8 +827,7 @@ static void execv_dashed_external(const char **argv)
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_DUP;
-	struct string_list_item *seen;
+	struct string_list expanded_aliases = STRING_LIST_INIT_DUP;
 
 	while (1) {
 		/*
@@ -859,35 +879,17 @@ static int run_argv(struct strvec *args)
 		/* .. then try the external ones */
 		execv_dashed_external(args->v);
 
-		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
-		if (seen) {
-			struct strbuf sb = STRBUF_INIT;
-			for (size_t i = 0; i < cmd_list.nr; i++) {
-				struct string_list_item *item = &cmd_list.items[i];
-
-				strbuf_addf(&sb, "\n  %s", item->string);
-				if (item == seen)
-					strbuf_addstr(&sb, " <==");
-				else if (i == cmd_list.nr - 1)
-					strbuf_addstr(&sb, " ==>");
-			}
-			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
-		}
-
-		string_list_append(&cmd_list, args->v[0]);
-
 		/*
 		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (!handle_alias(args))
+		if (!handle_alias(args, &expanded_aliases))
 			break;
 		done_alias = 1;
 	}
 
-	string_list_clear(&cmd_list, 0);
+	string_list_clear(&expanded_aliases, 0);
 
 	return done_alias;
 }
-- 
2.51.0.274.gdcb64e51a0f

