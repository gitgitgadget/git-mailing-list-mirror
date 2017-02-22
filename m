Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD53201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbdBVXgm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:36:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34732 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934396AbdBVXgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:36:37 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so2307863pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rlNmeK71+rB+1jNgSAot+1RgaY3alXkDWTNCO3VRomI=;
        b=QpstHWUwg6Z5zAAZtQnnzoq/DEIv+SQNeyWK3YGIq/a48tPDq6X/F+cNeaORLsZS77
         2I83RLgfD50a8Yc2fkk/xiVyHHJMUSRmGfjutTgr06LkSngAlsDC4MKjH4DAwFXNlvon
         pPUMbCWEU3nxHQ+tb+GQIMaq86JsctmzYwhKFUmLzpk+QAqrYx0WJ+YzAtn+ax71NuMR
         jGjif3Irg+Ym65Wh7JeFjvj1S5Z5FF0jejODfezdBArlpaFfVG+RicZWx2pe4LlUHmz3
         UWHNIeIgSRDExiNr8duUh4PvtRrArsUl0kvRS/mz3sxi/w6Hk172R7TI9KOmBvlxyrt8
         sb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rlNmeK71+rB+1jNgSAot+1RgaY3alXkDWTNCO3VRomI=;
        b=cg7JiQ/knmjjK00e9Dn6tGTikS+m02391KEkxydeMWyJAf1FVx8krEla8UKpRFQ3Na
         o2oBtLgXYvyMCbm2U7Rn2eChhI7zN00D0j3SlSxalDjVOSVp5cl5vayBnDbvBcGTQL9p
         6Dnf34TMnz6oS4vEDeL0nrMZgJPSvx9IXfNBCwCpc6ERuvdox+5ZojDkpSN0gfPZEArA
         sKu+kVKLp6ElG8DfLAw7wDC0dG2dNKlcN6tC9xEWzwGkxc7jPuuqVP5GrkfUkbzQh57N
         yifDqzb3SXlFXq8c9TDy7LJ1bFd4PnMNEb5pCK29FB8UtidBeX0P+Ewg2ZNexpOkVQ/K
         nC9Q==
X-Gm-Message-State: AMke39lat13SkOo2XkOP7Q/R37pnTt1LbSJ1f87lgt3vFk9DPRtzL7yXdF3SXOQAMcN1KA==
X-Received: by 10.98.216.202 with SMTP id e193mr23843402pfg.80.1487806595617;
        Wed, 22 Feb 2017 15:36:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id t184sm5651206pgb.11.2017.02.22.15.36.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 15:36:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 03/14] upload-pack: test negotiation with changing repo
References: <cover.1485381677.git.jonathantanmy@google.com>
        <cover.1485381677.git.jonathantanmy@google.com>
        <afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
        <xmqq8tpx30zq.fsf@gitster.mtv.corp.google.com>
        <0c727063-0583-f713-68fb-bd284be696b2@google.com>
Date:   Wed, 22 Feb 2017 15:36:33 -0800
In-Reply-To: <0c727063-0583-f713-68fb-bd284be696b2@google.com> (Jonathan Tan's
        message of "Thu, 26 Jan 2017 16:44:14 -0800")
Message-ID: <xmqqo9xtajcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This somehow looks like a good thing to do even in production.  Am I
>> mistaken?
>
> Yes, that's true. If this patch set stalls (for whatever reason), I'll
> spin this off into an independent patch.

... which may be needed.

As to the main goal of this topic, I think the "ask by refname (with
glob)" is very good thing to start the "client speaks first" v2
protocol, as it would allow us to reduce the size of the initial
advertisement for common cases (i.e. remote.<name>.fetch is likely
to list only refs/heads/* on the left hand side of a refspec).  And
adding this to v1 is probably a good first step to make sure the
code that is currently used by v1 protocol exchange that will be
shared with the v2 protocols are prepared to be driven by refname
without knowing the exact object name until the final round.



