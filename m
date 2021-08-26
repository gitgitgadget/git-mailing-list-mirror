Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B0160FD8
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbhHZSTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:19:55 -0400
Received: from mout.web.de ([212.227.15.3]:59311 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243307AbhHZSTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630001941;
        bh=ACVzUCQC2zkl2T8RI6nj0OmLex+apAGI8BX/3KvzICk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WwbuF5+/2LYzURdSA4fe+jAk8Ex4ObRqtHRNOwHuXHyiAZFf42kNu5awU0QlVYO5R
         F2zNIrC6adhMJLmb9MI1bYigch+gDRt6SjM0TCCoarAmn4rye53ZC3geMT8LgTMnPp
         xrkP6iItSlN50CaycXxwaIO1uoYElasQB56uV/jE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LlnQO-1msNjY3liq-00ZMGM; Thu, 26 Aug 2021 20:19:00 +0200
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <xmqqr1ehgq8t.fsf@gitster.g> <87h7fdcdc7.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <611b4216-7650-f4c2-ba46-0ddd98d5d7e5@web.de>
Date:   Thu, 26 Aug 2021 20:19:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87h7fdcdc7.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DFrRCYp7XXpDhKBO31b74Fuj/rYn9WnKK5s70333u1lxnWeyrCl
 MScOLapMQUic0SAqxux1WRomdpEooI7DIQvYJGsJmyuk6XUCDJVL7HQX72Oj3nlLYaK9Jrc
 Y+MgBmFme6ShLU+eyR8CsVDhqHGVPTSGDrU6WK2vse+MtbmyHGza83z5T5cFeD5WRF9EL6x
 4/PnedVyx3ed4Xkwl+FvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ic4e3CAFxaw=:PSEMY0Itma294ZRP73EmPH
 ckA+2LZNT4cXwwIeqvCEjZ7mCweBkVIBPzwcDAr7zYayw7rN47CksINQqV2ZdYyaGXpTVeWNK
 ZbZ9rtI5w/CFPaEd4babg+NXi+VrK8QcGQZ/Sf/3LjEKMZ+VMUciF3sUyiAE+d7cqJPFX5jzM
 2kajYg0qsnbE5oapFV8BiWCktmzgv8cjmoVFOohUXwr5nuThs1A1KoWcV2rJzTT6YQtLoYKjE
 5+aFp3DDFyG8ix3ALxw44csOtVXqRS1/ykj8HNxf6yEUuxL1YwylrrQ/nYBNBlEoMo/Lk1ie8
 GTTBBCRx+p4TnjzVIxYyjOZCy1f6UBfRzLgBwx0ZlZqyEA8mbS66O5qSRo4O1+fZFzYtemqln
 Mn7hzHV2ROi5VkDpnSa3w29qziOZW4X/geMZr7P6bdTTxVMl66dTR+LQI8M6lmjFXvTR6x3+4
 na6zrXWakyprXrJpz27zvCsR1my5oDRgwmd1BIF5JQzD6GbSDbrBqgTh6h2KDOuX2J1ILZG+U
 1QphI0VT5JhJ/AbIp3ATjsZbmfCVMyczLwwGkb0b9x+YHf4eOXrOZxHXtr9K6HIniv1QhHBKR
 A7AjmOvIV6dMoKifdL28aBXvJPT+9DruNnBCOODog78zrEhYrt7BMNDXhfGnX6iZ0NRDDI2hn
 c5dJOXwwH56wFbWvP1OmRexNxL3pjbH01/JDOwVHyHMKqVEfyJPVHN8FWS1TTebcGaLrlXhhn
 iy7erlkU1pgsITgjnH+DwWVTPZAn4uXdqDzJUJMuOGIEg1XMUfvEYLaGzOJGa73BgWID9JrQg
 V/4iAmY1RcLVHpeeJgN9J9vXCHMFcbfVduBsX07TVVJFTsmCXm0xOqIunt5ovj/u9o6gVMgQL
 3nkkzOO/hkuhaKhl8DvnkgssI3RR7PKYYdtFQx0HNel7BVVYknh1QbLvxvYduk9tOVmblHAh8
 iIcGVqCqN63UFUKKlyI86HY3IEUzPtrEMg0MgzoPk3UlrCrs5wFXJQvyXgp30YsK36LPRMOsq
 ZSRKgmK4+m57/M/cWVvPo6RdpSWx5PT8kPrYLF8x7bf718C0w7UKGNhzH37FxPdzPNL6Jsut2
 nzIH6TrxiGIgm1sQ1PDqwN/rjMeFmNXd9e7
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.21 um 01:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Wed, Aug 25 2021, Junio C Hamano wrote:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> git branch only allows deleting branches that point to valid commits.
>>> Skip that check if --force is given, as the caller is indicating with
>>> it that they know what they are doing and accept the consequences.
>>> This allows deleting dangling branches, which previously had to be
>>> reset to a valid start-point using --force first.
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>> Original submission:
>>> http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.d=
e/
>>
>> Thanks.
>>
>>> +test_expect_success 'branch --delete --force removes dangling branch'=
 '
>>> +	test_when_finished "rm -f .git/refs/heads/dangling" &&
>>> +	echo $ZERO_OID >.git/refs/heads/dangling &&
>>> +	git branch --delete --force dangling &&
>>> +	test_path_is_missing .git/refs/heads/dangling
>>> +'
>>
>> This goes against the spirit of the series merged at c9780bb2 (Merge
>> branch 'hn/prep-tests-for-reftable', 2021-07-13).
>>
>> Can we creat the dangling ref and test the lack of "dangling" ref in
>> the end in a less transparent way?
>>
>> An escape hatch is to make this test depend on the REFFILES
>> prerequisite, just like dc474899 (t4202: mark bogus head hash test
>> with REFFILES, 2021-05-31) did, which may be more appropriate.
>
> I'm not sure, but this may also be a good example of the sort of thing
> that we should probably go beyond REFFILES with, i.e. is it even
> possible under reftable to run into this sort of situation?

Probably yes: A commit can disappear when its object file or pack or
alternate object database gets lost somehow, and a ref store could
only compensate for that loss if it kept a copy of the ref target,
which seems impractical.

Ren=C3=A9
