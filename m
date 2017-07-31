Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACEE1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdGaVTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:19:07 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34967 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdGaVTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:19:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id t128so89090487lff.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zl3hSnoW/1qgZXxbpHV838nkoquxMDI/mwi0ix7lIKw=;
        b=IPd9Rr9k35X9LexTw9v8/fNobCEh5dDp9G9w1Nft20HizRLVvX0s3i0k965Cwc3PGp
         owbYAajUAYfyV7LaPePiHVRCFtsEX9aGSjIigsnVuVM/3HpWGYYqOPpZ1Gm4XDR6vy3u
         A4c2bmoE3HXZ78QSTNXOwFAmyExWra70ycGSzatnYMGhiEO2zf5A2G3yvaSTSCwoVsyI
         y4Wq5PWsVkcDY2SatxzkGn6xR9RM2Za2s7y9Ie2hrIcjVmFljhkRw+R3CXdY3XUsfYVd
         dy0naeYKT8Szeu5vQVdUr53W9mPIo5HSxS+lfkbT0tWJ6GioNqwzbzs2H/dplH7jWiFH
         8MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zl3hSnoW/1qgZXxbpHV838nkoquxMDI/mwi0ix7lIKw=;
        b=thf80SZIOHE9kwmKdYhwWHnk6n0zGgdIOw5mNvQ0y8J/thY79HZVRNdW2kN14An2FT
         FErYnV9S2j9Pgqj8Yb+pUKQqJl1uE6iCfPlmzyzehQUUJWqeH+7PwMxfj3GSzsVoGFyk
         EWW7RR9CzAGYu3b+W2wmNPAQqBw8spgqsWKxwEbSzKGbyq3P98+ug/82/lBwDko7Djr8
         q1gsoDwXJQ2UNo0s35ipCVOIrSw51IVJD+aR2B/ZQWhpYyaioxXLPOU2LmzYstoSMYwr
         az2eaAPx5S7h9uaMxz4oiVLuK5/RlC83uuGBcrLW75vNd2VVt/7U3aepB5qWg4Mrn11q
         tmHw==
X-Gm-Message-State: AIVw112DyK4wCQRzv80/nc9qhPoQQ1DKYixQ2Mbu48ncUd4ZZHUV+wjN
        wfUZ9zQUbJdK6tbu4/MoFwJAr1o0wnUO
X-Received: by 10.46.69.66 with SMTP id s63mr6781091lja.116.1501535944783;
 Mon, 31 Jul 2017 14:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 14:19:04 -0700 (PDT)
In-Reply-To: <20170731205621.24305-6-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-6-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 14:19:04 -0700
Message-ID: <CAGZ79kaxMKHgLoz-NnFGDs2MbB6i5kbhAGC9FZL8KJ8YYRAvLQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 05/13] submodule: port submodule subcommand 'sync'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> In this new version, the following changes have been made:
> * There was no good reason for using puts in the function print_default_remote()
>   Hence, in this patch, we instead use printf to do the same, as it is what
>   is generally used throughout the codebase.

Hah! I refrained on suggesting the opposite at the last patch.
In older code there are lots of "puts", c.f. "git grep puts", so I assumed
it to be a micro optimization, hence I would have suggested it.
Either way is fine with me.
