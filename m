Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F781F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAWXjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:08 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37470 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWXjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:08 -0500
Received: by mail-wm1-f53.google.com with SMTP id g67so1155866wmd.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=uSuBasElcHpLV1Bp6SRNipK+9LNndUFhJjkEndLKoxw=;
        b=S5K7Dx3ThCG7ooSzWlxqgkmUG+5aZY7z0qYb2j3acmrLTd+5wSxtTm07WqGEQop2kC
         UXeB2LL5vkCppx8sIWMmH4VTQ68ATa13bm988HumD6E/ALOf94Itqjm/25MsX5qMVt7T
         WzHxTVCfdIT42cd7+Jz8S0DvTZuaa0xoeU4aghoCDqGrjYrhXiO7gEJO3psNMwjgW/pw
         8g8d1b8YJoXWbOMdM+pjJTO3SV1Cm0qCR2UqmmwjOPGjqSivucxyMlqxpQgee/i9TtTf
         VEdS+Dx7WShinp4WX0VduoSU+EVruRAevnUJsEobYZErv6Ps2DMTISSw5gvb728io9Dx
         FLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=uSuBasElcHpLV1Bp6SRNipK+9LNndUFhJjkEndLKoxw=;
        b=Apxc0W5036M7y995Q7VmgeUWyl2yKEOnFq5+Kw64g+pnmxF415gthFiyx6L7AI6QbW
         r+R09ZFo32w3YSi8lcyrrHqdtWrpG3Idi0SkfdGbaui3N1HaiWqL5A3+pKcNCaSliyo4
         mg3DkIGlYvomyvj3ft4VUbOzUswEe90TGw4lkXAiltqRkYGXUTDEnPyfCZa6HjLa0C9I
         ZsHQBwjZXdNPseWcilLGdmQgSb7rye7AcwlqRUQPGjUzzRbMCuNcERYDrsw8J0QB8Y52
         qMpApJlq0dfJ/24Rj9hpYtJ56qH1hpABBjnsabDKri01AiJKgPsyAyBKxvOJlSLuynOO
         duaw==
X-Gm-Message-State: AJcUukcwm3mmU6bCzb1rzViCOE7/NJYJYJb83xzvGQf9SWoizHl4go1K
        hsHpLrfA7ZAWLjdozdiwu/8=
X-Google-Smtp-Source: ALg8bN6yRd3xKvY1EBjnL4F6jMaPvtpKdnOtW3w1wonFfoI35WIavEw5Zav/b5SlhR0AFGJtzx0UVQ==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr132694wml.11.1548286746409;
        Wed, 23 Jan 2019 15:39:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o64sm54724638wmo.47.2019.01.23.15.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/21] travis: fix skipping tagged releases
Date:   Wed, 23 Jan 2019 14:00:49 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <6ed2f2a35c394987be2bebd2364915c4daed888d.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqbm476j1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When building a PR, TRAVIS_BRANCH refers to the *target branch*.
> Therefore, if a PR targets `master`, and `master` happened to be tagged,
> we skipped the build by mistake.
>
> Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
> when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
> known as "push builds").
>
> Let's give it a new variable name, too: CI_BRANCH (as it is different
> from TRAVIS_BRANCH). This also prepares for the upcoming patches which
> will make our ci/* code a bit more independent from Travis and open it
> to other CI systems (in particular to Azure Pipelines).

Makes sense.
