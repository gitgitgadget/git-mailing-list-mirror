Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5549CC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbhLFTth (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:49:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53957 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbhLFTtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:49:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FC3015FF9E;
        Mon,  6 Dec 2021 14:46:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v5d8rOJileyZHKWdgMmNTrAb6Qyn+tbRT/E0sj
        DwiZE=; b=wXHPjcoJR7wzB5YRpG/hCN3Pc5ZeK/MQ/X2tVhcfhBFhRQgr4j44DP
        AJCO62JajeZ1QDOHGaOksG8D/NfSr4HQKVkAURMyoPNz+SGYQWSyhDxdbSW72ZXZ
        zQkLTsxf9xPdygfakhXc4z7ElAHsDpIBR7NpPTpcIpvi29IOY4UQg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4841615FF9B;
        Mon,  6 Dec 2021 14:46:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3155715FF94;
        Mon,  6 Dec 2021 14:46:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] usage.c: add a die_message() routine
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
        <patch-1.4-5a9ab85fa56-20211206T165221Z-avarab@gmail.com>
        <xmqqee6pfrkd.fsf@gitster.g>
Date:   Mon, 06 Dec 2021 11:46:01 -0800
In-Reply-To: <xmqqee6pfrkd.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        06 Dec 2021 11:42:42 -0800")
Message-ID: <xmqqa6hdfreu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25170D18-56CD-11EC-96D9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It also makes readers wonder why this is not
>
> 	exit(die_message(err, params));
>
> which I take it a sign that this new API is overly loose to allow a
> simple single thing to be done in multiple ways.  Perhaps as the
> series progresses, the picture might improve, but if that is the
> case, perhaps the presentation order needs to be rethought.
> E.g. start without the _builtin that implies override-ability,
> convert the existing code that can benefit from calling die_message(),
> and then finally introduce _builtin that is merely an implementation
> detail, or something like that, perhaps?
>
> In any case, the first step in this four patch series is not enough
> to evaluate if this step makes sense, so let's keep reading.

OK, it is the other way around.  This step with _builtin is
incomplete introduction of the API, even though it was "we add the
new API function without having any meaningful callers, because
combining them together into a single patch is too much to chew in a
single sitting".  A small part of 2/4 that adds the override-able
die_message_routine should be part of this step to make this step
understandable.

THanks.

