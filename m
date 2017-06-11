Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6C120282
	for <e@80x24.org>; Sun, 11 Jun 2017 17:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdFKRkP (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 13:40:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34690 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdFKRkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 13:40:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so1878629pfe.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=cm4ftE4yPCd9+7gZjLxMr85e6Ue1DvaSl5GTwAt28+g=;
        b=I5yN876FrjclVa+633hb68vs0XnJQeSCySEU3kFtU9muxDWpBR5+JZrygwocmvewkI
         JlbL4WAgrxg8lm4Ncoa5bqJXdL2s/IVFUfDvxBQYKpPK8tNV1Dwjd2gakOjAhnTQC0Tc
         JeIYN2hDv1uHprPFrcRdthDdsdZCf190UojmiTOV4h3GAMPlYqLHMQilDjNvRvGxd+6J
         bic9lFnI1A2bQCsBNP189wL0zzRbbHvvj29hXQOD4djeR/MBw71e2oGXBIk8a44jPV6I
         uBDdxGgQLwCS5zXViyEvU/nk//FZgyNvED+VUNJO0qydZJ2u6SXGIzM1QFSNENDaT2Ms
         6vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cm4ftE4yPCd9+7gZjLxMr85e6Ue1DvaSl5GTwAt28+g=;
        b=LIvOe4KVDOGGShmi4+PaSkIB7AUuCnALu2lbEQNG4BfP+zO006DJpYNz3vYMEm4G1E
         rw/8UfK1HI9hl64+gv53YpNRakzom1PflH/wZ7pOoYR8sCzB5l17U9V1i71hHjRPnovZ
         fUQOCl6PI9kCPnDwW9G6uXfNye7LyICgbd0eX7AsQiyI4X4TlpIq0n1BxJZSB/1HsSSq
         vPW8KXMQXOWKXp91Qsmnr1tLha7VtaJgGTMrqQu52RTpZPf9Zp2qMt6UvLYvWDoP1EwE
         R0J+QQ4UEB/ghpfvKQOy+U7WmaONiAJvk53xLxpbI/57AlOilWEnCf7Zc/O0RpsN2bMO
         eHdg==
X-Gm-Message-State: AODbwcDoFq7Lfh4sBuNFvD1UT7vL+9Z92PN+40hODU+W4fU03yUoaDv+
        7Fq3AgScW0KnysPb
X-Received: by 10.98.69.68 with SMTP id s65mr52817078pfa.178.1497202813679;
        Sun, 11 Jun 2017 10:40:13 -0700 (PDT)
Received: from [10.0.0.2] (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id b14sm15295624pga.12.2017.06.11.10.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jun 2017 10:40:13 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Implement git stash as a builtin command
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <20170608005535.13080-1-joel@teichroeb.net>
From:   Joel Teichroeb <joel@teichroeb.net>
Message-ID: <b67c04ae-a7f4-bd53-6b96-6482e6b83356@teichroeb.net>
Date:   Sun, 11 Jun 2017 10:40:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't seen any response. Would it be possible for anyone to review?

Thanks,
Joel

On 6/7/2017 5:55 PM, Joel Teichroeb wrote:
> I've rewritten git stash as a builtin c command. All tests pass,
> and I've added two new tests. Test coverage is around 95% with the
> only things missing coverage being error handlers.
>
> Changes since v3:
>   * Fixed formatting issues
>   * Fixed a bug with stash branch and added a new test for it
>   * Fixed review comments
>
> Outstanding issue:
>   * Not all argv array memory is cleaned up
>
> Joel Teichroeb (5):
>    stash: add test for stash create with no files
>    stash: Add a test for when apply fails during stash branch
>    stash: add test for stashing in a detached state
>    merge: close the index lock when not writing the new index
>    stash: implement builtin stash
>
>   Makefile                                      |    2 +-
>   builtin.h                                     |    1 +
>   builtin/stash.c                               | 1224 +++++++++++++++++++++++++
>   git-stash.sh => contrib/examples/git-stash.sh |    0
>   git.c                                         |    1 +
>   merge-recursive.c                             |    9 +-
>   t/t3903-stash.sh                              |   34 +
>   7 files changed, 1267 insertions(+), 4 deletions(-)
>   create mode 100644 builtin/stash.c
>   rename git-stash.sh => contrib/examples/git-stash.sh (100%)
>

