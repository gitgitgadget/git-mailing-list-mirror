Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204BC433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFED207D8
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NW5SLszL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLMDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:03:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFLMDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591963399;
        bh=XSXtgIvLKHc7ZFZXZUP4z//4KQvQn0QuFnzQMroXmmI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NW5SLszL7tZuSrtV8540z3sr7peJIXwK9/Ra8OoLKGvL7jtQH6rmx6jAMrbQ35KH8
         GrQ5PPL4dnKK7jiiZSUq5EvfrBTg5eyaADNgibDWT1TPP0gzas262Cj6/udoGrIT6I
         yVfbqfbKdGku0VAPmYnEqA+V0tIELFJnrSCzj7qI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1ikQDY1Z1b-011g9x; Fri, 12
 Jun 2020 14:03:19 +0200
Date:   Fri, 12 Jun 2020 14:03:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006121401420.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B9ciYVejy8yXkvGvjgbkA/Nfz2wtHbuqF4+UDmUkk5WMCMsVya4
 rg+UwpPHJHF3H3G7CAqWcPXETutUTh7/V7ob4QcYibTKEuik2s521IjhR1bY+j6oEaw/rLG
 fv/7jUl0z+LZ0Qcno3iRT/9FoqrvHr1jX8PPK4QSthplbA0fbcBTt7S6Te6BmCMD+JEONFe
 h5Dqf04kHckrEGC5DbSAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgPyTl3mb2o=:739JAPmAiZIteHsmf+vbnq
 +w8uIGZ92hgA6wOwVlvUJ3era3jAhGcSCifewkUNoUuA1KR9P6HgpljFlD/VSb84a4f/KV7aQ
 HNCr253AnoujbPLZld7xPAlOsl5usm6roDAEbv0S8Mjvr8nUxsbFpG/MbriXEk+YSLd9hLcE8
 HRwOoV4SGwCFL6IprnOOGbCNKs6c2aM5ysDRmgIuJMJIEbYgeYV93WyW8OBOVBEWLNEs2vS+/
 urE/RewERCqYSWBoowsK5hqusWQqYX9xE7ohZCFPIZcX/0PqGlYYauRCRfilEiC4pufDkg7gm
 81PjLb8F48w79Oehiu0NP1WoKhdE4HFx23JzX9UrpxgbCcAJcFuTz9XeZ1jGlr/O6cADBfZao
 ZptnTRyUZ3ngzYK50h0JCHc/5lFA6vCx+fd0OLpxmraMhQo5cy68FTeQhnuWCwxzg/agjE1S4
 76qB6jB2PQ0PM3PF/vXiUpUKBOnG0B6LEpiTErAeq3K+yTjumaXkY/3QkscZGTDOGVMP2Klf+
 sVGeyDkbI5hCCDSkO29Eezxt/NIt4ZTFqRgj5MJdKDp1G6YLyKV8TCQL57eJAKxkKErtBPDDk
 xlOILYPEFFRMKb838JcbdcT9ruZW4L8vZ4bmduuAbd2JdG47HB7uregm4bFIJ5s0FY5S088BF
 liMYYGFJD/KgbnqMDz6rE7e9E9LeBmtVDMzo7bPP0K4V25LPARlgbdVraPkF0TeXb7kdk1kGA
 oLX30wMXFqXaZsTYhi32KCZiwTvVA/MqYHUdlR/tRzM0Q5loAQyHI58m62vmhQcFy3ZLbkXfc
 AA/cQNP7hog8GdJluYSZSYiNto+XO9FLZ3+KQiC28hCXsWoMB+2VqCrAbT6GH/6mEg56Hbf0M
 Y2+oIciHuyM8DCPOp6zdLFCfyZJkHMr6PCM8BaDpz3Y6d8TLgjJK3wFU+pM8QBEYiBSqQtqSX
 /qRKaiU5q3i1wY6dNEdT7j6hVyW7J9hzAOks3hzxzeZWmUdfE3Rag52BqIxm7IHx33fKgWryu
 u1UNCqrWow0w3UPK/fucFZdlmy670CY8Q9t2T8y9R6wiSIfOxaC7tpetrHFjSwTMBi7CKNcJe
 +mgMYy/pNuKd6S5rHnwSMUDYCDDrb3LYZvYdMZPZ3CG5L8QMbR/onJ80X/7zcrmJIH+VbcYtT
 LvZSC55Y1vPn3GlSZnRMieLj8I58KB4Dhn8OznLnNsnfCCuSEtVNONTfH1q54CC8cfkDT8PB4
 Ikw+Z4vhJLstIBrI/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> It is a good argument.  I also heard a rumor that often branch names
> >> contain codewords given to pre-released hardware that are highly
> >> confidential in certain circles, and heard that it is one of the
> >> reasons why Gerrit has server side ACL that lets you hide some
> >> branches from authenticated users that can access other branches.
> >
> > Yes, branch names in general _can_ contain information users may prefe=
r to
> > keep private.
> >
> > However, we're not talking about branch names in general. We are talki=
ng
> > about the default name of the main branch, to be picked in _all_ of yo=
ur
> > new repositories.
>
> No, we are talking about the name of the branch, chosen to be the
> primary one, in one particular repository whose contents are
> exported via fast-export with explicit request from the user to
> anonymize end-user data.
>
> > Yes. And you're unlikely to configure the default name to be used for =
all
> > of your future `git init` operations to be something non-generic.
> >
> > Now, if you suggest that `git fast-export --anonymize` should either n=
ot
> > special-case the main branch, or at least have a configurable set of n=
ames
> > it skips from protecting, then I will be much more in favor of those
> > suggestions. However, those suggestions are quite a bit orthogonal to =
the
> > patch series at hand, so I would want to discuss them in their own cod=
e
> > contribution instead of here.
>
>
> I think after writing the message about your "two variable"
> approach, you would retract the "something non-generic" part in the
> above sentence.

You are absolutely correct!

> [...]
> -- >8 --
> Subject: [PATCH] fast-export: do anonymize the primary branch name

I like this approach a lot. Do you want me to integrate it into this patch
series, or rather have it as a stand-alone patch?

Ciao,
Dscho
