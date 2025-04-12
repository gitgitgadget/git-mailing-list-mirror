Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7717C77
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744439283; cv=none; b=W+j/yaKTKkTodFphPQKEX2woOZnQf4Gka0AYtanEOBygKFLxfwaK9SgyJ0Diy94MxiqFS9fV0OMkjDvjXHjZrCpoeoL7Qdk11jZQ36+zNQYfgCkvMVTMpNenERGS1CoBQvQw1ffDC4bA/96HLOwoTApV4VEIPH/S236ycVU11MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744439283; c=relaxed/simple;
	bh=JZmRFv4VuRs3aMp73H6g0Rf05Cd85kiEwVmIlLSI/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIPHCIzHMrFYtN/hQo9eSc8lBmFXEKpxyM78Fq2d+qtkvgpaRjLu4Y0ra1/sOm9CTKrmJP2RHnzaCJ9DIVe0DDeQEAUSSDSqeeP1aW9It5wAqT1Mc9Kb1Ai5XzSeSKhtIDoO6GzBNrieK1nml1GqBX+4gZFPvipyMxoaLjOucUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bh1c5SmK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bh1c5SmK"
Received: (qmail 11285 invoked by uid 109); 12 Apr 2025 06:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JZmRFv4VuRs3aMp73H6g0Rf05Cd85kiEwVmIlLSI/kE=; b=Bh1c5SmKyWNBj01W6NDg4LKGUCCqQsQC8caX36FiOvRsFaokB6OJ5GPxPSdHCEVrz/PNgoJYnKog7ZpU0IpUpK3yHr5KOElwEcOzdbSg5paUDyBgLHY6El4gr2JsR7WEkNs7WrWoPbMDEZHTzjXQTGWRqxTV4NYfymHLOJsVtbIpn5DLqTiv8Sa33thZMfLlmYI8NCOH9VcKkHM2Sj09Cbml5Iy+JZy+sWLURfpq4d8dKOYi0BA8kURCBwpp2z+UEl/Cn3j8xa398+Gs1EEh+Pd3rT/5a0XLS2CoCYLai9mx6aOCcdq1/x2EAg7MQ4NgHQfvEHX8a+uKOiIKxP3xFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Apr 2025 06:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6799 invoked by uid 111); 12 Apr 2025 06:27:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Apr 2025 02:27:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 12 Apr 2025 02:27:53 -0400
From: Jeff King <peff@peff.net>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: piotrsiupa@gmail.com, git@vger.kernel.org
Subject: Re: Bug: Git sometimes disregards wildcards in pathspecs if a file
 name matches exactly
Message-ID: <20250412062753.GA3763415@coredump.intra.peff.net>
References: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
 <20250412015748.7177-1-jayatheerthkulkarni2005@gmail.com>
 <CA+rGoLd-bSbaqfswD+qVrCv1fvG69QX+3BO1htbPJtinFkEQAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+rGoLd-bSbaqfswD+qVrCv1fvG69QX+3BO1htbPJtinFkEQAA@mail.gmail.com>

On Sat, Apr 12, 2025 at 08:30:00AM +0530, JAYATHEERTH K wrote:

> Upon a much closer look into the Git source code, specifically
> init_pathspec_item within pathspec.c, my previous hypothesis regarding
> the optimization check in do_match_pathspec appears to be incorrect,
> or at least not the root cause.

I think you're still on the right track, but are just mis-interpreting
the item->magic field. It's about user-specified "magic" flags, one of
which is "treat this pathspec like a glob, even if the default (or an
earlier "literal" magic flag) would tell you not to do so".

I don't think there is a bit flag in the pathspec item for "this item
has glob meta characters". But we compute and record the offset of the
first such character in the "nowildcard_len" field (which is for most
cases much better, since we can optimize prefix matches for stuff like
"foo/bar/*").

And you can compare that to "len" to see if it does any globbing at all
(which should also naturally handle stuff like ":(literal)" because we
then mark the whole thing as "nowildcard").

So something like this probably works:

diff --git a/dir.c b/dir.c
index cbd82be6c9..85cc08f4fc 100644
--- a/dir.c
+++ b/dir.c
@@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *istate,
 		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
 			continue;
 
-		if (seen && seen[i] == MATCHED_EXACTLY)
+		if (seen && seen[i] == MATCHED_EXACTLY &&
+		    ps->items[i].nowildcard_len == ps->items[i].len)
 			continue;
 		/*
 		 * Make exclude patterns optional and never report

I think if you grep around for 'nowildcard_len ==' you'll find one or
two similar spots.

-Peff
