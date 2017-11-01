Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96858202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933461AbdKAWkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:40:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:63479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933449AbdKAWkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:40:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRoyH-1dheuf2LH7-00SsDP; Wed, 01
 Nov 2017 23:39:56 +0100
Date:   Wed, 1 Nov 2017 23:39:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
In-Reply-To: <CAGZ79kbYshVjUh2XhbLHtYmnRuFaCmuWZJZd7HifKAqJbNBPfw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012337270.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
 <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com> <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com> <alpine.DEB.2.21.1.1711012307060.6482@virtualbox>
 <CAGZ79kbYshVjUh2XhbLHtYmnRuFaCmuWZJZd7HifKAqJbNBPfw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zBMlKYm4KdVXJ95geDVhESSAgOu1hG4eimFmJp0rmNWvQK5FRV9
 EBg1+GbdEN/m/k15D8kqDCZbUXgcbf5pPYVx9Du/UBqfqS87OnvZSUeh1cOibaeDqreZX+E
 eQBqBxe8eguawV0MCM9QggM7msNS1PhudwNIg4bUKIy8KKS32UFx4qesjyVXl2GYDh8uum8
 Nk+693Zb0fMZ3EnP2r1vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rz7lL3BE96U=:kYrdUZG3PQ+UJ/hOo61feE
 z9kDSRXx29IrHOZaWOXmRfr3MDZnlwQ5DYQn1nEgek/6/VP5AioecAjgIKAUei22/Af/bs1E8
 FZA5pu4FsKl43HrtplqPaLmaFHGd7POye+S4bnvc+DvF332CSgBEZZOS5TlUP4oawX/Z6ogWx
 yyfpq+JzWkjOUc+udpYawXyHgWcJ1dWW3aHt2ddUggMVS7LGDYZVulUQdfh5lFPfBPp07jvFC
 3sXMf34ogKa3ILTPNe4ghSLVItD7Vs1JbBWCQR2zJc1rnOvWCd03cY5yuVptPzNl9qlMGH5Ht
 K7n64UYSqU5s0ood5Vr4je7/gumnEioGjmnCTR6FHmYH+oRms4vypH5o/clFKDKhjBDTVXQ5o
 zoy7WdoQI3Sp3A2S5ltkLxQWhYz2qKmMaXnYkHA/D4cnr93e1cxrXUsbW6GwoGC+zi0JSklKL
 JzJ+QcjZT2et0tN+F37WqCq8KJ4IeMj4+LNU0UoMRC9i9HnuDynQZnpAUW6p6ur9ctR4bcXqL
 XwVKBxgY2EEZ9LdZV/SW1xEnPXBha+5JD+9Ou5RHnwa0r4Ebl2930GtmJxzDK9fay/oplBY8Q
 GG3NvzYjEKe9RwjJXe7/WN4mT/eeMJp6BfS7ff/Nou1kwdhQJrKlH14zYnMXUrmtUtGgtCQE0
 XYSJqEG3X/XwQ10FFvS3nNjhV69dfA41cORDoVD+gyOP27OebJwhN61q6sQ3QQg//jc16jF5T
 Tzk/0IcLQy3+hK4EufcBeOWbk9LMETwAJw7dwFZPLBaJOS4YIwDwcqkLQlC8Yvx5jnijSrJLo
 p2rHBOt+r6n7Ul2Qj8aaH900I/3lDSXE2qERTZdmtzZckke6zQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 1 Nov 2017, Stefan Beller wrote:

> We do not care about the internal state, aborting early, we rather
> care only if the whole loop body was executed. Running the test
> 
>     test_expect_success 'witty title' '
>         for a in 1 2 3; do echo $a && false; done && echo done
>     '
> 
> not ok 1 - witty title
> 
> That is all we want to care about here?

We care about the loop body being executed successfully *each time*. A
better counter example:

$ for a in 1 2 3; do echo $a && test 2 != $a || false; done && echo done
1
2
3
done

(even if the second of three runs failed)

Ciao,
Dscho
