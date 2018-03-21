Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8EA1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeCUW07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:26:59 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:43429 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUW06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:26:58 -0400
Received: by mail-pl0-f53.google.com with SMTP id f23-v6so4027456plr.10
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LpgETpHvAGTOWK69dO+laqgBl+tubCQ9loXH0VGsL1A=;
        b=YuOo3G8Q2k63BSlXlVncpZUhyzr/KKIbplMjQU1ix3Kn2FFKH07bQbu9iirHCPFaU3
         PG9VCBrijb2hlCcpa6KeJ6QloJjDsp+oZmMdvV3C2SPJi+bikEg6lgCQGu0/fnvkw6TP
         myObVRBTpaigJ3Bitk9t0SS5Q+ZT+uLgciBSghu96ER5VkxiWwEHa2syyrAzTQebQG6X
         saHG+CvF8xB29fqDf6nPQUMivP3GSTsR4o1oK/P5v8iXI8urRyWDPF2Y2YgjN4ThhIxw
         uBBYuxYB0wQsqj+83h0Oo+QNG88NRpBAZ+qW1IgVxvDc7PkYdQ8N5o4mIYHcfBX+Cn25
         b6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LpgETpHvAGTOWK69dO+laqgBl+tubCQ9loXH0VGsL1A=;
        b=sv99zmrLJALR/tnrOB+E1OB73q99tNDuwCVXwh9qYrQPhsugRNGOCoJI2v2qCLeuiF
         0/Fj8gBo26DVVOl06A/YyPyFgI0KaDtAHX9mIY49Ui8uNgo5H+TLL4wW14CAn4d8CPhB
         oy2umuD80IhW+Ft7LzCNFycjfQ7X4kwc7lNzTNLk4wary9gPh6uY+A0lsjDMy4cOR/cY
         1F3Iu35KG3BxXNlYI4A65XWNcwNKFlJdqY2E8wJhsowIilF36BLm3KYLJmKUwDEKuK10
         NuQQPrqCFsZ212nz1zHgzBLaa9+gOtnuu6A6PzAG0cRmtIBrCZLbPSfskJbkJIdCzfXL
         tj/w==
X-Gm-Message-State: AElRT7GwloxkHArOC++yqhzs6rjds6khGfmmOpGSrVv+6gkBB4s/ydY6
        6BTR7sDubG3xdfGSLek4ip27aw==
X-Google-Smtp-Source: AG47ELtC8TLw4fWzxROd+r+VGxCEU8aCkregztX2HL4pjSOC9HofKtBK0TpYXlwSykNCaADbO8hI6A==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2-v6mr21952950plb.12.1521671218061;
        Wed, 21 Mar 2018 15:26:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g26sm9584155pfk.173.2018.03.21.15.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:26:57 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:26:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/44] pack: move approximate object count to object store
Message-ID: <20180321222656.GK18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-14-pclouds@gmail.com>
 <CAPig+cSE_x2f_8RG151MX3+FJhiofBPoVPXP+mxdJpoHXwjv9g@mail.gmail.com>
 <CACsJy8CQxsTPH15jtvDUhc8DFdtPdLNDYtFe7HNn3ntUHAv=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CQxsTPH15jtvDUhc8DFdtPdLNDYtFe7HNn3ntUHAv=tg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04, Duy Nguyen wrote:
> On Sun, Mar 4, 2018 at 9:47 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Mar 3, 2018 at 6:36 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> >> The approximate_object_count() function maintains a rough count of
> >> objects in a repository to estimate how long object name abbreviates
> >> should be.  Object names are scoped to a repository and the
> >> appropriate length may differ by repository, so the object count
> >> should not be global.
> >>
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> >> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> ---
> >> diff --git a/packfile.c b/packfile.c
> >> @@ -813,8 +811,8 @@ static int approximate_object_count_valid;
> >>  unsigned long approximate_object_count(void)
> >>  {
> >> -       static unsigned long count;
> >> -       if (!approximate_object_count_valid) {
> >> +       if (!the_repository->objects.approximate_object_count_valid) {
> >> +               unsigned long count;
> >>                 struct packed_git *p;
> >>
> >>                 prepare_packed_git();
> >> @@ -824,8 +822,9 @@ unsigned long approximate_object_count(void)
> >>                                 continue;
> >>                         count += p->num_objects;
> >>                 }
> >> +               the_repository->objects.approximate_object_count = count;
> >>         }
> >> -       return count;
> >> +       return the_repository->objects.approximate_object_count;
> >>  }
> >> @@ -900,7 +899,7 @@ void prepare_packed_git(void)
> >>  void reprepare_packed_git(void)
> >>  {
> >> -       approximate_object_count_valid = 0;
> >> +       the_repository->objects.approximate_object_count_valid = 0;
> >
> > Not an issue specific to this patch, but where, how, when does
> > 'approximate_object_count_valid' ever get set to anything other than
> > 0? Even in the existing code (without this patch), there doesn't seem
> > to be anyplace which sets this to a non-zero value. Am I missing
> > something obvious (or subtle)?
> 
> Probably related to this
> https://public-inbox.org/git/20180226085508.GA30343@sigill.intra.peff.net/#t

Yeah as far as doing a conversion this should be fine, we can come by
and clean it up at a later point.

-- 
Brandon Williams
