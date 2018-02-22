Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6601F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeBVTca (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:32:30 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:46026 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBVTc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:32:29 -0500
Received: by mail-pl0-f47.google.com with SMTP id v9-v6so1443828plp.12
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qU+eebLUmx9GvMiLXRUeAvRBlfpSbBUpUVSgC3+nic=;
        b=nkD6VDDfRaq5XYusE0bSgtWLb1XdK2SyrR/ufkQKtNh/BfEIopEd21daY0xBmyuy04
         12WHcQSBF6FaFj1dGiChwWE2NzW6BJhLmvn+aIseJ/UfFYiH/e73EJ7PMXy07+M634ky
         jPyZ+J2A10hcS30up9vPQmVyOF1ZfB2P1SiIgoQcpgQFYwNC97QKdR5wvjwvEPrngFDq
         qvkLGKyjhmce5LR8n3vYyrQUARMSRBB9Nr/mHMQ9fnj+wyLdFJD/lCynllptT5wEVF5F
         2gnLCSYh+XGhJfAbaw0deKsyOCAm1chbnMJYxwkyq+kv7Hp9OpPi/4+kkEo04qYC2Fuk
         bX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qU+eebLUmx9GvMiLXRUeAvRBlfpSbBUpUVSgC3+nic=;
        b=sJxa8DON1IOdhHivQeEZS4+5bCyXP9EpUAPRBRmDsRp4tQkr7e+olSvk3wFRhaq8ZV
         0zBWGNhnYuclCoKtJtuBd/Dd6UaLQal8yf2hwTJN785MB3nAPI6H1w/AQ3P0p3evtG7c
         v+tlyiQnGww2EBlLKC4fArZef9dH152boSlersNpNLamFB/CDv2e53l68vDUAJoYpE9q
         NJaxz4WnIr7nn9iWqA4G/kcRq/kYLDtpqWRdQpknFQq4A9V6cMbyd8PSg+j6D8AgN7Gc
         HSvgnohhz33WSsabvruoIO79x1EMJQtWhEy3XnW6c2h52ZaiiosR9o6GnYKKmc1a/Tuw
         xtQg==
X-Gm-Message-State: APf1xPA9wRARnARpDUZsSh2KROri6ecOpwKVMyHRz3588fBLfGoX0f3Y
        1zx9xkQfcEBA/VrkwP42p50K1w==
X-Google-Smtp-Source: AH8x226821YS5ML8icARjy8uF67UImFF6DkqEZcqF1HaZC0ev0XXag7lPFYKo09blk6hz8o2Ts96dQ==
X-Received: by 2002:a17:902:b606:: with SMTP id b6-v6mr2616951pls.93.1519327949136;
        Thu, 22 Feb 2018 11:32:29 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s127sm1210074pfb.178.2018.02.22.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:32:27 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:32:26 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 16/35] transport: convert transport_get_remote_refs
 to take a list of ref patterns
Message-Id: <20180222113226.208f86fff80fb0d05c620433@google.com>
In-Reply-To: <20180222182647.GF185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-17-bmwill@google.com>
        <20180221145804.f483fb21559f71618812404d@google.com>
        <20180222182647.GF185096@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Feb 2018 10:26:47 -0800
Brandon Williams <bmwill@google.com> wrote:

> On 02/21, Jonathan Tan wrote:
> > On Tue,  6 Feb 2018 17:12:53 -0800
> > Brandon Williams <bmwill@google.com> wrote:
> > 
> > > -const struct ref *transport_get_remote_refs(struct transport *transport)
> > > +const struct ref *transport_get_remote_refs(struct transport *transport,
> > > +					    const struct argv_array *ref_patterns)
> > >  {
> > >  	if (!transport->got_remote_refs) {
> > > -		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
> > > +		transport->remote_refs =
> > > +			transport->vtable->get_refs_list(transport, 0,
> > > +							 ref_patterns);
> > >  		transport->got_remote_refs = 1;
> > >  	}
> > 
> > Should we do our own client-side filtering if the server side cannot do
> > it for us (because it doesn't support protocol v2)? Either way, this
> > decision should be mentioned in the commit message.
> 
> If someone wants to add this in the future they can, but that is outside
> the scope of this series.

In that case, also document that this function is allowed to return refs
that do not match the ref patterns.

Unlike in patch 15 (which deals with the interface between the transport
code and transport vtables, which can be changed as long as the
transport code is aware of it, as I wrote in [1]), this may result in
user-visible differences depending on which protocol is used. But after
more thinking, I don't think we're in a situation yet where having extra
refs shown/written are harmful, and if it comes to that, we can tighten
this code later without backwards incompatibility. So, OK, this is fine.

[1] https://public-inbox.org/git/20180221145639.c6cf2409ce2120109bdd169f@google.com/
