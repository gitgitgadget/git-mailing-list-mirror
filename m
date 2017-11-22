Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CE520954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdKVW4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:56:49 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36065 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdKVW4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:56:32 -0500
Received: by mail-qt0-f175.google.com with SMTP id a19so25839544qtb.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MVb17RpQtXBpGJOAICGhyoUO8K4xtpkffwIzORYH7do=;
        b=rRYejenhWVdER2nCoJshNLRML4bi1XXo9hnb8MNLZjYTWRBsJmPI77sB9T/ld+7XmE
         Gnbem7jiodZcXskb3Tms6anemM8TbD6IXUgbSk49bKnVDVhIJzU/8muU8grw9WicV1VK
         EddB3kRYABIJWadRdg0xKidlrHK7v9dc5l91Yd/GW8RUx5cLYfxBmXSSTPQuPTE0koRj
         tUFbyt2eETwbYvBXaTCKURMMHPuoSdK3LjCR3mAEvcvQiS+Cu0avN1zhvPuKLMxJbwpv
         xYf9KgDeAsDssnyOS2MQbQnT01sUR8k8C5BrmP+AgkqfggAkqwfW48mMuA+TjfIdTZ7M
         Gqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MVb17RpQtXBpGJOAICGhyoUO8K4xtpkffwIzORYH7do=;
        b=Fh0PGpp7LjRQIVhBIrwiWU7z2Qe+nh6ETkiqpBd8DzrjEKBfQtt0kJmgtIzCuBgJqI
         vnWY+YiVDgPWSQg0UV9E17x34H9yymOTvwxfqbVXvdOHNu3KNxFLUfrfDMO0zOXDPiLD
         /9/41pR0dLZXKBn4s48WKdNu5osbElTfwf7ikPi26QUVoTQLx3LW//DrrCgwUL8o/8v0
         TjLZjPBoE2yyLTiqye6u69WpBswIqQXGOKmsffnt8HTyH3OLDQt46Ocw32D4h2pXmUDm
         uuRmwnVa8UyVw1vFwJPJa6Cx6m4x2bKwL1OGHrFncl5xyRHj6BYUrO0hfwPayQwBjD6i
         4O/w==
X-Gm-Message-State: AJaThX4XG4iry3ho2QFnFM9S3LPQ67aPtF21K2Occ9qejOWjWESVWs0r
        gxu7ypHQQ+gqoSNAxp0KljTtLgGTUo74g+RmBWp4lEO2
X-Google-Smtp-Source: AGs4zMaTT9CXA/T/7533363rrpMthC1qkTLVVsmrE11/KSn4Zi+qUd8Ma7Tvwsh1hoxBetajNiF3zds+U7GW40aBi3s=
X-Received: by 10.237.61.181 with SMTP id i50mr37171936qtf.29.1511391391964;
 Wed, 22 Nov 2017 14:56:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 14:56:31 -0800 (PST)
In-Reply-To: <20171121205852.15731-5-git@jeffhostetler.com>
References: <20171121205852.15731-1-git@jeffhostetler.com> <20171121205852.15731-5-git@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 14:56:31 -0800
Message-ID: <CAGZ79kZR-W-_JJi7zptiGgv=W7KpNMaSEbmmxrXcKovznK9E7Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] list-objects: filter objects in traverse_commit_list
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 12:58 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> +       assert(arg);
> +       assert(!unset);

I count 16 asserts in this patch. Is that really needed?
Either omit them or use BUG if we want to rely on user
bug reports when these conditions trigger, as assert is unreliable
due to its dependence on the NDEBUG flag.

Stefan
