Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE0C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AB064E55
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCNWqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:46:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCNWqA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:46:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 630CE125995;
        Sun, 14 Mar 2021 18:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mtDz8rJD1mBUG+ddTApiB/EoYh8=; b=i5iL0a
        c3z69HDL4BSI355pnhT1Obpm10j/XKY6lkWE/KOBGuvIpvnY8S7dQpD58Hth/kQ+
        tUztg+9DeVZPhkH5UKcJqppx001rI7B7aObhB/o7m8DFcpJf44Qg0MFGBaV52/qB
        xjfS5BHI1g3ApacBlBF43nkBL4We1ta7IGzC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWV8jWH2KSbIF3WRdI9bh8AEqP6XpV9R
        9GpGZHRN5frkhzN38wTyT8DIK7d85s5MEG1EQRFjEpclyMdbFaSdHIKvKHwNiU0W
        Rja8H6X42tVOhSHhjOx4Z7SrycdL6KooVNJ3+qCF90uAvr9p7Ryq8Pu8m5BnaEwO
        TY1npP/XTqs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B8BC125994;
        Sun, 14 Mar 2021 18:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F2EB125993;
        Sun, 14 Mar 2021 18:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC] commit: add trailer command
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
        <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
        <CAP8UFD2_SSza-zsoqS_ugQBryiTvm0PqzrJDAuriT2jmjHM-uA@mail.gmail.com>
Date:   Sun, 14 Mar 2021 15:45:56 -0700
In-Reply-To: <CAP8UFD2_SSza-zsoqS_ugQBryiTvm0PqzrJDAuriT2jmjHM-uA@mail.gmail.com>
        (Christian Couder's message of "Sun, 14 Mar 2021 05:19:01 +0100")
Message-ID: <xmqq7dm94amz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ACA105A-8517-11EB-B01C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Ok, I agree that it's a good idea to have a good generic solution
> first, before having specialized options for specific trailers.
>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v2
>> Pull-Request: https://github.com/gitgitgadget/git/pull/901
>>
>> Range-diff vs v1:
>
> If this patch series has very few code and commit messages in common
> with a previous attempt at implementing similar features, it might be
> better to make it a new patch series rather than a v2. This could
> avoid sending range-diffs that are mostly useless.

Thanks for all the good suggestions.

