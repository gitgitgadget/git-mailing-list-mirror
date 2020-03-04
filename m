Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72631C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335221775
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGx92UL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgCDQZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:25:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58083 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCDQZh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 11:25:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50AB4CD14C;
        Wed,  4 Mar 2020 11:25:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bmXvIKplEgQDUP2Naye63muQrtU=; b=VGx92U
        L0J+vVt+aE4S1CPmz59lFlVbgOSKXX06vuak/gK6uLm+eb0d72P2IYMoZ2hSC6Dr
        9cPX31m/npibozzB4XiWGH3f7AMg92rk89bIpk4exz7ZMkpcK5qXE71s9FUyyBPS
        6jr/j+3PUcWPEgfJ297M8aLc6knZMwd247N9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fCR2lgpPtoVQKrwrSN/vzTCtI92p3k8x
        riuYU2jiUEP/URfGgWdcqaw0WJrcPrDaLkCDCEd8LZS4LV5qm0yjxBCf3pt6Jj86
        hOAj6/fADBMXOIfqPmUz7+wTraGrwC0VkY3zM7lsJxFRuBWv7xFVJz/NrRA8EU6F
        HHBAtYsoeuA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47653CD14B;
        Wed,  4 Mar 2020 11:25:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71DBECD14A;
        Wed,  4 Mar 2020 11:25:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <son.luong@booking.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/2] stash: remove the stash.useBuiltin setting
References: <20200302181832.GA1571684@cat>
        <20200303174613.3557960-1-t.gummerer@gmail.com>
        <20200303174613.3557960-2-t.gummerer@gmail.com>
        <xmqqeeu98egp.fsf@gitster-ct.c.googlers.com>
        <20200304114909.GD1571684@cat>
Date:   Wed, 04 Mar 2020 08:25:30 -0800
In-Reply-To: <20200304114909.GD1571684@cat> (Thomas Gummerer's message of
        "Wed, 4 Mar 2020 11:49:09 +0000")
Message-ID: <xmqqh7z45bph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C502C7D8-5E34-11EA-BB4B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 03/03, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > +	Unused configuration Variable.  Used in Git versions 2.22 to
>> 
>> s/Variable/variable/;
>
> Whoops.  Do you want me to re-send an updated version, or could you
> fix this up locally?

After reading your response to the end, it appears that there is no
other changes needed, so let me do the honors ;-)

>> I am a bit torn between "just document it here as a stale variable
>> that can safely be removed from your configuration, and do not warn"
>> and what you did here.  Even if we warn for a few releases, this
>> entry cannot be removed from the documentation for a lot longer
>> time, if ever, anyway.  It's not like having an extra entry that is
>> unused in the configuration file would hurt users, anyway, and it is
>> not obvious that the warning helps more than it disrupts them by
>> bugging users to remove it from their configuration file.
>
> Hmm I'm thinking of the warning mostly as preventing the "I have
> legacy stash enabled, why do I see a new bug all of a sudden?"
> question, as opposed to it helping removing this from the docs.

OK.  Thanks.
