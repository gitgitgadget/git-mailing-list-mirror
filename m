Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B827C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0C8613BC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhEEO2H convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 May 2021 10:28:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50480 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhEEO2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:28:07 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 145ER4uo031848
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 May 2021 10:27:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Elijah Newren'" <newren@gmail.com>
Cc:     "=?utf-8?Q?'G=C3=A1bor_Farkas'?=" <gabor.farkas@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com> <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com> <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
Subject: RE: git switch/restore, still experimental?
Date:   Wed, 5 May 2021 10:26:59 -0400
Message-ID: <00af01d741ba$b916a330$2b43e990$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH8RVX2O79v7iabS0EBA/z8bLxIeAKGPjZCAPCYjWOqbzLbMA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 5, 2021 10:18 AM, Johannes Schindelin wrote:
>On Tue, 4 May 2021, Elijah Newren wrote:
>> On Tue, May 4, 2021 at 3:36 AM Gábor Farkas <gabor.farkas@gmail.com>
>wrote:
>> >
>> > the "git switch" and "git restore" commands were released two years
>> > ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
>> > BEHAVIOR MAY CHANGE.".
>> >
>> > i'd love to use them, but this warning gives me pause, perhaps i
>> > should wait until it stops being experimental, i worry that it might
>> > change in behavior unexpectedly and cause problems for me.
>> >
>> > considering that they were released two years ago, could the
>> > experimental-warning be removed now?
>>
>> This probably makes sense.  The author of switch and restore isn't
>> involved in the git project anymore.  He decided to work on other
>> things, which was and is a big loss for us.  I think others (myself
>> included) didn't know all the things that might have been in Duy's
>> head that he wanted to verify were working well before marking this as
>> good, but these two commands have generally been very well received
>> and it has been a few years.  Personally, I'm not aware of anything
>> that we'd need or want to change with these commands.
>
>I think that part of the intention to mark this as experimental was to gather
>feedback about the commands. After all, the goal was to improve the user
>experience of Git (because `git checkout` does too many things, and its major
>accomplishment is to confuse literally every single new Git user).
>
>However, that hope never was fulfilled if I may say so, we simply did not attract
>the best-suited experts to this mailing list, not if what we set out was to improve
>usability.
>
>Which leaves us with two hard choices regarding switch/restore, none of them
>really being comfortable:
>
>- we scrap switch/restore because their usability is not really all that
>  improved relative to `git checkout`.

Please do not do that. Switch/restore is much easier to understand for new users. The semantics are also more consistent with what others have done with git over the years anyway (EGit as an example). I have users who have transitioned because the commands make sense. They have not hit any missing bits in their workflows.

>- we leave switch/restore as-are (because by now, changing the options or
>  the design would be almost certainly disruptive to users who already
>  tried to adopt the new commands, I being one of those users).

I think we should work on the commands to cover between them (well... and reset) to functionally cover what checkout does. Leaving them as-is, I think is not a viable option. People do know these are experimental and not to use in scripts - we can hope anyway.

>I say that neither of them is a really splendid choice because the original goal is
>not only not accomplished, but I would say it is even harder now than it was
>when we accepted switch/restore into an official release, because of that
>experience with switch/restore. We simply do not have the right expertise on
>this list, and therefore anything we do will always have that "UX designed by an
>engineer" feel.

My thoughts anyway.

-Randall

