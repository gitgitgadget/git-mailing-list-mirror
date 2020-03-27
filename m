Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E644C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27A206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ui0ly07z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0Rp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:45:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59740 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0Rp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 13:45:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB09B53195;
        Fri, 27 Mar 2020 13:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edKIoJb2ZwkKsSAOBfYEZECnahc=; b=Ui0ly0
        7zIoOjjfWXr/xJZ0iWwy+s6aLYPX/mdN/WRtAoWidWREoOgoK2fzRGaFf4AsTnF2
        joKj9cYUkd460VJve++dYV74dID2j1WIxzVwoFXOZ1Z12dZiDAbq+I9XoeCADDm/
        8foq8JMNMDwmfR6IMHA62qo0mqqISxNqd0KfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E8L6rCAgyuKiRuLNsFvNfi4albu4oQVQ
        nusHZLSCTVg1TbomSPf4GF3RU7g8PdjaB1MmHCtWcMwMvpUWOmNE2CGno5NLynPq
        6TvK8VIaOC79y0xORkxK3xQTpPHMuyiwFk16XwS/xEOnqSvKf6iJrabMKhYAL3ck
        szTyCMEb9bM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E13D153194;
        Fri, 27 Mar 2020 13:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EB7B53193;
        Fri, 27 Mar 2020 13:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] Enable GPG in the Windows part of the CI/PR builds
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
        <20200327091206.GB610157@coredump.intra.peff.net>
Date:   Fri, 27 Mar 2020 10:45:55 -0700
In-Reply-To: <20200327091206.GB610157@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 27 Mar 2020 05:12:06 -0400")
Message-ID: <xmqqmu81hess.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFCB16B8-7052-11EA-91D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 26, 2020 at 03:35:23PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> Changes since v2:
>> 
>>  * Reordered 4/5 before 3/5, as I had intended originally.
>>    
>>    
>>  * Renamed _trace_level to have a trailing underscore, in line with the
>>    surrounding code.
>>    
>>    
>>  * Added a note to the commit message why only lib-gpg.sh loses its
>>    hash-bang line, and no other files in t/.
>
> Thanks, this version looks fine to me. I left a few other comments
> regarding exit/return in the other part of the thread, but frankly all
> of it is too arcane and insignificant to spend more brain cycles going
> back and forth on.  So if I convinced/inspired you on that point, feel
> free to switch it, but otherwise I'm happy with this iteration.

Likewise.  I agree the above three bullet points are strict
improvements compared to the previous iteration.
