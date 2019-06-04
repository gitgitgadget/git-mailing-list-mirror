Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C89E1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDRXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:23:55 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:49534 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfFDRXz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 13:23:55 -0400
Received: from resomta-po-11v.sys.comcast.net ([96.114.154.235])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id YCoKhGQ8UP5jGYDAAhUGpg; Tue, 04 Jun 2019 17:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559669034;
        bh=rR/Z1UV/fBbKok4o6AeeZNjecFz8xNut0M5JWfLXqh8=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=SUcpTwt7SXXf0aIISGs/X9wMYNQKKmmsO/qWy9mSxHBhELkPq7DHMYqwBRXYBBgLJ
         nw5pyKCoZQOSmV5da1ojT6tu6y6F5zlPbWL/mk6Tdkpf00sYuEVpoNSMemuUvZgMhg
         GHgYY83CmLpKsV6BEI0JDPdXBzYPwQBqf/hEP5o9mMcWtuUmPuUsHLD/EblhE7cU4o
         iZ/S3sti8qM/lDepV4n8NtdKmvbmMv+ajyULXptpr5Rqry9F7yGC3BSRInnyaGKtEt
         ZxOBrXHXKgFe0ErhY17yWv0U9ucYYAPsSjjrKkFH9mZThIhwSrK0TcyoUrjmQAEc9P
         G8+ffpeMX/tCg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f95f:aa00:d2b2:a5dd])
        by resomta-po-11v.sys.comcast.net with ESMTPSA
        id YDA8hLyDsVCZLYDA9hxBHV; Tue, 04 Jun 2019 17:23:54 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 4 Jun 2019 10:23:52 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] url: do not allow %00 to represent NULL in URLs
Message-ID: <20190604172352.GK4641@comcast.net>
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-3-matvore@google.com>
 <ca09cb2f-e376-1491-102d-0b06e49530a4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca09cb2f-e376-1491-102d-0b06e49530a4@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 07:01:01AM +0200, René Scharfe wrote:
> It's a bit hard to see with the (extended, but still) limited context,
> but url_decode_internal() effectively returns a NUL-terminated string,
> even though it does use a strbuf parameter named "out" for temporary
> storage.  So callers really have no use for decoded NULs, and this
> change thus makes sense to me.
> 

That was more or less my train of thought as well. Thank you for taking a look.
