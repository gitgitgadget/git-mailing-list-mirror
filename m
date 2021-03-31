Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CAAC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5326261987
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhCaNao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:30:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:57455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhCaNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 09:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617197409;
        bh=kXIj4RZfCj+ygI4dXo5aLf4n5oxFI3JPAuLWL9FkkP8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EyQnfPs15VHjPEN+nzCucS5GAzECmgQi4RB1g7HxjOmijE8utNvj/ZGAejhlsVR4Q
         0lGghNK220Jsq8QtkKIwSM1buOKbT3sByCQbNrV38m0AK2OXw5NS1EbNYGw7+69xoT
         kUFLtCSv/8zTQnIimKCmbnWWpvtFlh5zUloLJU4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.127.121] ([213.196.212.198]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1lf5KS1Gyn-014UJJ; Wed, 31
 Mar 2021 15:30:09 +0200
Date:   Wed, 31 Mar 2021 15:30:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v8] builtin/clone.c: add --reject-shallow option
In-Reply-To: <xmqqk0poedr4.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2103311146210.52@tvgsbejvaqbjf.bet>
References: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com> <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2103301110040.52@tvgsbejvaqbjf.bet> <xmqqk0poedr4.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oFDZWdclcABPZ8dPZMBLlTdPhDg0zQOc37lwdFGvaqLWAQDli6n
 rgR283in0l9eaF/gdpffyI1a5ea7CjNXZz57SEWnZUxTMWJOBrQWzeX6XXvTigSBr3Z/Tib
 WLvi+3Ncb5nW5HozoJfNmT/xp5QW+dW7HCgWLEmvRi6YrXHdLNPaYrUQr/lrsSnAAty2/fA
 KHICvWyplaW8L7h0BIDIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DpNa55ZIgRQ=:p2O/kjgr8Wat9gcTyY79hU
 9k8hksDwFAgG9LapMN2GteiiaR/PyBbzjgMsXKDazl+UlwLg5VfvHHfmefrxe0qMLJa7VWyaQ
 m8+BWzUMLFGqWUvLgoOWAVWKMOReLQD5wn6AQe9qLX26WQ0+G3+NxUgjqXq7Y6P/Q3p8EVkBB
 mDq2gVBhJyRxYGN6WjLZ9GTbuYhadAnLbepPwXM0y8j18psgr4Q+dgNnPrYURr+BmOt9Sh51X
 FwFML3vCx3n1IwpjOPDqgNZt8aXAegjFnuIeqpYb8YF4d/BwkZcfO3m2xRQL2PPTZAPRxUa5X
 ClE15B9Ttjz2yS6Q2m2X19u0RXc2l26hGacImda/P+eWXmv8BSUx66WP+0ScYSpCsWD2cwbma
 /SA/aLXQUathPw1JO1xd2VxXzFcxtFe5Dd/gdrXdP90djex6dC0jKW+Kee/huzSWXMNV5K2d2
 hf07Iv8/yy7wDw3PVnpXQBIghED6FJq9Zyx2YhnUx+aoSsynJgHyfeWZxRxw7Kx9A7lKleaVI
 Bd62Dn4HdN7BrqlFXYKpMBEjkNh2SMeAktKcw9cuzBsqp7aFFR5h6DEwtu0kLiKZRO4EDleHg
 r4rzzHSPnvhlD/1gs8eaQ5dcgp74wpilSx1P0/0qGhBilJ1dXCOfJzakRtear9C6kSKJykvJp
 vcvpfn7VQQ+Sv3jcvGZaMxXMisENsPH9968omPQzrQOOXOM0S38Wz+gchH32R4TyxBU4+0OX1
 eUwe+/cOfvPjf+S+F6pYSMcq2BdaRLYo+FYjKj420+92zTnbxiAbjAkVynwEVGPXNQxbFSGwl
 89+jYNKjHMA5CsJbJHKWt8XZjWOiYijvGJbLxdliGjxBvI7jOkKZ7VmbPXtfxS+pGzKcSHdgn
 7gyNU4O6ke80UVh8LJURKr6ICKK5HxUXpkl73mYtnNpu2mSICYHf7tde18BAKbAi6B8JFaWo4
 yf3eYmSQ01K7Y1/uiNzpV6o9lMMqDlf3qxvATE+LbgKuUIHxXjFgFtoUJ8+aMDw+kYK/ogTqV
 FPUXd9jWKA3MNLCYQMGzLyPF++x4Ec0tb7QGQYXMUWT1E5VPytO7THdhTgugcoUD4jcpgeWvj
 TfRsC58ynKxAAcncunUwErKQQQW+DoCDSWytwCPXCAj9e4R+QTT7l/NKH9a6WpjM+7wYJOV7U
 X1nYi65qpolHPA+gnG/V9mu+ot3Sy5eYCeqmswRfGkMDnmkCLiZoC/j2h6nKPZGQlfIzu/yhJ
 /e4iSK7/e53OEOzNQ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Mar 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > ... repository has been initialized. Note that my suggestion still wor=
ks with
> > that: if either the original config, or the new config set
> > `clone.rejectShallow`, it is picked up correctly, with the latter
> > overriding the former if both configs want to set it.
>
> All four combinations ("set it to true" vs "set it to false" makes
> two, and before and after doubles that to four)?

I don't think we need to test all four combinations, that's part of my
point. We only need to verify that we can reject a shallow clone, and that
we can allow it, and that the command-line option overrides the config
option. That's three ;-)

> >> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> >> index 428b0aac93fa..de1cd85983ed 100755
> >> --- a/t/t5606-clone-options.sh
> >> +++ b/t/t5606-clone-options.sh
> >> @@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> >>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >>
> >>  . ./test-lib.sh
> >> +. "$TEST_DIRECTORY"/lib-httpd.sh
> >> +start_httpd
> >
> > That's not good. What happens if there is no `httpd`? Then the rest of=
 the
> > tests are either skipped, or if `GIT_TEST_HTTPD` is set to `true`, we
> > fail. The failure is intentional, but the skipping is not. There are m=
any
> > tests in t5606 that do not require a running HTTP daemon, and we shoul=
d
> > not skip them (for example, in our CI runs, there are quite a few jobs
> > that run without any working `httpd`).
> >
> > A much better alternative, I think, would be to move those new test ca=
ses
> > that require `httpd` to be running to t5601 (which _already_ calls
> > `start_httpd`, near the end, so as to not skip any tests that do not
> > require `httpd`).
>
> Or move the tests that require httpd, and use of httpd library, to
> the end of this script.

In the interest of saving some time during the already-quite-long test
runs, I would recommend piggy-backing onto a script that _already_ spins
up its own Apache server.

Thanks,
Dscho
