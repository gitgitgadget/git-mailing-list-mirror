Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1031F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeDIHus (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:50:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:34215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbeDIHur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:50:47 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyEUz-1eStkn1C7R-015aGQ; Mon, 09
 Apr 2018 09:50:28 +0200
Date:   Mon, 9 Apr 2018 09:50:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 11/15] git_config_set: do not use a state machine
In-Reply-To: <20180406212840.GC7870@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804090945460.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de> <4b3eba873df4355d7a77dfbd74963c636b1ba08e.1522772789.git.johannes.schindelin@gmx.de> <20180406212840.GC7870@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P1La8qcA+4nZcE74NMAonHgKcICuAXrIl6DNsg75I8ewZQNFmWO
 pKOV870qag9kpE2Kn+9B0Ax4wbw63+MnnRuEFuN6p8Be6JfX+Iu4ht9icak03t9AgDcME9k
 gZUu2nAKZPH9XoKpl0ZdO/Q22MrxUO7Wa2NmILO7vK1mo6fFNepir1IGIehwhbc3ZrWzfuV
 NCyF63H8lYsPlWZUEuIYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G6If/OXr+zs=:0htcCoSPuXLpBfzDWyFiz+
 DqEnCInI+YFdhYltV5A1s6VtccxVB2aXQqoCQHLYSBm78dndopN66WDnBRKZCR9QM8p/+jLud
 RZzNFjlOB64KE5wCRQC+e4X+QHGAuEsGyYvblI5pNSXeLe3PvPSnKqiJdQ/jscsEgaj4j3vt1
 dI/Z9irvzzC1iAi+/hlCEaYKnwmMY68w/VB0TwyIZ2OZfh6PN6+upxygr5Qsf5aomZWsVsZBe
 BIklhKSP7DZq0JKK78MQh/+CcSrEe6BAIDmK8TeQ6pLKS/ZVFJITL8wgA4GC2KixxdJN/ha4q
 Y8q7vs/chPqFKsNiHiNGeyxG96ZJBiTnjyDiwcrWDHZvu3vMvqDbnl/8o/I6eD4J1nqlPBERD
 E28TgNdOzabqxlPZVQuCf3htNr1TQjB6/OCXykrN4PNmijP9aIcdXNFnirhcqIm5/MQ5h9jpB
 TBMoAOPbL17jRj1/3sYx1Wq5B9O8JrgH4J1gIogbR5XoR6FSnUEM7aiZF9lt6YYt5WVDxC/7S
 kr0bEwHAyDN1NqLtTyXi/ktrFsWJblxPROj7S8npAUSh7oX6PluJEEFxRIg6dMW/+YceoTQlZ
 XHOb/dlyiRMEoCfKWfgyITyDW23OqkNvXXiK25oAlGSQnMkouoFiprS1Gs19+zKw+oymGrF45
 de7pSmuA5qqmMd46W5xMhsFErPLlmisk6HebqFb6rIMdKB57nagQdJ6Lv5qA77+mxHMrvS0e3
 eUQa9MpOdF/BztbdQc2eW1Z6lgPt15+rRXvmtJMoS4L8YnxNYv5bdTBsU3fD8Cw26WTQiAYyy
 OrGCPfHcD+Ulyy+OWHNfaVNtn18dVBkEwgsNtXOBNQsUpklZLU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 6 Apr 2018, Jeff King wrote:

> On Tue, Apr 03, 2018 at 06:28:42PM +0200, Johannes Schindelin wrote:
> 
> > While a neat theoretical construct, state machines are hard to read. In
> > this instance, it does not even make a whole lot of sense because we are
> > more interested in flags, anyway: has the section been seen? Has the key
> > been seen? Does the current section match the key we are looking for?
> > 
> > Besides, the state `SECTION_SEEN` was named in a misleading way: it did
> > not indicate that we saw the section matching the key we are looking
> > for, but it instead indicated that we are *currently* in that section.
> > 
> > Let's just replace the state machine logic by clear and obvious flags.
> > 
> > This will also make it easier to review the upcoming patches to use the
> > newly-introduced `event_fn` callback of the config parser.
> 
> I think this is probably a good direction. But one thing state machines
> can help with is keeping the state to a manageable size. With 3 bits of
> flags, we now have 8 possible states, up from the previous 4.
> 
> Clearly some of those are nonsensical (can you be in key_seen without
> section_seen? I'd think not), but it's up to the code to interpret and
> reset those manually.

That is true. On the other hand, it is easy to miss incorrect state
transitions in state machines (or to miss unused states).

> I'll defer to your judgement, though, on this making things for the
> future patches more readable. You spend a lot more time poking at it
> than I have.

The original reason to get rid of the state machine was: I did not need
the states any more in the end. Since the section name is set via the
event stream we now know in the config_fn whether we are in the correct
section or not.

I also liked the fact that it was much easier to reason about correct
code: "Did I catch all the states that apply here?" is a hairier question
than "Is this flag true?"

Thanks,
Dscho
