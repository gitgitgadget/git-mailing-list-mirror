Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11691F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfAWTFM (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:05:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51808 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:05:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so547068wmj.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YtZvyh2GUim2nPrsu1K6aqjHp0iZAYJcv/BKo/2fMeM=;
        b=fxSCtJjPwcaVdZFXQ1pfzjVnThIoBabh1dVBGUcxRC6++/QJ05wWe+EnocZHSfFeU/
         Xiuj5br6MrdXl2ukKpD1lltNXO5WfizEbfda23h9bF8abFn0PGyFAbOkCWdrcJ0OT0Do
         xFdEItCmTWuIJhDoACyU24UZXFOI22nRiaGjwmeNuMFpmwlopwMxi0WH2bOc60Wd/vqV
         MWwg2hz/Ur0r4FZkmk7QDMtV+UkdLeTVgiecAJ3AeSkoVFZqsjCtgMtmjBjU1ab4XwWK
         IWfuxtfyOlDwpB2MSm4uEQsahQix3lLbb1LrGcKgywBHxYN6dKt8cfrkaf/NTZRJoQbH
         eFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YtZvyh2GUim2nPrsu1K6aqjHp0iZAYJcv/BKo/2fMeM=;
        b=Ds47ptqWW84Zu3am8yW6B8Wbn1jwvTsVpz3pXtKwD+DZKvoT35G7Wh6T57BTspsh1w
         WKbNCtgqgZVtbbrfYlZssJBE2zF9H2sjUrkHxeZKB8ELilsRhT7b4D/vzQDAXiB+WQy4
         +tFlA8hto1pNQ00xcDeLo/l6uniU2rJC0+42ff4ikmXfeQCukOsKc7WHT/rHhO7rWyUV
         s6SibsMmdHKgoWpJyLbz0iFcK7EUSrEBTvR0N30MEa6Puic/Qhe0p8ozFtpizN+uNOhS
         d37g1IrVddsLX5FdQzUjCiQFR3MM7Q5AjUfzZMTnupq30bFfsuQ0ZzLZGuqwEQfLTbdG
         D4eA==
X-Gm-Message-State: AJcUukcAlg7QMfT7MPCWcyryGpbRmsQVM3Y7IdeXOLZVnVI6uoBdADz4
        nEGV62eAt3hg9nLr214LtnU=
X-Google-Smtp-Source: ALg8bN4n8W+oIvn+D0lij735Cmx9S8ykGyJOpuYcUeH4+urcRqasF/lmvLyEPx6RweNKhbRT50pd+w==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr3995106wmf.78.1548270309922;
        Wed, 23 Jan 2019 11:05:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x12sm80843651wrt.20.2019.01.23.11.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:05:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
References: <20181220134820.21810-1-t.gummerer@gmail.com>
        <20190108215225.3077-1-t.gummerer@gmail.com>
        <20190108215225.3077-8-t.gummerer@gmail.com>
        <20190122235313.GA199923@google.com>
Date:   Wed, 23 Jan 2019 11:05:08 -0800
In-Reply-To: <20190122235313.GA199923@google.com> (Jonathan Nieder's message
        of "Tue, 22 Jan 2019 15:53:13 -0800")
Message-ID: <xmqqy37bb3ff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'm nervous about the config with no associated warning or plan for
> phasing it out.

This was discussed long ago (in my panda-brain timescale) but my
recollection is to keep "checkout" default to the traditional
"overlay what was read from the tree on top of the current index"
behaviour, while the new "checkout-paths" subcommand (split from the
"checkout" subcommand to produce two subcommands, the other one
being the "checkout-branch" subcommand) would default to the new "no
overlay" behaviour.

So I am not sure if we even need a detailed transition plan.

If we were to make "checkout" pay attention to a local
configuration, that is a different story, as scripts that have
always assumed the overlay behaviour will be broken by such a
configuration variable.  But with the introduction of two new
subcommands in the picture to help interactive end users, I am not
sure if it is even worth considering to allow "checkout" to change
behaviour based on a configuration.  Those who want no-overlay
behaviour can switch to checkout-paths and be done with it, while
scripts can keep relying on the overlay behaviour, no?


