Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCA2D29C2
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027231; cv=none; b=fmDGgGrmROLHuzhFquqG1hfSMJPoLEfSgjzIrLTFweuuJbRot0OnaeKBFqkQj9x6Vz7QILw0KYcYNFWNixhdKP4sDhXeOKtWzxzGNi96TyDai67mzOZ8txdEHefbMVO9uW2sPu+fgVRk3lID5sW/P9+g6/4lk3/14UO9HSaripo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027231; c=relaxed/simple;
	bh=m/HDsI6CKhMaOLK4FCyLQAAaLcTMnqTU9kfJy5W9Ws0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttw75eBH3DgVUlKuoKx2ox4iyriPw7vumjCIJ9pUNju/DXgwqTLsMLf1JNC+kOLPelVhJulOgBAPUH3Jn5vKSWV/OZS+GSsclLHr3MwlvkmGny8N6e0Oma0E1kMQkT0ZhfTHtI76gv8yXmzyL2/GC/TsKq7FwM1nqDFUSgyO15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ewkz2jMJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ewkz2jMJ"
Received: (qmail 67004 invoked by uid 109); 25 Feb 2026 13:47:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=m/HDsI6CKhMaOLK4FCyLQAAaLcTMnqTU9kfJy5W9Ws0=; b=Ewkz2jMJbflMWR6kM5r6eTAfwgQJ3KbTMIZWKmmxWVOmVXg6mpUXJzzL3CYW3NA3ZNxYhidDcXno4JN072mxc68+IOgnTeetbDYN5w1y9XArnEtMlFJu7i1gankb4a6dg7uW8j2gs4Qoozr8P+NPVAqCIIVZ9DDKPB6vOup9Le8qqoDMnnK01JdTAr+Utzdk3JeP2Ra330ZRm8kWjJmSEWUwE0+fk88YyEJ+/2Z8J82DlyKFJcztzceqbq2fv/lZsqqpeET/bqIK3EbtodjaX6RD3XxSyvDPwYr4Wg6eGl2FYaidSyRxM/uidhtoB55N41kLZC25NfRDpvY6f+PBXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 13:47:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 200143 invoked by uid 111); 25 Feb 2026 13:47:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 08:47:09 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 08:47:08 -0500
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
Message-ID: <20260225134708.GC2139176@coredump.intra.peff.net>
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
 <xmqqpl5uhwex.fsf@gitster.g>
 <aZ4v6p_oKCayr9A7@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ4v6p_oKCayr9A7@exploit>

On Wed, Feb 25, 2026 at 12:54:54AM +0100, Mirko Faina wrote:

> > So a single commit_line is given to repo_format_commit_message()
> > repeatedly to accumulate those lines in it, which makes sense.
> > 
> > We prepare pretty_print_context once above and feed it repeatedly to
> > repo_format_commit_message()---is that intended?  Not a rhetorical
> > question; I do not know the answer.  I guess some existing callers
> > (like builtin/archive.c) do reuse the structure when making multiple
> > calls to the function, so this would be kosher, perhaps?
> 
> Honestly I applied Jeff change trusting his knowledge of the pretty.c
> code. After taking a better look at repo_format_commit_message(), after
> the pretty_print_context is passed to a format_commit_context as
> pretty_ctx, it doesn't seem like this value is modified at all thoughout
> the call. So it should be ok to reuse the same structure in multiple
> calls of repo_format_commit_message().

A dangerous place to put your trust. ;)

I do think it is OK here, though. And in general I'd assume a "context"
variable like this is re-usable unless documented differently. The
shortlog does use a pretty_print_context in a loop like this, too.

> > > +	if (cover_letter && !cover_letter_fmt)
> > > +		cover_letter_fmt = "shortlog";
> > > +
> > 
> > I do not quite see the point of doing this.  There is no law that
> > "cover_letter_fmt != NULL" is a crime when cover_letter is false.
> > 
> > cover_letter_fmt can be initialized to a fixed string "shortlog",
> > and nobody cares what random value cover_letter_fmt has when
> > cover_letter is false.
> 
> Indeed, was the first thing that came to mind at the time. Had I had
> reread a few more times before sending I probably wouldn't have left it
> like this.
> 
> I'll try to take my time with the next version as to not waste your time
> on unnecessary initialization trivialities.

I think that is OK, but FWIW my instinct on reading the patch was to go
the opposite direction: leave it as NULL and fill that in as the default
at the last minute. Like this (on top of your patch 1):

diff --git a/builtin/log.c b/builtin/log.c
index d13fcf830b..6907a680f2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1360,8 +1360,6 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	struct commit *head = list[0];
 	char *to_free = NULL;
 
-	assert(format);
-
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
@@ -1397,7 +1395,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	if (skip_prefix(format, "log:", &format)) {
+	if (format && skip_prefix(format, "log:", &format)) {
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	} else {
 		shortlog_init(&log);
@@ -2404,9 +2402,6 @@ int cmd_format_patch(int argc,
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
 
-	if (cover_letter && !cover_letter_fmt)
-		cover_letter_fmt = "shortlog";
-
 	if (cover_letter) {
 		if (cfg.thread)
 			gen_message_id(&rev, "cover");

I tend to like keeping the sentinel value as long as possible, because
sometimes it later becomes useful to distinguish "the user asked for
shortlog" vs "the user did not ask for anything". We don't need that
now, but I could imagine some hypothetical future where we are going to
switch the default, and start issuing an advice/warning message.

But it is a pretty minor point, and mostly subjective, so I am happy
either way.

However, the patch above does raise another interesting question if you
look closely: why do we never need to check for the string "shortlog" in
this logic?

We just assume anything that does not start with "log:" should show the
shortlog, and that is true both before and after my suggested change
above. What should:

  git format-patch --cover-letter --cover-letter-format=foo

do? With "log:%s" as the syntax, it should probably be an error. And
this seems like a good place to detect it, like:

  if (!format || !strcmp(format, "shortlog"))
	...do shortlog...
  else if (skip_prefix(format, "log:", &format))
	...do format...
  else
	die("what the heck does %s mean?", format);

But that gives me more thoughts (another dangerous habit, I know). Do we
need "log:" at all? Could the value be interpreted as a format, unless
it is the string "shortlog"? We would want to leave room for future
expansion of new hard-coded names (like "shortlog"), but I do not think
there is any problem there. Any reasonable format provided by the user
will have at least one %-placeholder in it, and no hard-coded name we
provide would have a percent in it.

And then you could just do:

  git format-patch --cover-letter --cover-letter-format=%s

Maybe not a big deal, as I'd expect everyone to set it once in config
(or within a script) anyway. But food for thought.

-Peff
