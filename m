Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5FBC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44F1208DB
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UjeFaZ4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392629AbgFSR3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:29:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60869 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgFSR3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:29:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41DBD60B6D;
        Fri, 19 Jun 2020 13:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eF5qGpWC4KxSUN0ol10AYlI3erk=; b=UjeFaZ
        4KTl/kAtWvoQHsmZ7yZM+uv5TdxPYR8cRF+K/zjcOnja8T2BdxaINvsL88MfcsVD
        3ZqPInCg9upSAdxktwIce2O7igKYXpAxqo46owdE9iorfrZGq0dnsYIyAXeRU0nR
        laRhsDIplZm6xAGVcmwMHdUcSpL9J1U5oQW+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=adVXTDwCjdpL8appt3zALIolvpeelnbN
        +lizY/tmeUSaVoYrR4BaDaDQoQgkeTrnngD8YJ/7UB3l0qXCrdm4zo6Zo9NnYnH1
        UznctaGGmAUS0J0j4iVdpE9Kd3VTGCapGEKMTEmHKshgN0MCIuqgzpN1Xyb2upeA
        fL0qEOFmkzc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 395A060B6B;
        Fri, 19 Jun 2020 13:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C150D60B69;
        Fri, 19 Jun 2020 13:29:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
        <20200615140349.1783-1-oystwa@gmail.com>
        <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
        <xmqq8sglq8zn.fsf@gitster.c.googlers.com>
        <CAKiG+9VZUqDi=EbbqY2vLAiD6LEFMfR_2UHE+gbt_RpKNanUCA@mail.gmail.com>
        <xmqqk104nnll.fsf@gitster.c.googlers.com>
        <CAKiG+9UqvrxyMQufuG=oAP6Yo7+YSoicwqZBJjsZZFQT-Bscjw@mail.gmail.com>
        <xmqq1rmcm6md.fsf@gitster.c.googlers.com>
        <CAKiG+9VCcH+CGc8=e22Xjc7z=-HL3vbDTDq9a4zZ9ONdmgTpvw@mail.gmail.com>
Date:   Fri, 19 Jun 2020 10:29:12 -0700
In-Reply-To: <CAKiG+9VCcH+CGc8=e22Xjc7z=-HL3vbDTDq9a4zZ9ONdmgTpvw@mail.gmail.com>
        (Sibi Siddharthan's message of "Fri, 19 Jun 2020 22:45:20 +0530")
Message-ID: <xmqqbllfhslz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 644D0170-B252-11EA-9C20-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

>> Let's not worry about cross-platform and instead stick to Windows
>> and nothing else for now to expedite the process.  As long as it is
>> advertised as such, nobody would complain that it does not work on
>> Linux or macOS.
>>
>
> Okay.
>
> Just for your information.
> This is the exact diff that needs to be added to address the issue.

I do not care how small the diff is.  This won't be the last such
case that needs a workaround, and I do not want to see us die from
thousands of little cuts.

If anything, a diff that removes things that are needed only because
we try to work on non-Windows systems would be more interesting to
see.  If it removes a single ifdef(), that would be worth applying.

Thanks.
