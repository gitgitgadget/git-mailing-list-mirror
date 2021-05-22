Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE0C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E906121E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEVJLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 05:11:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50553 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhEVJLL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 05:11:11 -0400
Received: from [IPv6:2601:646:8602:8be1:7cda:30c5:4c66:daab] ([IPv6:2601:646:8602:8be1:7cda:30c5:4c66:daab])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14M98HrN368871
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 22 May 2021 02:08:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14M98HrN368871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621674499;
        bh=cSBnONwzpN7c6YAUv+PQ2/Fk8rO5d6jM6vmdEbDFF4Y=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ndJHV6cruM1HIZ7V0SmIWkE1WxO8o6ZYlIbAlrGk7ssj2iCPDBdBsUZhVR38HD3l9
         wB1JNaPkGArvceKa/qOk77Rvk7LsFl+sYXTGy3IzqbpXwpX6jGIynsoPiEN6/feQWy
         Y0dmKl3ayVwZh3dJlOh5dbvfUZjAxyQEoZtfXESem4K3YeIESuGarS/QILEJ0doXMp
         KXEy62bLZ6XlQyTNZmgWs/Rw0mSn83fQfEcDgwxMYpR+Uart0PU4BJ9EgpydgeWNV1
         GKpl4sh1prBva3Uot+6fYd5/i6Q0Bfwqg26QH0EZAs3n0u74eHGPNHJO3puAkVukLQ
         2cm0v+22dV6vA==
Date:   Sat, 22 May 2021 02:08:10 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqfsyfqhkq.fsf@gitster.g>
References: <YKWggLGDhTOY+lcy@google.com> <60a5afeeb13b4_1d8f2208a5@natae.notmuch> <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com> <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com> <xmqqfsyfqhkq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: RFC: error codes on exit
To:     Junio C Hamano <gitster@pobox.com>
CC:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <357C5DA0-6A1B-4A69-8BBD-5D12327C136A@zytor.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sysexits=2Eh numbers are the same across all platforms which have it, I bel=
ieve=2E I think it originated with Sendmail wanting to know a bit more abou=
t why any subprocesses exited=2E

On May 22, 2021 1:49:09 AM PDT, Junio C Hamano <gitster@pobox=2Ecom> wrote=
:
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> writes:
>
>> On 5/21/21 9:53 AM, Alex Henrie wrote:
>>> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
>>> <felipe=2Econtreras@gmail=2Ecom> wrote:
>>>>
>>>> It's good to not include many initial codes, but I would start with
>at
>>>> least three:
>>>>
>>>>    OK =3D 0,
>>>>    UNKNOWN =3D 1,
>>>>    NORMAL =3D 2,
>>> If you go that route, could you please pick a word other than
>>> "normal"
>>> to describe errors that are not entirely unexpected? I'm worried
>that
>>> someone will see "normal" and use it instead of "OK" to indicate
>>> success=2E
>>>=20
>>
>> <sysexits=2Eh>
>
>Is the value assignment standardized across systems?
>
>We want human-readable names in the source to help developers while
>we want platform neutral output in the log so that log collectors
>can do some "intelligent" things about the output=2E  If EX_USAGE is
>always 64 everywhere, that is great---we can emit "64" in the log
>and log collectors can take it as if they saw "EX_USAGE"=2E  But if
>the value assignment is platform-dependent, it does not help all
>that much=2E
>
>    Side note=2E  We had a similar discussion on <errno=2Eh> and
>    strerror(); the numbers do not help without knowing which
>    platform the error came from, and strerror() output is localized
>    and not suitable for machine consumption=2E
>
>In a sense, it is worse than we keep a central mapping between names
>programmers use to give to the new fatal() helper function and the
>string the tracing machinery will emit for these names=2E
>
>Thanks=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
