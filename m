Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02310201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbdEQNPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:15:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdEQNPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:15:03 -0400
Received: (qmail 4762 invoked by uid 109); 17 May 2017 13:15:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:15:02 +0000
Received: (qmail 9375 invoked by uid 111); 17 May 2017 13:15:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:15:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:15:00 -0400
Date:   Wed, 17 May 2017 09:15:00 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 09/23] files-backend: move `lock` member to
 `files_ref_store`
Message-ID: <20170517131459.uznay3pmzgxijunm@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <9b52c29411fa11ac0d8227d5ae78ba2768485b3f.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b52c29411fa11ac0d8227d5ae78ba2768485b3f.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:32PM +0200, Michael Haggerty wrote:

> @@ -70,6 +61,13 @@ struct files_ref_store {
>  
>  	struct ref_cache *loose;
>  	struct packed_ref_cache *packed;
> +
> +	/*
> +	 * Iff the packed-refs file associated with this instance is
> +	 * currently locked for writing, this points at the associated
> +	 * lock (which is owned by somebody else).
> +	 */
> +	struct lock_file *packlock;

I'm glad to see you renamed this from just "lock", though the short
"pack" makes me think of packed objects. I don't know if
"packed_refs_lock" would be too verbose (I see it's just "packed" above,
so maybe "packed_lock").

</bikeshed>

-Peff
