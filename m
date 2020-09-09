Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44DCC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B63A20C09
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsQgvEKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIIUeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:34:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgIIUeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:34:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95C1F8B7FA;
        Wed,  9 Sep 2020 16:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+244wOGWXK1QXJlaUnFNPhL1ek4=; b=UsQgvE
        KJjC+Zkl64SoWRud/1s0+2PboeqetDiv2ciaFz7Uw76Ry5nENx7HUsTwHNiob9ap
        UPnL1Ici8Ywg0H9fY7IRGVwSEpTGda1fGsH8B0kgvlGHa8SlsGoSZJJpZIdLllIP
        CbXbF8MlXvyOGvL5xwGP2pzIXud54nugcoZSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tczrlLE5pBLFGALiaMtf4GzTylS1ZMW3
        z9eyvb+D7dMauSWbtEBS7prFZ653CI2DLZnK37AzIZxQR0jG/N1ZIYOyx1TX31UE
        8muNdN+XgtEN4sRSf5dQFNI+dJTX8kEXCNzR8NlYV9BIp6wyf3tryMPpJpk40fNv
        whMCtx30HTY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD568B7F9;
        Wed,  9 Sep 2020 16:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ADEF8B7F8;
        Wed,  9 Sep 2020 16:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kyohei Kadota via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH v2 1/2] Fit to Plan 9's ANSI/POSIX compatibility layer
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
        <c850888c25d4d1e1c6b0ca40ab4638462c1649fa.1599680861.git.gitgitgadget@gmail.com>
        <CAPig+cQ_KCAGpmfBAymBefB2JSVpw0-bk5HOnm41=SpADEyDnA@mail.gmail.com>
Date:   Wed, 09 Sep 2020 13:34:11 -0700
In-Reply-To: <CAPig+cQ_KCAGpmfBAymBefB2JSVpw0-bk5HOnm41=SpADEyDnA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 9 Sep 2020 15:56:42 -0400")
Message-ID: <xmqqsgbqu1to.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1E2A6A8-F2DB-11EA-AFC5-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 9, 2020 at 3:48 PM Kyohei Kadota via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> And its sed(1)'s label is limited to maximum seven characters.
>> Therefore I replaced some labels to drop a character.
>>
>> * close -> cl
>> * continue -> cont (cnt is used for count)
>> * line -> ln
>> * hered -> hdoc
>> * shell -> sh
>> * string -> str
>
> These are reasonable. "cl" feels a little odd, but I can't think of
> anything better.
>
>> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
>> @@ -24,7 +24,7 @@ category_list () {
>>  get_synopsis () {
>>         sed -n '
>> -               /^NAME/,/'"$1"'/H
>> +               /^NAME/,/'"$1"'/h
>
> This change is not mentioned in the commit message. "H" and "h" are
> very different commands, so it's difficult, at a glance, to tell if
> this change is even valid. Some explanation in the commit message
> would help (if it is indeed valid).

I am glad somebody else caught the same thing as I did.  copying and
appending will give very different results.

Thanks.
