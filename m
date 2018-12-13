Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC3920A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeLMWSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 17:18:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46659 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMWSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 17:18:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1679234pgp.13
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fm1E9A5TnPpg21dyehrYNR8BQ4pUHFcnIXvnLVYXFOU=;
        b=WHuAow5k+eAnE5t4Lv2hD7iNGZxfkvWdIx7gmvQoCxtAUy4q9I2g9X6ijHYVKT1YQh
         5nOcT+M+ClqtO6SHvmItVw95PLS2OpHb/gvfAj2bIKbJs6m1tJM/zun2YvDqHn8Jx8QA
         jixeg+xqv7lEjtoBes1V7AXfprLZhnKqJ60y9RH5NGcttxG0yPE1ldwryjS5cYLPIXE3
         WkqbcrbEVWN71pyxGv0JZg433EEyPFvT6LtEdhO3nEu5IiSfZ8cbT7OOqCVPSYLSo0Ye
         NNliYfPsahsLoIBl9lTHE0TM6r97UBtaI8S4Cj4CRLV1SQo4hf6cOpX4QjBjVipH/EDQ
         Cv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fm1E9A5TnPpg21dyehrYNR8BQ4pUHFcnIXvnLVYXFOU=;
        b=ZvRY3Id39qa9WBNJY0uG6o/UfGdX4yqUlp4G6EjkWxiQZPZ+af96lkj/D1Kwlq5gHI
         X0Eg+HsZ2mkhlXYnW852ZBAiPGHIbWDIs4aBbMpGfVWsVrsADPNo6F7E0C/99LFb/iVn
         K8+wkzf43S3mQXNW4F2ZyQowA0LVyih243FrhrPy5e4etl1w6I51zvVdHv9YVleULb0t
         jocw6K3ZpRjvZEC0I+8iquhioDvIsvKvTF+zT9PaI2IqQdiLY2tfM9hguimaw3tme2vt
         S9kOA4w8UkDjWNEAqZtGmKnMJd90hPd4SkDg7cdLjtjIjIOSj7xHlvKrUcklAnwyeBRE
         Ry8A==
X-Gm-Message-State: AA+aEWb9/hhmipbKBIG4VlW2li+1jQ77++ogOZE6HCwfrnsqXDkD0cxt
        xnQrbw3PhldlLmh5P3XA43Mb7Q==
X-Google-Smtp-Source: AFSGD/X4oHfycfT9+WO1S8bKlfytqUPiSS0U3E4kkiHxe7Wr2+gBfYEriW6cYo6zCGg03LgSaYrK3w==
X-Received: by 2002:a63:af18:: with SMTP id w24mr483564pge.385.1544739513150;
        Thu, 13 Dec 2018 14:18:33 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id e9sm3784708pff.5.2018.12.13.14.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 14:18:31 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:18:26 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     peff@peff.net, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181213221826.GE37614@google.com>
Mail-Followup-To: Masaya Suzuki <masayasuzuki@google.com>, peff@peff.net,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
 <20181212110206.GA30673@sigill.intra.peff.net>
 <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.12 17:17, Masaya Suzuki wrote:
> On Wed, Dec 12, 2018 at 3:02 AM Jeff King <peff@peff.net> wrote:
> > This ERR handling has been moved to a very low level. What happens if
> > we're passing arbitrary data via the packet_read() code? Could we
> > erroneously trigger an error if a packfile happens to have the bytes
> > "ERR " at a packet boundary?
> >
> > For packfiles via upload-pack, I _think_ we're OK, because we only
> > packetize it when a sideband is in use. In which case this would never
> > match, because we'd have "\1" in the first byte slot.
> >
> > But are there are other cases we need to worry about? Just
> > brainstorming, I can think of:
> >
> >   1. We also pass packetized packfiles between git-remote-https and
> >      the stateless-rpc mode of fetch-pack/send-pack. And I don't think
> >      we use sidebands there.
> >
> >   2. The packet code is used for long-lived clean/smudge filters these
> >      days, which also pass arbitrary data.
> >
> > So I think it's probably not a good idea to unconditionally have callers
> > of packet_read_with_status() handle this. We'd need a flag like
> > PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.
> 
> This is outside of the Git pack protocol so having a separate parsing
> mode makes sense to me.

This sounds like it could be a significant refactoring. Should we go
back to V2 of this series, and then work on the new parsing mode
separately?
