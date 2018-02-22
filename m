Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE67F1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBVThM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:37:12 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:42728 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBVThL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:37:11 -0500
Received: by mail-pl0-f46.google.com with SMTP id 31so3449160ple.9
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GD+6pexihlxECFYG41XYEknuR/4SMOOV7mennefq1Y=;
        b=LrDRCLUJ2YiXudzxkZlbaiRcId453zh3Zx/TyFSWKSaV6nEcbCfA486IP+11WP3yUU
         6BDYqOOW/2dm8VvjvH2nmuvnvHDmXL3hr5s5Ch91q+/y4ujSl7a7U6a574zEn6c3+OKP
         Zy8PLkLhymzpBFdU/hpPargQTt6mRUEat6uxqYakFdSoWoewQWZTw8Gf+56hzAvHcllu
         cVsWPHtUDT9C1UBmK8mNTFEokN2wCVjLXbJaWm4QiUmtJCcguvhrR7/DxJeDKsR+WRR6
         /B6QWh5vFZGpFDkjNEwjnFv1lvEvPmyxVR1oWS+hWtKIO4kuxTtA86fg4k8LlHQ6oIoL
         390A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GD+6pexihlxECFYG41XYEknuR/4SMOOV7mennefq1Y=;
        b=M6Od2PUZ//CdBsN75UypyoixgmYijmNSLi35i/rjJ4BuA/T4bd6UQ8rYRy2pwnInsu
         dRXw6NmT10w+zDhnTHBlzbt9FTLOiP1MdJKIWQOfZAz2PrBOmGad9zGujMCOBkkNAjuA
         M+srfXZjhTNS8U0EE+LwO6Tqxo55qTJ8GgE0fLKIdWgEsXJCeVIuDpZl6xgWp/U5jciF
         vnhzkJDnI4Q0H1jk/V37vYSHS6/3d4gfdYppn7tG9Jt/naF8eGiAMpT9f7lEPayGNGOg
         /YpGzcznA5hJu75OAoCIKHpEP919Ctrh47Ww9V0IDvGXQ4vIPyiElvPrN2EDH2Q4TfPE
         vdig==
X-Gm-Message-State: APf1xPDMN9Th10GjTqdg5nlFAzZ3NWkLco6FC9ZHqrkXhza+lSYdioUy
        s5j0WtVuGDjqzHwY7vlM4Po13zK0e/k=
X-Google-Smtp-Source: AH8x225Jb5JMAd2SSIbMLLdW7EsvNJjAnBG1xd5CpmzcR2XRJ8iTAQTY2ezHb1VEC24UTouMbLmibQ==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr7577175plp.249.1519328230740;
        Thu, 22 Feb 2018 11:37:10 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f12sm1257852pga.67.2018.02.22.11.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:37:09 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:37:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/35] pkt-line: add delim packet support
Message-ID: <20180222193708.GM185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-4-bmwill@google.com>
 <CAGZ79kauYniFpo+Y_hFauVKMWNgxjQ_OOoX0mgePcr3Z6hSLWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kauYniFpo+Y_hFauVKMWNgxjQ_OOoX0mgePcr3Z6hSLWg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Stefan Beller wrote:
> On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> > One of the design goals of protocol-v2 is to improve the semantics of
> > flush packets.  Currently in protocol-v1, flush packets are used both to
> > indicate a break in a list of packet lines as well as an indication that
> > one side has finished speaking.  This makes it particularly difficult
> > to implement proxies as a proxy would need to completely understand git
> > protocol instead of simply looking for a flush packet.
> >
> > To do this, introduce the special deliminator packet '0001'.  A delim
> > packet can then be used as a deliminator between lists of packet lines
> > while flush packets can be reserved to indicate the end of a response.
> 
> Please mention where this can be found in the documentation.
> (Defer to later patch?)

Yeah the documentation does get added in a future patch, I'll make a
comment to that effect.

> As the commit message states, this is only to be used for v2,
> in v0 it is still an illegal pkt.
> 
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> The code is
> Reviewed-by: Stefan Beller <sbeller@google.com>

-- 
Brandon Williams
