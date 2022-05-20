Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C2AC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiETImC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347455AbiETIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 04:41:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6241F89
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:41:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f9so14400750ejc.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=31Xi2HzWSJybcqSOhzyX3Gv3fPC34RKUzxQLp9bfsME=;
        b=LUmo4TFBhJg5rcCxr9Pw1z4tfHFCAxxtRn3yW/Wk0eZ68vsPk7PI/5+wtl1b3W/FDK
         dHp6QeTu3uYWd9S8PDaVpN4qIAKRTmw6og2KrWTL/WE9HXHpKFUNikelsIz6Nq6vtXgt
         Y/7jxitziEmu3XJrsuVt/FSU5la0exewt6HGNx91QRlD/KnSGBgvfpsGnt2HnGS/9HsO
         YxpnKGToyipkN2WFhzeDIrif5aYH/9GrahDhCzTT8FaA6P7RTz1sChTtcYeyiXlG8D9W
         LkjPuzU2a8lU7DNN3TXyf2hoTC00ZFuI3NlXp2RwlKMHmS6xl6+wvMXz1agamHZ3Xg0V
         A+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=31Xi2HzWSJybcqSOhzyX3Gv3fPC34RKUzxQLp9bfsME=;
        b=JQmE7TqcayDNJvnW/UymvIdWZVlvKuCowJRlBmMMFob3Y9STcb4DyTMtusmQoL674Z
         eVrDXd2ibluN/JjM+o6uWW8eYT4eZARsvrVPK6w+q4XJM8cCf1MVH1YjB+T/enBGFUge
         B8jWPBiVTpbZShLjhm8JZtV6zvaH2rPtk1OZvbA6oSjpkePo6buQ83iNwZu/ggEJUm56
         asxwPXdqXTBtzHYOZwf0GhYtvQ6SZVnXLMTzmGXBd1gz+0BwDHRTAohK1P5kSrr+UZRt
         Cqe4ek1DajvGl73vU/ql9FVhbUNpGtfjRj9JwNI0L9/UbxYu3nNWXl3b3iEhmXH2PhXM
         FdiA==
X-Gm-Message-State: AOAM532g0FN5HNgqP2kEUkLj3G/7kc00q9nOlCWGwnBRH/U9QmJGilYm
        31rKFBZGNvLW/FvJn3X+OHw=
X-Google-Smtp-Source: ABdhPJxnn0J6rODUSlXyQhTLnS9WZO9tpSyj8CCqv6uMesbpMr66/EhqD5zfvby0hOHTj2u5GDcZRw==
X-Received: by 2002:a17:907:1623:b0:6f6:e9ce:9926 with SMTP id hb35-20020a170907162300b006f6e9ce9926mr7620080ejc.360.1653036111758;
        Fri, 20 May 2022 01:41:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id cz26-20020a0564021cba00b0042aad7448besm3973480edb.18.2022.05.20.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:41:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nryCj-002R2T-On;
        Fri, 20 May 2022 10:41:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Frantisek Hrbata <frantisek@hrbata.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] transport: free local and remote refs in transport_push()
Date:   Fri, 20 May 2022 10:40:33 +0200
References: <20220520081723.1031830-1-frantisek@hrbata.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220520081723.1031830-1-frantisek@hrbata.com>
Message-ID: <220520.8635h438aa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Frantisek Hrbata wrote:

> Fix memory leaks in transport_push(), where remote_refs and local_refs
> are never freed. While at it, remove the unnecessary indenting and make
> the code hopefully more readable.

If at all possible it would be very nice to split up such re-indenting /
formatting into another commit, so we can see what the "real" code
changes are.
