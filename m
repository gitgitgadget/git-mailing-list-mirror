Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC63C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9E208BA
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 14:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgL2Oee (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 09:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2Oed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 09:34:33 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E806C0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 06:33:53 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q205so14723205oig.13
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JfyC4WDNWZBou542DgeC5V7UtEQ1/ZWze7fxkiVhl5M=;
        b=k4WH1nVFZqjxxCHjhzfboUyBND6ADNiOgyanxEd49fJD/VHvFDPXsRuiY5A8Oq7/CF
         nBFI4n32uslTcY+qf5c4bI1XOJilZi3f8JRkiftb9SbeG43sddKL6B+VeZQeGxP5GtID
         EGbrUJANLj1RjuGKWcWGBEwUbOrj5y2kL0dk3AYMjrmo6XljulDaA8zASAK7N0nUeGMs
         xW6rjrwr/KPN8jJX16EODJF/KEh0x0uhkVFTvWAKrxKgy8MJh0h4nzYvm35RsjVlT/Y7
         cVFgvRMN+0kdVJqKOgsalWHt4xrr+yHO/ozYbq39p2qK4HSNj7bXx0n+SBdMDIYHN5o8
         awsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JfyC4WDNWZBou542DgeC5V7UtEQ1/ZWze7fxkiVhl5M=;
        b=IlLAt+SQHxSi9WCfBMpHfii+gb5er30zgF5Cl/HfkFmEbl5w1TqFw0M6pccJid8zUB
         MOXwO8qpiJkjgw5d8peIpuq+5iMrt0TCjY8QVC6q48CTs3JLNXVTa+49p8+6vMPSXLNK
         A5OjxoiHKqlZfi0cItO1smKwfNTEwhqzlxXXs/obIpCghzTCC5Z/u6yTielkzBuggh7S
         GLZBJYesgaT7fys6HGkpo6T16vhhgirT+voh3qMIWnRndRwYudiwltcIyqF5K0Uaxqds
         oQuc9sDg9UcAijvg57PmwmjH9jBWjsQG9bGz6en6hXcGG4fHNsZgMNGmsTInerXMDnII
         pUjw==
X-Gm-Message-State: AOAM530Eq6ooLZvsm3YahWvOGA34ht14bHQz32QcEQzhtqjpKJ8CO0pP
        SUz2pp5e+FMrJsnnjjymdkAR0YjdSYvnGQ==
X-Google-Smtp-Source: ABdhPJyMN0pLr3GS0JfuWnRuxTryVCnS/iU+ZF0KXvpAH3zouLje893wio4oDrpn8zcQJ/2/Veq8LA==
X-Received: by 2002:aca:6146:: with SMTP id v67mr2441134oib.102.1609252432810;
        Tue, 29 Dec 2020 06:33:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b19sm7643938oib.6.2020.12.29.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 06:33:52 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:33:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <5feb3e4eda10e_3ed2e20830@natae.notmuch>
In-Reply-To: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
Subject: RE: [PATCH] builtin/*: update usage format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> =

> According to the "Error Messages" section of
> Documentation/CodingGuidelines, we should not end in a full
> stop or start with a capital letter. Fix old error and usage
> messages to match this expectation.

I agree this consistency is good.

The only time where you need capital letters and full stops is when
there's multiple sentences.

-- =

Felipe Contreras=
