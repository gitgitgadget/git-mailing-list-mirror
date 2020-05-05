Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB9C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27182073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5jpH/Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEEW7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgEEW7F (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 18:59:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D4C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 15:59:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so65300qkd.9
        for <git@vger.kernel.org>; Tue, 05 May 2020 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9nP7L3Yjf0fJwr+EqBeB/V793Luc7bC8VNhJnkpOw3A=;
        b=l5jpH/VlUuKWVstG1np4XTqWGX//loyCRm+E1K56ugSEwCR6PiSQaa1LjOt2O2/wzX
         FkadCz77bg7p7GGzjEAko4t7Ugq3ujy6dgKXGUjCYrmMWkAsi9HnRLNE9Xv15CtB4Mq+
         ngQOZejs8BMyzhuMTmFpPL4LOMb8awgOJ5aIby4xlAN0DMVp8Ipst6PvAiT4sNkpMozE
         9yeMFQP6hlvLTYSFr6z8pV1hGWa/kRy+LvzCYfjXquVlK1zTuanCV5qSpAWs63N/uL46
         vwkMeh4R9yNM1V4TKJ5CSqQB7hpYYtug3Wgh0waAn3c3Fh3F0+jbZ+/RB62VHTB8GLD/
         fxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nP7L3Yjf0fJwr+EqBeB/V793Luc7bC8VNhJnkpOw3A=;
        b=HevUjSwgM81bpf+mKBQFg8J3OTO8yl09TECDG8kk7UFE2nrdmodCuEItVwMlGN+QS4
         PJSslfTv9UQSTAXPyp1V6d6r8EiziEeuIRvmaAfZbtzuQ3ks/2Io9FgrHP7rkGdfyDPf
         F+MxycHIBdMzuISbJ3dJfDf7ORAhc37pu17K68cBxEn2RZuUrgGHDGSOEFmrEfg962p9
         uMcwtdS8JqDE1SXy/A8MoEnD0/gWXx/O0AY1iQMn218KiKFWd3lwgC71Il02lu9Ut5aH
         zX7VpnqlyDuyqlyYwIt4PD7QOEoGzJqt5GdKiSVVHWez7p9DbbVnmTVJZVwAFiqq3Sjc
         M5zA==
X-Gm-Message-State: AGi0PuYnc8y6bINpJ+ZeRf6cHJBep3tPuTgAFEiG9Iek+OEttllJYMb7
        e3Ums7nvEf1pxE1QOApnxtg=
X-Google-Smtp-Source: APiQypJJjlYBPP5LQphPMR+kk+vEuGsteJdFEbZ3TySWk918Q9dZevOQ+nrFuabKq6S//pdCEL1YAA==
X-Received: by 2002:a05:620a:c89:: with SMTP id q9mr5788943qki.375.1588719544148;
        Tue, 05 May 2020 15:59:04 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id 60sm2934443qtb.95.2020.05.05.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:59:03 -0700 (PDT)
Date:   Tue, 5 May 2020 18:59:01 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Doc: reference the "stash list" in autostash docs
Message-ID: <20200505225901.GA1454@generichostname>
References: <0b898ca26b0399e9f14b9170f6586014dee80cf5.1588683624.git.liu.denton@gmail.com>
 <xmqq8si6b55l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8si6b55l.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Sorry, I noticed a typo when reading this patch over.

On Tue, May 05, 2020 at 11:36:22AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In documentation pertaining to autostash behavior, we refer to the
> > "stash reflog". This description is too low-level as the reflog refers
> > to an implementation detail of how the stash works and, for end-users,
> > they do not need to be aware of this at all.
> >
> > Change references of "stash reflog" to "stash list", which should be

s/ be$//

> > provide more accessible terminology for end-users.

Thanks,

Denton
