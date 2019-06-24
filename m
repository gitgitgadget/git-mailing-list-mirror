Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B351F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfFXMya (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:54:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44340 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfFXMya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:54:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so14256015qtk.11
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kjikLVOKuEaGo0JmpAxB+RgTBKOYc3C3/cRUErQw8kY=;
        b=q2QAHvjgp8T5gQNWWaFai1m1jjfcwkyv2HFwtOuluiEByeHjem59ZnA90eAW+jXHnO
         jFrybBkyIvpbgUE+2UGyFPEVG8xpldPYc9y5WQIG0WfP1+MQpPqy6c54hO0lBwdOI5lG
         Z3zoKabpwlpRB2TPan+ci42q34FJVc7BAtjnzuX5EmxyTKk/YAr4iQrzemPpnWreUQ0C
         SJZjTZ2QNogCziLTgiMO7TZ0BbxYBaXs4muCH9+K8H+gxDlapsOfMpwoMWvSz2tji4it
         IQp6BYDm0JFZBrI9+BqPUISR+m+72v6Ilh0HE0QgY3Sfix63gw/k/FE/Dwb+00ANfU3z
         cdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjikLVOKuEaGo0JmpAxB+RgTBKOYc3C3/cRUErQw8kY=;
        b=emQgc2d+7SXKubMqGQiiCc19Kq/+ecfOZHWvy9bAR5WzKRmK789Jh0JmoioP5lcTXt
         eJyno2doZGgk3is8AY2KeZYIRfpCqZbXfn2rWNVg+mKGDwczAd9fJaxyBMPl6g05Y/iG
         6oxAfqGeChxVmfty/w7a+jncZYyRtfw0GBtwq8peMFjB2NBVjif4LgyL/p9jS4kdyObb
         hiowZ8gTvLk9G9McvnTGIYlYPrEBp5y3vhTTAiidoANS3PEUcJ2bZeK86ErIY+Jc3CZA
         3oOAJKQ0zO8UjpFUrE6H0a1mxVOveHpXAyvIAUSj6soy5M1jh7zoIlJ7eQzwJqIwocPL
         c1Bg==
X-Gm-Message-State: APjAAAWmca4FgRwouZ3VEdr++oPR/Jm5QtLMBV+EDWLRC5zfSyphmJFx
        AG/Id0ZdEJAMZzHdTTwXn3IepyBW
X-Google-Smtp-Source: APXvYqyV8HVQQCmzEuemmezQtNJNuIFxBL79NRonCaWVKMX54KOwY/bHqM6VxAEZRkHDw229GoFuaw==
X-Received: by 2002:ac8:2646:: with SMTP id v6mr108489399qtv.205.1561380869444;
        Mon, 24 Jun 2019 05:54:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1012:6e3f:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id 42sm1803727qtm.27.2019.06.24.05.54.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:54:28 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] revision walk: optionally use sparse reachability
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
 <20190624120711.27744-3-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6e726082-8275-b94e-c3d7-8899f00ea958@gmail.com>
Date:   Mon, 24 Jun 2019 08:54:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624120711.27744-3-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 8:07 AM, Nathaniel Filardo wrote:
> Add another bit flag to the struct rev_info.
> 
> The only caller that uses this after this patch is builtin/pack-objects.
> Without this, sparsity seems to do little good therein, as
> prepare_revision_walk will densely propagate UNINTERESTING flags from
> trees to tree contents, before mark_edges_uninteresting has a chance to
> be faster by being sparse.
> 
> While here, drop the "sparse" parameter to mark_edges_uninteresting,
> introduced in 4f6d26b167 ("list-objects: consume sparse tree walk",
> 2019-01-16) which can now use the flag in struct rev_info.  No
> functional change intended.

Looks like a straight-forward refactor to me. I'll keep reading
for the use of this new bitflag.

-Stolee
