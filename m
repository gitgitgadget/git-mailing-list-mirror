Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B097BC12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1CE613EB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhGQC3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGQC3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:29:25 -0400
Received: (qmail 22645 invoked by uid 109); 17 Jul 2021 02:26:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:26:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16493 invoked by uid 111); 17 Jul 2021 02:26:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:26:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:26:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 10/11] refs/files: remove unused "oid" in
 lock_ref_oid_basic()
Message-ID: <YPI/1H1Yo2+iTiPT@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-10.11-09dd8836437-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-10.11-09dd8836437-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:13:06PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In the preceding commit the last caller that passed a non-NULL OID was
> changed to pass NULL to lock_ref_oid_basic(). As noted in preceding
> commits use of this API has been going away (we should use ref
> transactions, or lock_raw_rew()), so we're unlikely to gain new
> callers that want to pass the "oid".

s/rew/ref/

> So let's remove it, doing so means we can remove the "mustexist"
> condition, and therefore anything except the "flags =
> RESOLVE_REF_NO_RECURSE" case. Furthermore, since the verify_lock()
> function we called did most of its work when the "oid" was passed (as
> "old_oid") we can inline the trivial part of it that remains in what's
> now its only caller.
> [...]
>  1 file changed, 12 insertions(+), 60 deletions(-)

Sounds good, and the diffstat is very pleasing. :)

The patch itself looks correct to me.

-Peff
