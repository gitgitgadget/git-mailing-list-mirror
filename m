Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C622E0934
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879466; cv=none; b=YsZQVifpyDRyA+9wkMJHzBKz6u0fQPi32GJENj8jEExx+6DyXmUEGOhVDZM1OLYo3wM1W8ki+6LiSMFdIrVcQglQmmljloA6Am/rZ75epj2LW8/JRaSWdEbqJ7DCH5J+HiU9mZDQLqWo0EjTNB4F2sccAn8fCxNyrzgQFTJBWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879466; c=relaxed/simple;
	bh=9p73AuKBuvH4SqXhU2JC3t2NMYeu9X2bjRmfvVBJb20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8DDL7+rZcY46CCsJfz/ciYtXuEudbp1+crJxiak0p1ipXqFOO0wlzmo0FaTuKBubb5kmrhlySbKfj5jQGwXbTQX2nQj7hYywzVhJtozTkRauChRzBKeDV1R6jSndlWAkNmW8LJTaNp7ArS+RUVr0hg0t4jO7VKDjb2s9+qhK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WD14Hbxc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBeYPZd3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WD14Hbxc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBeYPZd3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F1E851D00135;
	Sun, 14 Sep 2025 15:51:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 14 Sep 2025 15:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879463;
	 x=1757965863; bh=8HU4v8itWjAQ4mkPC8Prbc+a6Ou9RHI3IoyD8apDYqQ=; b=
	WD14HbxcBo1OpwqAhArJv7QbGyvYjtU9KmomAMu3zzEBBe+x8hnbKu1hk2F0CvbP
	D2tcj4OQ7CwgBy8jJt1f3/n/aEeNaJ888NkMmAFgEe42VsGBgqtiBuQG2Ub3HVgg
	toNqnZzeO/Pjl8Dh9tuqV3jI554scbA+2wSH8rpSvea/baXNco1WM+wZLHql9EZ9
	4YGlAk/GoKLuvfvSDpflnsUtZa9mb1HKJZz08IO/OgE40nv5OLIByOfnD1RVtOzN
	MGqjrPaTvzhBS+5rTuxmdGf3SmoTmmoWzY/nHwy7G9PnUnOBy/JJoYLv5tQAem5W
	MgSRXHeNkagYJ6mxZ0tQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879463; x=
	1757965863; bh=8HU4v8itWjAQ4mkPC8Prbc+a6Ou9RHI3IoyD8apDYqQ=; b=W
	BeYPZd3NBW4rQa8zXEusgjb4QiUzUv10vXT9sZYRQxuaM7Pg3rPSMOmEr8KuNTz+
	pBJr/3f6hPmxnNeJwsoak7o75Fyv8G1Auq/qtnBsOYI9S7xyT83kRij6K/ZoTdAu
	ygDC/oFxZVdw5a25G5NsHSZqBRv13Qtiq+EoUFBk7doWevSDQkQB+xZApulKi0fc
	jj5vcMRvCbdOofmrRuQemcAaGvtKiQVXH3rkwml7Ke6nIU/D/bdIddpnZTOsnL9w
	HXPLBgayRfPzik/nK67Ur6mOQsUDKtPyNsBs9D2/Y4EiPM6jwl/4/nSql4g7e+ei
	OVa8At3HJH6Gewhzgu/0A==
X-ME-Sender: <xms:pxzHaP1nK7E-zZ47ZF-iNdeyM3wZMjaOsUk0Ni_Lxyw4N-w_LSy8o3g>
    <xme:pxzHaGjv5_oy_TzswI2uuxNYIbwHOVAzI44CQKAmkMmkuhQrqO-bwyIAOmpAHTXPU
    8oNGlgik9ohWpRLbA>
X-ME-Received: <xmr:pxzHaAXPpf34iVs-j5h1UeCzTQexpNXlk80KSZPTjVjixJNffy4XTEU_FoRzzcHtuTVCYa6I2J7Ca2TrEXZqkm7qk8Qa9EFr3UwbpMRb2_X1jwYoJCsPuoNYbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pxzHaFVyqYzW7biW9ZBa8lFF3POxT5wJNSr3_Nx6aPC64XHyXrSY-Q>
    <xmx:pxzHaAgrasxgqBCysws-i0iAz181s0fJ_kDihDDC1_-feeaAY9PX1A>
    <xmx:pxzHaAb5RRU85ZU3pZNsidCTSrtHsZWsYMIPFMC3DgUs_Dk-ItBOKA>
    <xmx:pxzHaNpv3LCoVt66rnZP1mq-HDvgBogk85eJbGUy_Aq5XpFtzQc2fA>
    <xmx:pxzHaCM556_Nh6RA7f8z5RExBheFdoi1ta5F-cKCXRuJLOgDCCp-H0xf>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:51:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/8] git: move seen-alias bookkeeping into handle_alias(...)
Date: Sun, 14 Sep 2025 21:49:36 +0200
Message-ID: <7f82ef6e96f694cb1e40d7865b0520886a98f007.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
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
only run this logic when we have found an alias.[2][3]

[1]: We will do that with an additional call to `handle_alias(1)` inside
    the loop.  *Not* moving this code leaves a blind spot; we will miss
    alias looping crafted via deprecated builtin names
[2]: Also rename the list to a more descriptive name
[3]: The error output `'<cmd1>' is aliased to '<cmd2>'` is used for the
    `<cmd2> -h` case.  We will get one more (redundant) line of output
    in the case of alias looping; that is covered in the test “looping
    aliases - deprecated builtins” in the next commit

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
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

 git.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/git.c b/git.c
index 511efdf2056..f9c2d8c8d86 100644
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
@@ -423,6 +425,24 @@ static int handle_alias(struct strvec *args)
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
+		seen = unsorted_string_list_lookup(expanded_aliases, args->v[0]);
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
+		string_list_append(expanded_aliases, args->v[0]);
+
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
@@ -806,8 +826,7 @@ static void execv_dashed_external(const char **argv)
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_DUP;
-	struct string_list_item *seen;
+	struct string_list expanded_aliases = STRING_LIST_INIT_DUP;
 
 	while (1) {
 		/*
@@ -859,35 +878,17 @@ static int run_argv(struct strvec *args)
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
2.51.0.16.gcd94ab5bf81

