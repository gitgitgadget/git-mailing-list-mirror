Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0298C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 16:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjADQge (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbjADQgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 11:36:25 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7015FDE
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672850172; bh=q3wqtDe0qMLVqYWWznA1Tq8Sep1/k5nrrhkaSwJUAic=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i1jtnuW6MuJfzpDewmkRBoJkD6gYOMltPGCLyvbmh9Kh8a1/dn90E3A2csOnQ2CDE
         FVwNxsiCHbkd/XJLnfa7u+boFC2TxVtNeAnb0r/MyryskCrxtOgWsPbkD4eqXcnxCl
         /Q5G85bHVlzKH3QlNF7AI9paZkHYs+fObL/u4/ktsL2+wUV04VNau8f6dfd9/05rNK
         73y1jPpQwmh2zLAcriY3Fx4Ql/L2yB+IIhwMMjYSgB0jM9LqMxwq+kHa0xzEeYYSns
         XDPwIQw6odQwZRccsyuwumAMp4oSKlx8mQHRKKFzsn3JU514PG3WTsKVdtypyBvrPY
         Wz4qfN7B6bJbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1olVfc2CJg-01108e; Wed, 04
 Jan 2023 17:36:12 +0100
Message-ID: <07b8e696-2736-142e-1937-7e60636de5f4@web.de>
Date:   Wed, 4 Jan 2023 17:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-4-gitster@pobox.com>
 <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
 <Y7Ury+2n77XBzNl+@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y7Ury+2n77XBzNl+@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ftpL44VWWAYJx3p63gKt7Q9ZNzZm31xLYimMj9qsF2EWTfvpR1S
 9NxpRmhM6CV3VT6sBD+ZXYe8ZaxdMyZ5i911I7M+7EARs+8HZFVTsye+LmA7n9hTU/5+IEw
 DMkqN9enTCCO4xXSaf2qLspdm0mL0Ai8xvbmtx7AwnRTJUX/ghbICbIVup/euOl8KITcGgv
 6q9fyijhq7TXx1XOkSObQ==
UI-OutboundReport: notjunk:1;M01:P0:t3QBdoyPHNA=;yq/rdjHSitIlx05nbfFEUqOy8Rj
 5AYmW93A2i0do7bH9X/afFQpJnQrHG/QSn9dke16LirWBUAcWVr28u8JgLfhpMDP3Y2Q4GmAI
 D8Hba1sbPDCQiHKWiLdBBPI8bHnFVnw0Kp28j8/jIXxtey7oN08+JDO2bTSg5ZlsQlY6DCQbh
 Y0/FsXtWsVJwb3t+mrtXJvbL/c0tM7l3M7sz4j06/sFvTyS8WYlqUEGLIEmNfObYzp94ndEvl
 sZ3Dy4QNUyVO70m4PM3pdCTB6T5UaPxcgNdQcnUYrBte4Hnexxa34nmQLHsWUTdtjUO9r3Obv
 lHdb/8HhGaIhczWwtjsODmDHHKRG9Rz6VVzIwGe0TtgrqYzi3b3YKl+dQuzKNh2GXIVfig+Mc
 xsPxJnQRqop57KHd3ewx/iF8zd3M2W8caCH07rcbQIlS9BQAIwmfcaevjdzYbAnrEbpoghQQC
 HViZAyTUD185Oh3vTqhCasUKktDjqicyxazZxNO6ffb/eWvU8b7h0JfK+y6p52ZeQdjRjUx1G
 0SIygKwbIRcoB1wMgAfPzGGiI7bwRKjaku88b32eLAAbhMqWlwtHZ/0KePepF2bubaAiCRYFU
 YdXrKfkYoE14VdYcMKH988kkPt/PvxBFqzt35NRljEDZUEH/u4WglFF9W29Jc7izUwg1F/tUP
 QPVjA7C9d8ipDdwNhmOfvRMg1eChU+OMK7Ry6gqs+v2vxPJfBZrAM0LVTlxXt69MEgckg0SHP
 Abz21mzyEaCXZOQRl4tvhD2HAY1dOo2a8ldSFipDWhThhEN4GoI571IKQab0BPHohvvBuKOQD
 JemCK2ehfVxxLlQiLWM0mdOgaVmOqD8zdYoeRHGLKk5eNYRNupwhxYizRm7hBqosZMv6iIupJ
 PmtkAV9Bry/3waJ9dAavfuclqukp4BvQ2tsb020SOXNrGeJ0VPz8+rk+Dcbw+ElAVc/DEpbtr
 TitWYQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.01.23 um 08:33 schrieb Jeff King:
> On Tue, Jan 03, 2023 at 06:18:32PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>                        before                  with this patch
>> ---------------------- ----------------------- -----------------------
>> (unset)                if stdin is not a file  if stdin is not a file
>> GIT_FLUSH=3D             no                      no
>> GIT_FLUSH=3D0            no                      no
>> GIT_FLUSH=3D1	       yes                     yes
>> GIT_FLUSH=3Dfalse        no                      no
>> GIT_FLUSH=3Dtrue         no                      yes
>> GIT_FLUSH=3Dbogus        no                      if stdin is not a file
>> GIT_FLUSH=3D10000000000  yes                     if stdin is not a file
>
> These last two are unlike most of our other boolean variables, where we
> complain about bad values:
>
>   $ GIT_TEST_ASSUME_DIFFERENT_OWNER=3Dbogus git rev-parse
>   fatal: bad boolean config value 'bogus' for 'GIT_TEST_ASSUME_DIFFERENT=
_OWNER'
>
>   $ GIT_LITERAL_PATHSPECS=3D10000000000 git rev-list HEAD -- foo
>   fatal: bad boolean config value '10000000000' for 'GIT_LITERAL_PATHSPE=
CS'
>
>> This implementation ignores invalid values, and doesn't even report
>> them, as before.  If we want to do that then we need to stop parsing
>> the variable lazily, in order to report errors before the first
>> output is written -- in maybe_flush_or_die() it's too late.
>
> Why is it too late then? If we're going to do a hard die() anyway (as
> above), whether it happens after a bit of output or not doesn't seem
> like that big a deal.

That's just sloppy for no good reason.  And the output could be quite
long and might be shown after the error message.

I can kinda understand that if the user gives us a bogus value we might
feel justified to mockingly serve them normally for a moment and only
then kick them out for violating our rules.  That's not how I would want
Git to behave, though -- too human.

> And if we never flush and look at the variable,
> and the user "gets away" with a bogus value, nothing is harmed. That's
> how existing variables work (e.g., try removing the pathspec from the
> rev-list invocation above).

I don't mind this part.

> If that behavior is OK, then we could just use git_env_bool() here
> (though the patch size isn't much different; as you noted, most of the
> change comes from flipping the variable).
The current behavior with atoi() is also to not report any errors.  If
that is OK then we can continue to do so.. ;)

But this leaves the possibility that someone sets GIT_FLUSH=3Dabsolutely,
loses data due to lack of flushing and is dissatisfied with the lack of
parse errors.

Ren=C3=A9
