Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A122C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05F360ED8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbhIHSW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:22:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:43303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349718AbhIHSW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631125271;
        bh=7FkMM1SvGZm2+AmLuSSJct4IwX8fU0hOnlr8RspU4Ek=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kUCwyqlgcFfUdQTRkF2Y+tnwsuXvnCnyEXfgXs82Fr5+iILA9m9B+IsdEXvmTkcIV
         UM+m9EUKeBS65RMxOCQKrsBIP7MmiqU25BUIayYQNZ9VfW/sEmQItj52R4ySPXW1sR
         EP0hEIF0r2lOkETe9lhb/YW9HFntNUNKTdLcKq4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1mxdvY3Nwo-00Ztyu; Wed, 08
 Sep 2021 20:21:10 +0200
Date:   Wed, 8 Sep 2021 20:21:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 12/15] scalar: teach 'reconfigure' to optionally handle
 all registered enlistments
In-Reply-To: <CAPig+cQKKPq0cUn4iFpqaYOrwWnBTg0RhgHRztOGxB2Mm-GVUA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109082021030.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <732a28c22fcecafa308cd9444efe9158800b94e5.1630359290.git.gitgitgadget@gmail.com> <CAPig+cTG2+A0auFYdu-PHBVa1w2A5neS+6JQ5m+ADaOBq8vzUA@mail.gmail.com> <nycvar.QRO.7.76.6.2109031722460.55@tvgsbejvaqbjf.bet>
 <CAPig+cQKKPq0cUn4iFpqaYOrwWnBTg0RhgHRztOGxB2Mm-GVUA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xtkh1njbmj6voJ1i5V8REKFcolto/fiAjzs7trTx1k1Ubu45W/M
 iiuQXKmQvNESFPq+He9isR7o6zWTYyE9WMt0yppWRENUrDv6RoY/SrHm8CiZ1a/Z82rYJXD
 gERZ5JlmDt4mqhM9GcRhdaMpmiye+yZsTBhP36GOpMMIrfECTu3L9tfk9mjjZA9Y8esRUq2
 RFkWBqJmmRjb3T/CQ3cLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YmG9h+W9vzE=:KXnSrFjdNLnzH+SO0qWEOX
 WYORNAB64t/MQlcNbZOFSl9pg4zgKNapWuC7bmeTGMW3/b1P/q4JYNUwYVPOXBaqhd7dgLmdR
 wtqi5+8KZSUBAaFzyWFPKQhyPhPDTk5IVI3YtF/GSatpyydJLYfZ/ZNUyeNLYs1spJ1NewvWn
 prVQ+X9aIqBpGKPFU8QlHyYFdEGoO/fdTe5x/lOKJ6ltBp42XLr1xQfOt6x0u+XpjBaBawHXG
 9S8rfVA/oL9W44a+fB6RZC8OeyDYofnBuCrvwj2fTN8c24h3epex5T04+vhp9GL45pMOK6CKs
 LD1TdkBCjxg8noyu9A1oL7aqh1kN1I+llxIVDerKnKF0aFftqYeg7dU6U/lvZnRUdblmwvv14
 iYp5uiOg2vDYgR8Nw3MIgCvRF3VjeHBD5nqbqoxFsINlD/F0aq3jMF4AJ2lId4Y2nQZlamxi+
 4ixGY3ca/x9cbIh1aekI346JG1/RHeLEqr5HBtTqQiAFGyg3UdwmVE7zm6Ip3fgBB5lDA1Z69
 5mjI6eFEZqSY0sBoHivoIYbkFAnTKnS46bJtPk+dm7giuSjYjHgG27AS6TipyK2Whfmn9QQSl
 j6MUpSkpwFM8nb+n4IcRH6Vb2CcS1ZeCw9+HtczhZ70cmrn0DL9BnneYC+6VqUP60aWQUssoV
 djDG8qU3LOvCYe2Nk82vf5EMXWIPvR+rfgRvNld7j76fPbIzMMpHgLF8K3dzADHbnR5Plsfpe
 1SB2zaZ3P/JHmEvIfuc2F/DhyN1CkLX0Ukl0xcgpQI50wxst9lxRguIB+j7MVRHAtfdV3TGVa
 O73oEEjeDA3Zpxg/Zwr4Uzj2GyV9rt4+02AqVjFGuq3WPRkoK7kxiZuPcFHki5TEzYvcFWnp/
 zrO6BEr/j+lo+Wr6tXBkWnvD4rUu9kiDizVLakGlG8g071TSguIM7ddsIdScSKy0gYWly4Iaf
 31lEdDEmMlL8qAt/UehUIU3qOJ22lfW9lmeQ9xNLYtbRs+7NJyQNcJFHZlRwBLdVDexa+ffwL
 0SbTrH0MulpDmN+qMXAMy7Onf1QAqUTABEeLXIi6NcNIzKMMsJSpZnHzBLi9Xm5T89yZIagZj
 FQdVUuXidOobTo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 3 Sep 2021, Eric Sunshine wrote:

> On Fri, Sep 3, 2021 at 11:23 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 31 Aug 2021, Eric Sunshine wrote:
> > > On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
> > > > +With the `--all` option, all enlistments currently registered wit=
h Scalar
> > > > +will be reconfigured. This option is meant to to be run every tim=
e Scalar
> > > > +was upgraded.
> > >
> > > s/was/is/
> >
> > I wanted to convey a temporal order, so I changed it to "every time af=
ter
> > Scalar is upgraded". Okay?
>
> I think I understood the intent of the original, but it causes a
> grammatical hiccup. Your revised version can work, although I might
> write it this way:
>
>     This option is meant to be run each time Scalar is upgraded.
>
> However, perhaps that is too ambiguous and some users may think that
> the process of upgrading Scalar will automatically run this command,
> and you'd like to make it clear that it is the user's responsibility.
> So, perhaps:
>
>     Use this option after each Scalar upgrade.
>
> or something.

I like the last one best, too.

Thank you,
Dscho
