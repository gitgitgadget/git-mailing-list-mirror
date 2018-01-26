Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521BE1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeAZUzK (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:55:10 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37254 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeAZUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:55:09 -0500
Received: by mail-pf0-f194.google.com with SMTP id p1so1041127pfh.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kz0Y4BGp8Jp3R92iFWLOoAqRNCHOKiFywRN98MuoJ+g=;
        b=Bu4MLSWmMclBD90ntPWUvTtzvETzFOmy1i6cedmbKqMhS9RVq8/1UR9GXv8oJiKxGp
         mF3Wh7KNZPgWt8uJZRCkdngNWRFMxCsQGxOl4xYFvp64nNypGuDedqpSpFoPh2iKtZcK
         U0i01bVTOP+FHBpRa/RbedekZdh034wbtmnT7KV1tGwf5KBtozZiB3nXQ+W47/MPFyXE
         R83f+FwBElFCWi01zax6gkWofOwxWAZ0z9YIWeyFkHXTg6uXMDaVFeskI5OEK4HBokuZ
         sFjxhX4IaR+C671BtnWOt8ByeUBxLZ6UM+rnGyPLATKN/ql+fAv6U0mDyz/m1/3LhBcg
         8cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kz0Y4BGp8Jp3R92iFWLOoAqRNCHOKiFywRN98MuoJ+g=;
        b=C/uR+0wTqOu2sg37jdVBTEAb2wFGpIVcUY2UlryeRui4zj1QDw38oGInErUenmt9bd
         JwHLGxtpzELcetL/YmJ/mq7x6EeR5kGNuAgmZGBgDsX1cAgN8Hh1w4NNyyrlLaogXg8I
         hRQHPqAtV/XqNCGdnVXwSYUktKxhFg9I9/gxI6NhAZ1LiSSfd269If2hOodGbEzNxoLS
         0VuJM71WmwwacEtmtzMarfDKcneJ88xlq13SdP4ywqGDBOuAo7wdebcPDB4JlQkce+s4
         sipVVo8kh6X26njC5CJG8nYpQ4C1jLmVvWafwKh+MDiVuksjZskMCokrYfFBygRW2Z0r
         yXAA==
X-Gm-Message-State: AKwxytekKgx8XQtAtK1bLG4cLsxoq2TgsROZ8XPDXSkYoVxVrsJ8/Ixu
        hlndcGTiGacFE9deQEQialY=
X-Google-Smtp-Source: AH8x227swBp74aEcAmkb5cZjE3MEvxtUNOoSPBTeeZOHP/9rJXfWsqOz24PukMHtK1usYsjsfIasmA==
X-Received: by 2002:a17:902:2be4:: with SMTP id l91-v6mr15128116plb.387.1517000108648;
        Fri, 26 Jan 2018 12:55:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id b8sm18686205pff.31.2018.01.26.12.55.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 12:55:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 05/14] packed-graph: implement construct_graph()
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-6-dstolee@microsoft.com>
Date:   Fri, 26 Jan 2018 12:55:06 -0800
In-Reply-To: <20180125140231.65604-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 25 Jan 2018 09:02:22 -0500")
Message-ID: <xmqq607o732t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +		packedDate[0] = htonl((*list)->date >> 32);
> +		packedDate[1] = htonl((*list)->date);

How forward-looking do we want to be?  The commit.date field happens
to be unsigned so there is no point masking the result of right
shifting it, but that would not stay to be the case once we start
supporting negative timestamps, for example.

Also, I recall that you plan to squeeze generation number in 30 bits
or so of one of these words.  Wouldn't it mean that higher order
bits of commit.date must be masked out anyway, even though we do not
have to worry about right shift propagating the sign-bit down?

Also, would >>32 be a problem if commit.date is an uint32 (and
shifting all its bits out to the right)?

