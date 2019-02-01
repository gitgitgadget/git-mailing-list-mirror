Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496E91F453
	for <e@80x24.org>; Fri,  1 Feb 2019 09:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfBAJzV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:55:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41347 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAJzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:55:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id m66so245641qke.8
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 01:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5HQ04fVF43Lx6E7i8utjiZyG/W2sOZgqUliNhvu2Pj0=;
        b=kHa+QIu27S0UchIxHvvA3GXF3ugWHuJveWoAzrHMvpgQsnxSj2PvdABjifcMDgy1nu
         +xPUw6luhqz2iviWYTmO7ByPTDrtvSIPetOdAJ++7FuawdQyklqBNHu7VQJkVnbt//Vc
         SzoE/PJZ79VewXwrrIbxRDrx/HaXhpDp0KN7Jc96zM/rrvLjgeHcJtLCcW9+B6dhoO0K
         gu6iDF+zuxtiAasrKQXq8NeqG4zlnKC1EuTdyv6umlpdO5dc+275d1faZR0KqOETf+Rn
         APeySLktNdKX1Ia7W8amvM+5G+tAl5DQGF0xrCNEDMME80NqW8ODOTkvHRlMEGSAkNFX
         JzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5HQ04fVF43Lx6E7i8utjiZyG/W2sOZgqUliNhvu2Pj0=;
        b=BDqMjHAs8a6MJM/aw9QOyp+u1fytzMXMyx+8ekdNlx66gVXRAV7AvZFx36VbKMpOQ8
         YhJNGOOorN9wJWasEb8Pj31ljexS6qWA4lnAYMbQgmXHHyBGp9b8czhaiWOuOxW7DhaF
         Kd8Jw+JbUhAAnNlBD5LaEXtqO8S1e1VRqK1xZydqnuBGucUFUoalk/7zfFV4f1hI9w8q
         lBv/u1aYKOzvU7PkT0IoDRg57aNt1IKjRBVCk0RFjeuPGt38wKy/sHsqWRyYde4rf2eU
         38HX5qsvJGqJYbREZcR4kvPgtr7xk8LNlU00yutKMtLvZ++PAJTn6++F/mShQkr4Seh0
         HngQ==
X-Gm-Message-State: AJcUukd6Hxyw/WKQ0XAnUJD3mzWI1R5WqotuG0jZ3dxj/4bGGg3rZvaf
        29oj3Q0930P8WONJK4yrWN/kEe9uP7DBKDKEBCA=
X-Google-Smtp-Source: ALg8bN7T7eQxDOtFxhnzgF+R/cVHm6ppuAi49LkvCHBOoCB/o5kweR8k4Nx9LAdj+Zz9NaWPT5uyHKmRoRlbLFBcbD0=
X-Received: by 2002:a37:d643:: with SMTP id t64mr34256566qki.201.1549014919867;
 Fri, 01 Feb 2019 01:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-4-worldhello.net@gmail.com> <xmqqva241v6d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva241v6d.fsf@gitster-ct.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Feb 2019 17:55:08 +0800
Message-ID: <CANYiYbGpz57J9wY6+O17jgYw7rwnEr7=X73+_O61J_Cp+fVRyg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] pack-redundant: new algorithm to find min packs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Sun Chao <sunchao9@huawei.com>
> >
> > When calling `git pack-redundant --all`, if there are too many local
> > packs and too many redundant objects within them, the too deep iteratio=
n
> > of `get_permutations` will exhaust all the resources, and the process o=
f
> > `git pack-redundant` will be killed.
>
> Build each step of the series with "make DEVELOPER=3DYesPlease" and
> your compiler hopefully would notice...
>
>     CC builtin/pack-redundant.o
> builtin/pack-redundant.c:347:12: error: 'is_superset' defined but not use=
d [-Werror=3Dunused-function]
>  static int is_superset(struct pack_list *pl, struct llist *list)
>             ^~~~~~~~~~~
> builtin/pack-redundant.c:313:21: error: 'get_permutations' defined but no=
t used [-Werror=3Dunused-function]
>  static struct pll * get_permutations(struct pack_list *list, int n)
>                      ^~~~~~~~~~~~~~~~
> builtin/pack-redundant.c:293:13: error: 'pll_free' defined but not used [=
-Werror=3Dunused-function]
>  static void pll_free(struct pll *l)
>              ^~~~~~~~
> cc1: all warnings being treated as errors
> Makefile:2302: recipe for target 'builtin/pack-redundant.o' failed
> make: *** [builtin/pack-redundant.o] Error 1
>

These unused code are deleted in another, and will be squashed to
previous patch in next reroll.
