Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BEDC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiBTUMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:12:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbiBTUMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:12:30 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056926119
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:12:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47BED179963;
        Sun, 20 Feb 2022 15:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rcg9kyE2Cg3X
        j2gMQ1QmFmpoOE1CFHVH/onj7hTYomc=; b=iGypCfo1OLZ/GyC0d1S559UvfArV
        na4+pF8z/0IIFy0c+qjMUxCrdwKAPIvlCso4eARXKjz8GvX9eqbVuVdIGTVaQNsS
        HSmDpZdfL/uPJzemap6L0YBS7B4Ke8Kr1HMOftw418ly2l95+OKrayOCn8x1Ym7f
        u/br1jHtNFEGonI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4010C179962;
        Sun, 20 Feb 2022 15:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A98AA17995E;
        Sun, 20 Feb 2022 15:12:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH v3 3/3] trace.h: remove never-used TRACE_CONTEXT
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
        <patch-v3-3.3-27ea260bbea-20220219T103752Z-avarab@gmail.com>
        <xmqq5yp9wxt1.fsf@gitster.g>
        <220220.86fsodd7sm.gmgdl@evledraar.gmail.com>
Date:   Sun, 20 Feb 2022 12:12:02 -0800
In-Reply-To: <220220.86fsodd7sm.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 20 Feb 2022 13:38:43 +0100")
Message-ID: <xmqq1qzxwb59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E9BF4D4-9289-11EC-93D7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Perhaps you'd like a v4 without this. It isn't strictly needed, but
> where I'm going with this series is improving the usage.c output/passin=
g
> of these __{FILE,LINE,FUNCTION}__.

My stance is that

 * the removal of this indirection is so small that the current
   series can live without it---in fact, it does not benefit the
   current series at all---the only thing it brings us is a possible
   breakage for those we failed to consider their use case.

 * the removal of this indirection is so small but a future and
   unrelated usage.c improvement may benefit from it, so it should
   be justified within the context of that future series.  It still
   may break the same folks whose use case we did not consider, but
   the other "improvement" in that future topic may offset the
   downside.

So ...

> ... since those functions won't deal well
> with replacing a __FILE__ "just pass whatever data you'd like here".

... leave that as the justification for the _other_ series.  It does
not belong here in this series.
