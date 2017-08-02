Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D550C20899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbdHBU2q (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:28:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58599 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751739AbdHBU2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:28:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E28259386B;
        Wed,  2 Aug 2017 16:28:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BA34WUuUeoAQY6zsyM1vFtAdr4=; b=pekz27
        KhO6wc7VdqG/Fbg6sYz/BnDGvCYX122FaYUAwUH3uBy/23oZhZq1KyL0Myun9k0w
        j8iigj3eZpEK9m74ZFfcI9NcXcbOfwo1lkjGjJpmnxxoGPSH8vyB1TsfTBoVgmt1
        tnF96Agj0LNxO8T3GqB/gbjIPPaGIDjPzq8PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQbi1f2S+El7WW9lOXFgPPFBevVtIKT3
        Ul8Uq3Jlz7H81VoOx8UxrlLq18jKXgpg0EHWWG5fwwo+9MkYYLck2cFKXWakV9Hw
        orXjiqNn5JI3n+LtwcPgVEKcEzysnRwNXqaHsAWUmdrE7wXKa6mSmszOG5SimiXb
        WvbH7jHbNGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA9599386A;
        Wed,  2 Aug 2017 16:28:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FF1493866;
        Wed,  2 Aug 2017 16:28:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Richard Jones <richardj@backbase.com>, git@vger.kernel.org
Subject: Re: Git log --tags isn't working as expected
References: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
        <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net>
        <xmqqa83idjlj.fsf@gitster.mtv.corp.google.com>
        <20170802173411.tu7wyuehcktxge6o@sigill.intra.peff.net>
Date:   Wed, 02 Aug 2017 13:28:38 -0700
In-Reply-To: <20170802173411.tu7wyuehcktxge6o@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 13:34:11 -0400")
Message-ID: <xmqqd18dsoi1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B0D283C-77C1-11E7-BC75-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By the way, I noticed something funny that I forgot to mention:
>
>   git log --tags=does-not-exist
>
> shows HEAD, because the logic to kick in the default only asks "were we
> given any refs to start the traversal?". I think it probably should
> consider a wildcard with no matches to override the default, and show
> nothing.
>
> I haven't decided if it should be empty-but-success, or give an error.

I agree.  The same for --branches, --glob, etc.  I'd say it should
behave just like "git log HEAD..HEAD".


