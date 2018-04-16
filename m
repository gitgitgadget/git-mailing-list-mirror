Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103CB1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDPWmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:42:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35228 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbeDPWmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:42:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id w3so13641085wrg.2
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ocmzAIEOmDRDrF5JULQjIzRFJw9R5aQCo1TgA5djtRA=;
        b=SuirR/pbdL0bJObUO+4CtdDIVnqvf/NMPqwId/axCCr04PJQ0WZz3vlgojJwSkBEVN
         u/Tjxa3Nlkdh9NhJXca/5dz6eFBBSyXvH2eYBm50TW4LV28rCnMChjh4OF7HKXp8Q2ux
         xBq5AsPhZhrKEQBnx4rX5rVZeKBniKPKSnAVbdIB3krLkb3Xlgks4pqBuRmG58M9UmGL
         F6+5pX5J2y3SyPoAbYk9RjkpNppTCIQ7DyfmizRNuNHLSqK6zC38paPHTLtbSk9bZ+S+
         +rBq95h21hNMKV7e0cHWwuAdp/6qXihUev1wM75w852ndo5PUVVfbsAEp3rMNudb/TMI
         /2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ocmzAIEOmDRDrF5JULQjIzRFJw9R5aQCo1TgA5djtRA=;
        b=SEKraSa/iDpNMCZYLTVKULGhZ6vyNfm9ac16NbBF6ud+4MJPFmQCeCjO/1eNQzEOFi
         uDy91G3YKAWas6D7hLjP+L5Pa/x1lZtYsKCd4NU3LIVpM6EVhRhqSH+AYTLItKYwmT2G
         cB96hWONYLkczwL4cOxBcN07mqIKgQgrxX0ZvsOFulUhHcvfUVsaGWT/VNjfdGtRghlE
         3BYJN2eMMJJq2RQ/H0yOjztd0VRe5Fe+KBF7DEyMXez0H9XwbrHu2tXXJZu38ZxV6pvt
         2ON868mu1qRsL8XiYxftSSRUzG2KSevti/2Rs7NOVStpkR9tD6sFBqUQZoLe7sopnqW3
         PWXA==
X-Gm-Message-State: ALQs6tDDV2+So14Ky1yIxQdYFoX8d1q+wlZHoBtUyC772bYGuELBAjCz
        Fz6irGRH7QeLffKgsuOXOpQ=
X-Google-Smtp-Source: AIpwx4+euv81edub3OIx151e1IprTrmnUlZnxDAR438qBTUkNNOy/jDl5Osxx3kJA93Y2H8L0dPr8A==
X-Received: by 10.223.192.136 with SMTP id d8mr10889853wrf.268.1523918528493;
        Mon, 16 Apr 2018 15:42:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e202sm12184827wma.43.2018.04.16.15.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:42:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
References: <20180326165520.802-1-pclouds@gmail.com>
        <20180415164238.9107-1-pclouds@gmail.com>
        <20180415164238.9107-4-pclouds@gmail.com>
        <CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com>
Date:   Tue, 17 Apr 2018 07:42:07 +0900
In-Reply-To: <CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 16 Apr 2018 17:43:09
 +0200")
Message-ID: <xmqqr2newz7k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +while read cmd category tags
>>  do
>> -       tag=$(echo "$tags" | sed "$substnum; s/[^0-9]//g")
>> +       name=${cmd/git-}
>
> There are two issues with this line:
>
> - This is a "regular" shell script, therefore it must not use pattern
>   substitution.

Oops.  I missed that.  Thanks.

>
> - The pattern substitution would remove the string "git-" in the middle of
>   the variable as well; I suspect this is undesired.
>
> I think that the remove matching prefix pattern substitution should be
> used here.
