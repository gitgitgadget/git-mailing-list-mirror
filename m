Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D9C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3ACD61414
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhGHPUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:20:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63512 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGHPUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:20:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A77BD6D91;
        Thu,  8 Jul 2021 11:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4KssYD+erRLXAbpWUhJZW4KK2g4B8rHmJMEfor
        6b1B0=; b=vItNSoTaqAnqLk0+N7Hf3tBPE8QK+V9uAkI34ygwth//xpqmXbRm3i
        yVhgqGdRcJBApk0DlMYhZ/AgOI94eoWiQdS7LxxQ8KDc16nOgDosrlJ4sGKYwWmG
        K7LB0SDDNQ6k3/w9hjOoTsR1m/MwfTjU/peVq9ORgl0LlIDatwzLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31DC0D6D90;
        Thu,  8 Jul 2021 11:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACA51D6D8F;
        Thu,  8 Jul 2021 11:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH v2 2/4] submodule: prefix die messages with 'fatal'
References: <20210706181936.34087-1-raykar.ath@gmail.com>
        <20210708095533.26226-1-raykar.ath@gmail.com>
        <20210708095533.26226-3-raykar.ath@gmail.com>
Date:   Thu, 08 Jul 2021 08:17:54 -0700
In-Reply-To: <20210708095533.26226-3-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 8 Jul 2021 15:25:31 +0530")
Message-ID: <xmqqo8bcbzrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB39991E-DFFF-11EB-B319-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> The standard `die()` function that is used in C code prefixes all the
> messages passed to it with 'fatal: '. This does not happen with the
> `die` used in 'git-submodule.sh'.
>
> Let's prefix each of the shell die messages with 'fatal: ' so that when
> they are converted to C code, the error messages stay the same as before
> the conversion.

Sounds good.  More importantly, the error messages from the
resulting system would become more uniform---after all, the end
users would not care if scripted part of the system is emitting the
error messages, or the message comes from a built-in version.
