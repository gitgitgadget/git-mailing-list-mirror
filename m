Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9EC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA806126A
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhKQImL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:42:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56328 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKQImJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:42:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A95C10190A;
        Wed, 17 Nov 2021 03:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lQ/NM5CEMI9B560rvapTzNdVGoWiwSZbmu3I0b1btGM=; b=NHUj
        PJ3cACe2Dgx8MkrDsQ0J3YjG46GttnzH+I3rMv2Xo9i9yFZaFyAAEIxK1sdIQ/NN
        xi+l6kRt7BsN9V+6atFL72LbJYMvr3F4OuHhaKwuT7r+TFBtmYgS81gq3yT2XTWr
        U56klosBrTMufm//weFvAvimLM6uafKEXlZj2tg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52D13101909;
        Wed, 17 Nov 2021 03:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAC45101908;
        Wed, 17 Nov 2021 03:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?utf-8?B?5b6Q5rKb?= =?utf-8?B?5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v4 2/2] am: support --empty-commit option to handle
 empty patches
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
        <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
        <b7e30c9b7abecdc871ddc38122ca042e940cb190.1637039888.git.gitgitgadget@gmail.com>
        <23de56a6-5b41-d8be-d59c-5a4e025ccd73@gmail.com>
Date:   Wed, 17 Nov 2021 00:39:08 -0800
Message-ID: <xmqqee7f41n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D55FB572-4781-11EC-8C81-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +--empty-commit=(die|skip|asis)::
>> +	The command usually errors out when seeing an input e-mail
>> +	message that lacks a patch. When this option is set to
>> +	'skip', skip such an e-mail message without outputting error.
>> +	When this option is set to 'asis', create an empty commit,
>> +	recording the contents of the e-mail message as its log.
>> +	'die' is specified by default.
>
> This feels sufficiently similar to the case of handling empty commits
> in 'git rebase' that it is worth trying to have a similar user
> interface. Otherwise the two commands have two different option names
> doing more or less the same thing. 'git rebase' has
> --empty=[drop,keep,ask] where drop is the default. If am were to
>  accept --empty=[drop,keep,die] it would offer a similar user
> experience.

Ah, thanks for noticing.  I like the three words you suggest.  If we
already have a similar option, we definitely should follow suit, and
I think "--empty" would be a better fit than "--empty-commit" in the
context of talking about the _input_ to "am".

