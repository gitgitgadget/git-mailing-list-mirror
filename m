Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D473C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiG2SpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2SpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:45:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242980538
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:45:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CFE61A4F19;
        Fri, 29 Jul 2022 14:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eB0xOhXVo8dy
        STjWKhjUpJuuXOdpJSPZjssWHXu7sfc=; b=tO5Jxw47Fg/JfeBJ/3wpNNAWzXHT
        RyeQIU9vyiLwPIN/9KaTwmGCiy8O4IGVKlcWVrN3EVz8x2u+f+7BbpjnCtbIep+2
        rgQszeGwKMCrCiV8K30nAjgQUpJISFMlTKDNTqbFL+AppIVLe/Nc67uAjLNriUBn
        5a0jmbM2V0vQxRw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 768741A4F18;
        Fri, 29 Jul 2022 14:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 106F91A4F14;
        Fri, 29 Jul 2022 14:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/6] log: make the intent of cmd_show()'s
 "rev.pending" juggling clearer
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <patch-v2-3.6-1629299f883-20220729T082919Z-avarab@gmail.com>
Date:   Fri, 29 Jul 2022 11:44:59 -0700
In-Reply-To: <patch-v2-3.6-1629299f883-20220729T082919Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 29 Jul
 2022 10:31:05
        +0200")
Message-ID: <xmqqwnbv69n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D5CBB66-0F6E-11ED-8551-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Adjust code added in 5d7eeee2ac6 (git-show: grok blobs, trees and
> tags, too, 2006-12-14) to use the "memcpy a &blank" idiom introduced
> in 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
> macro, 2021-07-01).

Once we start using the "copy blank object to clear" pattern, we may
want to go all the way to use structure assignment instead of
memcpy().

