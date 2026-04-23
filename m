Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21A34C130
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978762; cv=none; b=KDG4UliaRe2zFpfPh7/IrBUHTnIofnlBbNxgDEy3a3bKQlu+DQ2tu6G3q+du5k5+bepFEEJnaZgOsC6g27MDNnRElZnk7l+NxHEC73smSwjw1wiejNwfyzkbO+n9Gn5u/WhUHC6C28jZbsg704Qx7ASTGueiIJSVFq19gu5LxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978762; c=relaxed/simple;
	bh=Y45Mg3l1/tiBDIWNtlYrEszYGUQk4K9ZXKjj0sURAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUFHA52hHcSO554HkyvLT0QInEA1lxwbD2ka/p6DmZ2KJXO4fMYeRByYNzWI6UUMEoM2OHUKRzT4l+5yF7bavncB7C+Gx8hZg+w9xDOVIPKT0kHOqtAkaOvqVojyj1rNHDayLlIlfJsJDcPN+PLE/WjDTq40UGhX+z4chp6dEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fOlUrhaD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fOlUrhaD"
Received: (qmail 436129 invoked by uid 106); 23 Apr 2026 21:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y45Mg3l1/tiBDIWNtlYrEszYGUQk4K9ZXKjj0sURAmk=; b=fOlUrhaDp4DQVrH7x2Zf/C7vPZrreNIUyLmkLmbsSR8IxdyTWZZ+qpxUhF3w/uJVKMQcDpOe5OcAOCl4S35ZNIUe3t5IeoGwxeNfXVgIF+Buj9WxJBpuldKZZ+G2CFh7OLRZV6gUKCuwfqL6bGDP39HnasTsCZ5c26tHONXMFWDJGV6M2hijh8/7sjuRZYTBWqwR78kcp+pfCyzQIm6y26rcNhESQW7L2Pz2n/z2hzBWSBgMMVVWZyi/d1GbgcLnex8RMzE19BEZ4BoALoTZgUAD6O/3S99LZhcn2sEXff6D/EpVLpfAsldvJXlZtPnTjUr7CDF0MaBiyUgaZCIYeg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Apr 2026 21:12:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 996667 invoked by uid 111); 23 Apr 2026 21:12:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2026 17:12:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Apr 2026 17:12:37 -0400
From: Jeff King <peff@peff.net>
To: "Grossfeld, Michael" <Michael.Grossfeld@amd.com>
Cc: Jonatan Holmgren <jonatan@jontes.page>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: Hierarchical Aliases no longer work in 2.54.0
Message-ID: <20260423211237.GA1906241@coredump.intra.peff.net>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>

On Thu, Apr 23, 2026 at 06:19:42PM +0000, Grossfeld, Michael wrote:

> Hello all! Seeing this issue on 2.54.0 and it didn't look like anyone had reported it yet.

Thanks for the report. I think you're the first.

> > What did you do before the bug happened? (Steps to reproduce your issue)
> 
> Attempting to use the hierarchical alias "pull.sub", which was working
> in 2.53.0, is no longer working in 2.54.0.
> It returns the following error: "git: 'pull.sub' is not a git command.
> See 'git --help'."

Here's a shorter reproduction recipe:

  git -c alias.foo.bar='!echo ok' foo.bar

With v2.53 it produces "ok", and in v2.54 you get:

  git: 'foo.bar' is not a git command. See 'git --help'.

This is due to the introduction of the three-level alias syntax in
ac1f12a9de (alias: support non-alphanumeric names via subsection syntax,
2026-02-18). We now allow "git foo" to expand based on both alias.foo
and alias.foo.command, the latter of which allows more flexible syntax.

But now we think you are trying to set the "sub" key of the "pull"
alias, which is obviously nonsense. I don't think three-level config
like this was ever a planned feature in the original alias expansion,
but it did indeed work. So I think this is a regression worth fixing.

In the short-term, you can work around it by using the new syntax:

  [alias "pull.sub"]
  command = ...whatever...

And I think we'd want a fix something like this:

diff --git a/alias.c b/alias.c
index ec9833dd30..58f21ac6ba 100644
--- a/alias.c
+++ b/alias.c
@@ -34,8 +34,20 @@ static int config_alias_cb(const char *var, const char *value,
 	if (subsection && !subsection_len)
 		subsection = NULL;
 
-	if (subsection && strcmp(key, "command"))
-		return 0;
+	if (subsection && strcmp(key, "command")) {
+		/*
+		 * We have historically support the "alias.name" form when
+		 * "name" happens to contain dots (e.g., alias.foo.bar to allow
+		 * "git foo.bar". But our parsing above would split that into
+		 * subsection "foo".
+		 *
+		 * If we do not understand the final key in a subsection-style
+		 * variable, fall back to treating it as a two-level alias.
+		 */
+		key = subsection;
+		subsection = NULL;
+		subsection_len = 0;
+	}
 
 	if (data->alias) {
 		int match;

That does still break a historical alias if you happened to call it
"foo.command". I'm not sure if we want to try to be even more thorough
and fall back on that case, or if we're getting now into unlikely
hypotheticals.

-Peff
