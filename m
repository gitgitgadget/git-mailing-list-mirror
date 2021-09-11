Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE6C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C191E611CC
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhIKGyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 02:54:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62244 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhIKGyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 02:54:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6490ECB18C;
        Sat, 11 Sep 2021 02:52:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=lsKy9CAVE6gSRnefZQ3HNePDM
        +a5oOsu6VRFr3YnWoA=; b=DFJutzFswOzvX6hdpRMUqUFVGeFy2gQLmKDUtVos2
        OuoK7sEoYJICiHTZUrDWE7Jdnx2azCdsrWdfYiDUcDhXtQS1bEHlNO6y26+Iv1Of
        pH4k5E1rwjxESz99UFNxekjxgsOM9e9r7Kud/fiuwrcS9aMQnvMRyv6twJuyLD/h
        5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C483CB18A;
        Sat, 11 Sep 2021 02:52:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8082CB189;
        Sat, 11 Sep 2021 02:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] parse-options: stop supporting "" in the
 usagestr array
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <patch-v2-3.6-11f4a119563-20210910T153147Z-avarab@gmail.com>
        <xmqqlf44otbz.fsf@gitster.g> <87r1dvaksr.fsf@evledraar.gmail.com>
Date:   Fri, 10 Sep 2021 23:52:50 -0700
Message-ID: <xmqq8s03mwn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E196B474-12CC-11EC-87F2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But if we do that let's do that with an API where we simply pass this
> custom string in as another parameter to the function, rather than
> having a state machine to parse it out of the array we use for the
> "usage:" and "or:" list of lines.

Sorry, but I do not follow.  A perfectly fine way to encode the
three (usage:, or:, and text) kind of information in a single array
is what this step is breaking, and then you propose to keep the two
still in that same array, with only the third kind kicked out to
"another parameter", which does not make much sense to me.
