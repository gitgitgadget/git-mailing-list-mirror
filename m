Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E84201CF
	for <e@80x24.org>; Thu, 18 May 2017 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbdERVG3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 17:06:29 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33313 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbdERVG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 17:06:27 -0400
Received: by mail-pg0-f48.google.com with SMTP id u187so28241991pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNZfjqwZksgyaRtKMVf9rJrwuxXgE1TyxhmBiM7yCGI=;
        b=VVp/erwhh5RdejAHXRGLKJNO95sCQw1ke6SzdyX+p2yV/ET7NRmcdtqAbZmZDRU7Gh
         qGW7TgjVaNLp67Q/Iq5/4yyG0H4Ouv8SN83LX6jArRvRgdUIbnN4PYDPfoNFLMoDfckY
         OIdiswBBnyqCYvLaXHoTt0U+nPHz0xPkNhZSpzp6OL5o2HhmkQR15lfa4iP5eb361VeZ
         HiXE8yV8hGPXXFcVMQMCFG8vrLCzVxuB5rEhhvND0SinYHSjeyETAwp4elb74M/lGhcW
         7z8MbJ6FO3MqzeuaA9ro3BF/opJ6AKMk4nWDcSXfUaPUEqze6WUWyKnHFYLCoCX3NND6
         MRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNZfjqwZksgyaRtKMVf9rJrwuxXgE1TyxhmBiM7yCGI=;
        b=ml83E2w5V1b92B6rG3qbzxAOWtM2r2KXTR4B0NXyWmSJKjf0EMqUrQixk6S1sf/fST
         61wTKf0PDdTrPO/AOi1CArpnW3t4cV8k4HAPms/eidHOfJL05uAou/hDGMsxBS/7voko
         rDJpqmiGPtINf3FiKPLFxjfUkWPP2+YhntbwvbXLbbLU0QvW18CWqdogta8RFTAIvX8Q
         5+VTox9pIaNOuxReCCYTugf6lvtionEANOO0tdcsxJkwMrBdrzNcHbFWIAqgzu4bgJgh
         h4hzupoR0n7bNfuOPHFr2pO3oswtCYxtDDJC8h/XfBiD3BQY60BBWxIDi3g55Ol9dvql
         jzcQ==
X-Gm-Message-State: AODbwcDyCPOJODBmz+H1AA4pP17DOKkwcLy7TCdwOGp2bsTdoipxZT+n
        erWN2Xb13q/p9j3U
X-Received: by 10.84.142.133 with SMTP id 5mr7236455plx.52.1495141586810;
        Thu, 18 May 2017 14:06:26 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:98a0:fe87:dfcc:8fe4])
        by smtp.gmail.com with ESMTPSA id o29sm10832783pgc.27.2017.05.18.14.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 14:06:25 -0700 (PDT)
Date:   Thu, 18 May 2017 14:06:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Manish Goregaokar <manishearth@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating
 over all worktree HEADs
Message-ID: <20170518210624.GF112091@google.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com>
 <CACpkpxn1D_g=im0um4ncLiq3A18HRPpfu-sb1FLoY__tet0--Q@mail.gmail.com>
 <20170518094038.x3xvpsfte3zxpuqd@ruderich.org>
 <CAJZjrdUXXEU9g+n5Xhq3eq4pW8zdaev9gVcwdcNeiDvPpgDzgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZjrdUXXEU9g+n5Xhq3eq4pW8zdaev9gVcwdcNeiDvPpgDzgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/18, Samuel Lijin wrote:
> On Thu, May 18, 2017 at 5:40 AM, Simon Ruderich <simon@ruderich.org> wrote:
> > On Wed, May 17, 2017 at 06:45:31PM -0700, Manish Goregaokar wrote:
> >> Hm, my invocation of git-send-email keeps getting the threading wrong.
> >> Is there a recommended set of arguments to the command?
> >
> > The threading looks fine here (for both cases where you mentioned
> > it being wrong). Why do you think it's wrong? How does it look on
> > your end?
> 
> If you're on gmail (as Manish and I both are) patches in a subsequent

Gmail does not do threading, well not true threading.  It does grouping
of emails by subject line, that's it. If you want to view threading
(based on message-id) properly then you'll probably need to use a
different email client.

> version will be threaded (wrongly) against "earlier" versions of the
> patch. So if you have patch series A0, A1, A2, A3 and new version B0,
> B1, B2, if you thread them as
> 
> A0
> - A1
> - A2
> - A3
> - B0
>   - B1
>   - B2
> 
> gmail will show them in your inbox as
> 
> A0
> - B0
> 
> A1
> - B1
> 
> A2
> 
> A3
> - B2
> 
> Depending on whatever heuristics they use to match up "threads",
> presumably because most emails aren't threaded correctly.

-- 
Brandon Williams
