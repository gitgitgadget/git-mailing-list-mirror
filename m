Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2F8E1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 06:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeB0Gxr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:53:47 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35853 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0Gxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:53:46 -0500
Received: by mail-io0-f195.google.com with SMTP id e30so9541342ioc.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SKAG7j5bJLFKM52RV+MLpO7pfnFWyNYb8mKwZ6Y+lwA=;
        b=MN5r+UejnwWsRZyvonBW6QIN21eRsiew+2pe7Ydnmrn7eTxZnykcL58Tmi48Bm2evL
         1XZCvmySAt9sqLs5hyAJTcxx/5/i+NSixSGpHEQe4pxyFgo1RkIC17/1sHQ2jUkUe7PS
         LsoGtOvxpUavjH9HdVMsP3yY3NN5uQueBAp8CkbXLFoV6Ovtc598Rr6O785pgIWLnQyh
         0g7xG0ceW6lWon7KZg0J9HVDzU6GEQhzib0HAIfpd8pDkvbcDxTBq96CzptRjZRwNvBn
         SKzqP43r4uQr2D6rINoeUhfyUuAjVxIPjGwq86emJYzYAhWHb5MrlH4EFW5vdxRY9OwU
         kxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKAG7j5bJLFKM52RV+MLpO7pfnFWyNYb8mKwZ6Y+lwA=;
        b=aYSpuWZhMxdjU0CPnLn2V7KAaZE43Q2ilx8Y1xn1bGCnnxmjjXA0vB1Ib2pbD6wIiK
         yFsSbQxXgbVYmEKhONP9sgiciMh3rEPYycCIRYussZpkwX+oh03XkGsQtCogMaYm2Teu
         OFKivQeU0CMVa84SSn0E3KJLZXC8aIdir0KoQTZpUnbBxqpB/m4Die/Gebw/CslAInRa
         OhKvE6T3iycbSFIWSGbSw0PY+DG8RuTfknWuj07pEIr1CXOkKfbejeNaT9aJ+doE7Y+u
         5HfGKgOjBy5PU4q3jUGTjDYTwZ6YCfhCzDGujhkcLq59ezwJSWi0D+Ycy6lnddRgo2GP
         bTVA==
X-Gm-Message-State: APf1xPBGlZ5hGj7Hwk938dCnhoP59dwpltSGNN9lDsJSGhiIxFDTzFUE
        4A1WIfCJLCdaCwcf2yEG3f8=
X-Google-Smtp-Source: AG47ELtwj1raUBZPamieuiIgtSRihwqJI/o/DaqjAnSioFPFNl3PIHfxD/uRNdrvXgHduyY/+JhgZQ==
X-Received: by 10.107.172.130 with SMTP id v124mr14497235ioe.301.1519714425857;
        Mon, 26 Feb 2018 22:53:45 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k199sm6891967itb.35.2018.02.26.22.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:53:44 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:53:42 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 18/35] fetch: pass ref patterns when fetching
Message-ID: <20180227065342.GI65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-19-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-19-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Construct a list of ref patterns to be passed to
> 'transport_get_remote_refs()' from the refspec to be used during the
> fetch.  This list of ref patterns will be used to allow the server to
> filter the ref advertisement when communicating using protocol v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/fetch.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Nice.

I take it that tests covering this come later in the series?
