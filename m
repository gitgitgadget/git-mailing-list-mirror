Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF542047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdISUp4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:45:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:54321 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdISUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:45:55 -0400
Received: by mail-pg0-f53.google.com with SMTP id c137so459644pga.11
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pvWzIM/PGf+pi2ttFAlzOSPxxvpqjnD44ykpqGcOjw=;
        b=N9Zv5bM7Xi4tXFAvWZ3KrqkqokdclWCG1ue/SJ7rrzyERNTpWfiFw2/OMQadFad8ft
         ZU3vLuN/0NN7bfL5ZMp3xn6Vh0OMOA/pi6woBaYqcnyamRvf1JTM5lv2EjPQCPStkdm1
         b++IgdSmoTjGOLz9wVvrtbRyqln3Xb2acYYic2tsJD48XX/fYG0jGplmvAM8z9HK6m9e
         +UgA03kmGN5AopsQraD6up2z22ZD6h19sw1xQuMdw6SYdBr75n37DosUWFaYyR9YHa+2
         p9x+en7pvcoyPC5m+YsIWFvPXAFkavi1QmLywNkQe6MLFUlSK42CDKijAkrOAXLq4b7y
         gQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pvWzIM/PGf+pi2ttFAlzOSPxxvpqjnD44ykpqGcOjw=;
        b=kHeX7BBxlk0Vgr6e1O+9kFfsGPkQLfDx69p6ARkI5h3XA00rWn6ZADWNTOLiprtI2K
         LZC6D+oBy9E/xtot4HXYHtx7Mt0MzZw9MqqtVOCrVzX2yr+DCi+dLa1RmPJ9LfcVanPc
         k2aj3CR9wYcmaXHYLauVLUrd4cXG+EouDv3h7yLeGJDdahpHJ4M92FrBpJl3pzb9CsRI
         u18YUJBSVut+hieB7Naqms90L+CDNyfeAQHGfq2DdPCrlns1jOZwGeXCJI2JKxzuQnL3
         Onpo317LzAZU8BG8pNM0wyOd9dRTAEHSMXOvD6+dfo8r0sapRno/XMgPzx6ly/zYApb/
         r0nw==
X-Gm-Message-State: AHPjjUj6Yb1BFjT0jbmi7KrJBrNCANY6aObXHxMAvVcmDpLxxvWFft61
        Q/YF+zonVjbCbGnxJCfiTHw6oQ==
X-Google-Smtp-Source: AOwi7QBCJVle6/nH4v54pFmD3PyrrZBa8u5mGvILLnjGPMwpSDvyzIJ86gWMODTPun28Gc0DQzxgwA==
X-Received: by 10.98.20.78 with SMTP id 75mr2364197pfu.239.1505853955233;
        Tue, 19 Sep 2017 13:45:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:c4b9:4349:9a84:b260])
        by smtp.gmail.com with ESMTPSA id m21sm5463127pgn.60.2017.09.19.13.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 13:45:54 -0700 (PDT)
Date:   Tue, 19 Sep 2017 13:45:52 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170919134552.7845f021@twelve2.svl.corp.google.com>
In-Reply-To: <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
        <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - this does look like a good thing to have. Sorry for the late
comments.

The following comments are assuming that we're going to standardize on
UNLEAK(var); (with the semicolon).

On Fri, 8 Sep 2017 02:38:41 -0400
Jeff King <peff@peff.net> wrote:

> +#ifdef SUPPRESS_ANNOTATED_LEAKS
> +extern void unleak_memory(const void *ptr, size_t len);
> +#define UNLEAK(var) unleak_memory(&(var), sizeof(var));

I would feel better if the semicolon was omitted. I don't think it
matters in this particular case, though.

> +#else
> +#define UNLEAK(var)

I think this should be defined to be something (for example, "do {}
while (0)"), at least so that we have compiler errors when UNLEAK(var)
is used incorrectly (for example, without the semicolon) when
SUPPRESS_ANNOTATED_LEAKS is not defined.
