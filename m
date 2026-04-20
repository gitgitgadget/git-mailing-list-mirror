Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F340DFCE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644482; cv=none; b=FPxxSeAyFQVj24+eWrML28v8zF/0Hsku4s+yNHsh4FZ44tRoUJInv/LBrloqPhKNA1UiL1PeGFTdEt4t/xnLV0LT09iWAei1l/GcoM/AzIKc+o7IEwH7wdrwpl2rtqYxhAqY1f42Bn5TGn9oJb11rYe8G/t8+VMgFIwypUYLkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644482; c=relaxed/simple;
	bh=FSbHFekIrPJRAk/37uIfEJLBzr/ArzFWo/BDnkzPhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at5hXXfchRJMRJgTmSnY1Dr7mibW1R3rQGXnaXx7NQ3GyfEHEI6IGO/7gWlAlt3k8BmsFSm9W9LlT7YF1g+jieROU8/r8EzBBu+w9BbRQsI2PiUiMXPD2xzlPELxDsuqsJTUfAWBau0OFDbtGMHaW8ZgxH+udRXNPvmJ2VQBMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XlvXjm9t; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XlvXjm9t"
Received: (qmail 402185 invoked by uid 106); 20 Apr 2026 00:21:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FSbHFekIrPJRAk/37uIfEJLBzr/ArzFWo/BDnkzPhX0=; b=XlvXjm9teven+WmtRUkfdZ5UGyndBYwjvpiRTAJX7S4bB9MnIpTRg2XuD2EdxGza7EwwSm7s4RlYjbGHYLzzbTKcGhrhXgo7V+cx5ysPsKji8xbvjR1AfQ1wnK3PqJTlsAxKb/tXjAn2jdK0ngsOi6oN2qhhgVbsgbd9aOb+uMQFTEw2D0LpcLfqCd5ACsq0kxkLDbGMOd7cPiVdppNPMq/6tCD5OB3w1l3OvJsq3A0Fp7HIfDY616KDYP1YTsYBxlkhmbAYSDEKJo1PEDiRQqLw93XxJSOuZ9B0S0JNk6aLIg8K9w4hCSAnBoQ3R1ce9lOCUJdv9kOT9SSvTKwrLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Apr 2026 00:21:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 916600 invoked by uid 111); 20 Apr 2026 00:21:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Apr 2026 20:21:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Apr 2026 20:21:18 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <20260420002118.GB1238475@coredump.intra.peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeUqSltEWIWaPDh3@exploit>

On Sun, Apr 19, 2026 at 10:31:37PM +0200, Mirko Faina wrote:

> > I think I mean that
> > 
> >     git log --reverse --reverse
> > 
> > shows commits in the same order as "git log"; what should
> > 
> >     git log --reverse=after --reverse
> > 
> > do? Or what about preserving the behavior of the original "git log
> > --reverse --reverse," which I don't think is done here?
> 
> Yes, this is what I was getting at. Since it is no longer binary what
> would a double reverse mean? What if "--reverse=after --reverse=before"?
> How should that be handled?

Yeah, I agree it gets weird, and I think it is OK if we don't try to
combine before/after reverses (either making it an error, or using the
usual last-one-wins to have "before" override "after" in this example).

But we should keep "--reverse --reverse" working as before, as there is
no other way to countermand a previously-given reverse option, and
because it has always worked.

Usually we'd spell the option "--no-reverse", and it probably makes
sense to add it (to override an earlier "--reverse=after"), but we'd
still want to keep "--reverse --reverse" working for historical
compatibility.

So combined with the earlier suggestions for using an enum and
disallowing the un-stuck "--reverse after" form, we probably want
something like (totally untested):

diff --git a/revision.c b/revision.c
index 599b3a66c3..89a58a65b7 100644
--- a/revision.c
+++ b/revision.c
@@ -2686,7 +2686,20 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			git_log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
-		revs->reverse ^= 1;
+		/*
+		 * This relies on "do not reverse" being the 0 value for our
+		 * enum, and historical "reverse after" having value 1.
+		 */
+		revs->reverse = !revs->reverse;
+	} else if (!strcmp(arg, "--no-reverse")) {
+		revs->reverse = 0;
+	} else if (skip_prefix(arg, "--reverse=", &optarg)) {
+		if (!strcmp(optarg, "after"))
+			revs->reverse = REVS_REVERSE_AFTER;
+		else if (!strcmp(optarg, "before"))
+			revs->reverse = REVS_REVERSE_BEFORE;
+		else
+			die(_("unknown value for --reverse: %s"), optarg);
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;

Note that your original also allowed --reverse-o-matic, which we
probably don't want (and is fixed here).

I _think_ the negation from using "--reverse" after "--reverse=before"
should be sensible here. And "--reverse=" with two different modes just
overrides rather than trying to be clever. But you may want to
double-check all of the combinations.

This would all be much easier if revision.c used parse-options, of
course, which has all of these sorts of rules baked-in. But that's a
much bigger conversion, and probably not something you want to make a
prerequisite for your series. ;)

-Peff
