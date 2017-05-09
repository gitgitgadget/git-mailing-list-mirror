Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B403A1FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbdEIEGg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:06:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33095 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdEIEGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:06:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so13357461pgc.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yIB0uLKxnHaS1/A9c54DKrF/l4gGBo5Ovr/WTCBS+L0=;
        b=Pu4hxkO6j16VtFi1mWohf5+t4MlIQTfLdBSdeworZlemCWwPMVWcYSd3XcERGj2yzs
         Em2P7mtyfpo1ZJEbnHTeEJTm+CPyznaXNKGf4ISLzNTFBs9sM6Dypc/WilbXKEKsUg25
         NbzRTJ5mYTDmkDduKPuVn3RXehAoL17pq0+rE2ekBI8yKUF+NZWLw4ni/dZIIHGSAx4C
         g73O+72dbAC0613xH2wGr5xth96FXfc4bUrjsm3k4onnop3w/4bnlkK3DfnsvbGts21z
         NWRh3CpmHLkPsBeBuOpjJSngHXLgn/uGZapNQd7parJJhtZqY+Vf67U38TViwepk2jK5
         o6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yIB0uLKxnHaS1/A9c54DKrF/l4gGBo5Ovr/WTCBS+L0=;
        b=nE9/fBrWaFfw4RH9cc0tkJUXdWoQdZytbyP+ulFhlShZstUn+5gGnSCbbXRkW1NCsE
         KgwBbQ4GQ/vTb1IbsvxYp61eND1hfub8qBorrgBJAlP9pZMy6wVbU37b2qaK4Tfv8aSd
         DoaDBZxiBjvM6cxEdYJeyv51Ek3z5E0sFSmfPMZfECLINJIgC4qPIp43AantkO/I/YrY
         +TMfDnBf8lUNv1TM49aRuozAj3ZAQUP4AIV6VB54tkjovn1vH8tFOj+O84rGx/QgLm7w
         kcR5oUqJXnneZ5SOe/9QRMEI6x+SxYFrn0iNZDGz8kGdgM+dusxuSek2ryXUXXUBS5vt
         XCIg==
X-Gm-Message-State: AODbwcAPpgoPBzF2Fp6AUpWWuiUj/uPWNpMrs5zmmeW/BH4wg+jrrOGT
        S8m9hV9/K+cNhg==
X-Received: by 10.84.171.193 with SMTP id l59mr10339plb.5.1494302794317;
        Mon, 08 May 2017 21:06:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id w3sm23666845pfw.67.2017.05.08.21.06.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 21:06:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
        <20170427205037.1787-1-marcnarc@xiplink.com>
        <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
        <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
        <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
        <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 13:06:33 +0900
In-Reply-To: <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 23:16:54 -0400")
Message-ID: <xmqqbmr24qt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do feel a bit sad about breaking this case (or at the very least
> forcing you to set an option to retain cross-version compatibility). But
> my gut says that we don't want to lock ourselves into never changing the
> diff algorithm (and I'm sure we've done it inadvertently a few times
> over the years; even the recent switch to turning on renames would have
> had that impact).

IIRC, we never promised that different versions of Git produce the
same patch ID for the same change.  I do share that sadness, as not
making that promise would affect not just such an external database
keyed with patch-ids but also affects the rerere database, and those
who heavily depend on the rerere database would need to refresh them
every time diff/merge algorithm is updated, using something like
contrib/rerere-train.sh script.

But at the same time, I am very much against promising that the
textual diff output will never improve for human readability.

