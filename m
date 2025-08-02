Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BCC13B
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160761; cv=none; b=SXPRIsIkR3WYyZaDJEiFiXlpf2EpWo4jkM8ZTCjGFE2VaV59HYCRdR2++94tqth2mQSk1Yjakq2CZRvD0xNF7smNr8XDLJ0Oi9yTy2uR7hleM+tfw/0zrTjZ2AFbJ9v2GVBmmJqc4kDJsstFJvdzOCwlMu3ZtXhBomP3VHqsGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160761; c=relaxed/simple;
	bh=HrtTbroS2zMHLENx0UG/Hb6+CUiaqQBWapmd2p2+gM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubd67t/NZgy40+ClvbKkhPgbGC5uhyn3YmRgn3LCXxg5poiqR3moqTu9KMJEWSo7SVZxeFajGsQ3vr8fJ0acWw6vHT7jOGqUbRT8SMYvYp/4tmCuHA9dBXSu9M92ZTaxGPnWs+mydtqaMYufTVZtrh1BhRyMg910gIjtGLSG1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wblm3z2x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wblm3z2x"
Received: (qmail 13729 invoked by uid 109); 2 Aug 2025 18:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HrtTbroS2zMHLENx0UG/Hb6+CUiaqQBWapmd2p2+gM8=; b=Wblm3z2xSJpog2jVA7FqhxaQjUQ3nvz8sUIU2o4bKT3rgPHK8HAn+j+OqWXnbKEvVM9kLUbvi/C4y7/8gNd6mXbuphINSf6ls6bupO36t7+5VwQH37vGMkYX8BXk6Ka/Q7XJOAnN3/GUGGqq3+6X5H/sXq+a3KPPJpD8U3VTulH2X3hzaAHYU60aV7Xvw7rjDXFcmHo8NlpLqlHi52KtV70H1saXp1mMrDUJGYSD57HPKfTmqZhwQQbAR5y9JNdEPL2inD7YLSTI53aX9tJoOfq3zONQ7rydOl/ki0JzR8ZqCMA7xKp9+cuODoszOWRZMGjwbUifwgKqUm/TRB3FrQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 18:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19377 invoked by uid 111); 2 Aug 2025 18:52:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 14:52:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 14:52:38 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
Message-ID: <20250802185238.GE1773585@coredump.intra.peff.net>
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g>
 <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
 <20250802094657.GG3711639@coredump.intra.peff.net>
 <CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>

On Sat, Aug 02, 2025 at 12:13:25PM -0400, D. Ben Knoble wrote:

> > Also, I guess this function ought to be respecting the literal_pathspecs
> > global? The actual pathspec parser does.
> >
> > If we can, we probably ought to be feeding the paths to a function like
> > pathspec.c:parse_element_magic() and then checking the resulting flags
> > (and skipping past the prefix as it indicates).
> 
> Thanks for pointing me at this; maybe I'll find some time for patches
> unless someone beats me to it.

So here's a simple-ish way to use the full pathspec parsing code:

diff --git a/setup.c b/setup.c
index 6f52dab64c..ad27a65d6b 100644
--- a/setup.c
+++ b/setup.c
@@ -176,28 +176,27 @@ int path_inside_repo(const char *prefix, const char *path)
 
 int check_filename(const char *prefix, const char *arg)
 {
-	char *to_free = NULL;
+	const char *args[] = { arg, NULL };
+	struct pathspec ps;
 	struct stat st;
 
-	if (skip_prefix(arg, ":/", &arg)) {
-		if (!*arg) /* ":/" is root dir, always exists */
-			return 1;
-		prefix = NULL;
-	} else if (skip_prefix(arg, ":!", &arg) ||
-		   skip_prefix(arg, ":^", &arg)) {
-		if (!*arg) /* excluding everything is silly, but allowed */
-			return 1;
-	}
+	parse_pathspec(&ps, 0, 0, prefix, args);
+	if (ps.nr < 1)
+		BUG("pathspec ended up with no items?");
+	arg = ps.items[0].match;
 
-	if (prefix)
-		arg = to_free = prefix_filename(prefix, arg);
+	/* empty paths (after parsing magic) are OK */
+	if (!*arg) {
+		clear_pathspec(&ps);
+		return 1;
+	}
 
 	if (!lstat(arg, &st)) {
-		free(to_free);
+		clear_pathspec(&ps);
 		return 1; /* file exists */
 	}
 	if (is_missing_file_error(errno)) {
-		free(to_free);
+		clear_pathspec(&ps);
 		return 0; /* file does not exist */
 	}
 	die_errno(_("failed to stat '%s'"), arg);


It does make :^:Documentation work as you'd expect. Curiously, testing
:/Documentation is hard because that is _also_ a valid rev (the ":/"
searches for a commit with that string in its message). So it will
almost always fail anyway as "hey, this is both a rev and a file". But
you can do ":^/Documentation" to see how it behaves. ;)

But here's the interesting part: it breaks a bunch of tests. They all
seem to be doing things like ":file.txt". In check_filename() right now
we treat that literally. But as a pathspec, it is technically "colon
followed by zero or more magic signature letters", and it is eaten.

So I wonder if we have painted ourselves into a compatibility corner a
bit, if we have two conflicting expectations. We might be better off
just teaching check_filename() to parse multiple of [^/!] and the
trailing colon. It's horrible and not great for maintainability, but
this syntax is not something that changes often.

-Peff
