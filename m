Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9232036D
	for <e@80x24.org>; Thu,  5 Oct 2017 02:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdJECLw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 22:11:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35098 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdJECLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 22:11:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id i23so13659474pfi.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mgH0inLjVdgaOOgmIN2FQsWkmcWaNJ1GloJPXMAAo8=;
        b=eNoQJ6bMgktONjj++Ard50ELu5AOsiksF5JsHKTPl99zUCFBYatQvtBjcFD0iANuIs
         9h91PIUPm48fyXg2D1SqXWHdJj7NE+SoVZIc6DAFoRJL8oGfJN+G74UJl90dBw6+9axv
         ddM5jUjFIOXm3RdrmvopS1J35S+n9k88IJ7hD1EZDsMFub9rrFoT8VuAg7xdfpEeXsdg
         ksgwo6vU93PI5gSN3ELtrskC743KS5owEam8SPXXNk+qQfjB2Ow2AcB4MisJ1q+/xpMY
         6El/8oeB1efEuvu4nuId+psPqBWvaFjXAActSFAqExXV4RTJmc7cbBrQrx6YOPE5sGqX
         Dzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mgH0inLjVdgaOOgmIN2FQsWkmcWaNJ1GloJPXMAAo8=;
        b=SaJ3J7bNlQE+fLv05iVUiIL9r/WxtfWWfnOMFAAn4lpu3KAvjFBdaUmiusPs8Cemjw
         TERbBKuL7ZSaLq0haczcQwhXEAA00s932I4VuCyZyj/1ek8/qXLEUZDmP1sIn/G4Nnal
         A3WOYRBuVMHhfvQZCrJBB9DPtQL/3AipmBVodVrHvJyYPT0+6mLpzbwvx7ljCcVst27R
         kOWbLE5VlJ8IVbGlTG01Dk6E048jhQ9mg3zwqBWSeW30VD1RhBHqZoBGD6AEEja8kq6m
         BtW9fxEEDPKA04FvJRTQqnjKL77j3Jmung7kv9NkJLyPAk/wr9mKiUaOX9sBAwu4MuRk
         qQcg==
X-Gm-Message-State: AMCzsaXDuwNWC/sfdLgXYy1kpcfkfJb2FqClUMCR4Xyp3V/PMYVjA6D5
        /J/ITlXg9MNrf94J03F5DhQ=
X-Google-Smtp-Source: AOwi7QDnvafnGUzc066RNWlzuH+l9mxLE84ljQItNqE42zEeWKApKoiyB+4W9NQXZ8JHXRgB6rlZ1A==
X-Received: by 10.99.109.4 with SMTP id i4mr10679790pgc.308.1507169510846;
        Wed, 04 Oct 2017 19:11:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:960:8965:26b6:313])
        by smtp.gmail.com with ESMTPSA id f24sm14687613pfk.183.2017.10.04.19.11.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 19:11:50 -0700 (PDT)
Date:   Wed, 4 Oct 2017 19:11:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom
 parsers
Message-ID: <20171005021148.GU19555@aiede.mtv.corp.google.com>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002161034.44867-1-me@ttaylorr.com>
 <20171002224052.GR19555@aiede.mtv.corp.google.com>
 <xmqqmv59m7fu.fsf@gitster.mtv.corp.google.com>
 <20171003033726.GA84817@D-10-157-251-166.dhcp4.washington.edu>
 <xmqq376y9xf7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq376y9xf7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> From: Taylor Blau <me@ttaylorr.com>
> Date: Mon, 2 Oct 2017 09:10:34 -0700
> Subject: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers
>
> Peff points out that different atom parsers handle the empty
> "sub-argument" list differently. An example of this is the format
> "%(refname:)".
>
> Since callers often use `string_list_split` (which splits the empty
> string with any delimiter as a 1-ary string_list containing the empty
> string), this makes handling empty sub-argument strings non-ergonomic.
>
> Let's fix this by declaring that atom parser implementations must
> not care about distinguishing between the empty string "%(refname:)"
> and no sub-arguments "%(refname)".  Current code aborts, either with
> "unrecognised arg" (e.g. "refname:") or "does not take args"
> (e.g. "body:") as an error message.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Reviewed-by: Jeff King <peff@peff.net>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ref-filter.c            | 10 +++++++++-
>  t/t6300-for-each-ref.sh |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)

Thanks for taking care of it.  This is indeed still
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
