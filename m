Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683D3208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 08:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdHXINv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 04:13:51 -0400
Received: from 9.mo176.mail-out.ovh.net ([46.105.78.81]:46869 "EHLO
        9.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdHXINg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 04:13:36 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 58DD7830FE;
        Thu, 24 Aug 2017 10:07:02 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 10:07:01 +0200
Subject: Re: sequencer status
To:     Christian Couder <christian.couder@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
 <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <98dc75b0-8822-638a-16fa-3adc12e3c55e@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 10:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS2.indiv2.local (172.16.1.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 9882586434994235357
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdeggddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 23/08/2017 à 18:40, Christian Couder a écrit :
> Hi,
>
> On Wed, Aug 23, 2017 at 10:10 AM, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Hi,
>>
>> I've created a small tool to display the current sequencer status.
>> It mimics what Magit does to display what was done and what is left to do.
>>
>> As someone who often rebase large series of patches (also works with am, revert, cherry-pick), I really needed the feature and use this daily.
> Yeah, many people use the interactive rebase a lot so I think it could
> be very interesting.
>
>> It's available here:
>> https://github.com/nmorey/git-sequencer-status
>> SUSE and Fedora packages are available here:
>> https://build.opensuse.org/package/show/home:NMoreyChaisemartin:git-tools/git-sequencer-status
>>
>> It's not necessary very robust yet. Most of the time I use simple rebase so there are a lot of untested corner cases.
>>
>> Here is an example output:
>> $ sequencer-status
>> # Interactive rebase: master onto rebase_conflict
>> exec    true
>> pick    e54d993 Fourth commit
>> exec    true
>> *pick   b064629 Third commit
>> exec    true
>> pick    174c933 Second commit
>> onto    773cb23 Alternate second
> It is displaying the steps that have already been performed, right?
> I wonder if people might want more about the current step (but maybe
> that belongs to `git status`) or perhaps the not yet performed states
> (and maybe even a way to edit the todo list?)

Yes it is displaying all steps.
The line beginning by '*' is the current step.

Trying to "guess" what is happening on the current step is quite hard. Between conflict, empty commits, stopped for amending and other, it's a lot of cases to handle.
I'd rather have git-status deal with it (and you get your standard log/error fro your rebase/cp/am/revert command too).
The idea here is really to find out where you are in your operation sequence.

I've had a 700 patch series to reapply on a different subtree. Took me 3 days. This script was quite handy. (Also depressing as you can see how much work left there is).

Also if you feel it's missing something you need, I'm accepting PR on github ;)

>> Two questions:
>> - Could this be a candidate for contrib/ ?
> It seems to me that these days we don't often add new tools to contrib/.
>
>> - Would it be interesting to add the relevant code to sequencer.c so that all sequencer based commands could have a --status option ?
> Yeah, it's probably better if it's integrated in git, either as a
> --status option in some commands, or perhaps as an option of `git
> status`.

I'll have a look at what can be done.

Thanks

Nicolas


