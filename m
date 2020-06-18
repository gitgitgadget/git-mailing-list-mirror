Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A79BC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36646207E8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfJSdBGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgFRUIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:08:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61133 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFRUIo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:08:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A17B6DAEA3;
        Thu, 18 Jun 2020 16:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iiAxVbxqh/VxT77hQaSp6EyUxlk=; b=NfJSdB
        GcOO1aLCXXfEW6Jl7cxJ+FdAR+fq2GE90XFbegKOmUpqvZbbGhMABG+B2bF/12ox
        Qh7CekDQqVnr/7jeAQn5g2B6HZepdpl5DwJsTFvUBXLGF2BRnE/kfUHAmEFwQV5G
        Ihvk8/E2TAFU9B+JRuzoR2VcVzG1A4cRjsfok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wMmhTIoVZE7f1rhdeTtv9xciSVv/U5R8
        JtnX03tYIjALyTiGADjM6lQQAAZ9ribPGMhqjH0lHZTwsqxpfA37bqPjJu7zjpSH
        HLT2i7IuyPihgTMie8OB5OnJbFlO95RLAg4awfw+eD3pZRb4EH6zldCfWqNrNeiG
        aZteYEpalG8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99205DAEA2;
        Thu, 18 Jun 2020 16:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2915DAEA1;
        Thu, 18 Jun 2020 16:08:39 -0400 (EDT)
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
Date:   Thu, 18 Jun 2020 13:08:38 -0700
In-Reply-To: <CAKiG+9VZUqDi=EbbqY2vLAiD6LEFMfR_2UHE+gbt_RpKNanUCA@mail.gmail.com>
        (Sibi Siddharthan's message of "Fri, 19 Jun 2020 01:25:22 +0530")
Message-ID: <xmqqk104nnll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80590D68-B19F-11EA-8B99-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> Since this patch series has been merged with pu, I didn't know whether
> I should wait till the patch gets merged into 'next' or do the change
> immediately.

Ah, OK.  Being in 'pu' does not mean no more than that the patch was
sent to the list and I happened to have seen it.  If it were ready
to be merged to 'next', I may have marked it as such in the "What's
cooking" report, but otherwise, the default is to be polished until
it gets ready.

> One more thing, there is an issue with the scripts' permissions when
> run in Linux. They don't have execute permissions.

What script?  Your scripts you add in the patch series?  What is the
reason why they lack execute permissions?  Forgot to "chmod +x"?

It sounds like, in addition to issues pointed out during the review
cycle, you have identified more issues that can be solved to make
the series more complete yourself, which is a very good thing.  It
is hard for anyone to review one's own patches and find issues, and
you seem to be getting the hang of it.  These are all good thing to
address before the topic becomes ready for 'next'.

And there is no need to hurry.  If you do not want to waste time in
repeated rewrite and review cycle, the best way may be to go slowly
and carefully to avoid "this was known to be suboptimal even when I
wrote it, but I didn't bother fixing it before sending it out, but
it was noticed during the review so I have to update it and send a
new round".

Thanks.
