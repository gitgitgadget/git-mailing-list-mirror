Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D271E1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 23:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBTXkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 18:40:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41971 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeBTXkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 18:40:32 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so14702749wre.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 15:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2L4dYjG00nlnjQZyisptpuk4N7NXJOPugOvGOf65RQs=;
        b=BeOexoLrhY4tKXqy+7WCX6TvC6in0MYqrSy1+Ub2krYPKX5h2db9/ZzdN/KZyhDMFq
         ylLkUZdcxLJrjfJVCd0yf6oLA/QtUowYmKKClhuTlakXoRGWamD7/blbYxQ+wBkVDrI3
         jKMKi7Xe9mZxHPZVzYDowdYL3BLHGpS2Fvn8T8tM0ST0t1A5E/FF594ECi16Kj3bLX8G
         DSYx5jDlg7eepCdAo6WdstwD9vWJqNt4DEdPtjA5cNMYTZmcFqegYlU71tp9wcNRXMbb
         UJW9OP3b0hTwqeBkYe153XN048iGb+c/6+KzMIXkGUqVAxDFvsd8KmTcwAqx/qzLMBbC
         CqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2L4dYjG00nlnjQZyisptpuk4N7NXJOPugOvGOf65RQs=;
        b=VXipcVPZ5rnEsygD+Ww1Y7m0F2HLHk/Shi1Dy8pGSPt772ifo33Zjhl8BMvt5XG3U7
         x4wBUd+Y6FKbZBV8RLR4dot3/XqB82rRi/pKkyeav5OsmIKbFZv3o29hTBjruW1+lUPA
         4cxI02pjMXknTWWE16aPeCnhOVJJKVgDODe/lJSAOEhAqzu2i4cawlwEvg7oFGb9U6Fk
         yuQWx6QIvPP0NlHok7GEuIKEd7xzlROa7bLk6srozCoV/RHTMUsIsUmC0VVk+NwXmW5c
         eyxUJM9pgs36/xyQvSJ34QrWhhhmKkytih+tEabMRQaEU+lBPSMuX2puV9weul2phSaE
         XIiw==
X-Gm-Message-State: APf1xPAhlPL9+3Sc/NTSf05n/ajVY60ivyUCrgG2IdPHXnIL1nHhaC+Q
        zqjTjxeJLPiRuZybI0YTnavtxI87
X-Google-Smtp-Source: AH8x224m9CVHQrx5JIqh+IhNTDe0Ve2nA/sHQxCYsJqgdSY861NiSYC2SKBqUXxc0AhOmWlkaxgyww==
X-Received: by 10.223.134.193 with SMTP id 1mr1052580wry.245.1519170031128;
        Tue, 20 Feb 2018 15:40:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k45sm7155709wrf.62.2018.02.20.15.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 15:40:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>, git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
        <20180220211634.GA15232@sigill.intra.peff.net>
Date:   Tue, 20 Feb 2018 15:40:29 -0800
In-Reply-To: <20180220211634.GA15232@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 20 Feb 2018 16:16:34 -0500")
Message-ID: <xmqqeflf1b82.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Modification times are a subset of the total metadata you might care
> about, so they are solving a much more general problem. Which may also
> partially answer your question about why this isn't built into git. The
> general problem gets much bigger when you start wanting to carry things
> like modes (which git doesn't actually track; we really only care about
> the executable bit) or extended attributes (acls, etc).

"modes" are interesting, especially when you think about group
permissions, as it would make you design how you store group and
owner, which in turn forces you to think how "peter" on one system
relates to "peter" on another system (answer: there generally isn't
any relationship) ;-)

