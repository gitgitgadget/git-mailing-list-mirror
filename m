Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740641F790
	for <e@80x24.org>; Tue,  2 May 2017 14:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdEBOBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 10:01:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:59847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdEBOBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 10:01:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMShK-1d9OuR28je-008I8o; Tue, 02
 May 2017 16:00:45 +0200
Date:   Tue, 2 May 2017 16:00:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 23/25] name-rev: avoid leaking memory in the `deref`
 case
In-Reply-To: <xmqq8tmfexg6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021433060.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de> <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de> <xmqqd1bsdjmw.fsf@gitster.mtv.corp.google.com>
 <xmqq8tmfexg6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7pZN18hggw7b9NHkhHLznDpuPmYwfI8UwKfPWoa2u36/1mOiq2o
 c4PzLbOyGYEmUlg9fTRzsJOjc0nT5bHi2dki+PLEYa6MQaKr0l2IB5pV8t7bAsUHK7iBu/O
 6+sAnyTHk+Sib6FobUb87Iins07VbCEop5RlSWuBqKdaNObhhsQR6QEubCudKFHmXPqrSCQ
 EROEZbQIFVD0AChHIjCcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QFDdlcepWFs=:4bjE8yBOER6e+F2FD/E9YS
 4QdKALvyhknCQAoeqXm8tqmF0vQjlMtxmRS/5pw7avC8SFINLapo/jRkxzgLuwnpNyzlk1tSd
 7l2KLCT+pVGx9sTcdquwEvJ+mrbTZMlKRwow4pEoPHIZMCkcnEBUX0nwtF5CHVTwdsvgUhvuY
 OAxySlA6x6Dpbg+mX+zi3ikuoW2vZwe5WjB7X4MXb8bZ5pHFtqxUvjOsySBSsUza7i/lvlvIS
 4ggJ5XHbFdI6QoaYRWh7dnC6lF9kqJIt58Y8TRHUsMjf7hNJXybYMlFbjVK05/Vn0TnlIrsAh
 eMwCf7R8CIv0jkhCtJsmtYU4kLC+zG2FpFKhTw0WAAx037HfcsBLCfPOrenMQg7K+F9Mkpopw
 NX27mmfPhhbUI9oLoDpJoQ0q2UCiHV8Augw1iBNYNrYa7ldqRDRJufvNodB2SK7i+Pd+Kcfhs
 sXPLpyo19yuv19vYblW2d+LgedYJV061kw3fXj+SQfR4sUKXeo0rn3PdYr4pEMo8UFzpbViRv
 WcjnBmy2bOeb5wavmVoPTqXMpf3u6L3YZLLjVZcshBFxO+VlGkqzScwzLU4eEOPLO3Peiaj9v
 Nfj5W5uXSrHStddka075P0e/NkIVoKoFi/0EijbtQxU25jcNZDqd+QcKJGQYHoaYx8GiUqfPY
 cvD++ezzreE/UL3fdF0dG4nKi/Tq+WLFk9NkP9Z5f/0sufl0Ma94ixK/MAGYYN6tmS6ZCpAtQ
 lfGxWVOQ1y7LTWdD0P7+QTKjNGNHZcCB4atBg9nq9DXfpK0E2QvlVEdXE3CNsg7rBdOCJrKaj
 V+104Zj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 May 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> >> index 92a5d8a5d26..a4ce73fb1e9 100644
> >> --- a/builtin/name-rev.c
> >> +++ b/builtin/name-rev.c
> >> @@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
> >>  	struct rev_name *name = (struct rev_name *)commit->util;
> >>  	struct commit_list *parents;
> >>  	int parent_number = 1;
> >> +	char *p = NULL;
> >>  
> >>  	parse_commit(commit);
> >>  
> >> @@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
> >>  		return;
> >>  
> >>  	if (deref) {
> >> -		tip_name = xstrfmt("%s^0", tip_name);
> >> +		tip_name = p = xstrfmt("%s^0", tip_name);
> 
> I'll rename 'p' to 'to_free' while queuing, though.  Without a
> descriptive name, it was confusing to view while resolving conflicts
> with another in-flight topic.

Good point. I also used `p` in builtin/mktree.c and setup.c. While you
seem to have renamed it in builtin/mktree.c, I think setup.c also needs
the same fixup.

Ciao,
Dscho
