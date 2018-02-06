Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996FE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeBFULB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:11:01 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:38746 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeBFUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:10:50 -0500
Received: by mail-pf0-f174.google.com with SMTP id q79so1107307pfl.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OHwOX6j6NV6j6kwfF2WmPRcJjOyloomWOIaNL3ZzItk=;
        b=GPpgiLlueOWY6wUMtJmpD6lqXqdbFx2uBDuJe38pQHZM4OSeik29daW4p46GS+IH6P
         3oD1dOGbltfFZXc0gBgCtIaLrfZ8IfIACJuKF8ygZKaRs2vYB8bkCZicbWzAaScsnP/m
         gCJshm+5c0IYIExMcGcmpEW7dvR0YE0GPZUIdbmH2OHviM7wKaczDEtonVFG5QSmurYb
         BNwp+vTDswUkI+KDuqIfh1jwO6PlENp/Qf6YPMcw3krQBMjUsHgCb3r2ijuz1po0aJ4L
         4eYyyB2rLJ2FxMam2+8aK6MgHTjDVkTDjI5w0zNGvtlkO3AS0mWIFi85LCeaDJWR3Cx1
         mWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHwOX6j6NV6j6kwfF2WmPRcJjOyloomWOIaNL3ZzItk=;
        b=qC2Blg8V7//WvSTFFRh3PTKbtaOhPeYL/3GIPaD2fpVHc5jaUuUrE2ANRvRAjJaYyy
         o3kmhgn5vpwxmRNsS0ts9rlNE8HUKwjs7r7ZBpRYZC/Ej+iuyy/FynQyEM3K7GALemAf
         SWzhCjzMU8+ILNyFAmAh3+pXajldX9dWiDGTGBcWGMY92NLel+XEBNA2Yv9g2iUIUwam
         zkIK+VP16VyY6mdH7hW9+kBoqR4IuM8TeHTkr2B1qJ0GUnyn1zuhN2pga5a5OItdzlpo
         3KnvGYVMzuxi+J2aoyHixnQnyU5Rt5qKEl+5Xp0E6e+VaygogCPv2UJ1ULjKY/w4v4DG
         76fw==
X-Gm-Message-State: APf1xPDlhBYoC4rsQXoYyA4R+ZuG9j0Mxv3R13G5ivb3bM9WGvVUUoGf
        vt37aYRy2Y+IEHbrQiyfwGM=
X-Google-Smtp-Source: AH8x227vfvdUNUeC9qPIFaJZuktDE63JXehZC7fndIbXjcNgriSyNb8InBrMw0qdhVXDCLnZJabtpQ==
X-Received: by 10.99.0.139 with SMTP id 133mr2825160pga.267.1517947850045;
        Tue, 06 Feb 2018 12:10:50 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v28sm19353838pgc.47.2018.02.06.12.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 12:10:49 -0800 (PST)
Date:   Tue, 6 Feb 2018 12:10:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ian Norton <inorton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Are concurrent git operations on the same repo safe?
Message-ID: <20180206201047.GE104086@aiede.svl.corp.google.com>
References: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Norton wrote:

>                      Specifically I'm trying to speed up "git
> submodule update" by doing several at the same time.

Can you say more about this?  E.g. how can I reproduce your experience?
Is there a script I can run?

Thanks,
Jonathan
