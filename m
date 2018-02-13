Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116771F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965181AbeBMRGu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:06:50 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37270 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964869AbeBMRGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:06:48 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so6929330plb.4
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JcKwZU6LQLbNTo6F22w18RxAquUDVt1I+DMMJJezT6c=;
        b=UQHmF5+p6Xl33zFhNRxArRDFPBd6bw4G4CjA4od0GCQVn7j5Ze+I6ordRUdNLqTmU8
         o3bMlQ0z7fPzt+4MbATLfsTFDu+qEsJ1kRuxLQY+8tXytwNPAi0+Fws5XdUxJoQ8Q5RF
         Ot2Abj2wfTbq5RLAeywubjbnpz15g/ko/bUaUXTOeG7av5GfJeIOeSav3sdw0wwVS8aM
         iO3t/+l8wVTUArPFbt0ybdKnQKmCzigcmm6YCyML/PBR1udDdViqZ807E5V9nOVU5IVK
         N2DBo1rTtvgauH5qhqWcoebbsayOWLgyvPn3kLOCgN+I9NmCoSWThvs1oxWsQKYsPg9Y
         ADug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JcKwZU6LQLbNTo6F22w18RxAquUDVt1I+DMMJJezT6c=;
        b=ZtzX80xCA+k7oeR9CGHwSVXev3S5IlJS9higHtJqjwvICXxRU8auMkg1GeBEVKl1Qh
         UTt0SDgHUi4UCa8fRMy2qFsxtWRgYRlnZmwtRCGeVtJrFc5A9wd0hm4MGZTnnUchakA7
         6gp+ZgKh3Thlfbyemh6a3RbRD4Di7qnkMy/gAEuN/DBJAQEdgjvj5psv1i/JLhROW3EX
         q9GLG075Q6IRRCyve3GNZtEDX7CRjAgu+dNyFLduS2bjPdKovobfe/qCu4G1V/YOF4DB
         SwoBXSsm5npDoSs2qPCZ76+6e8FbkcUJwDuUjBvL1RA5Vett2lHy+3+jFLD3AXY8eQ2I
         txAg==
X-Gm-Message-State: APf1xPCx9rUe6x6pjR8zx6hDtMfrEy/XVBkUuMaFgZwHzYHDYJyu0KV4
        UPLvRovxgTek3b9fDcK9mcTjIw==
X-Google-Smtp-Source: AH8x226XXKhWWI/sCTB2iqjbdOrgsi7JkBjEA69oK3Twh+zx4v1Uy9w1ik3MrRVjTJq7nLB994dl4w==
X-Received: by 2002:a17:902:34a:: with SMTP id 68-v6mr1767930pld.276.1518541607719;
        Tue, 13 Feb 2018 09:06:47 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o63sm36739448pfa.101.2018.02.13.09.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 09:06:46 -0800 (PST)
Date:   Tue, 13 Feb 2018 09:06:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 22/35] upload-pack: support shallow requests
Message-ID: <20180213170645.GC209601@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-23-bmwill@google.com>
 <CAGZ79kauMhgP4Gjm=yVKSDGh0-WMSpNVCJRamfjnANyO5SWXTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kauMhgP4Gjm=yVKSDGh0-WMSpNVCJRamfjnANyO5SWXTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07, Stefan Beller wrote:
> On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> > Add the 'shallow' feature to the protocol version 2 command 'fetch'
> > which indicates that the server supports shallow clients and deepen
> > requets.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/technical/protocol-v2.txt |  67 +++++++++++++++-
> >  serve.c                                 |   2 +-
> >  t/t5701-git-serve.sh                    |   2 +-
> >  upload-pack.c                           | 138 +++++++++++++++++++++++---------
> >  upload-pack.h                           |   3 +
> >  5 files changed, 173 insertions(+), 39 deletions(-)
> >
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index 4d5096dae..fedeb6b77 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -201,12 +201,42 @@ packet-lines:
> >         to its base by position in pack rather than by an oid.  That is,
> >         they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
> >
> > +    shallow <oid>
> > +       A client must notify the server of all objects for which it only
> 
> s/all objects/all commits/ for preciseness
> 
> > +       has shallow copies of (meaning that it doesn't have the parents
> > +       of a commit) by supplying a 'shallow <oid>' line for each such
> > +       object so that the serve is aware of the limitations of the
> > +       client's history.
> > +
> > +    deepen <depth>
> > +       Request that the fetch/clone should be shallow having a commit depth of
> > +       <depth> relative to the remote side.
> 
> What does depth mean? number of commits, or number of edges?
> Are there any special numbers (-1, 0, 1, max int) ?
> 
> From reading ahead: "Cannot be used with deepen-since, but
> can be combined with deepen-relative" ?

It just uses the current logic, which has no documentation on any of
that so...I'm not really sure?

> 
> 
> > +
> > +    deepen-relative
> > +       Requests that the semantics of the "deepen" command be changed
> > +       to indicate that the depth requested is relative to the clients
> > +       current shallow boundary, instead of relative to the remote
> > +       refs.
> > +
> > +    deepen-since <timestamp>
> > +       Requests that the shallow clone/fetch should be cut at a
> > +       specific time, instead of depth.  Internally it's equivalent of
> > +       doing "rev-list --max-age=<timestamp>". Cannot be used with
> > +       "deepen".
> > +
> > +    deepen-not <rev>
> > +       Requests that the shallow clone/fetch should be cut at a
> > +       specific revision specified by '<rev>', instead of a depth.
> > +       Internally it's equivalent of doing "rev-list --not <rev>".
> > +       Cannot be used with "deepen", but can be used with
> > +       "deepen-since".
> 
> What happens if those are given in combination?

Should act as an AND, it uses the old logic and there isn't very much
documentation on that...

-- 
Brandon Williams
