Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE607C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A6E60EC0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhHBSns (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhHBSnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:43:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0AC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 11:43:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qk33so32374719ejc.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RSoPzG7WJnvNVbkQUkgT8IH+BMHH6lQ18YAHccjRwL4=;
        b=GOSxp74ftGt//RC43O/ChipoDEwpTuUrZKDjWSr9vdVrQbatjWtGtH/8UJ34r1Ytn5
         UmPHaxzHYH9p8XA/PTh4CmB1K1fnsQ0OkiG243SsivQENlYxwWTCFbKyDGZx35R0Syry
         CEwWt6P7pnSI+t3PhfIwrck9J6vPPbfNnN1y2An6aZvLinW3lCeTnz1fo3g/q2dWZHmK
         zutS4OBCguRV4wzjHvbUkVsGHgh/ANkBg/FeAvL/jSAJZHX0PyimvzyyBsFHEliXDj0p
         2wL+afAmT4gv7tOJpqxhmz0KFl1OoX9fhfvbEgrNmn39RpzGjXiFjRDbttyj+4BvA9u1
         hlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RSoPzG7WJnvNVbkQUkgT8IH+BMHH6lQ18YAHccjRwL4=;
        b=LQyzeo85/U2QMlB3sQzfzk0jKSTUYathfGb66UumL5eO4YpjGRthgsfpVOlLHGQ1Ut
         K5/K9/2XmojanUP698QserjeMjGeyZV9qWpAr5bMRaHaql51GXl88omFbxNDbmwZ2BrL
         I1IPh/Zz+l3iNbDMJzcF1p7Uploa3Ag3MR46FQq+f0i3hR/A0wbF4y1XYBpPt4ffEcUw
         evZcljeZzxrm6mA0nlGAftVW+EfcvU9YNyr1y0OAkJeCcAELGsyXGaWGIqe9nXjiHsUm
         qoeiqHbY0qrMNgAmrwx73TOBNCeKYg42S2LaaB7QVG/5Q6bBqzyR0TcnMGVu60XYhakh
         uP0Q==
X-Gm-Message-State: AOAM533DH76Wtbd/7AI8FD+ktr//gcNUJCPyek/R1PsFw0WM63l3f1Jf
        l0c3xrbdcy2gH5Eby9FDvME=
X-Google-Smtp-Source: ABdhPJxGVGhKWIxSAk0W1dglUqRBCEnVamA9TvvehdU5qKbFAK0a6XL/Po7TqCkXeqImDNyDINrxgg==
X-Received: by 2002:a17:907:98e1:: with SMTP id ke1mr17122382ejc.162.1627929815537;
        Mon, 02 Aug 2021 11:43:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m12sm5010386ejd.21.2021.08.02.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:43:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 20:42:46 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
 <87lf5kp27s.fsf@evledraar.gmail.com> <xmqqwnp3x19i.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqwnp3x19i.fsf@gitster.g>
Message-ID: <87bl6fofft.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Jul 21 2021, Emily Shaffer wrote:
>>
>>>  compat/linux/procinfo.c                | 55 ++++++++++++++++++++++++++
>>> [...]
>>> +	/* NEEDSWORK: add non-procfs-linux implementations here */
>>
>> We'd want non-Windows and non-Linux implementations of this, but that
>> NEEDSWORK comment should not be in compat/linux/procinfo.c, where we're
>> never going to add non-Linux code.
>
> I am puzzled.  This is talking about additional implementation for
> Linux that does not use procfs, no (i.e. what to do with builds of
> Linux that compile out the procfs support or installations that do
> not mount the /proc hierarchy)?
>
> The comment seems to be at the right place to remind us of them,
> even though I do not know how important such an environment is.

Yes, I see I misread that, nevermind the narrow suggestion then.

Is there a way to do this sort of thing on Linux without procfs? Other
than things that use procfs themselves, e.g. parsing "ps" output.
