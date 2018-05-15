Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168481F406
	for <e@80x24.org>; Tue, 15 May 2018 16:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeEOQvK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 12:51:10 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40076 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeEOQvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 12:51:10 -0400
Received: by mail-pf0-f169.google.com with SMTP id f189-v6so333972pfa.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p25tQGrmgTK+GcY8fzUCZmTPBQv6CPftS79zAj05W4s=;
        b=rrZejJZMGdwlTtoHQ4QOMPfdEYT/6gSaulcFvV3vtHiVFhYKlS33PThgJZ0bq/Vzl2
         WRTYcCw6TRIl/3+jl6UuOPEF39GtDztnUZuoqfmPupayrwGOr2whrg1lBMSy5m2jrtDL
         mcAYXbzPPvkhR6AqYgoob9lzNio0aNb5zvyn3HIvkZaYumC0l033JuA8+vOJFHlYhYl3
         3GAh0p9MSLXz3IYcgYSiV04nPnlzxswYuoFrR+F/anuHweJiVF4YqGP3p5fu+rQtdEYq
         8Q4T+rwQvSd1FL2m6S/vLvbA2dFz/rDDCLPyoIpc0FMApFu1HMKYPuG+3wElEeeXz8dY
         H7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p25tQGrmgTK+GcY8fzUCZmTPBQv6CPftS79zAj05W4s=;
        b=e/Dup9AJc77jmqRaat2FDDYQftIqj6hPpTZbsxr2wWrJIP6XwleytkktyreIR8aLnf
         59wX2O6PhegSAKW9HMDX36kkqAlHzA8aq590AJRJ7sxsz1dmOExgGxRtlXy/kPATJOsi
         SOT6IHDNjz86cZUTiuX3uKovjJcjvNIG2lEv1jX+97WqiKWUXZfhtdnqieZCSXs448PQ
         TSslZ2UDef06EeQ2g0hkFlDWKJCCjZs8tXOHJi5M3zWGU0DlGQqJv7ixX73aURSuvRHw
         SFxIefoxdpaM/FzGbbNTIFrGEuW1MWGavix6bntZDt7PRbE4e6M9iI3Aq3tUVBV5nzlM
         wHMA==
X-Gm-Message-State: ALKqPwduklIeHsORYUDiwlZmDjKMEvAaT7t+/XgqrPgzqe8yVnEn5jpT
        aAyrGKaO+hK+E8WiiaCE/cgwiaFOg5o=
X-Google-Smtp-Source: AB8JxZoTnOhtrGa0dfhEfQ1tHM+RYZMcd+hc2vpEBaSbKcX0cf+2mhW4ezXMaenvOvKJB1R+4UTZGg==
X-Received: by 2002:a63:a312:: with SMTP id s18-v6mr12652923pge.187.1526403069019;
        Tue, 15 May 2018 09:51:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r30-v6sm473101pgu.89.2018.05.15.09.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 09:51:07 -0700 (PDT)
Date:   Tue, 15 May 2018 09:51:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/35] refspec: move refspec parsing logic into its own
 file
Message-ID: <20180515165106.GA72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <20180514215626.164960-2-bmwill@google.com>
 <xmqqr2md8hrz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2md8hrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > In preperation for performing a refactor on refspec related code, move
> 
> Preparation?

Oops, I'll fix that.


-- 
Brandon Williams
