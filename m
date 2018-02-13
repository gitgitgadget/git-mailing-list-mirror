Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A779C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965586AbeBMSwm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:52:42 -0500
Received: from mout.web.de ([212.227.17.12]:38515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965457AbeBMSwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:52:41 -0500
Received: from [192.168.178.36] ([79.237.252.254]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvPJ-1enbVD2sY5-002ZuH; Tue, 13
 Feb 2018 19:52:34 +0100
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru
 to object store
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235508.216277-4-sbeller@google.com>
 <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
 <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
 <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de>
 <xmqqbmgtswuq.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8b8f6e8c-9077-793b-81d7-8769eee31e66@web.de>
Date:   Tue, 13 Feb 2018 19:52:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmgtswuq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iPMWXcbQ4s/scjpL8HFbAQE3dlk0X5ngZGn8gCxlsDX/oQ3JgTq
 /SVoqxktiPszqU26b+bCGyTxu037cn9feKVLSlG1VHnPCVr5WTgKCAQEwrHuS9Yga6xyFRE
 siqXUJ7WfxcpV7192tmPqe1ZNbXG48wab9QaIfpxYIeXk5ktA6g4mOCrh9okogxzNhTbi5C
 DYzLrUJsRC0MrbpyI5xzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3abT5cfUiJo=:BWUAvgCxFXmL+eDXXqDYaf
 Z6aMkz5sZQogMi7NviiDTIKT4PaVwt+Vbib++mfGDXMWsnMa4HNsMc6ZdORtOzMYUgKLyR0na
 +rcIP8YLY/Xk94iegNzMg/E63ZDmCaU3oRWHtkduud/zwVPwV9qNmzgG+W2KPtmUgIWHLsUtZ
 uqBTZmylDKvvyebLoi406eHOzKHMHg1aWL2Lp29BckSLQooMoi2IZKk22hFYptm+kFeFjUYaV
 txdRDODn7GLpsWSlYjZlXrTQg7L0ncdDgzS8AAUWKLk9HuktWt9s2hy0XwVlt2FqIDtDgD1kJ
 dl8yzRxw/mcmO+qvYHSXPjmBOC5VSrz0SQmUI9A2famZ93UjCzlQm818BoMpAebKfT+Rk1FZB
 mlM5n9dhRMj6D6jwX03mTuIWsYS6z4ZncFdz93jIM/aDBlV6A4sR9jB7h5nX0s29gdeh1bDLN
 to8uInziWK54QbEM8nSkRHgdOE93GNgNEd8aB0m9cG9us4NA/v/1e+uX7dSWHOt42MnmvoqwU
 pYHp0uLTI2g5g7B3SPPlJmXm/xhYUG+nsA/uqVL2D3RicaYhK99G9Y6ZVHltGobgVWOgkowgd
 Y3LiFYRVwCuFQxdLDSCP7IV3Qz17KvXlv9WOpSdvLNwRngpq4mhJgDM032mB6nHWhYGpeNNZz
 d9tXBEkRIRidcMnH78J1pWFfDy6g4AVgxy+aJ3jl0A+emIqGpTXwvULs7AU45hZSuP5zfk34u
 ATUnzp52+jWdLTyGRjqDkAqKt3UIXqN8p+cDYYrAhepAqPXIbhCPtTJmRAArpOijtgnhID4Za
 Zom2mB7NZrpiJiseLUo+RYwicjmkn6HQ30yA9VgnqvAGWUXdY0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2018 um 22:48 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 12.02.2018 um 22:04 schrieb Junio C Hamano:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> I thought it may be a helpful
>>>> for merging this series with the rest of the evolved code base which
>>>> may make use of one of the converted functions. So instead of fixing
>>>> that new instance manually, cocinelle could do that instead.
>>>
>>> Having the .cocci used for the conversion *somewhere* would indeed
>>> be helpful, as it allows me to (1) try reproducing this patch by
>>> somebody else using the file and following the steps in order to
>>> audit this patch and (2) catch new places that need to be migrated
>>> in in-flight topics.
>>>
>>> But placing it in contrib/coccinelle/ has other side effects.
>>
>> Running "make coccicheck" takes longer.  What other downsides are
>> there?
> 
> Once the global variable packed_git has been migrated out of
> existence, no new code that relies on it would be referring to that
> global variable.  If coccicheck finds something, the suggested rewrite
> would be turning an unrelated packed_git (which may not even be the
> right type) to a reference to a field in a global variable, that
> would certainly be wrong.

Ugh, yes.  The semantic patch in question doesn't contain any type
information.  I don't know how to match a variable by name *and* type.
Here's the closest I can come up with to a safe and complete
transformation, but it only handles assignments:

	@@
	struct packed_git *A;
	identifier B = packed_git;
	@@
	- A = B
	+ A = the_repository->objects.packed_git

Seeing the many for loops, I'm tempted to suggest adding a
for_each_packed_git macro to hide the global variable and thus reduce
the number of places to change at cutover.  Coccinelle doesn't seem
to like them, though.

A short semantic patch with a limited time of usefulness and possible
side-effects can easily be included in a commit message, of course..

René
