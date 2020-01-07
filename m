Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5AC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39572070E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HgTDTKih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgAGQf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:35:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58028 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgAGQf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:35:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3A902BB93;
        Tue,  7 Jan 2020 11:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NEUr7IOqFfTGgmF/Rv5XRJnxE2o=; b=HgTDTK
        ihFtwSwgI36Y7/q43vGH4JGrJUVRNWfFYg6ccN5UT/ArMcPkYnfWKr8XeXc7/GUC
        mGAyGq7t3wgDc8TXYFwNZbKVq6IAEjQpjaYNvapLW3h1QSDICjG2QhBta9KjzMe7
        S9SPac0CBZrkkMX9roz8QEEPrcvucT8bJIxsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhCEIGZB8f0zkaNfVRtCgdW/s82sMVLh
        Tupn4RhBczRkgTbmRq2pCxZKb9TEStdiC2IhSdfn6AShFHmeGZxwDMrJOGUNkS01
        11LmvPk92BBdPKO/KPu2igdhO1iaCBssVTOzCiCeRjmEulDaoTp8OmgbF9/pnCyn
        YCtfsZxWFqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB4182BB91;
        Tue,  7 Jan 2020 11:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FC8F2BB90;
        Tue,  7 Jan 2020 11:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
        <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
        <xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com>
        <CACg5j27ce5BfR9RKekMEXokvCnXiXzmCVsyEKce+HORe8kL_GQ@mail.gmail.com>
Date:   Tue, 07 Jan 2020 08:35:54 -0800
In-Reply-To: <CACg5j27ce5BfR9RKekMEXokvCnXiXzmCVsyEKce+HORe8kL_GQ@mail.gmail.com>
        (Heba Waly's message of "Tue, 7 Jan 2020 23:54:04 +1300")
Message-ID: <xmqqd0bv6x79.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C73228D2-316B-11EA-AD04-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> On Fri, Jan 3, 2020 at 11:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> A side note.
>>
>> Right now, the advise() API is a bit awkweard to use correctly.
>> When introducing a new advice message, you would
>>
>>  * come up with advice.frotz configuration variable
>>
>>  * define and declare advice_frotz global variable that defaults to
>>    true
>>
>>  * sprinkle calls like this:
>>
>>         if (advice_frotz)
>>                 advise(_("helpful message about frotz"));
>>
>> I am wondering about two things:
>>
>>  (1) if we can update the API so that the above can be reduced to
>>      just adding calls like:
>>
>>         advise_ng("frotz", _("helpful message about frotz"));
>>
>>  (2) if such a simplified advise_ng API is a good idea to begin
>>      with.
>>
>
> That's a valid suggestion, I can investigate that in a new patch, I'd rather
> keep this one as simple as calling the existing advise function.

Yeah, the side note wasn't even a suggestion for improving _this_
topic, nor even specifically addressed to you.  Let's stay focused.

Thanks.

