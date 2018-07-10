Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86111F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeGJRQb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 13:16:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933299AbeGJRQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 13:16:31 -0400
Received: (qmail 26996 invoked by uid 109); 10 Jul 2018 17:16:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:16:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28770 invoked by uid 111); 10 Jul 2018 17:16:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:16:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:16:29 -0400
Date:   Tue, 10 Jul 2018 13:16:29 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180710171628.GC23438@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
 <20180710170901.GH23624@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710170901.GH23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 01:09:01PM -0400, Jeff King wrote:

> > +		gpgsm --homedir "${GNUPGHOME}" --import "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user &&
> > +		gpgsm --homedir "${GNUPGHOME}" -K | grep fingerprint: | cut -d" " -f4 | tr -d '\n' > ${GNUPGHOME}/trustlist.txt &&
> > +		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
> > +		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> > +		echo hello | gpgsm --homedir "${GNUPGHOME}" -u committer@example.com -o /dev/null --sign - 2>&1 &&
> > +		test_set_prereq GPGSM
> 
> This &&-chain means we can't have GPGSM without GPG. In theory the two
> could be tested independently. I don't know if it's worth the trouble to
> make that work, though. I wouldn't be surprised if there are some subtle
> dependencies within the test scripts, and I'm not sure how common it is
> for somebody to have gpgsm and not gpg. So it may make sense to just
> punt on it until such a person appears.

Oof, sorry, I thought I had read all of the v1 review, but I just
noticed I missed a similar comment from brian. So it sounds like you
already considered this, and just ignore what I wrote here.

-Peff
