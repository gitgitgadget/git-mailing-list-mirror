Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C92BEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 05:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF2Fwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjF2Fwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 01:52:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C297E58
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 22:52:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1229024051;
        Thu, 29 Jun 2023 01:52:33 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1qEka0-MIz-00; Thu, 29 Jun 2023 07:52:32 +0200
Date:   Thu, 29 Jun 2023 07:52:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Linus Arver <linusa@google.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Message-ID: <ZJ0cIKrSVmwMy6F4@ugly>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
 <owly8rcc3j1u.fsf@fine.c.googlers.com>
 <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2023 at 02:15:39PM +0100, Phillip Wood wrote:
>On 21/06/2023 16:57, Linus Arver wrote:
>> - Make the 'TEST' macro accept the test description first. Or, keep 
>> the
>>    'TEST' macro but also name a new macro 'IT' that accepts the
>>    description first, to encourage usage that reads in a
>>    behavior-driven-development (BDD) style, like 'IT("should accept foo",
>>    t_bar(...))'. I find some test descriptions easier to write this way.
>
>The test description is a printf style format string followed by 
>arguments. This allows parameterized tests to include the parameter 
>values in the description to aid debugging but it means the test 
>function must be the first parameter. We could have IT("should accept 
>%d", t(), i) but that would be a bit weird.
>
with some minor preprocessor magic [1], you could make that

   IT(("should accept %d", i), t(i))

which would be somewhat more noisy, but arguably even somewhat clearer.
notably,

   IT("should accept foo", t())

would still work with the same macro.

[1] https://stackoverflow.com/a/62984543/3685191

somewhat on a tangent: it's also possible to overload macros on argument 
count [2], which may also come in handy.

[2] https://stackoverflow.com/a/24028231/3685191

regards,
ossi
