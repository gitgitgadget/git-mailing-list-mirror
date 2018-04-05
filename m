Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B828F1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeDECr1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:47:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39934 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDECrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:47:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so17093447plq.6
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+1q1w3uXAqEXKpgFanTjyWq/QHp7qZ2k3yb19taEC4=;
        b=kl/fhQXMIua3B7y66vIR1e2XTH42eYbaUUSa93NYFGmqW6F1+AfLFfDBq6JAE6ELDi
         3JnJeyQ2rLctUTZkT16mYyJzHDLPGNxr9k2AIUfnbOtXQr2p1c7RyRg2MHDqn2osPDms
         pvSm7awKN1TOX4jxo5jZZpPgWH/nq8e8uxWLa4L2a+n5loJkAZTpuWMq+IaCukpP1LHa
         8Q0ueC4q/fsL2PynRQ4kDL8wJ6YkyDuNF8P438ZC8iBL+pZ7f+7//xmkndECFmrbF9ZS
         3OoZfbslDRtVf+ApMNvoecRTIzi7mVNG2/ftlnXDtXYn6M+Bm9FckUZan+fvT9wZ885T
         Wjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+1q1w3uXAqEXKpgFanTjyWq/QHp7qZ2k3yb19taEC4=;
        b=TFkXYk+MHB5e6jqmg4PTQPFtZQSJWSVhr5Idi1lwr/JjZ6RlFgUY0t8sMWl9VONo79
         0fVnDDFi+ZRRssSHE4F6HIaU+zhLP8UUzHz26mXzUlbevTt55rNIEMEmVljSMpfnwCOy
         joIfLfDmaaDeuJwjdp4zzx8C8pxSSZgcLvjj2JsnT+kU/5KLjLhjFsn5s4JRkE5wpjlq
         HjEwnUQesKBpLlFJZRkGTABYwbl2fof6kFTF2QFofJgf3vZlq45fKCdnFFz0w5J/J6Xs
         S+FNlxvYho+k1Mug3NfZ8714BWluyxSAtIcMFKH8m+8VhtBb4QAggGXzzM8La/sv3GS4
         6SDw==
X-Gm-Message-State: AElRT7F7aizYjgONylEpleQV2tY2PiIko8vd5LLPjEO6F+8nT1QdDiOd
        g9zIXnBsMOcduPJXfKrdBFRpLQ64xD4JrA==
X-Google-Smtp-Source: AIpwx4/iQbZS8sAdyTN3rixhqyvpuKvdXb7slmRCDE0gzvB+nEipOAA7pj4sytR9X6VQ8+Idb/B97Q==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr15402085plk.183.1522896445117;
        Wed, 04 Apr 2018 19:47:25 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id x27sm2751018pfa.134.2018.04.04.19.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:47:24 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:47:23 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] config.c: introduce 'git_config_color' to parse
 ANSI colors
Message-ID: <20180405024723.GC31883@syl.local>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-3-me@ttaylorr.com>
 <CAPig+cRbQbFLw_qarT0rcOoEgBg-7gW_pbFpiH5yuO=miLuWfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRbQbFLw_qarT0rcOoEgBg-7gW_pbFpiH5yuO=miLuWfA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 04:26:09PM -0400, Eric Sunshine wrote:
> On Wed, Mar 28, 2018 at 9:16 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > In preparation for adding `--color` to the `git-config(1)` builtin,
> > let's introduce a color parsing utility, `git_config_color` in a similar
> > fashion to `git_config_<type>`.
>
> Did you mean s/--color/--type=color/ ?

I did; thanks for pointing this out. I have fixed this to mention
"--type=color" in the subsequent re-roll.

Thanks,
Taylor
