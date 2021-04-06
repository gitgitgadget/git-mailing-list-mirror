Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93927C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CE061103
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDFUdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:33:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58162 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhDFUdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 16:33:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFF8112C9E7;
        Tue,  6 Apr 2021 16:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jvniM/GEuyz5
        R0HYkioU913Efks=; b=Ui39498l1YGrDXsBF9jbLnD9QICW682aIGRkIFeF9GrW
        IiOx5fXXkJcboRd/OBV/oBHcyHqELFMFalTs52EEROGywac/jWuGnuRddDjtBn7Y
        VfHVGkkbi8z3TjhT6LX6NffNZ0ZG4yobFVCKqxPvGrPixrhy3iNAzPVeSvqUhkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xg9223
        X8WK3lOsWJqDzKk+SI6s/+EkYW9R9gJ3Mit3EvHHwe5qbRhhP3WRWjDxS3pLw7y0
        NMILX1dhwxk7QGDreQS3f0tGZfevc6HrIW86jOLSw3O/KoTL5BRKEo8gKgeshHf1
        ehNSX/sThI+UP16f+gK0o0daQZAGUwEpDXBqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8C8012C9E6;
        Tue,  6 Apr 2021 16:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DD9B12C9E4;
        Tue,  6 Apr 2021 16:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 0/3] refactor duplicate $? checks into a function +
 improve errors
References: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
Date:   Tue, 06 Apr 2021 13:33:07 -0700
In-Reply-To: <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 6 Apr
 2021 16:00:34 +0200")
Message-ID: <xmqq35w32lx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CA30254-9717-11EB-8B9F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Version 3 yields the TREESAME end result as v2[1], but re-arranges the
> way we get there to make the progression more understandable, along
> with a minor commit message update.

Nice.  I see no more nits to pick ;-)
