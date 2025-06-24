Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5827F4F5
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759888; cv=none; b=h/Hnl5rh55HrEDk4p2hwANj/3Zi7q3KQ1jI07hraTTZsOBUKStgepani++ZXZmSb12sNdGMtegv5Sv6lK3fWN1JWp+0FPbIaew9/V0OXhCza6QQYxsJ4V+K1MEhWgSpxf/wyYiNswkYfPs62YZfNLEO6LyVYTZvJnRRJ8wrCbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759888; c=relaxed/simple;
	bh=+olpsT2n56LRlTOSmQZrCQVasD002NZpOiazroadw4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wha1M7KRHI1P4k5IU3827F26Ddn7ER9bZV454NUDsLBej2gZ5r7IuNg38i8AD26TXIVsOCAm0drM/tUNS29UGv8ZU0AmYHXMJOSzuf2uIZIMCube/deia1QEhTUzpiXhJHxQLMLO3FV0ouaJ3hM08Z1RfmuGY7+6tQ/rJzmOZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aJ+wWtEO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aJ+wWtEO"
Received: (qmail 17737 invoked by uid 109); 24 Jun 2025 10:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+olpsT2n56LRlTOSmQZrCQVasD002NZpOiazroadw4c=; b=aJ+wWtEO4IfEyAFcSiezTfDT4OyHGgz81LDEfjbrGQIQLscokA3DPGY+zBzemr3i5zUIfrVdHYthFiAOtREAT8lvZ6c17qp4tpMD97pm3a6SX1sIUH70b7zSRWP6UkeUj88prlxM4v3t32s4MXOFgB+syO5nxH5Kqpnwfd8wjhljUKu0tp+QbSo8AlxdzuvyxtChjOhQmouXrKAIZw75Awe9o/IM99IUwwozBTDktieThhjUlOJ+DlnRom953glclBRchcKvvuHw2WMVfy+GBNLH7SnIgAwlAh6IVEoCQlUDztH+e1GqSePxxoitiGOzbXWoX0HmxAMcuzgfA9yWLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:11:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29255 invoked by uid 111); 24 Jun 2025 10:11:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:11:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:11:24 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] test-lib: document test_seq's "-f" option
Message-ID: <20250624101124.GB636332@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
 <oai7p5xmq3q7c3ovdpmbyimoidvgw4lhxfd727qdid5ulcdn3n@7n6vqa6wn3pe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oai7p5xmq3q7c3ovdpmbyimoidvgw4lhxfd727qdid5ulcdn3n@7n6vqa6wn3pe>

On Mon, Jun 23, 2025 at 11:25:20AM -0500, Justin Tobler wrote:

> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index bee4a2ca34..8c176f4efc 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1454,6 +1454,13 @@ test_cmp_fspath () {
> >  # from 1.
> >  
> >  test_seq () {
> > +	local fmt="%d"
> > +	case "$1" in
> > +	-f)
> > +		fmt="$2"
> 
> With the `-f` option, the default format string gets overwritten to what
> is provided by the user. Makes sense.
> 
> If we want, we could update the comment above this function to mention
> this new option.

Good point. I didn't even notice that comment!

Perhaps we should squash this in? I don't think there's any need to keep
it as a separate commit.

-- >8 --
Subject: [PATCH] test-lib: document test_seq's "-f" option

The previous commit added the "-f" option, but didn't mention it in the
function's documentation.

Suggested-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8c176f4efc..6230746cc4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1451,7 +1451,12 @@ test_cmp_fspath () {
 #     test_seq 1 5 -- outputs 1 2 3 4 5 one line at a time
 #
 # or with one argument (end), in which case it starts counting
-# from 1.
+# from 1. In addition to the start/end arguments, you can pass an optional
+# printf format. For example:
+#
+#     test_seq -f "line %d" 1 5
+#
+# would print 5 lines, "line 1" through "line 5".
 
 test_seq () {
 	local fmt="%d"
-- 
2.50.0.399.g566d3d7b27

