Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DBA1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 10:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDWKJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 06:09:08 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:39361 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWKJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 06:09:08 -0400
Received: by mail-it1-f175.google.com with SMTP id e13so3370127itk.4
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoMs4EJhAE1GMQtiPlPvBmP45XsxxXVS/xS7f6MkCT4=;
        b=NrkycsUR9z5WQeadqVbuS59SOC443k0njM0JcwodkIc58xtJ/U9rejJh//CQ/TplCw
         RMHDobyQvjhEzYkQds3IrGqNt/0UIs1g5lKWWJsiGTv3+TkW30oRknHa7IUOU4t0cQPo
         1PUKu5S4G5tvLq6MDBhFpSNx85MgeQvmtNHbep/PJty2pnsBDrQLEHpGAtD4jrBpPyIW
         o9VscxN8iM15Z2Po0Cpri/G0MEYdVdLUyuZOQbPBRibzwj8RERAnp9VTV4mOiTc2gNPq
         u+D6jpiwv601hVHMaycktRPDXvWjxBiGr6bIB6NEXKGQ4p2MhgllM6ovncBs9FQOuDiL
         HxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoMs4EJhAE1GMQtiPlPvBmP45XsxxXVS/xS7f6MkCT4=;
        b=J93pd00Lwq1vZZKyWsePwaIRDB1iGfa+kKH+IayOU/i1saxFIsEYx02pevr9fybPrN
         1wiD2icd6eKkyu8HXV0tOs1Wfb8v0KAFSa9UfwihSxlrbD8ScxUasQ7RLLX/1Ho5COLl
         z02pzBfQneQW0H2c9kSE3tWFdnxgqPwBTbwFo7VE34rIZksKhTT+Z/9ZAtpAb7lqJ8nl
         5Ekw2u20hmSRyTOpFSBo8TKmKZVcuJCw6IsKN4+VFJCj30F/6W22yyGFMl0fKYs1MelV
         Eu1z7CdSGGSGngN2aiXW+CzsDeYVVYr51Tvu4bHSMw95AyCKd6Y28raLbbamJ7dBTluG
         Xiuw==
X-Gm-Message-State: APjAAAV24sNw7sEj4T1E7YCxbvs86kU9PtddVJcuqphWUaXxDMnv+2Ru
        qU8AdzwZzIK35UdxyNOQs9UEfU28VntEa2srmoFoBA==
X-Google-Smtp-Source: APXvYqxKmOPD0WYQu3XafJj96saX9DATTvDv5wAPkBiBfv0NsJB1HCpcHqzTXDgFnOCsGXkaKFIkp+uQ/1bzjDERGC4=
X-Received: by 2002:a24:5493:: with SMTP id t141mr1203114ita.10.1556014147261;
 Tue, 23 Apr 2019 03:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <259296914.jpyqiltySj@mfick-lnx> <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net> <19221376.OlD5LWjr85@mfick-lnx>
 <20190423015538.GA16369@sigill.intra.peff.net> <20190423042109.GA19183@sigill.intra.peff.net>
In-Reply-To: <20190423042109.GA19183@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Apr 2019 17:08:40 +0700
Message-ID: <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
Subject: Re: Resolving deltas dominates clone time
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 11:45 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Apr 22, 2019 at 09:55:38PM -0400, Jeff King wrote:
>
> > Here are my p5302 numbers on linux.git, by the way.
> >
> >   Test                                           jk/p5302-repeat-fix
> >   ------------------------------------------------------------------
> >   5302.2: index-pack 0 threads                   307.04(303.74+3.30)
> >   5302.3: index-pack 1 thread                    309.74(306.13+3.56)
> >   5302.4: index-pack 2 threads                   177.89(313.73+3.60)
> >   5302.5: index-pack 4 threads                   117.14(344.07+4.29)
> >   5302.6: index-pack 8 threads                   112.40(607.12+5.80)
> >   5302.7: index-pack default number of threads   135.00(322.03+3.74)
> >
> > which still imply that "4" is a win over "3" ("8" is slightly better
> > still in wall-clock time, but the total CPU rises dramatically; that's
> > probably because this is a quad-core with hyperthreading, so by that
> > point we're just throttling down the CPUs).
>
> And here's a similar test run on a 20-core Xeon w/ hyperthreading (I
> tweaked the test to keep going after eight threads):
>
> Test                            HEAD
> ----------------------------------------------------
> 5302.2: index-pack 1 threads    376.88(364.50+11.52)
> 5302.3: index-pack 2 threads    228.13(371.21+17.86)
> 5302.4: index-pack 4 threads    151.41(387.06+21.12)
> 5302.5: index-pack 8 threads    113.68(413.40+25.80)
> 5302.6: index-pack 16 threads   100.60(511.85+37.53)
> 5302.7: index-pack 32 threads   94.43(623.82+45.70)
> 5302.8: index-pack 40 threads   93.64(702.88+47.61)
>
> I don't think any of this is _particularly_ relevant to your case, but
> it really seems to me that the default of capping at 3 threads is too
> low.

Looking back at the multithread commit, I think the trend was the same
and I capped it because the gain was not proportional to the number of
cores we threw at index-pack anymore. I would not be opposed to
raising the cap though (or maybe just remove it)
-- 
Duy
