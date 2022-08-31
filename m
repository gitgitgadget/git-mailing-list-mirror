Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41388ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHaUPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHaUPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:15:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE2A1AF3F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:15:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u22so15137989plq.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=eYfDJLeVvasms45CUZThKamp1VuUETe0n7XRvii2H1c=;
        b=ezNEvK31NanUk3kvWYuFJ1VZWFPIFOcN9CiDaHlGgKWND4GTqS825Nh6ucpptSwEY+
         GwT0iibWmuSCWN//BB+Syu/wWzsvwuXrjyPmd4UYSnOoXOgYKaU6m4RMn5wHTZPk7Syh
         AiHlo62+VU061xZTK5oA/DXQum8JGzAF005/KSnsrWkJ3dGAGpTkPFQSLF7gK/Q70DWm
         uNAW9Ri2UIWnPMuY6zPHvh5lxP4n8PuPF28hnDyILROBlFEknyZQOGPqNjziqkQM+EWw
         SMWhOyBETJNLlH3Pg7OxopDh3TUZeVu6Zyn5llUHirdVFOTRIXMf5WeOpjp376LUmLjE
         1VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=eYfDJLeVvasms45CUZThKamp1VuUETe0n7XRvii2H1c=;
        b=LDVXEmUc8GMry/dMc9rJtw0JkgUkLpHfOMBOXcszlEMqhEZYGw6evS/TXt1w6rElnf
         Ew6BpwjEDoNaqZ7tRwsLIlEbwA6SYVq4RzPiM2DQ70zAszcFBY1RSzOEkMb6nHFbTdd2
         sAyrBL3oy5Ft/wVZYld52d1q79s1/sRLmK9/ZXEaNzf74r/sKFLP0rqDfSwn07GBoW6o
         5+GDIyVXWkVQ3bEqlfX3qKdDO7luSHwmfzRxNYl/f7mED7vvENws74+en6ZCQfmrHzY1
         af/JlQLwogIzKpqM8GsuQSlBEV9RXOU/RI7ibKte7blE7oZAHiMLoctnK6MoCWtAKRfE
         0jQA==
X-Gm-Message-State: ACgBeo22VnBxILGYt9PZ48FUi5J7D1IJKP/nmEt3C/H7CS5MEm04KQF9
        UTeaMrq+xtyY0cljovHPCnPdV/wrqLo=
X-Google-Smtp-Source: AA6agR4XHNijjBTFP/6G8rkS1cG3Io4EK5luPrtlu2sEZ/br2fGmCyJbzHfsCVNOA3ecB0WiXQQhxg==
X-Received: by 2002:a17:902:f684:b0:172:d54d:6f9e with SMTP id l4-20020a170902f68400b00172d54d6f9emr27429612plg.174.1661976907850;
        Wed, 31 Aug 2022 13:15:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b00172cb8b97a8sm135171plh.5.2022.08.31.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:15:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: js/add-p-diff-parsing-fix
References: <xmqqilm9k0bc.fsf@gitster.g>
        <220831.86bks0ajy7.gmgdl@evledraar.gmail.com>
        <b0a368a1-a6cc-1940-4804-3cbcae1db235@gmail.com>
        <578r404o-r7or-6pnp-2s59-o6s0525nn38p@tzk.qr>
Date:   Wed, 31 Aug 2022 13:15:06 -0700
In-Reply-To: <578r404o-r7or-6pnp-2s59-o6s0525nn38p@tzk.qr> (Johannes
        Schindelin's message of "Wed, 31 Aug 2022 21:54:29 +0200 (CEST)")
Message-ID: <xmqqv8q8dvat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A convincing argument!
>
> And after implementing this (and dropping the patches that implemented a
> deviation from the Perl script's behavior), the patch series looks so much
> more elegant, too!

You cannot call anything written in Perl elegant, though ;-)

