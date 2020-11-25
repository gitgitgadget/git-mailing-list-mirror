Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CACC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B312083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xnw2Q6wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgKYTap (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:30:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51325 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgKYTao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 14:30:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A10F9E7C1;
        Wed, 25 Nov 2020 14:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=26eR5sZ0f2xa4TagK/4GHGcRJ0Q=; b=Xnw2Q6
        wrw+iU/2DXt1EwT9IPPCEL50sskTJgu5OLvjQMx3tzm5UR4qayIOHC5THToD7uWX
        wtRiTxYVrHCqAbBw2bV5M+TP4cNOEZjaHEznQqt2E+VyOLEzEKo/ZfWj7d6VLR1C
        YKjcQ8ezrxg6BwFPI2y5YH/TtKlpQ2Gwr9J7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HGxPOIzZxDvzxiTGblk3cJd/hH2EwLHC
        EXrugBEIT70aZFXWwo2tDxf6XSKUiz3n2zBO7BJzizo2m680eu/khjab5BYQN6oH
        QZYbk3s9ByTZTbhS4iynbN/SPktPGhKJ8WJcEK4wAGLYxKn9JaiOTmZQHaNKrkV7
        dO5iKWB4iuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DFA29E7BF;
        Wed, 25 Nov 2020 14:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A3199E7BE;
        Wed, 25 Nov 2020 14:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
        <20201123215122.GD499823@google.com>
        <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
        <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
        <CAPig+cTQMCho=wFHhg-ACrP2oOEQwBHnfmV-Rk1vARpF2Fafng@mail.gmail.com>
Date:   Wed, 25 Nov 2020 11:30:40 -0800
In-Reply-To: <CAPig+cTQMCho=wFHhg-ACrP2oOEQwBHnfmV-Rk1vARpF2Fafng@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 25 Nov 2020 12:28:46 -0500")
Message-ID: <xmqq4kldfd3z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B46F5584-2F54-11EB-931D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Nov 25, 2020 at 9:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 11/23/2020 5:41 PM, Junio C Hamano wrote:
>> > Update the document and help text with s/value_regex/value_pattern/
>> > and say "use value_pattern as a fixed string, not an extended regexp",
>> > perhaps?
>>
>> If I go about changing all documentation and error messages to say
>> "value_pattern" instead of "value_regex", should I also update the uses
>> in the *.po translation files? Or, should I leave them unmodified to
>> trigger manual intervention by the translators?
>
> A minor request: If you are going to put in the work to make that
> substitution, perhaps change it to "value-pattern" rather than
> "value_pattern" since a hyphen is more common in documentation for
> this sort of thing than underscore.

Yup, I misspoke.  s/value_regex/value-regex/ unless it is a variable
name where '-' cannot appear.

