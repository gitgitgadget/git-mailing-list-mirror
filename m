Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ADC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B848C20721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IGtIxZc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgKWX1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:27:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63609 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKWX1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:27:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 979CB8DDF3;
        Mon, 23 Nov 2020 18:27:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n+lOgcnE/b0PkB7kKTOLgG3pqnk=; b=IGtIxZ
        c6LIhW73A10+zdtxTVbClPAGfvT4K3QLj1sK8DfRof8PR/vWCg7MXnduphfYyOtV
        jqIwc/iT2ohWuyh1GfxdjrJtQmQOrG7Sv2qOMbp4FW6RMZuJ6c8QUQNraTTdwYra
        BnYiGUi9yTOehrzgZqlKF2sJsOjjFq4RVbm3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RT1E2s93UPfNVuLR0fM4O35cQkmNEf8Z
        dSwPeX1vQ8ZAlZZ9yqWNTIwMWLkqwy51I6MZuD07dRnb1uAdBPmdkiTNjIIr2tA2
        pvXpHpvLOmPCHPSrJbx274PQZ2PQpyVuhmmO5Hs9Lfxy9eFv7g0ZhplLOpvQPBo5
        ET44WDRkDbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D7F08DDF2;
        Mon, 23 Nov 2020 18:27:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 169408DDF1;
        Mon, 23 Nov 2020 18:27:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 7/7] maintenance: use 'git config --fixed-value'
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
        <20201123224814.GG499823@google.com>
Date:   Mon, 23 Nov 2020 15:27:44 -0800
In-Reply-To: <20201123224814.GG499823@google.com> (Emily Shaffer's message of
        "Mon, 23 Nov 2020 14:48:14 -0800")
Message-ID: <xmqqmtz7lklr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D7CF6A2-2DE3-11EB-86D8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Nov 23, 2020 at 04:05:07PM +0000, Derrick Stolee via GitGitGadget wrote:
>> 
>> 
>> When a repository's leading directories contain regex glob characters,
> Minor "well, actually" - I'm not sure 'glob' is the right word to use
> here.

A careful reader ;-)  "metacharacters" is probably what we want.

