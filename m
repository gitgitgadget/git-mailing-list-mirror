Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C121F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBVTjX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:39:23 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:43358 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeBVTjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:39:21 -0500
Received: by mail-pl0-f41.google.com with SMTP id f23so3458291plr.10
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRuzqoES7uEGHh0vjXXLLjd+uAYb273XX7LwBtqUh44=;
        b=Cq4dFv3uqXPU524ZAf7FS9gusSwSvg1wy69QIXYYWlKu2v4LAygeaccmqlqxTME4Xp
         tYoZCup/iwUzKLVjp3jVRm6I9WaqMcdLBZacs0Jl5vH17q/6f1hZ3rZ/HQL24N0zLFD8
         6tbM2cj8I+iWLb136yDxJpH8OYAfTUHtBg6M31Do5Kc8aqBjsCgvuibPW80o1GsEqHyR
         l2rWr0UWySmkRPWehzjrKIg5mhe3hF+WAc0K0NmTOSDlDV/EO5PusV4VPy+JSh9sbnRO
         HG4+FFmW1QhY0v5SPcFRTEBri8GynFMhordSLTMYIZTjs76iZ0SKIuyZckatFHm55YjA
         +qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRuzqoES7uEGHh0vjXXLLjd+uAYb273XX7LwBtqUh44=;
        b=IHEedRPs1BEu31vN/8rN4SEX1bqQZkrUoic82QLSbj6x3mrWrCstJWrS0VKa9Zg7za
         rQl/cQcJCr/JNqzhmsONuE05c96ewI0I1bIs5ah7/gSQoI5SXSjFCeHZROoRZpNW+fGv
         C/Fy5cio3LRKsfDwPa89DD3QbtPI3Pr2C67MKV+u+MQbad+MT666OVP6ilL1GdTXqAEz
         j9gtjUxs3UsEneudBN9+oiOfbxh+2kyoHNQKSQ7nadkaLfBQYcUiRa1SjxTeZJYu8J+p
         tipnhP5HSaaQXmYtv45ffBzcKN70gwgs1s6BNoRYQIVfdMYyZkVrYSgiEUmyqlK+tu5l
         xkVw==
X-Gm-Message-State: APf1xPBxLIW3Vg43W0fx4ICLgCuF6nCJ3mv+DXK2UFe2sb6Qfw2LEsX9
        bmivM+2XhWBHvNAMQ4VuABgneQ==
X-Google-Smtp-Source: AH8x227B9aMGN5IvUshx92XMGWm4uziBn5g1LGSSRW7QZFalRg5h7ZlnzH47Xp3kT73maq6e6OLp0w==
X-Received: by 2002:a17:902:7d82:: with SMTP id a2-v6mr7544159plm.358.1519328361331;
        Thu, 22 Feb 2018 11:39:21 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p79sm1209013pfi.115.2018.02.22.11.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:39:20 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:39:19 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/35] upload-pack: factor out processing lines
Message-ID: <20180222193919.GN185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-6-bmwill@google.com>
 <CAGZ79kanWXGa3v4oJmoerh3XzisS+3V2oyO7WXK-tPTiHgSgxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kanWXGa3v4oJmoerh3XzisS+3V2oyO7WXK-tPTiHgSgxg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Stefan Beller wrote:
> On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> > Factor out the logic for processing shallow, deepen, deepen_since, and
> > deepen_not lines into their own functions to simplify the
> > 'receive_needs()' function in addition to making it easier to reuse some
> > of this logic when implementing protocol_v2.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Reviewed-by: Stefan Beller <sbeller@google.com>
> for the stated purpose of just refactoring existing code for better reuse later.
> 
> I do have a few comments on the code in general,
> which might be out of scope for this series.

Yeah you mentioned some comments in a previous round based on style
preference.  I'm going to refrain from changing the style of this patch
since it is a matter of preference.

> 
> A close review would have been fastest if we had some sort of
> https://public-inbox.org/git/20171025224620.27657-1-sbeller@google.com/
> which I might revive soon for this purpose. (it showed that I would need it)
> 
> 
> > +               *depth = (int)strtol(arg, &end, 0);
> 
> strtol is not used quite correctly here IMHO, as we do not
> inspect errno for ERANGE
> 
> Thanks,
> Stefan

-- 
Brandon Williams
