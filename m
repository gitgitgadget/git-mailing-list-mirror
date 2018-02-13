Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEB41F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965676AbeBMTfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:35:23 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54169 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:35:21 -0500
Received: by mail-wm0-f54.google.com with SMTP id t74so18191890wme.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uJSOgEJRuMB81/N8s00FfjjWp05THCT+k47aSA06WMo=;
        b=EdZ8nFuodVpOt3VMcXl2PyYovhwO6Fwn3VJiSUuf+CuJzkDEH0ftyO6btfjCZkeDrd
         ARlmPq2sOKEHDNn0tEsl7nPeZp6mnbDaycn5nZscjfrMRehKAhM2w0Ers9aOBYeb4dS+
         FQiHvvIUr7NhWvzDWXIr+cM4QJ/t7OuyBr4c4VDMu1rO7FL++FU9MTaEqUwsy064vLHN
         rIvugNWMQvdSfeD+v5zCUGtTfRa16NbRk+Oj4ZOVLRrXS82vMi5dtZScsbeQRP9+pqif
         iX52ssPQ4UPvr59RC3F8Y+euy8Qe7USHBfcjWftck9GqwEwxlDwQCKg96zgRYEoorBZF
         v4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uJSOgEJRuMB81/N8s00FfjjWp05THCT+k47aSA06WMo=;
        b=F55SlPbTcQPvsjfJdzPrfADV8+8OA05edw433Ji5AfNuYz3m+Uyhjnj4rW26rh386Q
         3J5ym/BkRlsjH9VaUkt7Edu3/1rXbmcCIiHm6SIg4Q80kZNlhaVo5j/GW57KW4BnP6OX
         yvHK19escIjpBQTfwIZhLxb1Nuv3+MVTGHJ3/vo0TIYnv/Ay2d+DY8YoJd/CF/VExRBF
         V4028KK4xAZnxMEg0tDZmGBG/vz/nH4N9JcXP/0zL0qWCFLOZwyZopeU0w2un4tsM+fo
         Odj7FXe+UdW4aDOHkhxqmthYZ/MTivzUhp6jXJRfKe5vZP0v/LMI6R9eadkJAjlW6MhD
         /JVQ==
X-Gm-Message-State: APf1xPDRTdAaQkxIFzDnM2F6JD7xKj7SOmpIO4ZL0aEmzyQdaJ/g7hAu
        BQx87erAaGXXdJ1NqCTgE+M=
X-Google-Smtp-Source: AH8x227GsSxNuXhGsPMdzvJWbsVBccH8rttPLHXe9O/se9NHDrBHUfkR+zdPDl2JUwGYSAQLkdKAdw==
X-Received: by 10.28.38.133 with SMTP id m127mr2120700wmm.40.1518550519410;
        Tue, 13 Feb 2018 11:35:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o25sm12682205wro.55.2018.02.13.11.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 11:35:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object (part 1)
References: <20180213012241.187007-1-sbeller@google.com>
        <20180213114903.GA21015@ash>
        <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
        <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
        <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZOq+_NOOabBUtPJ_zKNb_vdais70F6VzVFoSn5B5A4fQ@mail.gmail.com>
Date:   Tue, 13 Feb 2018 11:35:17 -0800
In-Reply-To: <CAGZ79kZOq+_NOOabBUtPJ_zKNb_vdais70F6VzVFoSn5B5A4fQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Feb 2018 11:23:04 -0800")
Message-ID: <xmqqzi4cptsa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> For now the ignore_env bit lives in the repository, as that helps
> when working with submodules, when reading its comments.
> Unfortunately 359efeffc1 (repository: introduce the repository
> object, 2017-06-22) did not reason about the existence of the ignore_env
> flag in its commit message.
>
>> So from that point of view, it may not matter where the "bit" lives,
>> among repository, object-store, or ref-store.
>
> It matters on the scale of confusing the developer?

What I meant is that from the point of view, having the bit in the
data (not on the invocation) is confusing no matter which data
structure holds it--they are equally bad.
