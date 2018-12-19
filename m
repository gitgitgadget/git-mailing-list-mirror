Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF461F405
	for <e@80x24.org>; Wed, 19 Dec 2018 23:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeLSXaN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 18:30:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46954 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbeLSXaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 18:30:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so10125897pgp.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dp1z/Q9omJWADsKiHt8LyQTA0D6U3gO6nuDFnxqbICQ=;
        b=JlLlDQCu4qSBcpcbkoSM6A3zedJiOvFLjmNQxgIW4ueQVN6PbPkMOZttBv8j5/lSuc
         OYrrq1Eq53j1fLuK33e2SK2gLdveYb7osoD+TtLL6LYYeaOD/oAZWoGHv/o47gcDnrZK
         BYxNmpboU4OUM+x1cK92m3Ne7Uwq++55Kht28bidSqtQDBgafsI8ifNWRfs4PXDuM5NZ
         c0B7aRmhrv2WOdTyVVyp5/nR4hHf0GqEeLnKMk+Ykx6jw3caXRxuE40cf4G/otSeSzPM
         Jrd2iI7oXz2mPLeypLZxJOPY9Oh/rxm25vgWku8bwQBjq82UCeed6+5o0Tcag808UJjY
         qb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Dp1z/Q9omJWADsKiHt8LyQTA0D6U3gO6nuDFnxqbICQ=;
        b=Dn+1NZi9Ea4KPHY7IHmYdY7TRo7ZOUqbgir2hfRHN/zPpdywFEL9wP71PvP1amgyqx
         2ucJU0NtRSwbGHwKy7g3AdrG+5dQH6xcUjW/+ZE1FMntXri0Y/ZlndPboTrUsiB3m+T+
         jyXyN2ctt5metX8z84YewV0pYGJTQ5jK3SgSUsA5K/n6Rics5HfMvUkPFS5ky9Ktn/A0
         xl0VWe0BxYDd7NntyYJxEhBdUHNKrgqVx5CztxkpxOz10XPvYirRN4r9EEmkgiGsvIwW
         tE+MS/19mp9JsbEaj4Iuhxp5bBgltikGn1mlX25VvY19ZpkaNQyjfLI5TQ94Wxwzq//3
         fH3w==
X-Gm-Message-State: AA+aEWZA9btdmJqzKJj4xWV01OVeE1UjBsw1BTxSh4WEcTcfSKcnSuzo
        cHvM1D+CSVEaWOFK0FO0FC00rg==
X-Google-Smtp-Source: AFSGD/XUQyePG8nhFMge8nQO5R+zIWEHlqcztMEqCRrtkpGLP5/0jK6l/InALqGDP3skyZpQjQydZA==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr22215646pfr.246.1545262211350;
        Wed, 19 Dec 2018 15:30:11 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id u123sm23665770pfb.1.2018.12.19.15.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 15:30:10 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:30:05 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181219233005.GI37614@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
 <20181212110206.GA30673@sigill.intra.peff.net>
 <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
 <20181213221826.GE37614@google.com>
 <20181217213310.GA14251@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213310.GA14251@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.17 16:33, Jeff King wrote:
> On Thu, Dec 13, 2018 at 02:18:26PM -0800, Josh Steadmon wrote:
> 
> > On 2018.12.12 17:17, Masaya Suzuki wrote:
> > > On Wed, Dec 12, 2018 at 3:02 AM Jeff King <peff@peff.net> wrote:
> > > > This ERR handling has been moved to a very low level. What happens if
> > > > we're passing arbitrary data via the packet_read() code? Could we
> > > > erroneously trigger an error if a packfile happens to have the bytes
> > > > "ERR " at a packet boundary?
> > > >
> > > > For packfiles via upload-pack, I _think_ we're OK, because we only
> > > > packetize it when a sideband is in use. In which case this would never
> > > > match, because we'd have "\1" in the first byte slot.
> > > >
> > > > But are there are other cases we need to worry about? Just
> > > > brainstorming, I can think of:
> > > >
> > > >   1. We also pass packetized packfiles between git-remote-https and
> > > >      the stateless-rpc mode of fetch-pack/send-pack. And I don't think
> > > >      we use sidebands there.
> > > >
> > > >   2. The packet code is used for long-lived clean/smudge filters these
> > > >      days, which also pass arbitrary data.
> > > >
> > > > So I think it's probably not a good idea to unconditionally have callers
> > > > of packet_read_with_status() handle this. We'd need a flag like
> > > > PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.
> > > 
> > > This is outside of the Git pack protocol so having a separate parsing
> > > mode makes sense to me.
> > 
> > This sounds like it could be a significant refactoring. Should we go
> > back to V2 of this series, and then work on the new parsing mode
> > separately?
> 
> Which one is v2? :)
> 
> Just the remote-curl cleanups from me, and then your "die on server-side
> errors" patch?

Yes, that one :)
