Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CA11F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392915AbfITPk5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:40:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39025 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfITPk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:40:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so2708658wml.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LS8zsx9LgEcxoi19FaItMbOCahMSshmp0n7mWFPLYe8=;
        b=iDLKUUUh8GtGAkdJKbpa14mQ4MVxsyA5ftp5qPWhBtiGf2QtRq7F5QdfaKXjeOlvgL
         xrc9oNe/kCYgqu5HXxO5DzoNHiKMNyU25ZtlusEStMncmbAs9QPUTuIBBjWvLSm4Tst4
         JK0pl8iZN7XKfIHPmItnjgtHfSmmdpDBQAy5xRUPJ8MBuS3Q5sNcxu+ytUrROemhmsP/
         r6uJ5c36BABFt/EIcaffBPqiXQ6Ub78jUT36HWLGriDCt8P9bRJYnB1luh+QxSI25LNo
         uwdRlhQk0Z/qKuYlpM9feojTeW8kEtKUaml5WWpSJeFi+15qtMdUvTqhTbXSrcUaEtIo
         PXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LS8zsx9LgEcxoi19FaItMbOCahMSshmp0n7mWFPLYe8=;
        b=dqcaAUn/TqznXlG7ITzaVv8oidRlGeD5QMzqG8+w3S40NP6/hX67nbIwG/IqR7l0kE
         nYmrXDOEmUwfPSL8bTyxmYxOdPvTOwrgZLn9W8KlpuAmltPd/+MO4ZH+Y8dCWum/lq/i
         ntuoBRmPgHAx1GVPjZCI9kEtjc8b99yoSdyv+HkC8IvMwJ9psNnQm7xRYoBbv4yfEx/i
         JBxu2HgiGBk9d6uy/uwa1gi6pFzdYBjGmBItnUD2sys3hC7T2sJ2/JSQ5+c6mJWIqOaI
         zuZknLMw8b9Lf/6luDJXGb6d9b+DxTPQXJYZI/aNTEUbFeDPf3YkZaxbmM4HcZBkd1s0
         m9PA==
X-Gm-Message-State: APjAAAXmW+ZXlOdos4aRQAYdL6qYvlL3to27V4MMRCrvS74+z+OXEMYn
        xl0NFMZSBWUmQJtHjRsiIOjytNmi
X-Google-Smtp-Source: APXvYqz7i7ybNyAVUtbcqTxog101TN2lzQpFkmuRcwA4kELHi3ZFe8G1TYEN1w1ItekWa83eCeOQKQ==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr3821677wma.132.1568994054632;
        Fri, 20 Sep 2019 08:40:54 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id b22sm2722174wmj.36.2019.09.20.08.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:40:54 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:40:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 05/15] name-rev: use sizeof(*ptr) instead of sizeof(type)
 in allocation
Message-ID: <20190920154049.GA32332@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-6-szeder.dev@gmail.com>
 <cb35b779-79b1-e27d-e539-9ea9d2601b07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb35b779-79b1-e27d-e539-9ea9d2601b07@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:11:02AM -0400, Derrick Stolee wrote:
> On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  builtin/name-rev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index e406ff8e17..dec2228cc7 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -98,7 +98,7 @@ static void name_rev(struct commit *commit,
> >  	}
> >  
> >  	if (name == NULL) {
> > -		name = xmalloc(sizeof(rev_name));
> > +		name = xmalloc(sizeof(*name));
> 
> Is this our preferred way to use xmalloc()? If so, then
> I've been doing it wrong and will correct myself in the
> future.

I seem to remember that Peff mentioned in a commit message that this
is the preferred way, but can't find it at the moment.  Anyway, when
using 'sizeof(*ptr)' the type is inferred by the compiler, but when
using 'sizeof(type)' then we have to make sure that 'type' is indeed
the right type.

Besides, that 'rev_name' should have been spelled as 'struct rev_name'
to begin with.

