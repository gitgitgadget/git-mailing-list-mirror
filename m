Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA1C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA79460ED3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhHTAFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTAFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:05:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A29AC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:04:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so7042721pff.3
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LMGDKY6RLrlGNRVS+cHeTgTKZMlx77MyMC7wmTu/y2M=;
        b=Khhh7azqmJYx8X9V9+w3Y0jjoBtkc9wU1eVH+U6gekNjKMKZXSpq5b78lq/GrMJGDU
         ce/YdsfUk0L3bNMl3hpnKB0U3NmaJz0qsP2WTy8VIbyqA9dI/r+S9RX9qoUchUh1xPaB
         Td0b1tiQPguB9vwKZDfTRp7o+WdZy+t6zbsHW9zoRQWME8Kw+kZrymym6ZF5sW5VH3eM
         cjNdA+P/YiyI1cQW2NoOrvrIKvoCET1rZG/AY5KNCC2lcVrzvYQ7LjZzlOM2mu5r8z/P
         u/GhtPAfrEOimvpSYwWYGk9D8MNsunnZNVgIcuGhonbf8lH23KOWVjvHBOX68jWhb27C
         hntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LMGDKY6RLrlGNRVS+cHeTgTKZMlx77MyMC7wmTu/y2M=;
        b=N9xe4TXUl1beOJBIKtfC2/tCxzQ7ZJY/3qFg+luRzYTnF6l0aevoCQl5soMQJcpWGw
         7yWva8+sG6TS3KW/wVlaxXkqf28HT5KqLqNQeyGgmYrSu7xAm0qOOsYmIv89k3X0hc+U
         Sc2/7/WfRec6malzT6thRsxJM7WyrFxsu6tNx2+KTJJsJ0XWD04iBGkTWP8i5Eqh/cAl
         E3k+t5aEgotHUpXUiFzCbM+6MLnqTGCVQfm8gUTm4w0G42Oze7hh/l8lZ4stA2MVCp5O
         JO00LMZtAqCjJBLNatt8DMfCpVNDUkVGmKGSkWKh9WjSgJmFP8Iktu1XGMBxvSJ80/Qs
         QZxg==
X-Gm-Message-State: AOAM531jmZjWWtydOfNfB3Hgicq8m3MBtnbRH5Qwf1Apmg0S6ZzbizuY
        iLj9cgg+h7SQb4TjakWhV+/MbOg/Rk2ofseKBIxV9g==
X-Google-Smtp-Source: ABdhPJywUmWEUuqGmmAiFwsyQw6GQ9xAPyS83qBDJK2CsDoV/6agiw43y20XtTeAICSYrL9ielqxqw==
X-Received: by 2002:a62:1c84:0:b029:39a:87b9:91e with SMTP id c126-20020a621c840000b029039a87b9091emr16813718pfc.7.1629417862859;
        Thu, 19 Aug 2021 17:04:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id n18sm4810194pfu.3.2021.08.19.17.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:04:22 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:04:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 01/36] Makefile: mark "check" target as .PHONY
Message-ID: <YR7xftXDd5fJNgu1@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-01.36-81fe1ed90d5-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-01.36-81fe1ed90d5-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a bug in 44c9e8594e (Fix up header file dependencies and add
> sparse checking rules, 2005-07-03), we never marked the phony "check"
> target as such.

A simple enough change, and it gave me an excuse to go and look up what
.PHONY actually does. Thanks ;)

> 
> Perhaps we should just remove it, since as of a combination of
> 912f9980d2 (Makefile: help people who run 'make check' by mistake,
> 2008-11-11) 0bcd9ae85d (sparse: Fix errors due to missing
> target-specific variables, 2011-04-21) we've been suggesting the user
> run "make sparse" directly.
> 
> But under that mode it still does something, as well as directing the
> user to run "make test" under non-sparse. So let's punt that and
> narrowly fix the PHONY bug.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index c6f6246bf63..2ff038069e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2931,6 +2931,7 @@ hdr-check: $(HCO)
>  style:
>  	git clang-format --style file --diff --extensions c,h
>  
> +.PHONY: check
>  check: config-list.h command-list.h
>  	@if sparse; \
>  	then \
> -- 
> 2.33.0.rc0.595.ge31e012651d
> 
