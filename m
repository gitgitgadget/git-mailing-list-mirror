Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0EC20986
	for <e@80x24.org>; Fri,  7 Oct 2016 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756513AbcJGN1G (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 09:27:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59055 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756504AbcJGN1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 09:27:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u97ClKdV016266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 7 Oct 2016 14:47:35 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u97ClLbl010625;
        Fri, 7 Oct 2016 14:47:21 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <20161006114124.4966-1-pclouds@gmail.com>
        <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610071319520.35196@virtualbox>
        <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
Date:   Fri, 07 Oct 2016 14:47:21 +0200
In-Reply-To: <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 7 Oct 2016 19:27:53 +0700")
Message-ID: <vpqmvig5ns6.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u97ClKdV016266
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476449276.29555@h0FtlsM2x/NnjrNO7edwBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Junio,
>>
>> On Thu, 6 Oct 2016, Junio C Hamano wrote:
>>
>>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>>
>>> > Throwing something at the mailing list to see if anybody is
>>> > interested.
>>> >
>>> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could
>>> > make
>>> > handling path arguments hard because they are relative to the
>>> > original
>>> > cwd. We set GIT_PREFIX to work around it, but I still think it's
>>> > more
>>> > natural to keep cwd where it is.
>>> >
>>> > We have a way to do that now after 441981b (git: simplify
>>> > environment
>>> > save/restore logic - 2016-01-26). It's just a matter of choosing
>>> > the
>>> > right syntax. I'm going with '!!'. I'm not very happy with it.
>>> > But I
>>> > do like this type of alias.
>>>
>>> I do not know why you are not happy with the syntax, but I
>>> personally think it brilliant, both the idea and the preliminary
>>> clean-up that made this possible with a simple patch like this.
>>
>> I guess he is not happy with it because "!!" is quite unintuitive a
>> construct. I know that *I* would have been puzzled by it, asking
>> "What the
>> heck does this do?".
>
> Yep. And I wouldn't want to set a tradition for the next alias type
> '!!!'. There's no good choice to represent a new alias type with a
> leading symbol. This just occurred to me, however, what do you think
> about a new config group for it? With can have something like
> externalAlias.* (or some other name) that lives in parallel with
> alias.*. Then we don't need '!' (or '!!') at all.

Another possibility: !(nocd), which leaves room
for !(keyword1,keyword2,...) if needed later. Also, it is consistent
with the :(word) syntax of pathspecs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
