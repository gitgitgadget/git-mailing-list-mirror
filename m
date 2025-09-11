Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70521DBB13
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622789; cv=none; b=GH8dPyJ2O69IDG6ufOoO1VimFNwj/NCxAYtu++nbjam0JNbMjU8wb6rcEJtEaQmvReTP9MOQ0VT9COM0kFd3z5LfSTJ0H32xU7bGGqxF+Ndev0QfEjK7D69IHVHpp2o4Z4rlQwV33KXPxuVby/56gj+Ey7Jyz4b8IJdlxEX37sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622789; c=relaxed/simple;
	bh=EDC4w3+u0BodU7HMHp52HDIyPEGrEZ+oa2UjJB9mvpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oivTnHp4lYwAd8xDXZHxIlN5k0Vr+W1uYfEbVOPpJVSsG0pMUySCyRZI3xS4jdNcL/9PcJtcRwbEDnvPl2L7AycLasqW3NtvmtBIHvDGNk+RpNCDAQmCY5eMN1rkc/L1Ru3mU1J/+N7osWvj8orBI9iDuPD9Yf6oUN4DeMFYZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E7tLVnAx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E7tLVnAx"
Received: (qmail 56956 invoked by uid 109); 11 Sep 2025 20:33:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EDC4w3+u0BodU7HMHp52HDIyPEGrEZ+oa2UjJB9mvpE=; b=E7tLVnAx7BwjNRuHGjLddbrDYabOnaFaAGTLG6ffCtSDOl6rS5knOokwpbiWQTqt40tCUS+YEHT/XmYXEsjt2bwLD28miIlf07YOsgaIP9NZ4BXHCo8MiVZKNz270MdvmAem+p96bXZmtxmvRECT/6cVxDE9mYmPb6yf6jfy7P1kEbR/d4lwiFwfCCWBM7Mpdplwqa4bRI98MhNXn4S1pz48C0Pva2e4z8GALTf70ozWCsinbt0Asl8I+NTdoji+7x6ZlGlQO6F4nx8K76zntgWraYGNhGG++24NgEnq8wCBMIns86uVq3ileEydM7+m6hjx1ujACVQct0WyHiQBmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Sep 2025 20:33:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 90721 invoked by uid 111); 11 Sep 2025 20:32:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Sep 2025 16:32:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Sep 2025 16:32:56 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250911203256.GA1894340@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>

On Thu, Sep 11, 2025 at 07:31:04PM +0200, Kristoffer Haugsbakk wrote:

> But it turns out there is a regression in my code with the recursion
> detection.  Compare:
> 
>     $ ./git -c alias.one=two -c alias.two=two one -h
>     'one' is aliased to 'two'
>     'two' is aliased to 'two'
>     fatal: recursive alias: two

Your example there is a little funny; "two" is recursive to itself, even
without "one". We detect that case in handle_alias(), and we would still
detect:

  git -c alias.whatchanged=whatchanged whatchanged -h

in the same spot. I assume what you meant was:

  $ ./git -c alias.one=two -c alias.two=one one -h
  'one' is aliased to 'two'
  'two' is aliased to 'one'
  fatal: alias loop detected: expansion of 'one' does not terminate:
    one <==
    two ==>

which is handled in the caller. And indeed...

>     $ ./git -c alias.whatchanged=pack-redundant -c alias.pack-redundant=whatchanged whatchanged -h
>     'whatchanged' is aliased to 'pack-redundant'
>     'pack-redundant' is aliased to 'whatchanged'
>     'whatchanged' is aliased to 'pack-redundant'
>     'pack-redundant' is aliased to 'whatchanged'
>     'whatchanged' is aliased to 'pack-redundant'
>     'pack-redundant' is aliased to 'whatchanged'
>     'whatchanged' is aliased to 'pack-redundant'
>     'pack-redundant' is aliased to 'whatchanged'
>     [forever]

...that cannot work with where we've placed the new conditional, because
it continues the loop before hitting the alias check. If we move that to
the top, like the patch below, it works.

It is a little funny to do it up front even when we're going to directly
run a builtin, but I don't think it harms much. OTOH I find the whole
placement a little odd in the first place. We are speculatively adding
to the cmd list before even finding out if we have an alias. It kind of
feels like this should be part of handle_alias() in the first place.
We'd need to pass in the cmd_list variable for it to add to and check.

-Peff

---
diff --git a/git.c b/git.c
index ca66e24639..17c566a802 100644
--- a/git.c
+++ b/git.c
@@ -814,6 +814,24 @@ static int run_argv(struct strvec *args)
 	struct string_list_item *seen;
 
 	while (1) {
+		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
+		if (seen) {
+			struct strbuf sb = STRBUF_INIT;
+			for (size_t i = 0; i < cmd_list.nr; i++) {
+				struct string_list_item *item = &cmd_list.items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == cmd_list.nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
+			die(_("alias loop detected: expansion of '%s' does"
+			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
+		}
+
+		string_list_append(&cmd_list, args->v[0]);
+
 		/*
 		 * Allow deprecated commands to be overridden by aliases. This
 		 * creates a seamless path forward for people who want to keep
@@ -874,24 +892,6 @@ static int run_argv(struct strvec *args)
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


