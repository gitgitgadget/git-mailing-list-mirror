Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2180B1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 08:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCKwk (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 06:52:40 -0400
Received: from ao2.it ([92.243.12.208]:56126 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeHCKwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 06:52:40 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flVsK-00061Q-Mw; Fri, 03 Aug 2018 10:55:56 +0200
Date:   Fri, 3 Aug 2018 10:57:17 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 12/12] submodule: remove the .gitmodules file
 when it is empty
Message-Id: <20180803105717.7a023507f96651a4769c1fd7@ao2.it>
In-Reply-To: <CAGZ79kaDK9nuUm_hqAZKMHydiaBDhDkM_y1UFwpRHoGjCQoq4w@mail.gmail.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-13-ao2@ao2.it>
        <CAGZ79kaDK9nuUm_hqAZKMHydiaBDhDkM_y1UFwpRHoGjCQoq4w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Aug 2018 14:15:54 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
> >
> > In particular this makes it possible to really clean things up when
> > removing the last submodule with "git rm".
> 
> This sentence is a continuation of the subject line, and I had to reread
> it to follow along.
>

OK, I'll fix that.

> >
> > The rationale is that if git creates .gitmodules when adding the first
> > submodule it should also remove it when removing the last submodule.
> 
> I agree with this sentiment. It seems slightly odd to me to have this tied
> in the same patch series that changes .gitmodules reading behavior
> as I could think of this feature as orthogonal to what this series achieved
> up to patch 10.
>

I will send this as a separate series, I briefly mentioned this
possibility in the cover letter.

> > -       test_cmp expect actual &&
> > +       test_cmp expect.both_deleted actual &&
> 
> This seems to be the re-occuring pattern in t3600, and given that
> we have
> 
>   cat >expect <<EOF
>   M  .gitmodules
>   D  submod
>   EOF
>   cat >expect.both_deleted<<EOF
>   D  .gitmodules
>   D  submod
>   EOF
> 
> with no other writing of expect in the range, this seems to be correct.
> Maybe worth testing that we do not delete a .gitmodules file if we have
> more than one submodule? (But I would expect this to be covered implicitly
> somewhere in the test suite. If so that would be worth mentioning in the
> commit message instead of writing a test -- just looking quickly we
> do have " git rm --cached submodule2" in t7406 which might be sufficient?)
>

I think I will remove the new test in t7400 as the changes to t3600
should cover that case already.

I will check about the case of more than one submodule and I'll add a
comment to the commit message.

[...]
> Thanks for this series!
> Overall it was a pleasant read, though I had some comments.
> 

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
