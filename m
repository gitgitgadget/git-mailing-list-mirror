Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F30C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhKWCid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWCid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:38:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03512C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:35:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so85613497edd.3
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qWMiBCwh7EBzQl3DbbYVoJoe/3KqfmJRM59R5l/ShcQ=;
        b=A2fna0wIr/ww4g4A1FDdFHPSSJSfT0d1s4jqB5zdBG//y7I2VpEi08P7JBz3Pgs4fJ
         n/zwPBLeQcwtj4RpLs7evEba3cZva4gxgM7yISvQ/wjmtp3hqHYkVNlOogr6hxuNpCH7
         9UavIiwrhaguMFfOcU1Re20Qls4bbTgiT+vjvWhstAE/h0777nRM4IzQX8HG+ZPsWsx2
         ta1ZQVR3bDp6LbwbistRDjMO+A+ZzhtGNow8CSBEXjKSV5qwBativRBpZRmbXd5Fbw3L
         BKg9lO5PZFrJq3fmND0c1tW96vRlBOPoqUU3iEWpMbJZYqhSh0wt9kxB0N63Vr2ekt8c
         VwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qWMiBCwh7EBzQl3DbbYVoJoe/3KqfmJRM59R5l/ShcQ=;
        b=DtxIC2a/a89Q+EJGqcr5SnSAzaVU3ixZgIhjewXJXUozlTom2w/PzSW4BDLVmmjmQf
         peFLXIacZbW+hg0LXXzH2oqTHDPqNb1lexQIEOf/1Z9tsPW5i1wS5rqR3ehSbt2M+are
         0CHPGzIDqV0hPIqGfIJdnXqskx+r3/ruaLaHCsXnr2kts0fDPBdglUN1oKM7giD6szcG
         kNUAx/x8KIb5WCLjmKBJANdWuGQ4TZu5IqI6zibi3dHx4Mvmv1P2t1E5VulvWvPRHzH9
         BUyGyostL7NE2A+ZEqxVfmzdsWbmHCnxjg7FaTJS3Df6aj5J1ea6lud04KKqtMuoTb3g
         KPcw==
X-Gm-Message-State: AOAM531tV9ycvRajmps4wHHEPBreKh6eQQlkqT0henPrz3C43OmrG83b
        vefwFiuAuyHEAZo89XdejPo=
X-Google-Smtp-Source: ABdhPJzF+fQNLnilaROh90Tq1BIsPe0coyJED9N8EPeGdnKiEJ3ts2utOew+5GNuUHAa11yxP3Za+w==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr3140537edz.375.1637634924428;
        Mon, 22 Nov 2021 18:35:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og14sm4571894ejc.107.2021.11.22.18.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:35:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpLeV-001Hjj-Ik;
        Tue, 23 Nov 2021 03:35:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Tue, 23 Nov 2021 03:28:15 +0100
References: <cover.1637567328.git.dyroneteng@gmail.com>
 <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
 <xmqqczmsf2d2.fsf@gitster.g> <211123.86tug3wu8v.gmgdl@evledraar.gmail.com>
 <xmqqpmqrachl.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqpmqrachl.fsf@gitster.g>
Message-ID: <211123.868rxfwqdw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> All of which (and more) would also be addressed in an obvious way by
>> just supporting --format as I suggested in
>> https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com/;
>> don't you think that's a better approach?
>
> That is what I would call over-engineering that I would rather not
> to have in low level plumbing.
>
> I am all for making _parsing_ the output from the tool easier by
> scripts; I am not interested in eliminating the _output_ by scripts.
> They should capture and format the pieces we output in any way they
> want.
>
> So, no, I do not think it is a better approach at all.

We've got --format for for-each-ref and family (also branch etc.), and
for the "log" family.

I'm not sure I understand what you're saying, do you think if we could
go back and change it that the "FIELD NAMES" in git-for-each-ref (which
is plumbing) would have been better done as
--field-name=3Drefname,objecttype,... etc?

Having used it extensively it's been very hard to have the flexibility
of formatting, e.g. to specify arbitrary delimiters.

It also leaves the door open to teaching ls-tree etc. the %(if) syntax
in the ref-filter, e.g. if you'd like to only print out certain data for
certain object types or whatever.
