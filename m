Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA5A1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeJIF6q (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:58:46 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42611 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIF6q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:58:46 -0400
Received: by mail-ed1-f49.google.com with SMTP id b7-v6so12412492edd.9
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nh91m6lERy1nm046YIPd6dXK7iLrbBzX5hPTxRtNVtE=;
        b=RkBvIYkmfMuaHQB/DEJnMdHvJYrd+TWxz8qFxHnuALMzy0mEh8OIDTxUkwqjlUeX6u
         f+mDtalLDK6ElllbJWJR9kjqDJaGro6Z3Qz5Sd9rWXto6eBvaV/vgmw/E1Dio2wNovNz
         qT8a0QUeYR3Kk4+Xq1Lf10WKbb3/+iBnmlN9i4ASZ2ZHlf8JzIy9u5O2KRtKrVCr5llD
         2M31wFMMxgcQ67b+zUctFeHmUNPeJiIcW8+pwkT+L/NbNYyE2YduDPH1gfYzTTyDSX8N
         NGEUiTNiDyKPtKR4OfChqXEjMiWAp6fDyiXlCojwb/mcRd+9hwwiC2LoAymZYu4FCREc
         b5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nh91m6lERy1nm046YIPd6dXK7iLrbBzX5hPTxRtNVtE=;
        b=h6w/UNeRgxHj6Ccj97Tg6gOGjTz2bzYmxG5uyOOPmPrbzSRfTWStjQ06O1/gyIk/sJ
         6JGKda19yDPoUWYppW7DhNO85pJl1qIX8erBGb/lMT+aR3/8zql59zGbMLCWbCMlhJJh
         YlLc2Z2LBv94KXAbpf7C1xB2swHPiiRRQBd1rzbiLUc+dqtZGZXsV/o8kJcDDAzl8JHk
         naJXTfPpHvHtfN5b3WUcb/5s4x/5Y42iNumAQLMCfsb/NqlQjqpP1jdCbswB2raajp07
         7MU51BU87UMfsQWBeLX4dkuAHwudrRsHXalYdjV8v34CLr2IB0PMdvhVBjYLbLN9BDl8
         E3vg==
X-Gm-Message-State: ABuFfojmY69BhYIssT815YBn9zzAZmBV6HcgbXASaHMEpm1jmONvTM3g
        fanv1tKZJX6Js8hORqjwskU36u4tNLhj/SAwTLGW9m+k1mBSSw==
X-Google-Smtp-Source: ACcGV63cuK9InKxJkyV9GWOxRSRtwZ9qkb5QubDNM8ZE6sjL/XjgOaQp95bkX9BSZXUqU7uSsSAv3aMwHQxKcbRnPRk=
X-Received: by 2002:a50:b607:: with SMTP id b7-v6mr9256791ede.215.1539038687117;
 Mon, 08 Oct 2018 15:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-6-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-6-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 15:44:36 -0700
Message-ID: <CAGZ79ka97gq5Vc_rp675=o0V+kJgZXhkTX3Da72QRCZwQWcM=g@mail.gmail.com>
Subject: Re: [PATCH 05/14] pack-revindex: express constants in terms of the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -       /* This knows the pack format -- the 20-byte trailer
> +       /* This knows the pack format -- the hash trailer
>          * follows immediately after the last object data.

While at it, fix the comment style?

With or without the nit addressed, this patch (and patches
1 and 4) are

  Reviewed-by: Stefan Beller <sbeller@google.com>
