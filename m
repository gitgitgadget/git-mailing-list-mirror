Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812B2DF707
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751962; cv=none; b=PFud8VHPTvUdiC3zrBPifSbOZ0lLD1RfhjC3WMSvnMvryZ2egk5mf0lH6wZvqyssYp7tIlL90DGGTcYBGeFVqek09MVfkEv2elHRHhyN61iRWXSRMknNaNwu+NwcVHD3+r/zdqSJSaWH+HtNn/skz6MP0sAMph9Do1F/9bzjmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751962; c=relaxed/simple;
	bh=meE2eGO7OQcnwuCK7hrK1EXOohMc1S42CJa3KM09baY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGWv1yYidYCPv2BepHxwOw9ENxk53VafHDLdIHy49lYDNvV0Ygc8IPmuKzUICSIhrYsQU56KJWq+CtBZRpTdH1Na4WxNREKB0TZGUIMCaD7nSXX7TSjy7J5u8PNv4IxETePIF6rw+AxZIu2Pno+/FRnR8erDaGlVSqax2kFojtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PjPq39ZE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PjPq39ZE"
Received: (qmail 377518 invoked by uid 109); 29 Oct 2025 15:32:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=meE2eGO7OQcnwuCK7hrK1EXOohMc1S42CJa3KM09baY=; b=PjPq39ZEvpXBKoqcxTKUyBVh/eN3qFGa7t33P7SPrr6sYmYKRCwtueYWY/Oce89aHa5JuWMuDvOwyCt7rd7ndiQxIssRBcxI8+eM2zZW49YfC8lTrLg50WDLvQJ41la6iKpxUm+78X9Ax43SeO2rFYY2fA8Snf+dSwKgBHKbPkKHstPYkOBz8w1ctGG6BJUTvglROZ3D/U9ROGI34mcW3ev5B0iuD8B9mQWdBFUYLdCP/V3cx3UTQWv7Q8yDO3oN686nPRh6vosDmYLPyHQh0me05aEEOQDtUpsOb4pK3L4E2+H/ujnjArRESiH+ns+6mDJQbREfyYD7sLzRXz2S9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Oct 2025 15:32:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 585144 invoked by uid 111); 29 Oct 2025 15:32:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Oct 2025 11:32:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Oct 2025 11:32:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] doc: document backslash in gitignore patterns
Message-ID: <20251029153237.GA1133542@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
 <xmqq7bwhmecb.fsf@gitster.g>
 <20251027142902.GB2758515@coredump.intra.peff.net>
 <xmqq4irkl5ms.fsf@gitster.g>
 <20251028231945.GA4128296@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028231945.GA4128296@coredump.intra.peff.net>

On Tue, Oct 28, 2025 at 07:19:45PM -0400, Jeff King wrote:

> So I think the input is really nonsense, and we're following POSIX here
> in rejecting it. I can't fault an alternative implementation too much
> for treating the "\" as a literal char, since that's the only other
> sensible behavior. It's probably what I'd do if I hadn't read that bit
> of POSIX. ;)
> 
> But to a certain degree, I think this is a case of "if it hurts, don't
> do it". If you are trying to match "foo\", the correct pattern is
> "foo\\".

This was all non-obvious enough to me (and to the JGit folks) that I
think it might be worth beefing up the docs a little, like this:

-- >8 --
Subject: [PATCH] doc: document backslash in gitignore patterns

Because gitignore patterns are passed to fnmatch, the handling of
backslashes is the same as it is there: it can be used to escape
metacharacters. We do reference fnmatch(3) for more details, but it may
be friendlier to point out this implication explicitly (especially for
people who want to know about backslash handling and search the
documentation for that word). There are also two cases that I've seen
some other backslash-escaping systems handle differently, so let's
describe those:

  1. A backslash before any character treats that character literally,
     even if it's not otherwise a meta-character. As opposed to
     including the backslash itself (like "foo\bar" in shell expands to
     "foo\bar") or forbidding it ("foo\zar" is required to produce a
     diagnostic in C).

  2. A backslash at the end of the string is an invalid pattern (and not
     a literal backslash).

This second one in particular was a point of confusion between our
implementation and the one in JGit. Our wildmatch behavior matches what
POSIX specifies for fnmatch, so the code and documentation are in line.
But let's add a test to cover this case. Note that the behavior here
differs between wildmatch itself (which is what gitignore will use) and
pathspec matching (which will only turn to wildmatch if a literal match
fails). So we match "foo\" to "foo\" in pathspecs, but not via
gitignore.

Signed-off-by: Jeff King <peff@peff.net>
---
I like the compact format of the tests in t3070, but it is not at all
obvious what the two lines of zeroes in ones means just from the diff
context. ;)

The first line is wildmatch directly, and the second is pathspec
matching. The surrounding tests, without a second set, default to the
same outcome for both.

 Documentation/gitignore.adoc | 5 +++++
 t/t3070-wildmatch.sh         | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index 5e0964ef41..9fccab4ae8 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -111,6 +111,11 @@ PATTERN FORMAT
    one of the characters in a range. See fnmatch(3) and the
    FNM_PATHNAME flag for a more detailed description.
 
+ - A backslash ("`\`") can be used to escape any character. E.g., "`\*`"
+   matches a literal asterisk (and "`\a`" matches "`a`", even though
+   there is no need for escaping there). As with fnmatch(3), a backslash
+   at the end of a pattern is an invalid pattern that never matches.
+
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
 
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 3da824117c..655bb1a0f2 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -235,6 +235,8 @@ match 1 1 1 1 aaaaaaabababab '*ab'
 match 1 1 1 1 'foo*' 'foo\*'
 match 0 0 0 0 foobar 'foo\*bar'
 match 1 1 1 1 'f\oo' 'f\\oo'
+match 0 0 0 0 \
+      1 1 1 1 'foo\' 'foo\'
 match 1 1 1 1 ball '*[al]?'
 match 0 0 0 0 ten '[ten]'
 match 1 1 1 1 ten '**[!te]'
-- 
2.51.2.833.g5cd7b514cb

