Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE0C1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfH1Q5y (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 12:57:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42318 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1Q5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 12:57:54 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so898621iob.9
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQYySDyRuptr4aiAZrcDmjWiIfoEw8qcVto3kpyW02k=;
        b=a+SweYFJO/Mhr+W9553b1b2v75lK7WFA6EFQRM+YF+d9L7H45asKEG3m4PlCyt6wsa
         r4w4NaooJiQKnnDJIPP+DDruSCDJulOSTP7qUrA91I9gfA1uOIcC+naOEuOs/+NdVvYH
         V5B7LcwMcE+IbpW+nWzWuZG2o1jSMUEaiMWBlpHUeb5SCglvAGUURAtJ9npQEk1rEqqa
         GUJvwl1V/mQtQ7oH/Ay/B6GAxvC4Ckpsz2UHlvmQbcPNx9EJjvkbJnPsWCTlwC7yLSRI
         4P4Epts5Qyu8cLHo2Dtx2ACEOHQvTDmudYPvJi7B0AYjbFyq2obEu4Bsj2G+T2vN/tre
         xsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQYySDyRuptr4aiAZrcDmjWiIfoEw8qcVto3kpyW02k=;
        b=Xk8RYmmi9sGiQi6fu31r/5u+CTNI09/Jd0LSvPT6xDqnFlNPUecnmZiAZxzcmIetdL
         DY9P51aaiDhZfS7XawkYd511TnVPk48gxtuaQd2WIlClrh+BwsJD8HvxT/C2Qs1/9Do9
         D4alzMI4x7oEapzJe3SI6AUWy+JuAfjaL+ukDBL7D6rALSDEu72KaAx6z6kktB80T2ST
         /LVxPBA1mg9vU0vZ/rHm7zW9X49JBxjmuw1Wvf2DEr1m7yMyfKZ4bJNlaQGWtKnE7oQz
         3NGspow7xN2EgQH4oYwAQN8VhGcni3Jd2FiuWwKy+9avSpZ6A6aNntbwexCEi3cXTzQM
         o3yw==
X-Gm-Message-State: APjAAAV/OFt62N+M4HRzhTycHfbisjDO8KwsyZFIrobGM/jU6I0P26GN
        XkFZCVvGiyL0+iuoOGiWBMHbFo0KlAlIAapPS3shgdZC
X-Google-Smtp-Source: APXvYqxyGwIkG0VHCks7AdAsWt+dxJeLE3airNmB231li6r3gXrVVRSbZkJttmb9gaclP4vOUbH4SZO1qBi0HR8xamE=
X-Received: by 2002:a6b:6010:: with SMTP id r16mr5422967iog.124.1567011473023;
 Wed, 28 Aug 2019 09:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com> <20190828145444.31588-1-carenas@gmail.com>
In-Reply-To: <20190828145444.31588-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 28 Aug 2019 09:57:39 -0700
Message-ID: <CAPUEsphatmoBg3jV9p_xLF_zYe0qn=S=5UTYBCHKjnuNZm4_VA@mail.gmail.com>
Subject: Re: [PATCH v2] grep: skip UTF8 checks explicitly
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW, the changes in grep.h are IMHO optional and hadn't been really
tested as I couldn't find a version of PCRE1 old enough to trigger it
but I am hoping are simple enough to work.

As in my original proposal, there is no test because this is going to
(as documented) trigger undefined behaviour and so I don't see how we
can reliably test that.  Goes without saying tthough, that the same is
triggered when JIT is enabled and the JIT fast path is being used, so
this is not a regression and will be more visible once
ab/pcre-jit-fixes gets merged because we are moving out of the JIT
fast path with a patch[0] in that series

While =C3=86var made a point[1] that this wasn't a solution to the problem,
it was because PCRE2 could have a better one (still missing but based
on ab/pcre-jit-fixes), and it was expected that PCRE2 will be used a
lot more and so it wasn't a good idea for it (something that doesn't
apply to PCRE1)

the patch was based on maint (like all bugfixes) but applies cleanly
to master and next, it will conflict with pu but for easy of merge I'd
applied it on top of cb/pcre1-cleanup and make it available in
GitHub[2]; that branch could be used as well as a reroll for that
topic (if that is preferred)

the error message hasn't been changed on this patch, as it might make
sense to improve it as well for PCRE2, but at least shouldn't be
triggered anymore (ex, from running a freshly built git without the
patch and linked against a non JIT enabled PCRE1):

$ ./git-grep -P 'Nguy=E1=BB=85n Th=C3=A1i.Ng=E1=BB=8Dc'
.mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
fatal: pcre_exec failed with error code -10

Carlo

[0] 685668faaa (grep: stop using a custom JIT stack with PCRE v1, 2019-07-2=
6)
[1] https://public-inbox.org/git/87lfwn70nb.fsf@evledraar.gmail.com/
[2] https://github.com/carenas/git/tree/pcre1-cleanup
