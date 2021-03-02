Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51286C43381
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032A264EDB
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhCCGcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:32:00 -0500
Received: from mout.web.de ([212.227.15.14]:60907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448985AbhCBQD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 11:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614700835;
        bh=TYJ1tmTOn+tG0l26OxTBkqD5RaiAaH/v/451I/flxJ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Btyr49InHYu8aMVCotKyZv/nrI8FoICkdC9IInNl2dSEfVCTGSE/4Veab/5IH2yYU
         7tZkL3AyLOK9v3MLTq6E9nCggC52lLkFBM59h5d+NfSWBbR4BDvX7rnbcFvFLnTfWo
         NRt6rc43a0ekfmgZRpHHhQGjiMmhmkWVGe6/STS0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MJpnI-1lG1WJ2d1w-001DiQ; Tue, 02 Mar 2021 17:00:35 +0100
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eli Schwartz <eschwartz@archlinux.org>,
        git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
 <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
 <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
 <xmqqy2f6rc8f.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <3be35be6-66f7-9191-1c9f-1b279ca760f9@web.de>
Date:   Tue, 2 Mar 2021 17:00:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqy2f6rc8f.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sgPQx7wa3tpysH6TcmGk956mfcTQ1A/pmdc5sx/7rL4b3jmmVN+
 PokzYyJXxSDSzInuaOU14tWUQ6HVhtVYB5VwOwUuZpHDMy2dW38uwo1amrwNQW07I51HnmX
 1OwA+0ic2Ml55F5KAoVvwrzQcO+sJ4icNnHzb4yRsetMei7DtI3t8t/b7BMx3XIIoC35xnF
 H8rwziplvkMDdVZzYl+FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBMx3341tsw=:lTAzpqQm2moeFlnK3Qv5JJ
 MZ/+JiEqgchnUr5eAdHSD6Tng6x6so6JmHmmRXSAI8WCywpedWJsPwEk1WdqLSvr3ltcdkedc
 iO/hVrGhInHH4tOY1HZdgSJ+cM4u2ktXKlF/sWC5Q2QPuFE21JnfNP2m5jiASQ/d2vH5uMSq/
 XJrbsosP8x8vEAwA2tZXAaJ2Gy3j+R1TLun/01FSUFLRpKjpgGwu5lCVALFqfhlWbipopQic9
 uKlc6Jm/dvD2ARDhp0FuUeqPK7yNuV88n86WfOf2pmDuJu5QUsVreWftCoZiwT0DwLNAY7/o7
 ooYUtJIvrCFQPyPzS8+g6iBhveyhFrS11qqr+/cEh1WZm4/P6X5YyCoeStgXWs4Hl7WKLLjos
 HxiLyZNSfCXYTX947VzGHNRdv9W+b/WtK2LVKjqnCWfZh3gPf1LFkSUrFOsDDloDeShBd2Ukn
 nVqiCwcJOAMAh6kNeCTDKRfsvPonpIVyPXTN4l1IAw4Nc+98tTsRkOvsOadkbU25YQJ6BMXyn
 8S7qIW+MijFOgb6GRlEpPnUOLhP1o+Yyjs247+gQVByZ6aGUOR1WrzTz5NESlXL8Y5C3KpF84
 C2lqJbbAyab88OihXPdmk669Pmc4oUN/1n0vxWEd0zKspJIL2UDcqyRjWqhr0ONjX3UO3WoNF
 Rb/5CIa/G6YJvwrXg1GG2rj/HHNq/hbWf5iK7J6BCYprdwD3ZpSns/wVNgaNoF+yEuFqnMyeM
 adQ6SxCXTgH5wPWYh/yJloXWMinELvN/cNjkifrsMBcc2chmE9VyTRV9rcuY5+svrtk5vAkVv
 pCo8iiQW00yzgfm0gV2tsuoq72wDBg+6cWvuspPHtJPXVdkWoFJFdu1anPYfBa4sTGPJSgLWQ
 Uqz14QeYhxuKflE3TmSQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.21 um 18:54 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
>> Am 17.02.21 um 19:31 schrieb Jeff King:
>>> On Sun, Feb 14, 2021 at 11:10:57AM +0100, Ren=C3=A9 Scharfe. wrote:
>>>
>>>> Allow restricting the tags used by the placeholder %(describe) with t=
he
>>>> options match and exclude.  E.g. the following command describes the
>>>> current commit using official version tags, without those for release
>>>> candidates:
>>>>
>>>>    $ git log -1 --format=3D'%(describe:match=3Dv[0-9]*,exclude=3D*rc*=
)'
>>>
>>> An interesting side effect of this series is that it allows remote use=
rs
>>> asking for archives to fill in this data, too (by using export-subst
>>> placeholders). That includes servers allowing "git archive --remote",
>>> but also services like GitHub that will run git-archive on behalf of
>>> clients.
>>>
>>> I wonder what avenues for mischief this provides. Certainly using extr=
a
>>> CPU to run git-describe.
>>
>> A repository can contain millions of files, each file can contain
>> millions of $Format:...$ sequences and each of them can contain million=
s
>> of %(describe) placeholders.  Each of them could have different match o=
r
>> exclude args to prevent caching.  Allowing a single request to cause
>> trillions of calls of git describe sounds excessive.  Let's limit this.
>
> An invocation of "git archive" would have to deal with a single
> commit, no?  I wonder if it is a more fruitful direction to go to
> teach format_subst() to "cache" the mapping from <placeholders> to
> <resulting-string> and reuse.

Yes, git archive only works on a single commit.  Caching cannot help
against a DoS attack using describe placeholders with different match
or exclude arguments.

Ren=C3=A9
