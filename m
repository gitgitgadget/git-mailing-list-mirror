Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A80A202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933321AbdKAWJK (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:09:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:64909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932794AbdKAWJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:09:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSuMn-1dkxFg2lNd-00RmnT; Wed, 01
 Nov 2017 23:09:01 +0100
Date:   Wed, 1 Nov 2017 23:08:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
In-Reply-To: <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012307060.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
 <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com> <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t7DEzR9MBL/yuxcyP+51gZoECq+cpMFQZUSCZAi0FGPa9ZU1iA2
 xIKHWDP/e2Xe5/RJOWf76L+YaxfWvgQTLOhFlDWeSQYmDaFNKPfso/QRMLxwkA9S0EYrjl0
 uFYU5m6rA6Lyyh2ydlhs49w/qezg9lscZAO1FP0YDEKQdl4E2M0qAYp3L6rWSpZdl6FVq0Q
 RRzMK2CqDpZ7sj77ed++g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:msimpy4X4rs=:2Im2q4E8B2hHTfLn2qlIeJ
 IScofWa7fAgWTgE2mknJEmpU32d5VjGtcyS9tVUTGRVm7+TMfD7vXXGYxUMKeQMGFMcgmErGw
 +hilh68pkQLL48f3Bpk+zHQk9cAUNpY9/JPBuN+Ysqhqoy9ck3+ocrjaSdh9Ux0LdGbBLnwez
 xkGA7XmvD/Pg85TnVLMPZ31eT2n5BxZOS0lXrwccHNTQWTWfwk8WUnMbpttVgwp0XI7gL0a86
 2eJo1xBbTHRqnagSENjFo5lOqSO0xMajYsTXhk8mPFxQfefYgWuAgp2pUOx701TIEbubxZiLV
 WX9dW2wigu2H3kXhcIhmNJpiRAlw4mXTc32jAMqr1DVohdvKk8xSDWor+hUXVB12svlF7sRTb
 Ej9eA0A/+1bMUEeFbboqrri8jYj0/HxaKoXEbEUxVXWkHCo1Q5BTUcZRy3XOtkBJULXjxUsnX
 mJJtQf/FOPSTGZ8wCsBNe+y2tgvWWXgiEzBY0rERbCIIglIiXdv3oIdK4Oijgk/iWcVRcENNW
 E66zBclQRmA9f3BeJjL9KGtMwI+iHZ5YoyBUl+KgahELcKk+gRrpbdW4sGXBu4A/dHWgLuy4L
 vXI485kOgNB1D6zMDyWemSHUZun9/8wwT7PfMcRwmlX2fvM4Mt4jxgZJLSwgYVb2+6UaaT18u
 2/4XAFRnb0BawuCPYC9aQAgXxfKDP4JhIqMLWfWNYMdYbQj+Ydlxp+NJE6lNU3T9kiMSHkeT4
 +z4qHZBVqgxLr726VXvUCui2EXUVDHmvbIUAgnoAQB9xeJM35BkcvN3y1p5ooaZAMmUK/9XJR
 fqhtUdl5o0oq3h45zvVdnrAzMLOx9OpwwO1ingFzOjtPlKigw8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 1 Nov 2017, Stefan Beller wrote:

> On Wed, Nov 1, 2017 at 5:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >>
> >>         ...
> >>         (
> >>                 for x in four three
> >>                 do
> >>                         git rm $x &&
> >>                         git commit -m "remote $x" ||
> >>                         exit
> >>                 done
> >>         ) &&
> >>         test 0 -eq $? &&
> >>         ...
> >>
> >> Ugly? Yes. Correct? Also yes.
> >
> > I think returning non-zero with "return" is how other tests avoid an
> > extra level of subshell.
> > Ugly? Yes. Correct? Questionable but it seems to work for those who
> > wrote them ;-)
> 
> I think I'll go without the extra subshell and with s/return 1/false/ as
> the exact value doesn't matter.

You mean

	for ...
	do
		xyz ||
		false
	done

? That does not work. Try this:

	for a in 1 2 3; do echo $a && false; done && echo done

While it does not print `done`, it will print all of 1, 2 and 3.

Ciao,
Dscho
