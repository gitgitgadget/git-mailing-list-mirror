Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE17201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934624AbdBVXmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:42:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:60332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934635AbdBVXmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:42:49 -0500
Received: (qmail 1451 invoked by uid 109); 22 Feb 2017 23:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 23:42:49 +0000
Received: (qmail 2060 invoked by uid 111); 22 Feb 2017 23:42:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 18:42:46 -0500
Date:   Wed, 22 Feb 2017 18:42:46 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222234246.wjp3567vesdusiaf@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 11:34:19PM +0000, brian m. carlson wrote:

> Browsers usually disable this feature by default, as it basically will
> attempt to authenticate to any site that sends a 401.  For Kerberos
> against a malicious site, the user will either not have a valid ticket
> for that domain, or the user's Kerberos server will refuse to provide a
> ticket to pass to the server, so there's no security risk involved.
> 
> I'm unclear how SPNEGO works with NTLM, so I can't speak for the
> security of it.  From what I understand of NTLM and from RFC 4559, it
> consists of a shared secret.  I'm unsure what security measures are in
> place to not send that to an untrusted server.
> 
> As far as Kerberos, this is a desirable feature to have enabled, with
> little downside.  I just don't know about the security of the NTLM part,
> and I don't think we should take this patch unless we're sure we know
> the consequences of it.

Hmm. That would be a problem with my proposed patch 2 then, too, if only
because it turns the feature on by default in more places.

If it _is_ dangerous to turn on all the time, I'd think we should
consider warning people in the http.emptyauth documentation.

-Peff
