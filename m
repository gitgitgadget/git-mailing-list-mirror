Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49FB20401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbdF0Van (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:30:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36297 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbdF0Val (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:30:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so6249055pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=URi0lOOb5pPAdW955zp/thhb9TjW3Gr0g1v/3XfU+V0=;
        b=iFzbe5eD6WEYzib7fQglr7afY3f1z1Zg+0PkffontJeoxvXHY9LW8Hlf3Uvd3yqBnf
         nOvgeqzcS4NZWHwVEm9lp3F/fftseXezoTnUTjtAfCcAYhotqkSnxLZnvMFKf+2MawOA
         1RBjPIohPuxISJhGjh4plaVGGh4EbYY+2/T+CWl5qUNeJpvJqe9+Hx8NuFfUKjE4PAUx
         MJdzqcd8jwGhyB4A023vwU3xRwoe4FD+nIxMzpFXU5vupWhuh2S1wlEHw8v7/Ic8BZl1
         jOqZZIuKeDzjRMr9IHq1eFHVxJ8jh8M0+hOpgLCK1fFCZSsvK1LuSjSUrMJUO6j4uC4H
         bFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=URi0lOOb5pPAdW955zp/thhb9TjW3Gr0g1v/3XfU+V0=;
        b=W+j40KNOSsrWIY6mkTZknKFlX5fCIjTWZXe3K8iYk7xCF9qgyEKwJPf7kdSUjPWLW7
         e4/3zCSZq1Nh5hJLFvjK36heZVV/jj8UqQqF3y9hwGhEYTQtzmWdhTuGLojNK+4qufcx
         MNYqRTDDg2FDudw2GlJXESLegaDr3OjTOtGx+3aTFsAn/7uNWkkU5aC+t+ReTRLfdOCT
         Qcf3H7l6ymytR0MbEFnPCPchrTOO7rg2hf/xCmUum7i1za89JZF/dfV/ng34hJ+PLf/y
         Z1bUgnCNTVrE60z/tTUJD0YqqYcuf6bYEeUKT66qZxOIqZSKk2++pIS/iaQXfDBeHB3w
         tuZA==
X-Gm-Message-State: AKS2vOwWoEfxkvhIEz2oTUj82Q2o9c7TXjL3KN7JLERcDhSMSw927mId
        RMzZfyZprieTyNfn2Iw=
X-Received: by 10.98.212.91 with SMTP id u27mr7404653pfl.157.1498599040737;
        Tue, 27 Jun 2017 14:30:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id p15sm362855pfi.99.2017.06.27.14.30.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:30:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v7 6/6] convert: add "status=delayed" to filter process protocol
References: <20170627121027.99209-1-larsxschneider@gmail.com>
        <20170627121027.99209-7-larsxschneider@gmail.com>
        <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com>
        <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com>
Date:   Tue, 27 Jun 2017 14:30:39 -0700
In-Reply-To: <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com> (Lars
        Schneider's message of "Tue, 27 Jun 2017 22:34:50 +0200")
Message-ID: <xmqqlgodyv7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I treated that as low-prio as I got the impression that you are generally OK with
> the current implementation. I promise to send a patch with this change. 
> Either as part of this series or as a follow up patch.

Sure. I was just being curious what happened; I agree that it is a
good idea to treat this as a lower priority clean-up item and leave
it to later.

> Yes. I guess that was a premature optimization on my end.
> This is how "write_entry()" in entry.c would change:
>
> -                               dco->is_delayed = 0;
>                                 ret = async_convert_to_working_tree(
>                                         ce->name, new, size, &buf, dco);
> -                               if (ret && dco->is_delayed) {
> +                               if (ret && string_list_has_string(&dco->paths, ce->name)) {
>                                         free(new);
>                                         goto finish;
>                                 }
>
> OK?

Actually I should be asking the "OK?" question---the above was what
I had in mind when I commented, but you are a lot more familiar with
the way how this code is supposed to work, and I didn't know if the
emptyness of the list can be a 100% substitute for that bit.  If you
think they are equivalent, that is a great news.

> At this point I want to ensure that checkout_entry() is called
> with the CE_RETRY state. Because checkout_entry() needs to pass 
> that flag to the convert machinery.
>
> This assert was useful when checkout_entry() changed dco->state
> between CAN_DELAY and DELAYED. In the current implementation the
> state should not be changed anymore.
>
> Would you prefer if I remove it? (with or without is both fine with me)

If that is the reason behind the assert, I am OK with either (1)
moving it _after_ checkout_entry() returns (to ensure that the
function no longer mucks with the state, or (2) removing it.

Leaving it at the current position does not make much sense to me.
