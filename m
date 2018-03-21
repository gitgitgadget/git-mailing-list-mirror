Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBCF1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeCUWKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:10:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38856 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUWKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:10:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id a15so2486428pgn.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2RE3cWMn21ShOR8ilSQF047uCMDQW98jzOI1uZWyLT8=;
        b=CV4j7H2QyDkX0ayYV6J0uEj7MDsjwMHE5nWYhn5PdozEnpi60n9beAVf4+MICT1Uzr
         OL4mLaK/j+bO0PW4oI9uDN09kRiHcr80pFMywhpLwkbfSLXZbRb7FT9rW23aVQ3bllfK
         Qy0XMK4iQo9RfKMyUKlaVYzJPiLGBGmGMgcFB2cBNlsbU2f1zjKHxNBYU96Bb2L2GcWy
         CMcA9QQIouqnem6kibFqd0EEOEqRvwwPjmeoyo0uUnhHz9iqFbVtOK4imEc0HHuaAcyD
         I/Uwuv90ffMLwjEyQdMfIsG2tXm2qPEBE1GRbEam07MQ5H7ASHLPoxD6zTnI5fs7Fpxu
         tRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2RE3cWMn21ShOR8ilSQF047uCMDQW98jzOI1uZWyLT8=;
        b=KTwPUyH1HPW8Q1bIdGfhuEmI7fdJLEIUs9bja1HPKNLvkIurtU64+qvsUTFFtvuQrQ
         vY2qLvD7OJdEWcok+lK1jwHXzmYHlF1YdkyJjVvkUpmBXzTkV2Ea9ZpyP1kynpuj75Bi
         YlcPBlDU69VrQGCSH2Mn2a3gemLDG2eCATs7oGjQdWvwfNVtFbnV0/WG6u44R+rn4k28
         W+hv2M+ykHcKL+Zdf13MN0ymrzbEteu8fBxzWB1nTaDOfqrzMqMAZOxctboEDBPfX86d
         N2y117qp9KfQRKXPx9YNdZh/Jh/IgDEH9gtDz94kZIDqI2rDT5+ueECoyOb8AxE7UVoF
         +ieQ==
X-Gm-Message-State: AElRT7G9tR4x5j68iBadssbQ+Zo3CLCEIhHTEiKTthDW0r7frOn1TVdj
        jjbEs/cix57xD5Yfjj5G9DgyQA==
X-Google-Smtp-Source: AG47ELtBOLq/HoanQqfYCSImbYkNgYUVhUPm74I9DEv6YG10E8NAWLGjQB78ufPS2ntt+UFOlR9AiA==
X-Received: by 10.99.149.86 with SMTP id t22mr2460584pgn.144.1521670252248;
        Wed, 21 Mar 2018 15:10:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z28sm8268975pgc.15.2018.03.21.15.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:10:51 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:10:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/44] object-store: free alt_odb_list
Message-ID: <20180321221050.GG18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-10-pclouds@gmail.com>
 <CAPig+cSkU8j-NiNeMP-F3VygF1sAoXP3qzn4fx7C1qxTZoO5+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSkU8j-NiNeMP-F3VygF1sAoXP3qzn4fx7C1qxTZoO5+g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Eric Sunshine wrote:
> On Sat, Mar 3, 2018 at 6:36 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > Free the memory and reset alt_odb_{list, tail} to NULL.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > ---
> > diff --git a/object.c b/object.c
> > @@ -450,8 +450,26 @@ void raw_object_store_init(struct raw_object_store *o)
> > +static void free_alt_odb(struct alternate_object_database *alt)
> > +{
> > +       strbuf_release(&alt->scratch);
> > +       oid_array_clear(&alt->loose_objects_cache);
> > +}
> 
> This doesn't free the 'struct alternate_object_database' entry itself, right?
> 
> Is that intentional? Isn't the idea that this should free the entries too?

Yep it definitely should free the entry itself.  Should be fixed easy
enough by freeing the list entry after grabbing the next entry

> 
> > +static void free_alt_odbs(struct raw_object_store *o)
> > +{
> > +       while (o->alt_odb_list) {

                    struct alternate_object_database old = o->alt_odb_list;

> > +               free_alt_odb(o->alt_odb_list);
> > +               o->alt_odb_list = o->alt_odb_list->next;

                    free(old);

> > +       }
> > +}
> 
> Accessing an entry's 'next' member after invoking free_alt_odb() works
> because the entry itself hasn't been freed (as noted above).
> 
> Is leaking the entries themselves intentional?
> 
> >  void raw_object_store_clear(struct raw_object_store *o)
> >  {
> >         FREE_AND_NULL(o->objectdir);
> >         FREE_AND_NULL(o->alternate_db);
> > +
> > +       free_alt_odbs(o);
> > +       o->alt_odb_tail = NULL;
> >  }
> 
> The commit message talks about freeing memory and resetting
> alt_odb_list and alt_odb_tail, but this code only resets alt_odb_tail.

-- 
Brandon Williams
