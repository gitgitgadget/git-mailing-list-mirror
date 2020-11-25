Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AACBC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F72206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YjmJ3o4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgKYTaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:30:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53786 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgKYTaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 14:30:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D048102EBF;
        Wed, 25 Nov 2020 14:30:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fkEofJ8h0JfJVkYZKPqgpil4epM=; b=YjmJ3o
        4N7KAck9ExIxhtss6Qk4KiJO7Y0zP87CIPImwCu9F+z4/rwZx/xFzAqBze7habG9
        sFxdOpdEcF3fnLVSt6isz7dV0Af3tXgRUTFHCU0dDHDjjdKFO1nNTMTlOpjfrA5q
        oCAZzHEttVEUAuacG6mRaCz+ziD5CA0ERricU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eFJzhVVSk57Po+ky10WxIzmyhR6xsgOO
        Q31+aEW3FMGfHwj6mLh48iJvbqYOP3AHGH9xfvBnhLB5S8wqnIkn0sNzZqL0Lzxt
        ayay+GR/WmTSbn66tkS78ew4PPQb9PfkOfGsk4P1ROtX0zXaUKsk8WH/u0rEcBkx
        CHpA2EXDB/k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53FC1102EBE;
        Wed, 25 Nov 2020 14:30:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D539102EB9;
        Wed, 25 Nov 2020 14:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
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
Date:   Wed, 25 Nov 2020 11:29:57 -0800
In-Reply-To: <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com> (Derrick
        Stolee's message of "Wed, 25 Nov 2020 09:08:15 -0500")
Message-ID: <xmqq8sapfd56.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B400EE6-2F54-11EB-A82F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/23/2020 5:41 PM, Junio C Hamano wrote:
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> 
>>>>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
>>>> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
>>> I'm not sure how to feel about this phrasing. I wonder if it would be
>>> clearer to say something like 'treat 'value_regex' as a literal string
>>> instead'? Hmmm.
>> 
>> Update the document and help text with s/value_regex/value_pattern/
>> and say "use value_pattern as a fixed string, not an extended regexp",
>> perhaps?
>
> If I go about changing all documentation and error messages to say
> "value_pattern" instead of "value_regex", should I also update the uses
> in the *.po translation files? Or, should I leave them unmodified to
> trigger manual intervention by the translators?

If you do, you do not have to worry.  The i18n/l10n coordinator will
update the po/git.pot file when we near the code freeze using an
automated tool that extracts strings from the sources, and the
po/xx.po files for languages are updated from the updated po/git.pot
mechanically with another tool, reusing unmodified entries, adding
new ones, and marking near-hit ones to help avoid unnecessary work
by translators.

I earlier thought that the "when matching values" phrase you chose
in this round, without such a clean-up, would be OK in the context
of this topic (which is depended on by a bugfix topic), but after
seeing how we need to clarify the way '!' negation prefix works in
the documentation that has deeply ingrained assumption that value is
matched using ERE, it may be necessary to bite the bullet and do the
regex->pattern now.

Thanks.




