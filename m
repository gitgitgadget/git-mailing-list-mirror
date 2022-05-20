Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B7BC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 16:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351607AbiETQ1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351598AbiETQ1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 12:27:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB513326C
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:27:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F5AE19B0F7;
        Fri, 20 May 2022 12:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TilUiGwekPsk
        yFlKcUAwER5vTlFZaPh4ga9/25kfoZQ=; b=k1xqB3Oqk1cNnslzYqy3hi5NSntk
        rLQvqSczXNS9E06POzz5CRugn5cJ4Lj50KyrhDDXby3kPAsQfJKGuGVNEvlFO+tc
        Px8t51+3wzJV+dQDHM8VVMEpH8h2TrhJ66Sliu3xJDiZUQ8pLdD8/Z1phlzbjkKz
        ed6ofrrRkn1HZII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 885EF19B0F6;
        Fri, 20 May 2022 12:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30FED19B0F3;
        Fri, 20 May 2022 12:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] run-command.h: rename "env_array" to "env"
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
Date:   Fri, 20 May 2022 09:27:09 -0700
In-Reply-To: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 20 May
 2022 09:24:38
        +0200")
Message-ID: <xmqqilq0jhk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2A02152-D859-11EC-94A7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Follow-up 32ec72c3e1 (Merge branch 'ab/run-command', 2021-12-15) and
> rename the "env_array" member to simply "env" in the "struct
> child_process".
>
> Changes since v1:
>
>  * Added a commit to remove the coccinelle rule after its application,
>    as suggested by Junio in
>    https://lore.kernel.org/git/xmqqzgjdkxon.fsf@gitster.g/

I actually think we do not even have to tentatively add one, only to
remove it at the end.

Wouldn't a two-patch series whose=20

 - first patch does the real damage to the codebase, with the
   coccinelle rule as part of the commit explanation in the proposed
   log message (e.g. "the patch was mechanically prepared with the
   help with this Coccinelle semantic patch"), and

 - the second patch does the non-mechanical "comments and names"

work better than four patch series?  A single patch that says "the
code was mechanically updated with this s-patch, with names and
comments that refer to env_array in the surrounding code manually
adjusted" would also work well.
