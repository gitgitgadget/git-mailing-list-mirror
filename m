Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF8C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359321AbiFVPXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359232AbiFVPXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:23:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645221144B
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:23:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1F991A9BE1;
        Wed, 22 Jun 2022 11:23:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A1Mw5Z0rem4y
        3SPkgquvRq1Vg7btxyEC1QzGdCzkxWg=; b=Kb5GMJmpPhfYgncsip3a41Gapa+l
        QQId1ZcRjDg0434dITPY1CSrweeTGj3Rl/27fLlSBGmJ6sHmnAOHgdkeycfPAw7J
        TzIrRJ0W+LdMA0qT7HLwSyC1btehcTF4TSSIp7/JQHzR3iY+EDsKJsNVbk23tl/o
        Ds0zUfYpO9FKZyU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A0931A9BE0;
        Wed, 22 Jun 2022 11:23:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B5EA1A9BD7;
        Wed, 22 Jun 2022 11:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Dimitriy Ryazantcev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: Re: [PATCH v2] i18n: mark message helpers prefix for translation
References: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
        <pull.1279.v2.git.git.1655819877758.gitgitgadget@gmail.com>
        <220622.86v8stkt1g.gmgdl@evledraar.gmail.com>
Date:   Wed, 22 Jun 2022 08:23:44 -0700
In-Reply-To: <220622.86v8stkt1g.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 22 Jun 2022 10:12:51 +0200")
Message-ID: <xmqqbkuk7mdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4EEBB9BE-F23F-11EC-BCA3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I posted this patch[1] to do the same a while ago, except it also
> translates the "BUG: " message:

We should take this one, exactly because it does not touch BUG();
the messages given to BUG() are not marked for translation, and
translating only the "BUG:" prefix does not make much sense.

When BUG messages are shown, it is better if they are conveyed back
to us exactly.  It would be cumbersome to near-impossible, depending
on the language, if a message was given back to me in a script that
I do not even know how to type---I'd need to map it back via po/*
files with "grep" to locate where the message came from.

Besides, BUG messages are meant not to be seen.  We could discuss if
it makes more sense to translate the messages and spend engineering
resource to mark them with _() while massaging the messages to help
deduping, but because the messages are meant primarily for identifying
the locations and not explaining situation to human user, I do not see
a huge benefit doing so.

Thanks.
