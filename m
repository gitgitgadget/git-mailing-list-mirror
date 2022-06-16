Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CFCC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiFPSDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiFPSD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:03:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2016585
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:03:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A89F129895;
        Thu, 16 Jun 2022 14:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IHG316IZNi/H
        vsk4HbWJxSaAP8oOnnUWxWOhFMKoXAs=; b=I7NbuoRpQmlgAIUug5cyG7Jh2M11
        u8H46FgpqG/ALYyjexeknUnizVhz5WK5awOxDZdCXrWWW/zsrFOVQlIO0Gafu0ja
        pbbgys02sFUaaRmgf5uEc1zhE5OdCm7ndsNYiTxJWMFwUH/e60wNfD+EdGgXxQ2y
        5XETyip+j7iWPLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72479129894;
        Thu, 16 Jun 2022 14:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3EDA129893;
        Thu, 16 Jun 2022 14:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
        <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
        <xmqq8rpxw6ch.fsf@gitster.g>
        <220616.86o7yswyek.gmgdl@evledraar.gmail.com>
Date:   Thu, 16 Jun 2022 11:03:25 -0700
In-Reply-To: <220616.86o7yswyek.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 16 Jun 2022 15:02:03 +0200")
Message-ID: <xmqqk09gtriq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9EF0F3CA-ED9E-11EC-B5B7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But obviously that's a bad use of the varargs API, I just don't know ho=
w
> we've been getting away with it in practice, sorry about that.

Exactly.  We three all expressed our surprises on why it "works".
Nobody offered an explanation, though, which leaves us in suspense
;-)

> The fix Peff's got here LGTM. I can (re)submit it with
> format-patch+send-email after giving it a commit message describing the
> issue if you'd like, but the change would be the same.

Yup, I think the code change there looks the most sensible.

Thanks, all.
