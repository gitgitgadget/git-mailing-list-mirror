Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA9C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA5964E79
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBPXug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:50:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52379 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBPXuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:50:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8ED09F247;
        Tue, 16 Feb 2021 18:49:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eYJlvPFCpobS
        /MlJ0+e8OMEp/Tk=; b=lbqmqXZ2M34KC1KLuPl5Q8U72QkLDPpYOrJZv8hVD3eL
        +UnMhe2318HlsrNl8tjDEmOfGbMtoXnu27kfajW3v4LMzlcTvVT5+NO8BR5VQczj
        Yo5LOxxSM8zWF7myw+J0UH9x/TK6smAP63dc+LOtpjWTyjnjfWWb8LZExxdb24o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UCjqTf
        Zm9qLP0WzPLt6U2tlRAvEIbRBOIcyhfaYbYwpu6X2TFbRhBADAwv+3F0HWnKpegg
        yZ9pKceKRo2cu5BfQmF3tW2tNp49xTMESn/ztUZLtF5JXHW5sGuSIuXf6lWg5s75
        aOQlO3BBYLn9tIe2B+gySRHCLbbMrppR0XcSE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9C5C9F246;
        Tue, 16 Feb 2021 18:49:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FB629F245;
        Tue, 16 Feb 2021 18:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 10/27] blame tests: don't rely on t/t4018/ directory
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-11-avarab@gmail.com>
Date:   Tue, 16 Feb 2021 15:49:48 -0800
In-Reply-To: <20210215154427.32693-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Feb 2021 16:44:10 +0100")
Message-ID: <xmqqeehfo9nn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7C0AA9C-70B1-11EB-818B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor a test added in 9466e3809d (blame: enable funcname blaming
> with userdiff driver, 2020-11-01) so that the blame tests don't rely
> on stealing the contents of "t/t4018/fortran-external-function".

I like changes like this and wish they (I haven't finished reading
the 27 patches, but I am hoping that there may be more) were
separately available ;-)
