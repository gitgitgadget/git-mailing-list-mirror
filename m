Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9641F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeH3BH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:07:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:07:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so2827815plp.7
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l+/r8FEKfZeGj2yAHN4SMduzIE6G0XdDTjqiGMz9sgk=;
        b=H/7IKKoulmB3mZ2k6RLHGe7EBxrbXIpPzyg5LCmYYvIOJgk6VdX7uy52fgFbjKfWx5
         isEbk5+SDJ0L1knLLwgXZeHjKwB5kFb1dFXw7mABgTxkE1YjRV1swZCyBLYqDhSe2gT4
         mmRpeyz3R0hg9quxYnvYaF2Vpf6LjCXjIeqxk+kJ6ZMFmgvCVEPmGw+bL8503qvJSYIk
         Xv0WSHHrWFGoO7kyxKvsmcB2Bmwpqv51lTdeMtRV9QBDQLAjSV/IPKftahjXsifjBJpV
         MMRxe8S3ITKqFcG/N2RXuvAneDWq+2A4iWWt+kWvz5+uKtYB9Yw3qyd1dY00zKCs98mn
         LgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l+/r8FEKfZeGj2yAHN4SMduzIE6G0XdDTjqiGMz9sgk=;
        b=OnNrk5wPVeZrzR5FDqFBCCGcBOGW1aWatbTVCGv36a9ZCcqdfuk7v6vs8rc4Azc8Uz
         97fQHse11FRJ63/kSQznFX77kH3wIRv1pNbvH9los90QoSnqU8BF26vz4Ggh55glNSnE
         NrAkgAVB9J5Gn4bIf+E/ZcV7Az/V1NeTAwjdUCIMK7kSHZjhin5rZuW4d034Apy0TLOq
         YQOwpAxxXUF1oN+owue/DjHEwShS+9WI85tnOk2FOhiXN70kRcPIWq9Q/Fywr+EzeBkI
         Xj2dNirn6G1EpU+iHN1DWUQqsLGE0/IQtzVItSELJkKtrF/+T/s44eQh/M7CZpD0k0xN
         aNXg==
X-Gm-Message-State: APzg51DWIL/mw0vbR1mw8255IoDZprhTlfqnmM94lfiVII9BSj8xju9s
        0OSQ4cW1tBCJb+XGwWHtNGUPXPM1
X-Google-Smtp-Source: ANB0VdacIRhcrANtxv0jSuDWBySZlJvrHcSu4IC2GnCJooF8pPfuGzyMjYaUNTNWyCUubrjNRJV6Jg==
X-Received: by 2002:a17:902:68:: with SMTP id 95-v6mr7341605pla.248.1535576955459;
        Wed, 29 Aug 2018 14:09:15 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d66-v6sm10544000pfd.121.2018.08.29.14.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:09:14 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:09:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829210913.GF7547@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829052519.GA17253@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:

>> Yeah, then let's just convert '/' with as little overhead as possible.
>
> Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> colliding)?
>
> I'm OK if the answer is "no", but if you do want to deal with it, the
> time is probably now.

Have we rejected the config approach?  I really liked the attribute of
not having to solve everything right away.  I'm getting scared that
we've forgotten that goal.

It mixes well with Stefan's idea of setting up a new .git/submodules/
directory.  We could require that everything in .git/submodules/ have
configuration (or that everything in that directory either have
configuration or be the result of a "very simple" transformation) and
that way, all ambiguity goes away.

Part of the definition of "very simple" could be that the submodule
name must consist of some whitelisted list of characters (including no
uppercase), for example.

Thanks,
Jonathan
