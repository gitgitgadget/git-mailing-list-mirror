Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B59A1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeCMW4n (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:56:43 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33293 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCMW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:56:42 -0400
Received: by mail-pg0-f51.google.com with SMTP id g12so546361pgs.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cnuL+98TNVyPEzoabWdq3WSvd2QwCxilMgy8pe/3nGI=;
        b=BWWWwV/w8D9eOg7Y5/RB9jvT0UyFh7cXynxXeYYZp0lThaUaMSajaDDEKPypoDkFbU
         kVDcaxUCA3PxQr1RirdvMSBpGIhDIfbQihZGVZc8XWWyFUDgXaYjOVy7rAwvMMcD7k9C
         27PRiCyMpPSM7dVc4r2WwoQK68fV9Kc+3w6EkS0dxVyCWtx3vQJvbujIr/pYACNhTyak
         FUJEWmmzRI4HYf7HjxiWA6KP2Cn7LugTvJFoxpJnHLWRZxYGJ1PfKIZ3z5op2r2/8Gqk
         Ob4CVxn7ivhYAvIdK6wtBh/bzsL546UoGF065nmm2MBWnfvviPlmwLgrwszPmASeSX8B
         M7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cnuL+98TNVyPEzoabWdq3WSvd2QwCxilMgy8pe/3nGI=;
        b=cquiFmPKDhgyXbrK5dWO5hmqZKVnRs7xJo7NKL7Fd2Ddv8ZVS3l3z4luOCAEYaaxDp
         TWtqq7ahOxYWVCk8oS/NpUNKsaXuuWfjVZo4/BsJgdArBFcsrg/EGdrY8HJSjJSlSxeL
         7rKeZSH+gkeBgBDXfm30ysaZRcsZEy1UGqQYHgJN48DirnrIOItJjx8TsCpiO192C2Sh
         OvTxTZcuMOgct1eT1Nd0ru6/ao2rYXzVF9/2LVjtGqTEC0Odh22zVeEVqAbztwleok90
         gXXjmvgMa/UGEV/kFse191wFszGl6Melc+Nt6/rudZWZLh+s22GPcvxRY1i5PqM1VRDS
         eZrQ==
X-Gm-Message-State: AElRT7FhF4Mrfsr7xx8a+bdqPltVAV7CcMfVGQXo42xDvG2IWwyo8xmo
        jBNlzfTIOk8WgyNtFNaatdo=
X-Google-Smtp-Source: AG47ELtadU35qD2XLS0umxzm1WNnJKN7u+Irt5xEd71ToLGIGCUnMsuHlRQnXci/bqHgS7kwZmu8dA==
X-Received: by 10.99.124.2 with SMTP id x2mr1852450pgc.262.1520981801922;
        Tue, 13 Mar 2018 15:56:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x84sm2428651pfi.3.2018.03.13.15.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 15:56:41 -0700 (PDT)
Date:   Tue, 13 Mar 2018 15:56:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
Message-ID: <20180313225639.GC147135@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com>
 <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
 <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
 <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com>
 <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> However, my question here about what to write to the working tree for
> a rename/rename(2to1) conflict in one particular corner case still
> remains.  Should a two-way merge be performed even if it may result in
> nested sets of conflict markers, or is that a sufficiently bad outcome
> for the user that it's the one case we do want to write colliding
> files out to different temporary paths?

Nested conflict markers only happen in the conflictstyle=diff3 case, I
would think.

merge-recursive writes them already.  I've often wished that it would
use a union merge strategy when building the common ancestor to avoid
the nested conflicts that rerere doesn't understand.  But anyway,
that's an orthogonal issue: in the rename/rename context, it should be
fine to write nested conflict markers since that's consistent with
what merge-recursive already does.

Thanks,
Jonathan
