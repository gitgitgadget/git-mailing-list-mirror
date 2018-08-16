Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745931F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeHPUeE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:34:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46890 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeHPUeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:34:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so2359494pgv.13
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzPyuE+x7HsJuOf7a6WEqKSefLgWrBDN7qNaVpxp1F4=;
        b=Lbq7b8VW7YpooCcDzyx6Ml7hKBs8OE2Cxu6qoUbwIjMsTB2PZnZPOCTF/0K9sRNWtH
         fT4zBoCk1Y1BME8xdwui0z6F00DlixM8n/BtGrMT2q9F1VS3ZqebpayxIYL9UYvadT+r
         OxHkWzqBpZa+M+6HKdHrbM45WBZm4qNgd4PQFga6E/q/sMqwzHwv7Hwy65Xt7CIyOsnq
         PlANTNgUbAvH9PItUDS62de6/FN4e29x03OZt81jkl3f7Qrv69HICLeeXB3Cutc/1QoD
         jeFBqLsO4+z9bYG5Sc1CQR2xGjKyp/qj8pkE8dhqKW9UJ7gxrVPuJHX3mD9Jgoej2HyL
         Kz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzPyuE+x7HsJuOf7a6WEqKSefLgWrBDN7qNaVpxp1F4=;
        b=HoPCS1aIpUL9xXGtjwvpk5J7PxA/3M2PTGodqe70sfDmbDBhMNvzzYHN92zCFjFkI+
         /XRzsLLuW0wno6gthONHQsr6gJGpQJ2BfNR7Eym122n6cE6rZ3bJBFvoA/kGqkJ7Fr5R
         Drnl2m4I0FfcgWZFSXvNq1OO5PzBrlAw5YNJwVPPzBwCeYnF/qTZTIwJnWTlROylUWh4
         iHUtLHK5hnFHfSbxHOiwZpUxr2niufJ2zFTe/MQLhkRC5ZpaKROnegpZ5QeJq4U2b+3b
         hCIBUcUSUfCZtPWSp/ln2BM7iYtGOdmgsl2dOIabLhGolKaSjlhCDm5IpRiM1X5R4p3O
         E9xA==
X-Gm-Message-State: AOUpUlGAIJB4Lb27YHSpRivIiMJ9i+Nc63typsOOSnOuPuJt/zF83EyT
        5f4Vd/fq74NacxrBP+jXkRZD8w==
X-Google-Smtp-Source: AA+uWPzhejXh+bU9Wtcbh+ND7PkQLJKUGVUJjD8SGbb8+Ivk1ie4XO+UZIwBgE3wAJEkDN/rjiB/KA==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr30297953pgc.344.1534440854510;
        Thu, 16 Aug 2018 10:34:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t15-v6sm42813852pfa.158.2018.08.16.10.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:34:13 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:34:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180816173412.GA212462@google.com>
References: <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
 <20180814211211.GF142615@aiede.svl.corp.google.com>
 <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
 <20180816023446.GA127655@aiede.svl.corp.google.com>
 <CAGZ79kamoPjX_yWYABLoyTh8jqAPV4iVX0r46q=41B12zku=tg@mail.gmail.com>
 <20180816024733.GB127655@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816024733.GB127655@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/15, Jonathan Nieder wrote:
> Stefan Beller wrote:
> > Jonathan Nieder wrote:
> 
> >> All at the cost of recording a little configuration somewhere.  If we
> >> want to decrease the configuration, we can avoid recording it there in
> >> the easy cases (e.g. when name == gitdirname).  That's "just" an
> >> optimization.
> >
> > Sounds good, but gerrit for example would not take advantage of such
> > optimisation as they have slashes in their submodules. :-(
> > I wonder if we can optimize further and keep slashes if there is
> > no conflict (as then name == gitdirname, so it can be optimized).
> 
> One possibility would be to treat gsub("/", "%2f") as another of the
> easy cases.
> 
> [...]
> >> And then we have the ability later to handle all the edge cases we
> >> haven't handled yet today:
> >>
> >> - sharding when the number of submodules is too large
> >> - case-insensitive filesystems
> >> - path name length limits
> >> - different sets of filesystem-special characters
> >>
> >> Sane?

Seems like a sensible thing to do. Let me work up some patches to
implement this using config primarily and these other schemes as
fallbacks.

> >
> > I'll keep thinking about it.
> 
> Thanks.
> 
> > FYI: the reduction in configuration was just sent out.
> 
> https://public-inbox.org/git/20180816023100.161626-1-sbeller@google.com/
> for those following along.
> 
> Ciao,
> Jonathan

-- 
Brandon Williams
