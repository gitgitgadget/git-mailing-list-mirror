Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D9C1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 00:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeIHFDL (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 01:03:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHFDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 01:03:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so7741492pgf.2
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YvxCYqKnNj1srJn10bZ/vAnFT7A2yK/HJoRlipbKkTQ=;
        b=kKYDfHlX2AbpWBJIJsNC/tx8ZzeepsWFbf8fty2TWXv3bfyOFbwXHTQZdzp2ZJ5+Ny
         CJrtYqbZEGdnVHI38bB63r4VZur2I+aLmfuUrPvnQxC8Y1zXBw9pPk9bqb+lsAAmd9cA
         XA9f6adp0QiDs6QkuMCzp6wExB6grhtxLMk2uoew7OmZe9qPnsRoCKQ0O6UYAT3n8GgT
         3iWwINkEawFlfYw3fB/FpguWteoUkKBDUu1xIWC6SWTfzZPf/YCAWaelIA8nkYJIj2+l
         Pt7mUBXWB3IBZRd5coD3oq5XcUJItvgj89F9QRDhk+lD0mxglW1ubVv18H3aoznbq+HB
         Thtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YvxCYqKnNj1srJn10bZ/vAnFT7A2yK/HJoRlipbKkTQ=;
        b=bjxbkHE0QHF8zwi2kxCrmZQnc0iROby9CSwqmPCJpBiM1d6gPcHQrGzJ8vIUd3Gd4C
         C8DFShcSQwG5X65XaZom1apSD0CIxf3zeZhExBs1DrS+PNU/A0yIqKae76VYIMbCQEXx
         uwo48eAXZpa18crOuZyV8chI2YRjStGnDP/J7UhjBjeXiXQa8Q6tEU9qdjkefnqa6+7k
         XtI4i4a5PaIo6YNldEf2Wla0t0F9vz/B5H7QVgvPafZFZhOy16pSngbC6wvI/p7sYM7j
         oDAa4ny/HzAFW3etbh5Shi4MsMI/mVVjy6nUiw7Co4Na0FzWSAp1c86wRAz2I71zARZ3
         rF0A==
X-Gm-Message-State: APzg51D+Avr3j1x8CJJ8GMh0/dl/Y8ODGHCCNq82qyOMVqO+bgf1bXGt
        cEawBig/PWJEDTXgZqrpncC1i2BF
X-Google-Smtp-Source: ANB0VdaJ7LXfGhJfPJzVdY8sS7/SBTLcE/tAHuk7+gi7IfnAS2wjWxXOhrD3DgjGXR4QjuHiMG0I4w==
X-Received: by 2002:a63:790b:: with SMTP id u11-v6mr10917401pgc.111.1536365983281;
        Fri, 07 Sep 2018 17:19:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g66-v6sm12924317pfk.39.2018.09.07.17.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 17:19:42 -0700 (PDT)
Date:   Fri, 7 Sep 2018 17:19:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180908001940.GB225427@aiede.svl.corp.google.com>
References: <20180906193516.28909-1-max@max630.net>
 <20180907033607.24604-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907033607.24604-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Max Kirillov wrote:

> According to RFC3875, empty environment variable is equivalent to unset,
> and for CONTENT_LENGTH it should mean zero body to read.
>
> However, unset CONTENT_LENGTH is also used for chunked encoding to indicate
> reading until EOF. At least, the test "large fetch-pack requests can be split
> across POSTs" from t5551 starts faliing, if unset or empty CONTENT_LENGTH is
> treated as zero length body. So keep the existing behavior as much as possible.
>
> Add a test for the case.
>
> Reported-By: Jelmer Vernooĳ <jelmer@jelmer.uk>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Added the "reported-by" and explained inline the reason to keep existing behavior

Lovely, thanks.

To me, "keep the existing behavior as much as possible" isn't comforting
because it doesn't tell me *which* existing behavior.  Fortunately the patch
itself is comforting: it makes us treat "" the same way as unset, which is
exactly what the RFC requires.

So I'm happy with this version.  Thanks for your patient work.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
