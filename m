Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFD299A94
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623386; cv=none; b=QcVsuRmnWHudYRfdGQOuFIETR0f6IbbbW7vOE/a3O/0gRw/dG/tGU9eooir0dkX08hDPU6D6feSL+nkgLymGhFN9ZDUY2zfKmtNEZgK/44BfOnmazqWMnXZVQzIHbDbl6Cv+jG6RJsFmStWkj/oJK6tUWMNMB6Obluuv9xtO8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623386; c=relaxed/simple;
	bh=Gucyw4oO6w31H7onPYMBWC5+44pgNQHrP+/XqCUnNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBckkj/ukW23k5jyJtgGXTiLlUPubj6nJRahIZT/WZDN3eAbUwK1Q795/ow7Y7uy946aes0W9RfbGzstp5orvlWLCstUftasVOynfIdAYDTlbEl2B7qP/mD5ijhyxiBi328oaJsjDVGnIbrcTHS4sd/LtfP/O5uSPWA9nABvUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A0ZLErr+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A0ZLErr+"
Received: (qmail 57078 invoked by uid 109); 11 Sep 2025 20:43:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Gucyw4oO6w31H7onPYMBWC5+44pgNQHrP+/XqCUnNgg=; b=A0ZLErr+wOOqQT5eVyOZV+r1tg/G9AaCwxx9c6hb9LhsorWw4NTdps/s/z/8Szdy0yyg9YlI6XSvLuHhKKIYGsRmRRjlmqY0ScKsbHPIrA7YC1SKrTHDO2W6Q4evl8GWC99pcuMP4V8YfDRKuDJVx+bDlojEWbK72WxvypXhpdb40glOfmUlQNWdv3LVMnETubOnTUUJP+eNyOhoAde4xkO4OZMpAY38NvSqriHQa4rS3Ts4TUZ44mJJQk4nFIvRhUxDGkfo9VNHp7Ewm2WtnxEDw3rtDNWylizOfzuXVOjpdWYHhceC8ndPlOvBuJDidh/6pP5i7KF6qknvxw2Meg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Sep 2025 20:43:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 90839 invoked by uid 111); 11 Sep 2025 20:43:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Sep 2025 16:43:02 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Sep 2025 16:43:02 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250911204302.GA1907101@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911203256.GA1894340@coredump.intra.peff.net>

On Thu, Sep 11, 2025 at 04:32:56PM -0400, Jeff King wrote:

> It is a little funny to do it up front even when we're going to directly
> run a builtin, but I don't think it harms much. OTOH I find the whole
> placement a little odd in the first place. We are speculatively adding
> to the cmd list before even finding out if we have an alias. It kind of
> feels like this should be part of handle_alias() in the first place.
> We'd need to pass in the cmd_list variable for it to add to and check.

IOW, something like this (perhaps as a preparatory patch):

diff --git a/git.c b/git.c
index ca66e24639..06de0bacf3 100644
--- a/git.c
+++ b/git.c
@@ -365,7 +365,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return (*argv) - orig_argv;
 }
 
-static int handle_alias(struct strvec *args)
+static int handle_alias(struct strvec *args, struct string_list *cmd_list)
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
 
+		seen = unsorted_string_list_lookup(cmd_list, args->v[0]);
+		if (seen) {
+			struct strbuf sb = STRBUF_INIT;
+			for (size_t i = 0; i < cmd_list->nr; i++) {
+				struct string_list_item *item = &cmd_list->items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == cmd_list->nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
+			die(_("alias loop detected: expansion of '%s' does"
+			      " not terminate:%s"), cmd_list->items[0].string, sb.buf);
+		}
+
+		string_list_append(cmd_list, args->v[0]);
+
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
@@ -811,7 +831,6 @@ static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
 	struct string_list cmd_list = STRING_LIST_INIT_DUP;
-	struct string_list_item *seen;
 
 	while (1) {
 		/*
@@ -821,7 +840,7 @@ static int run_argv(struct strvec *args)
 		 * deprecation complaint in the meantime.
 		 */
 		if (is_deprecated_command(args->v[0]) &&
-		    handle_alias(args)) {
+		    handle_alias(args, &cmd_list)) {
 			done_alias = 1;
 			continue;
 		}
@@ -874,30 +893,12 @@ static int run_argv(struct strvec *args)
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
+		if (!handle_alias(args, &cmd_list))
 			break;
 		done_alias = 1;
 	}


And then along with that:

  - a new test at least of the looping deprecated case (we have an
    existing test for non-deprecated looping aliases)

  - while we are moving all this code, I might consider calling cmd_list
    something more obvious like "expanded_aliases" or something.

  - the placement above puts it next to the direct-recursion check in
    handle_alias(). But it does change the output a bit, since we now do
    the check after the "-h" expansion. So Before we'd print:

      $ git -c alias.one=two -c alias.two=one one -h
      'one' is aliased to 'two'
      'two' is aliased to 'one'
      fatal: alias loop detected: expansion of 'one' does not terminate:
      one <==
      two ==>

    And now we'll print:

      $ ./git -c alias.one=two -c alias.two=one one -h
      'one' is aliased to 'two'
      'two' is aliased to 'one'
      'one' is aliased to 'two'
      fatal: alias loop detected: expansion of 'one' does not terminate:
        one <==
        two ==>

    with one extra "-h" line. Probably not a big deal, but that perhaps
    points to the fact that we could be detecting the cycle one loop
    sooner. I.e., as soon as we see that "two" points to "one" we know
    we have cycled. We could probably be checking new_argv there
    instead, after adding the current name to cmd_list (and in fact that
    would catch the direct-recursion case automatically and we would not
    need to do so manually, though maybe people prefer the more specific
    message it produces).

    I'll leave that as an exercise for the reader. ;)

-Peff
