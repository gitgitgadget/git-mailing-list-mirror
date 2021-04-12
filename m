Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBDC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D275461356
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhDLT1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:27:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60339 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbhDLT1c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:27:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E55111894B;
        Mon, 12 Apr 2021 15:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tdRUZxtoFjme
        9jIQIAZ1lb0XCxQ=; b=WQQ0DnHkmV8a6GYJoPeQ1a4SMZl+/dz7UTiV5U86+wG5
        rEzmaIu7DuBwQvRMrPMwEldRaQoJmqMb0MzQh3EqQ54coh3rdhUAjeqwNRlzJ8eh
        SnpsU6+4WMwz2IP24pr72tMD6xSSz5+I4z8TIb4kUTpx+A0Z+oPfHDPyR1NGCPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PMP8V9
        dHd9P42cS3zC0KGYz7Ahiz3G5iUmuNe3GalYtvbirAwJqpho32xSYd41mv4/Cmxb
        GfaWKLUayRnZ7a+UgQRIbb2ol/QeyH+tJIwZL2KBFQb5S9YlQv/E2B1mM2Hnqf/U
        H7qDrWz4k39dwbfAbRG+WGPfDitfmJKFilMlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F44711894A;
        Mon, 12 Apr 2021 15:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A33D9118947;
        Mon, 12 Apr 2021 15:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/16] test-lib: modernize test_create_repo() function
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 12:27:08 -0700
In-Reply-To: <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:09:01
        +0200")
Message-ID: <xmqqk0p7cnhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13BB29FA-9BC5-11EB-A560-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  4. We don't need to move .git/hooks out of the way.

It might be unsafe to assume that we'd never have an
'enabled-by-default' hook in blt/ template directory forever,
though.
