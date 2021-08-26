Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C0C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A616B60FD9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhHZSTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:19:51 -0400
Received: from mout.web.de ([212.227.15.3]:52851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243307AbhHZSTu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630001934;
        bh=yDqhA6G3Fb53POnrQfv71TbvlBOi7WVQoNnt3/82NGY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oqIG12RsCM1AZAv9xp209uXdeVLrL70aXo+2IO21VwdPH+kgWbqOua9NIsU6GSxda
         wneWtMDl/mqt7Z5uTD74NKKrUDv0kcX8YAmUXFYosY9wKjzgG7bIC2iUAQ10m+uumY
         lu6SL+s3Z6cErFAvgLYPWsTrIRG4H7mhHV6rCqgM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lu1Be-1mzV1s1K6g-011PKq; Thu, 26 Aug 2021 20:18:54 +0200
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
To:     Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <xmqqr1ehgq8t.fsf@gitster.g>
 <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f2511e9a-cc0f-20d0-d196-5dacdd637b7d@web.de>
Date:   Thu, 26 Aug 2021 20:18:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHXmGjLeOv/Sy7J6XDZM///MPilcGCRza1MVzjaX0EzaZO1HhtF
 D7SgIYy3R49w6b7ENWObxXdJSq3QOr+tXzSLVzb6Lh7uA2r3TqaKgSWW3AqEYOnrhydZjWr
 eLmRg5TlQ739UMHvJkJC3qjvyYMfvIoPs06qCprLzEO19dufV/i+h6d7fgsQsRr8+H02clJ
 JTzRPzU95dcDHGl/Q0fuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsBlnCL6RJs=:kRw2k1UujsvdUnfgsyQpjg
 LDpn7tEAgbuz9mVi/+JK7Ti9iplP50ysG6cpdG3TSjcWKo5dlcLt5bmn86cs7WB/V/t0gMBew
 yHtO8FiLF7PTmzWiqd4NMuHzGZ5QXF8KIPc7FMZOPzCqcEiFuTi7ZVbruwHszlNeay3psTTSN
 biF+mgluO5chHJsqDJAas+fBa0S7NnbbBpy03yl1QFFGo2r0rasHcvKKNnkA/o77M8bLgZ06u
 Rvixv/v+gpviEeq08OoWl+uwx+SLo7e0MVh+j6ylarwfMNdJ4zpD0lAscw8RAZAb+mHYYa/76
 DmeXQQvEeCr0hFn50tkK4WPQ5vK3IEIeBPFjYYAQlnUcLXTdm4MdTHSNHp7NkOvdmqgMWzlIh
 5MUumcbghRQnVHMuB0Q/8NHGmvC2rva1CeaaYdHNAQQbhZ0f7PkPeL/ebqxx7NY3bPRJJA9iJ
 QRwO6anray9slbI4e/G1MxtKjciCaflrd+Y5Nm/lpLCaEvoigX+2yjBauWwWGFVxXeOmf0Cm8
 rl7xUyqSc/3ZLi2P9xjktwmzsjj2fCCiHu8jOm59UI7SHX8MVtp+zIF6AM9RvyI+zAo3cPv8N
 W2jJNqnE/j0p38bFYaY5u1m6tkNHhLX4R8VgKy9F0qukMdCwAdICe37KcT+2M9dT+BFN3GDFT
 ji408HRqf/VoQsH2Ta0vMCzescPmL+a5UA6R9NRXFfMDmQpUSJNDYVo2Kuz5GrhmgJ1x+5iwW
 GC4un3JUOaTsxe4xk1nPZqDAhK9d4qpLMujVtdQHoCMJCroWefjNy9xozSpUqPPNS+bCLft0B
 K4vIyjN8IDu03pqtLzOpgMZWSVHzreDLMO+6uFf2gC3Ag1pD5PjRC1U3ycbNdZ0qKkKT2dJe7
 kdEKJJME0XzNY80ktXahkPJDE2YYtPK3aIyQiaLuVEVDx9cR8/eh7OVfKs9cb/h09c8zViBz9
 6TjWS+9zU/Scs/yHmjtQ1N78VdTi65Al1Udvg0KfyST5kU87U06MW1B/wNtbOpPXOwxH299xX
 504ngj0IP1p4f2G9oE7wCjS4ySUqNH8iJmhgCDRQcXpPb6Y4kcgc3zaXjpUUJ22mRPGSQyUpb
 axq173K67z2N/HSa7eQ+D1igzpIdv2v5TKs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.21 um 09:26 schrieb Han-Wen Nienhuys:
> On Wed, Aug 25, 2021 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>
>>> +test_expect_success 'branch --delete --force removes dangling branch'=
 '
>>> +     test_when_finished "rm -f .git/refs/heads/dangling" &&
>>> +     echo $ZERO_OID >.git/refs/heads/dangling &&
>>> +     git branch --delete --force dangling &&
>>> +     test_path_is_missing .git/refs/heads/dangling
>>> +'
>>
>> This goes against the spirit of the series merged at c9780bb2 (Merge
>> branch 'hn/prep-tests-for-reftable', 2021-07-13).

I assume the file backend won't go away anytime soon.  So I guess the
idea is that the test suite is supposed to be run with the new backend
as default and exercise it?

>> Can we creat the dangling ref and test the lack of "dangling" ref in
>> the end in a less transparent way?
>
> agreed. Try the ref-store test-helper's update-ref command?

It requires the new hash to refer to an existing object, so we can't
use it in this test.

Ren=C3=A9
