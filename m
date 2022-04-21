Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392086AbiDUTui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355803AbiDUTug (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:50:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401A4D60B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:47:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71E34119862;
        Thu, 21 Apr 2022 15:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mr4DzohA7f9m47Zn3KuK5APEPgZADB9x5cz69s
        cVW78=; b=AFXb2kVyVb57dLUZzOYZlyR4uIh+Ai5F94M3py1M3rNNONNA5qODxr
        tXXUnznBavf0yQlWLsia/AXgEnfWMUqByQJojATyBXiNw76gjUFFiON3OX/w2UPO
        T9wVGGcr3nUq1KlZ52rTHnnHsxKSD1riUvwB6jxT8HCmAf1+qMxyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5626F119860;
        Thu, 21 Apr 2022 15:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A495111985F;
        Thu, 21 Apr 2022 15:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
        <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <CAPUEspggNfra_C8PBcVqjZrxxnswg27WFLg2kT6JOCMB8f0FGg@mail.gmail.com>
        <xmqqv8v2gsjl.fsf@gitster.g>
        <CAPUEspgrk3+FAo9Y6VWcYddh0o4xCkqmQ=GLap1XomcMmnFCuA@mail.gmail.com>
Date:   Thu, 21 Apr 2022 12:47:42 -0700
In-Reply-To: <CAPUEspgrk3+FAo9Y6VWcYddh0o4xCkqmQ=GLap1XomcMmnFCuA@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 21 Apr 2022 12:22:21 -0700")
Message-ID: <xmqqr15qgqw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9279D00-C1AB-11EC-B14F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Apr 21, 2022 at 12:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Carlo Arenas <carenas@gmail.com> writes:
>>
>> >> -       CC="${CC:-gcc}"
>> >> +       CC="${CC_PACKAGE:-${CC:-gcc}}"
>> > ...
> Wondering if something more explicit might be easier to understand anyway like :
>
>   if test -n "$CC_PACKAGE"
>   then
>      CC="$CC_PACKAGE"
>   fi
>
> Carlo

The parameter substitution is commonly used part of the shell
language, and even if developers, when starting to work on parts of
the system that are written in shell, are initially unfamiliar with
such language constructs, nobody will stay a newbie forever.  

To them, idioms like ${A:-${B:-C}} would quickly become as explicit
as a long-form written as if/then/elif/fi.  Surely it takes practice
to be familiar with the idiom, but idioms help those who know them
to be more efficient and effetive, so, no, I do not think it is a
good idea to aim for "easier to understand by newbies".

Thanks.




