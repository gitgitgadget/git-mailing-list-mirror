Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA064C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjALQM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjALQMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:12:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D521DF2A
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:06:50 -0800 (PST)
Received: (qmail 5139 invoked by uid 109); 12 Jan 2023 16:06:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:06:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16610 invoked by uid 111); 12 Jan 2023 16:06:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:06:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:06:49 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] object-file: fix indent-with-space
Message-ID: <Y8AwGdtrsjnBdXN7@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
 <230112.86k01s2jzm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230112.86k01s2jzm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 10:13:20AM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Sat, Jan 07 2023, Jeff King wrote:
> 
> > +	oi.typep = type;
> > +	oi.sizep = size;
> > +	oi.contentp = &data;
> > +	if (lookup_replace)
> > +		flags |= OBJECT_INFO_LOOKUP_REPLACE;
> > +	if (oid_object_info_extended(r, oid, &oi, flags))
> > +	    return NULL;
> 
> Style: This is "\t    ", but should be "\t\t".

Hmph, I'm not sure how I managed that. Thanks for pointing it out. The
commit is in 'next', so I think we'd want this on top (of
jk/read-object-cleanup).

-- >8 --
Subject: [PATCH] object-file: fix indent-with-space

Commit b25562e63f (object-file: inline calls to read_object(),
2023-01-07) accidentally indented a conditional block with spaces
instead of a tab.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 80b08fc389..ce9efae994 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1708,7 +1708,7 @@ void *repo_read_object_file(struct repository *r,
 	oi.sizep = size;
 	oi.contentp = &data;
 	if (oid_object_info_extended(r, oid, &oi, flags))
-	    return NULL;
+		return NULL;
 
 	return data;
 }
-- 
2.39.0.508.g93b13bde48
