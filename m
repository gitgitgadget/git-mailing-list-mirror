Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEA21F462
	for <e@80x24.org>; Fri, 14 Jun 2019 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFNXSz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 19:18:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36818 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNXSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 19:18:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so2279558pfl.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXinPc7xHX3SZaeu9a1NYNV/SqI5jWdjL6jZBhzIOP8=;
        b=C3tvftsEMBBiqnyWtb4VRZMFtALEBAnWYQSUovULGgaR32w+ceQ3TmrzI5ZnYwRZZf
         Lwfa9+7z5DSG+t79yXCTbdCP1E2wZUNkvs2kkahagFE1S5fYXXif5xP2PMQGLz5eB+Ec
         231+pAeGAbmm+IKjfjLvZZ06LfgS3a82TkzS5pQUOg96kr8l5XzUImANiuojjk7zV+xh
         +72q9APV0/lfTGFfEITa+Rk0HMu/frFprvM/zrxmhURnyxsT1NoBo19cJcJ+qH3+WyqR
         oKjNVGWp4a/ZtmXR/9jGpGM7leVZ7fBGnYBUU8dyg8Z0ZxQujqPz4jWDPDBXDTkspynp
         1fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXinPc7xHX3SZaeu9a1NYNV/SqI5jWdjL6jZBhzIOP8=;
        b=dcd2SLFUMfK6/CN/qDP9hsTJZVjWxeZ7OQpoWFmwyqpcwRomSxPOoHl0XcBYG6kaRj
         oleDYt0q/X3SMWqd2NWH2rzexPo9H5GkGWGGfpU5x2tY1Bp+mzEnYqyuL8MVJlt+gUM/
         fAh3Hoo27exim+2PE8ww979EXBnuQSLJ5qyc3BWOAEVaszjIoOGxX/tvKhY4roB1jOj3
         ANOfIclppuPvmD6OKwqq7+hfclEhJhiAgab7yglJZ9NiRsCyMHkGYv6+N1LJrxcQ2trI
         RmGAWUsme8qMj0bnuW3MmmMFdwOMvIqO57TNIp5I1l/uAC1QzYfTv+TpCgV8MS1H0e4P
         ibDQ==
X-Gm-Message-State: APjAAAVn9kcT/B/5Q9vZBI2PwOGB9e9x1sedDAWFO9FcVd71CW7DgV30
        W8jZMNJWezR9XPJ/4ZKiCF0UMA==
X-Google-Smtp-Source: APXvYqz3drbnjX09YwstEbCEN6fl2fuKHiKRkD1wSN9PC7kbiFCKs5dR75ZIx97RwxlQEKKFYm93/g==
X-Received: by 2002:a63:1617:: with SMTP id w23mr29828735pgl.183.1560554333631;
        Fri, 14 Jun 2019 16:18:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a16sm3823445pfc.167.2019.06.14.16.18.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:18:53 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:18:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rev-list: teach --oid-only to enable piping
Message-ID: <20190614231848.GE233791@google.com>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190613215102.44627-1-emilyshaffer@google.com>
 <20190614160728.GA30083@sigill.intra.peff.net>
 <xmqqlfy3ud60.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfy3ud60.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 01:25:59PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > But I wonder if things would be simpler if we did not touch the commit
> > code path at all. I.e., if this were simply "--no-object-names", and it
> > touched only show_object().
> 
> Yeah, that sounds more tempting.  And the refined code structure you
> suggested ...
> 
> >> @@ -255,6 +262,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
> >>  	display_progress(progress, ++progress_counter);
> >>  	if (info->flags & REV_LIST_QUIET)
> >>  		return;
> >> +	if (arg_oid_only) {
> >> +		printf("%s\n", oid_to_hex(&obj->oid));
> >> +		return;
> >> +	}
> >>  	show_object_with_name(stdout, obj, name);
> >>  }
> >>  
> >
> > A minor style point, but I think this might be easier to follow without
> > the early return, since we are really choosing to do A or B. Writing:
> >
> >   if (arg_oid_only)
> > 	printf(...);
> >   else
> > 	show_object_with_name(...);
> >
> > shows that more clearly, I think.
> 
> ... is a good way to clearly show that intention, I would think.

Sounds good. Thanks, both; I'll reroll that quickly today.
