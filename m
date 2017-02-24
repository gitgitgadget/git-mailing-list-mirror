Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C454C201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBXVUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:20:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33428 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXVUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:20:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so4387735pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WjJ4gFFJ1SFfEgWcwE7WpS8T/syPnwUQoS3dELJxy2Y=;
        b=cnOrM96tWkLfHpqSJGcmoTn0or9kRMY9chBSt2Qnk7cDZow53C8QEovkMM4gCmRMZC
         LNVF62lO+HSx30QizSjh0vRTc1vEG3peLsCUccchlrFy+cx9UgWWPvdDxe7lMT1vY08f
         YtvEgsYRWIB6SqjhznMdWceNkD1rbvBlkYb36hpjjDnaQo7vW5AhUCXWGRJTgLc6TUfA
         lLU6EGRD/FYCgKxG8JD0R99ZN8I1ktG/d8l3gDpN1wfx1arik6LvpHyu+VJmwHb4B7B9
         MZ17i1NRUhbSOujf1ofdukTtzaW0FBuY8OsjucW11NkJro+NTTxdMebu9e0kvNksYgdA
         UOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WjJ4gFFJ1SFfEgWcwE7WpS8T/syPnwUQoS3dELJxy2Y=;
        b=BDdeaWCIBd3/StpADPL4FyxsCt9SMAEtcmVjzDG7w6smzmekM07YYGKcYx/XAxfS1J
         1ehyCwY6Vm1XuxTXm7BGGFXhKAuVVP5IxDFDit6phKuywhpnvoMcB5rSieyOFcmgtCSp
         kebYWhmzkhnYslmjIAKzJ1D2CEvSVOvNWQsCx8winoEs4GXkZwVNbW6FN2Nq43rWSSnK
         r90zQFId0TnpIxQiX1wdvF5YWLKZo175VgeV0RZvI7bFwJMqq7ldr6aj8SmBaC4oh9pa
         EY4Et+m94DqSMynxFpL/FXy0C7PaL512bwcyGrem8MjfF9PNWTwZr4rqHHX+PBdLywWq
         x6ng==
X-Gm-Message-State: AMke39lgvDc5hQrSLjNnFC3pdop+JuCFZ7ww1nUuzVsXKpCjaqW5YUzmpacSE/f/OtmdWQ==
X-Received: by 10.84.238.195 with SMTP id l3mr6741351pln.180.1487971249576;
        Fri, 24 Feb 2017 13:20:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id d68sm16715860pfj.92.2017.02.24.13.20.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:20:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse_config_key: allow matching single-level config
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
        <20170224210802.rpr5vdpqhsp3pt5v@sigill.intra.peff.net>
Date:   Fri, 24 Feb 2017 13:20:48 -0800
In-Reply-To: <20170224210802.rpr5vdpqhsp3pt5v@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Feb 2017 16:08:02 -0500")
Message-ID: <xmqqzihbz3nz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The parse_config_key() function was introduced to make it
> easier to match "section.subsection.key" variables. It also
> handles the simpler "section.key", and the caller is
> responsible for distinguishing the two from its
> out-parameters.
>
> Most callers who _only_ want "section.key" would just use a
> strcmp(var, "section.key"), since there is no parsing
> required. However, they may still use parse_config_key() if
> their "section" variable isn't a constant (an example of
> this is in parse_hide_refs_config).

Perhaps "only" at the end of the title?

After grepping for call sites of this function, I think we can
simplify quite a few instances of:

	if (parse_config_key(...) || !name)
		return ...;

