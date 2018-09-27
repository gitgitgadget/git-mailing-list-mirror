Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6DE91F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeI1BoF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:44:05 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:52782 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeI1BoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:04 -0400
Received: by mail-it1-f202.google.com with SMTP id e9-v6so9204365itf.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlDKlP/vG6N80mJu/2+NPpHoL9jYdk/0pnq+HzS6dWM=;
        b=OB7OxEazMZgdCnqb/G1MxVRwUhFzDYY4K4ahSGfMRNZigU8oBcCBNlO6bex6qCBneD
         lJWXfSTOIMJvZThI1Osu3hzCBPVT2fzonr+Acnhq0BQpbaC1Fp+U+eSF+w14PWyuFLIV
         EHVzVT+vcCbEODuaUBApmOarFVPXUZJOxseGOkmqOkAeiPU1NOtrkYZigMpLD86a2sLv
         mGWPNgeMG+FadbsI1BlkXhj9q6Z2OJhR/eyNXxWyPK/Ru/zetdKBLHFvWl6Xdwj2T4gJ
         xSHKiECvmtwJzAmzYM6V8KCBbrAls0/ycREyfLUk6jZjVyRQl2l9DRWQTLlrXWUg0nFN
         CPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlDKlP/vG6N80mJu/2+NPpHoL9jYdk/0pnq+HzS6dWM=;
        b=iljQLOfNPizcc7yp4toP7DCVteAMViWWPdL3SbZrJMBzoxxIdACWo/t7I2pyWLC6RP
         aoIGF7ZBuwxp78fPybjvutVQHRT5pDiOmvOkU6iyVYCF0HgeIoJA1EJTipbYPtcpQfp+
         ypW1LXEdv/Dj5GAC/p5G4ka2Jd4ts0F5LMjFCbofVzEJFhHWBc8tzE+s9rqUCCH485Og
         62oXBwzUIGX4+eOMLjK/em90RzSu996O+ghRN7tPJY949bTVfhCI5iyQpNd/WWZiIzJR
         rq4z2LOiQ7cieecy8hfNPSPZC2D8XiztvIvVaGsMX+2Ms0YbIfb65jKmESoC3RfpF3qV
         J3Nw==
X-Gm-Message-State: ABuFfoj6/sNQpGfQOX/n9TkIxLHONAkMghB/Kr23F1ptBCideYAoROeb
        bP8LANzVVcI1uOaLnztwDuBEbyf4VU6oBpiZ4cRoE02XWS4lgh1NH+UuuaH4T71j2/3GYjN2aCq
        6DPa2RVQqvp0fkvJ6py4hQ5J/DEwxbjouHFYr0FO87MrsRJXxvuBWmb13Hk0LvAB8Wh0M6bmmaU
        Ir
X-Google-Smtp-Source: ACcGV61RtYU0B9lR0tqohLIyJd3CY+1cQ05wzf3jLuA/PCKty+zIdn8KexYcsMFdMCczxSVLQEAmtz8InVZQC6aHgYoo
X-Received: by 2002:a24:e303:: with SMTP id d3-v6mr395329ith.0.1538076256867;
 Thu, 27 Sep 2018 12:24:16 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:24:03 -0700
In-Reply-To: <20180925225355.74237-1-jonathantanmy@google.com>
Message-Id: <cover.1538075680.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH v2 0/4] Avoid ls-refs when possible in protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To answer Junio's questions in [1], I think it's best to include the
full patch set that I'm developing, so here it is. The original patch is
now patch 3 of this set.

[1] https://public-inbox.org/git/xmqq8t3pnphe.fsf@gitster-ct.c.googlers.com/

Rearranging Junio's questions:

> ... ah, do you mean that this is not a new feature, but is a bugfix
> for some callers that are not calling get-remote-refs before calling
> fetch-refs, and the bit is to work around the fact that some
> transport not just can function without get-remote-refs first but do
> not want to call it?

Yes, it is the bugfix you describe, except that the bug coincidentally
does not cause any bad behavior. fetch-object.c indeed does not call
get-remote-refs before fetch-refs, but it calls transport_set_option(),
which so happens to do what we need (call set_helper_option()).

However, we need it now, because ...

> But this I do not quite understand.  It looks saying "when asked to
> fetch, if the transport does not allow us to do so without first
> getting the advertisement, lazily do that", and that may be a good
> thing to do, but then aren't the current set of callers already
> calling transport-get-remote-refs elsewhere before they call
> transport-fetch-refs?  IOW, I would have expected to see a matching
> removal, or at least a code that turns an unconditional call to
> get-remote-refs to a conditional one that is done only for the
> transport that lacks the capability, or something along that line.

... this "matching removal" you are talking about is in the subsequent
patch 4. And there is no transport_set_option() to save us this time, so
we really do need this bugfix.

> IOW, I am a bit confused by this comment (copied from an earlier part)
> 
> > +	/**
> > +	 * This transport supports the fetch() function being called
> > +	 * without get_refs_list() first being called.
> > +	 */
> 
> Shouldn't it read more like "this transport does not want its
> get-refs-list called when fetch-refs is done"?
> 
> I dunno.

I'm not sure I understand - transports generally don't care if
get-refs-list is called after fetch-refs. Also, this already happens
when fetching with tag following from a server that does not support tag
following, using a transport that supports reuse.

Jonathan Tan (4):
  transport: allow skipping of ref listing
  transport: do not list refs if possible
  transport: list refs before fetch if necessary
  fetch: do not list refs if fetching only hashes

 builtin/fetch.c             | 32 +++++++++++++++++-----
 fetch-pack.c                |  2 +-
 t/t5551-http-fetch-smart.sh | 15 +++++++++++
 t/t5702-protocol-v2.sh      | 18 +++++++++++++
 transport-helper.c          |  1 +
 transport-internal.h        |  6 +++++
 transport.c                 | 54 ++++++++++++++++++++++++++++++++-----
 7 files changed, 115 insertions(+), 13 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

