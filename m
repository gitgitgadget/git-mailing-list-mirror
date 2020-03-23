Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C57C43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFA620663
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lOxGfxFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgCWUPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:15:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57698 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:15:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FD29BC62E;
        Mon, 23 Mar 2020 16:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRIqiivTDsiM3d19cj2rLFrxx38=; b=lOxGfx
        FcRpvuhZqyRbzMRmxqosRIFzApmBveeO3vkMJw/CaIcamIN/RLNN1rtqg9dKDfRV
        hB+M0SYWLZFaEBH8Vs58O78ryN5BNgD+yc5sINRFhwyAb8n+FkE9dFJWpVIFs+kw
        5nAFPJMhEAoDOH+b7gU3s9lHrhDOc8DNz1PGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TqvLcaPuggVuIv8RITcmDhy307c4nyHz
        ZB3b4f+0HWSeHXxTjMPzMC1MO51hjyIqxHHEcv2DoPu0U4cpP7zGe/hpYjN0DQCD
        6DwpxxRq0Mfo2ctOFuZ7kX58+Pffs6SLhvk7eIi6ptoqYMyTcMtMGTLUeBkH+kQ9
        0GcuRGoT6yg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87502BC62C;
        Mon, 23 Mar 2020 16:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C91ADBC61E;
        Mon, 23 Mar 2020 16:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] trace2: teach Git to log environment variables
References: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
        <aa4d22be-3710-1377-97aa-8ce8cfde0e20@jeffhostetler.com>
Date:   Mon, 23 Mar 2020 13:15:36 -0700
In-Reply-To: <aa4d22be-3710-1377-97aa-8ce8cfde0e20@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 23 Mar 2020 11:28:16 -0400")
Message-ID: <xmqqzhc64yl3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F7E388E-6D43-11EA-82D7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> As I mentioned in the commit message, I modeled this pretty closely on
>> the config parameter reporting code. It may make sense to split some of
>> this out into its own file, particularly the parts in trace2/tr2_cfg.c.
>> Alternatively, we could also just make the env var reporting part of the
>> config param reporting. Let me know if you have a preference either way.
>>
> Looks good to me.

Yup, thanks both.
