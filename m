Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF1C433E2
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AA52080D
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtUytqDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFRVAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:00:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56542 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgFRVAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 17:00:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF84C74DB7;
        Thu, 18 Jun 2020 17:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MuBJZ/LpFYkoowaB7G5H1oK2K+s=; b=qtUytq
        DYcatmaLOAG5/LEdEq15TxIfScmY2IKH8P7gIyetIzpHb0dB1XwKzUaXjJnwMras
        616rqq2CGp8hi+KrQFjgG75i0jMw6cPI55eLYkPKXUqhAlCnsSSMQ5AnojOM1uCQ
        HWYcbciICwzwqKXbKKLgPAf+OvBP5SpcDc37A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmWdxtQAypG3wbPwCLCoUhbWpxxsdT3K
        V5KMrID4T0h2h9OsnQZ/qWFpXMJl5n2S7pCLyKa7s4aKMoYuhZbtEAWPxRkryqZO
        DudtF3WvrDeslNl+obrtmLa6fIEcov7MsLkVa2T2o2FRNyTescx0rKMwn8pbDNo+
        AgYIS+PcVCk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A79F574DB6;
        Thu, 18 Jun 2020 17:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FBF274DB5;
        Thu, 18 Jun 2020 17:00:43 -0400 (EDT)
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
Date:   Thu, 18 Jun 2020 14:00:42 -0700
In-Reply-To: <CAKiG+9UqvrxyMQufuG=oAP6Yo7+YSoicwqZBJjsZZFQT-Bscjw@mail.gmail.com>
        (Sibi Siddharthan's message of "Fri, 19 Jun 2020 02:10:42 +0530")
Message-ID: <xmqq1rmcm6md.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5F5C274-B1A6-11EA-A0ED-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> The reason I deferred modifying in PATCH v4 was because there was no
> easy way(cross platform)
> to change file permissions. The workaround is to juggle the files to a
> temporary directory, and then copy them
> to where they are intended to be with the required permissions. This
> added quite a bit of code.
> Since Windows platform was the priority, I did not address this issue.

I recall asking you, in a very early iteration, if you just
concentrate on Windows and do not even pretend you support Linux or
any other systems, the series can be kept smaller and review
simpler, and your answer was "no, it can be done with just a little
extra code".  But I think you are saying it needs "workaround" and
what needs to happen in the workaround sounds quite ugly to me.

Let's not worry about cross-platform and instead stick to Windows
and nothing else for now to expedite the process.  As long as it is
advertised as such, nobody would complain that it does not work on
Linux or macOS.

Thanks.
