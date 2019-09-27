Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A4D1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfI0NbC (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 09:31:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51525 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfI0NbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 09:31:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so6642423wme.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vms5h+2UCLAFd+IQYe0nBEz91EMExQQd+t2vNejgLCw=;
        b=VX0pWFTWBWJr9/FrnwDjfczRqshBX2wpPArdAKkhth0cUaNQGBh4GFrG/HMC0YoI37
         ExotSfPtmNG/NvfRIc7ELt3kVZAdCTZ8fAnqKq5k/7RwcAEV/rv/bIuYmdSEZp0kILGD
         /QN93INon0i7M1iJLid8Mp4SOKu6MZUgr1wwsIoGzOLu6lnekESayn9eeYGmoe9gJL8d
         071FXSLGGBN04D/PY7SpcrUjwca7lnvQdylItN0+WEOD6fOAh0OvE6/bCFszKS9fgF7P
         HaQzY69g3AcQZkHgJrdNEsgEwqqGtYe71uRomtUyk67OtmVSzxQ5JyStDLzzXrHttmzF
         lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Vms5h+2UCLAFd+IQYe0nBEz91EMExQQd+t2vNejgLCw=;
        b=Jdloe0fhhWoATVvFhR9e0E59rqyrkTZrQrNiaWt1nKwaDndUxfczGSIPQ4ouY99ovD
         yz/X2qA+nxeHAIXqW0H6/b2unK0363kZnlBLdU+dju0b+UYzwKHRCq74bzZCaj3SopZi
         xHL6HWlDy9EzYLTTHiYvlhOqB1Bv/4eY0vdtKGOTkFwbT1M8joRL31bvLjMKQD6bXk+u
         RY0PabSBEcsuvCMIvgVgMOj53cdbMejRX1o3cVRXAjc8Q0UnNiOGMOWXAP1dkGjACEXJ
         RtoNqmF5t30AKvBSVc4Om6BpB6nAYyK0Y8jow86Lml9BMuz9kzRV251Z6tkSwCHezC9m
         gu0w==
X-Gm-Message-State: APjAAAVf2rBPn4Axvbh3uYMQ6XJ+yvvhW0VYs9WCGhSEgYDlYcTiawrB
        jAvOLA+aMYh/dbAAq2a47hg=
X-Google-Smtp-Source: APXvYqwaqyoljdaq1VND61pZu9TNDz7O3AKNftth9QCqPm8zxJk1k27IE+6gfVQC1eghAqnRt8xqtw==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr7047555wme.137.1569591060593;
        Fri, 27 Sep 2019 06:31:00 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id g11sm6380506wmh.45.2019.09.27.06.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 06:31:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 4/5] rebase: fill `squash_onto' in get_replay_opts()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-5-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <66fcd66b-fad2-e5a1-cdd8-fd7b37c4abbf@gmail.com>
Date:   Fri, 27 Sep 2019 14:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925201315.19722-5-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 25/09/2019 21:13, Alban Gruin wrote:
> get_replay_opts() did not fill `squash_onto' if possible, meaning that

I'm not sure what you mean by 'if possible' here, I think the sentance 
makes sense without that.

> this field should be read from the disk by the sequencer through
> read_populate_opts().  Without this, calling `pick_commits()' directly
> will result in incorrect results with `rebase --root'.
> 
> Let’s change that.

Good catch

Best Wishes

Phillip

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e8319d5946..2097d41edc 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	if (opts->strategy_opts)
>   		parse_strategy_opts(&replay, opts->strategy_opts);
>   
> +	if (opts->squash_onto) {
> +		oidcpy(&replay.squash_onto, opts->squash_onto);
> +		replay.have_squash_onto = 1;
> +	}
> +
>   	return replay;
>   }
>   
> 
