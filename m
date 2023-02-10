Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE8C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjBJTLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjBJTLD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:11:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF682136
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:11:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u9so7445601plr.9
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DOSui1yVRGbeTEdQR3z9cZroFuBvMeuz+mPOPLl81s=;
        b=FDbwKmwwRX61NV5PqHa2Oqz9aLYz3/uceYI38OtUmRir0B0ki/rM9QJ8/ldtBxozhF
         Ob3IPvxHcVpjr6uTTe7jIGIGqqYwwL3IPa3hzNn353+Dv0bG8hkHAaplnDfdFxDGlKIo
         Xj81nUuX4KrXgeo1RPL14Fi4Nlj41chKFQl7E8Vuenp4w12CzUUvetIaidlaPUAMij1O
         TiqiHVZDfAn3JMNUlbXNAYaJQsGca1izjhhMy+NVL2j36XI14vsQg84WN29fIBgghEj5
         YqICf+N8kjYMYAKT6fSSuCdp2XNV4CVNaBOaBs5hcLnbhN21WQvjvoNfON7TTdKOvF+u
         BhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5DOSui1yVRGbeTEdQR3z9cZroFuBvMeuz+mPOPLl81s=;
        b=T0hiceMagutV4qdEK6Fy/V3ayOLIiCsEvfrMDcbp+ZnPyvYct7tp+OiI+H22Eu1mO9
         EHfoW4XhTqQJyql5AHxtba774mvbHXLf8fwPXKi/KlNkLTQG6jfcFi/kGBMsZCD7YdMT
         Y7R8XfNWxfQb/5afjHzFNNcXkvUwzG0NryW0xnQfKmCFBDbPHvur21btc7KAtDzoE7UV
         te2rk+xcGx07wBi4hONtKo5fasZP2pAbNI2zOSqgIF/8MCejQvWfTQkxNZoD7WkbJ8GF
         FwIsxaiuHOKATEqNqFAAgmneH0eJtIBmD0Jz+hlXGYXknBoc4WHxvEkACqB2XQBGBjh3
         dh4g==
X-Gm-Message-State: AO0yUKXs4mwcMgPD69/f8h0zHPOcJx4owBwS2p5RB9im5oA64cifTaUM
        z1IsOgInILdNg6nFVHM4VdM=
X-Google-Smtp-Source: AK7set99+BoeecM8b4R5JdwE+7P1Lq/JMImiPwSJWUuemL3pntayDyc3SljpzsxtvMqTKPmETmsOkQ==
X-Received: by 2002:a17:902:e3c2:b0:198:f907:2a9b with SMTP id r2-20020a170902e3c200b00198f9072a9bmr11649578ple.37.1676056260671;
        Fri, 10 Feb 2023 11:11:00 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b00198df32b41csm3720465plb.29.2023.02.10.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:11:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
References: <20230210075939.44949-1-masahiroy@kernel.org>
        <20230210075939.44949-2-masahiroy@kernel.org>
Date:   Fri, 10 Feb 2023 11:10:59 -0800
In-Reply-To: <20230210075939.44949-2-masahiroy@kernel.org> (Masahiro Yamada's
        message of "Fri, 10 Feb 2023 16:59:35 +0900")
Message-ID: <xmqqo7q1ibek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> Use them with care because they are not robust against the pointer
> increment, like isblank(*s++).
>
> The same issue already exists for isspace().

Does it?

>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>  #define isascii(x) (((x) & ~0x7f) == 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)

sane_istest() evaluates x and mask only once, and isspace evaluates
x only once, no?

	isspace(*x++)
	->
	sane_istest(*x++,GIT_SPACE)
	->
	((sane_ctype[(unsigned char)(*x++)] & GIT_SPACE) != 0)

> +#define isblank(x) (isspace(x) || (x) == '\t')
> +#define isgraph(x) (isprint(x) && !isspace(x))

Given that all the other tests are implemented with just picking an
integer from the table and checking bit(s), the above two look
somewhat out of place.  The fact, as you noted, that they cannot be
used safely does not help, either.


