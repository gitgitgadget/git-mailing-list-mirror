Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF775C43216
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C7363272
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhHPMlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:41:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:39015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhHPMkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 08:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629117591;
        bh=dE+7NivS/lCSBN+giBRF28soO8UkDkpcQAjwRtsk71Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b6zADwQG1wY3CR0nkx7Mm1UskzaX5iDsxfng2HmanZlWwx0bciJQU03uGiIMGj5o5
         bDm+wsIbT2/2aByJVKwGqItBFVsctbo2q0YHl8upVnOOowRRJSPjw4TR5Iy+S8Nn5f
         lGmxKvW9sug3Gfj1a1kGyatzCC/WvZx5NfWoG9Vs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1mYVpj34sv-00J3o5; Mon, 16
 Aug 2021 14:39:50 +0200
Date:   Mon, 16 Aug 2021 14:39:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kim Altintop <kim@eagain.st>
cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/3] upload-pack: treat want-ref relative to
 namespace
In-Reply-To: <20210815213453.GB10013@schmidt.localdomain>
Message-ID: <nycvar.QRO.7.76.6.2108161431500.55@tvgsbejvaqbjf.bet>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210813062237.10403-1-kim@eagain.st>
 <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet> <20210815213453.GB10013@schmidt.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s9DiZ8ktHvG8eu3P0UzD2BP/OiCsDEsHOsL7mZBHsQbxKvPgDgd
 rTMpSeYE7dhpoAtzg9BV2qYt8pCA/bJD3FDOaf3wm0liCHO4IscLn+rMa9fucmgvEPq/iiV
 YS5tVg2yNtt55lTp6LGA7kgFGZgCdk1Mmll08sWC2BjzxRrmagBCo7vOBKNj3v+FQQBaGhM
 xSVD5GKBpsKQPLCBYsZkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YKgmAOQSPis=:g8cyhhJf8qggRObXej0LKL
 CzSoOcqHqxNEqRrBykxV676Yd5ilu4C9S3JFjP4UNfSLI5ADC2WPlWkxjCuxpO3pY5huxzNfH
 CG7oaq6vynwQchJaKEghbYipcU7wdtSyc3A4VBOyUTC2uxEJT2Tf8SSltzmJhDRV3ow+eZdfI
 r4KJbT0kuEzlAgcpfBDWVGjvnsbQEAyjqwWBxeCcZiqNV62CSkNRW1+hwp8b8wQkUYOW5JcUU
 mxIesx87dKbce2Q6/1G2R5TlyUyN24i2zqq6sWJVv0dW+i+k78+6KUBbM303RqOG4pEEjo1wi
 n2n8k6mEOhbFZdulq85t1AS4dnfObIbP9H9/i8FkeSHHwSAcIowebnHev+CoyzGKTx0WSpOJq
 oSGoVkqk3ctd6hyfez53q0mYdXA7QLLrATHDrXJ4icNXnHFfJv7zXUA/wpM20U6dwmVTFxfU1
 EnXaeOR4HBsE8xhBJbTknNRqLMFbUoj+oPb8kJrg0i+1bOSEj8Z5tjPZfsnsZIY6sHRh6iggq
 p3h8dc6tqE0yFUpxUqAKdjSSEWG11bMmz8VbUeYCdVKfEniMLp+DOaLfrSQGJiwAaVAD0GFMt
 JzpDg9HKyBzRzmBHMBv/2MByr92F8V7zjwVoMQ5akfj1FDu+0fqErnsOJ5GkOHRjl7m+z+f/l
 aJrFZ/GjnJt8q6mMsmkGlAXhG1/OE5ETIeviMmgI5K7iMJlmj2sTNRM1ndinnfN6W+BK7GsR4
 wBH3s0bQDwefhOgwqBf1U4qkMyUG8jsiZPYDlcfYj0ej0WX+RtbEgWHoSs9H+0KZS/UGbBbpC
 8qeSvOmph7KjWBIf44zdaGXoBqCcrmZAH663G0dMby+jeuXDsJNDaiX04jd7dU5yPAvpJ0Ddl
 zKgWYnwSRwKQHIEFGpOfsy4JBu3Go35270anykZGYZiRjYsvU6omERLp4tSX7CgTPq3oIVk9L
 peKJ9A64v9eCpXtnnw8AM774ptMM/hIvwKWe7PhaSx3kxksbdo07szuL3js4fuXYxg6jAv75i
 /2cpVvKunqNSpI6MSUVLujA8Tad7/PfwKMCmvA573dAH7xuV9Ebhi5X4P8jTOvctM3E+qFSMP
 +WMe7R3LFecpDdhFa3juGxmmlAfrdSxGlGSv0entFyyjCkL6bBsMr+67Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Sun, 15 Aug 2021, Kim Altintop wrote:

> On Sat, 14 Aug 2021 Johannes Schindelin wrote:
>
> > My only comment is that I would find the diff to `upload-pack.c` much
> > easier to parse if the `arg` variable hadn't been renamed.
>
> Can you explain why?

Yes. I prefer patches to be really obvious. That way, it is really easy to
spot bugs.

In this instance, the same patch that introduces a conditional block
_also_ renames an involved variable.

To satisfy myself that the patch does what is intended, I therefore have
to virtually split the patch into the rename part and the
added-conditional-block part.

It would be easier for me if the modifications were presented as two
separate patches. And I could imagine that I am not alone in this: you
yourself might also have an easier time looking at the commits in six
months from now if those concerns are separated into their own commit.

> Just because the diff would be smaller? I can see that in a larger patch
> it might have been preferable to put the rename into a separate commit,
> but in a hunk-sized change it seemed fine. It is also that this
> particular naming ("refname_nons") is used in other places in
> upload-pack.c, so it seemed obvious that, if I introduce namespace
> handling where it was previously missing, the terminology (if you will)
> should be the same.
>
> From you comment, it seems like the proposer of a patch should assume
> that the reviewers only look at the diff as sent in the email, and not
> any context. Junio's response suggests something else, but I guess it's
> fair that if someone feels like they got CC'ed by mistake, they're not
> going to spend too much time.

In this instance, I indeed did not spend more time than on reviewing the
patch, simply because I am (currently, at least) not all that familiar
with the `upload-pack.c` machinery. I probably touched it in the past, but
for the moment, all I can comment on is the shape of the patch series,
which is what I did.

> So my question from above stands: are there better ways to find the
> right people to CC, especially for newbies?

When I look for reviewers in projects other than the ones where I know the
usual reviewers' special areas of interest, I like to pick a function at
the center of my contribution, then look at `git log -L
:<function>:<file>` and try to figure out who was the last person to
implement non-stylistic changes on that function. This has worked
relatively well for me, in the past. Maybe it can help you here, too?

Ciao,
Dscho
