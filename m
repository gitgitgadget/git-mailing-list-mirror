Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4181F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967000AbeFSSJa (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:09:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53247 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966738AbeFSSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:09:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1864955wmb.2
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PA/ADTupfj4AAa95sn5ye5DfWou8VF9mUOEjUrRQFxY=;
        b=joMmH8qKP/PWl9drZHYglYWgvKSkjEeiXm5kHyalmMRuSLEEw8kTwl7sQD9NOXlkxb
         EfrXBJEyfcD684RxKJ74T/X1WifDZz6Auw3T+nRpZXCSdzz1Jo48/c6fKVwabH1YE/q1
         n/RlTIiW6qcfO8kqNrDMTnnTt0XIoHG41THvtPPJtCZ0jLwEd6ojEak1EoBMsvexKm/R
         z29JHlQ88nMqBmFjShKx8vbYcZIMISZEVah25xxQ3B8aYYD3YPj3V9mlkuTEPuSDBxAg
         a/CpF9wEyq9EFP4tSQM1EjDn/8OEGbdZ2jtsOubX7YbtmKyD5M1mwZuradqIzs43XC6v
         iuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PA/ADTupfj4AAa95sn5ye5DfWou8VF9mUOEjUrRQFxY=;
        b=V24ya+HNs5aFVahQuZ0FGXkj5bKyXX92omfFDQ5UTUM80rixvJjr3PSdFT/5Jq+d6/
         bND0cH1JkgMUjdnuar7VQzli8ecqwMSZ55oApWlPE4L/eSizwBIUbrTNbZvAhlGeYumH
         ESaKHYrjogwokLP+5s24XphVZMOJXeIF3Ij4Ouy2Xeo8mOQasAlJG1orEbIE0s9VXHTq
         q2JAImh0GIQVgBHF8EiIi3gsfuVO6GT2eDD44ORdUj3Gd47PsSOXyz4l0fajJPGn6Ke+
         fQTLBH8Tc76pOFYaU27fvlUX6UuTkyivf6LhOc8RTqx410/IZQ0zwVyENRa399fHqEbL
         Hf0A==
X-Gm-Message-State: APt69E1ZhZezYnRsHs0/8Iq8Yediw4sNVxv2HB1PKI80GmlkX4zRUl+Y
        t1yNdYwQ8JTy8ubQqxbXhVo=
X-Google-Smtp-Source: ADUXVKIEBzJ7EVUNk21Oc3pY0a7/YKf92hcX1c61+HI3Qhx7GFwWPmUcT5A4393W8zUxlQI9Iy7eow==
X-Received: by 2002:a1c:45db:: with SMTP id l88-v6mr11929473wmi.19.1529431768489;
        Tue, 19 Jun 2018 11:09:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h77-v6sm1060208wmd.9.2018.06.19.11.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:09:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
        <20180619163506.GB22034@sigill.intra.peff.net>
        <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
        <20180619174846.GA27820@sigill.intra.peff.net>
        <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
        <20180619180525.GA28203@sigill.intra.peff.net>
Date:   Tue, 19 Jun 2018 11:09:27 -0700
In-Reply-To: <20180619180525.GA28203@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Jun 2018 14:05:25 -0400")
Message-ID: <xmqqfu1iveaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Even if it's a double-inversion? The reason we carry both `col` and
> `icol` is that it allows:
>
>   git grep --not --not --not --not -e a
>
> to still say "we found 'a' here". That's a dumb thing to ask for, but it
> is true in the end that we show lines with "a" (and will colorize them
> as such).

Yes.  I think the code is doing too much to cater to a dumb request
;-)

