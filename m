Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA821F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeJAWXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 18:23:33 -0400
Received: from mail.ao2.it ([92.243.12.208]:39164 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJAWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=Ch6k3oBpJ9EK2jWmSy3Pbfa9TkmgnEMMkQLF8fGV9J8=;
        b=bjHi1lbl4xuuFewJjw3To43bt4uzEHCMHHxISs2wI/xFPErrbNh5+gdrmu8jnP4Mr/G1LboZLDYSvxH6FckY50UAx8KwB+K4llsCpwQI3eSs09duhwlVZx/VpnnBRJ0WGuR26O16Xq7Ot7u8ZvtwGaZLW3LQAnNfamHWhniMCuJdxYubGBJ/VCUJkABq11KSTuHPMuknmH1VY8kB2n2H5f8QotHK7XVlvxsN0SFUWxdetp2OwI/B43SLrb1awsBhUsz7iTBEgN3O8dTtmFfr6OfeBVcPBEkGGWQ+UQJtwp8eE/mAkE8cmW0SJEWf7qAfKWImboJmjQp8v3ObqByBIQ==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g70LD-0007ar-Nd; Mon, 01 Oct 2018 17:42:35 +0200
Date:   Mon, 1 Oct 2018 17:45:04 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
Message-Id: <20181001174504.684457e627ed76abee5e19b8@ao2.it>
In-Reply-To: <CAGZ79kYHLF0TVfVuVfKfe_A4D2QGziRCsrYpyh7wuHjdpPEkDA@mail.gmail.com>
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it>
        <20180918171257.GC27036@localhost>
        <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
        <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com>
        <20180927164415.44b1d00ee5f8e582afdaa933@ao2.it>
        <CAGZ79kYHLF0TVfVuVfKfe_A4D2QGziRCsrYpyh7wuHjdpPEkDA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Sep 2018 11:00:52 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Sep 27, 2018 at 7:44 AM Antonio Ospite <ao2@ao2.it> wrote:
[...]
> > OK, so the plan for v6 is:
> >
> >   - avoid the corruption issues spotted by G=E1bor by removing the call
> >     to repo_read_gitmodules in builtin/grep.c (this still does not fix
> >     the potential problem with nested submodules).
> >

Actually that is not enough to fix the inconsistent access to the
object store: the functions is_submodule_active() and
repo_submodule_init() too end up calling config_from_gitmodules() and
need protecting as well, so I am going to put them under the git read
lock and leave repo_read_gitmodules() in place for now.

Removing unneeded code can go in a possible stand-alone patch.

> >   - add a new test-tool which better exercises the new
> >     config_from_gitmodules code,
>=20
> Sounds good.
>=20
> >
> >   - add also a test_expect_failure test to document the use case that
> >     cannot be supported yet: nested submodules without .gitmodules in
> >     their working tree.
>=20
> Personally I would want to live in a world where we don't *have* to nor
> *want* to support submodules without .gitmodules in the respective
> superproject.
>

Just to double check: are you referring to *nested* submodules in the
sentence above?

I am asking because the whole point of this patchset is to *enable* the
use of submodules without .gitmodules in the working tree of the
superproject. :)

It's just that current limitations in git do not allow to support this
for *nested* submodules yet.

> We did support some use cases historically that I would make sure to
> continue to support, but I am not sure how much effort we want to spend
> on supporting further use cases of incomplete submodules.
>
> Feel free to do so, as such tests help to document the boundaries.
>=20

Let's see how v6 turns out.

Thanks,
   Antonio

--=20
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
