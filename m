Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D1C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 22:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJSWPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJSWPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 18:15:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CF15F935
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 15:15:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 618041C3295;
        Wed, 19 Oct 2022 18:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1kHfcrtIfZ44
        tsmEq3EveStOoDMwiYSSQlreulaQTXg=; b=w9AuP3tH2uFWplocqHN14/M3v6Ab
        5eToX3Xn0/3m6jgucTqFShg+Uats7OiVQnOusZ+LiVLzvRxN74w2FeXJ42d06QX+
        Eo3sIccUpBGdsKnrsD4vXbvAeY+R8gBG44YNnTfckSsasYXFrVfGoLCpJJsq6Vzk
        rQaSXa0vBW9gf+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58FF71C3294;
        Wed, 19 Oct 2022 18:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D6271C3292;
        Wed, 19 Oct 2022 18:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
        <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
        <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
        <xmqqo7u7srp4.fsf@gitster.g>
        <221019.867d0vhbsz.gmgdl@evledraar.gmail.com>
Date:   Wed, 19 Oct 2022 15:15:00 -0700
In-Reply-To: <221019.867d0vhbsz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Oct 2022 20:54:29 +0200")
Message-ID: <xmqqy1tbo3yz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A166E58-4FFB-11ED-8D43-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> There's things I can eject from this series, but I don't really find it
> to be "while at it" changes, I suspect what you're thinking of is
> one/some of:
>
>  - Re-arranging the Makefile commentary into sections: I did that
>    because now the structure is very much one-paragraph-per-flag.=20

And it does not have anything to do with "why doesn't macOS use
sha1dc as the default like everybody else?" fix.

>  - We're still claiming that we use OpenSSL by default, so I fixed the
>    docs in general (not just the Makefile). Would you like this to be
>    just a "we forgot OSX?" series?

A focused change s/We use OpenSSL as default/We use sha1dc as default/=20
goes well with "why doesn't macOS use sha1dc as the default?" fix.

>  - Ditto asking to provide NO_DC_SHA1=3DY now in addition to

Those who explicitly opt into DC_SHA1 do not need any new $(error).
Those who have explicitly chosen something else should not be forced
to say NO_DC_SHA1.

Let's make it a focused change that does one thing very well without
wasting reviewer's time on discussion on non-essential things.

I do not mean by "non-essential" that reorganizing Makefile comments
to make it easier to find and write relevant documents, or making it
harder to turn conflicting knobs.  They may by themselves be
worthwhile thing to do.  But in the context of "why isn't sha1dc the
default everywhere", they are non-essential distractions.

"why isn't sha1dc the default on macOS?" is also non-essential
distraction in the context of fixing "oops, we no longer build on
macOS unless Apple Crypto is used".

I've queued [1/4] with an intention to fast-track it down to
'master' (after cooking it in 'next' for a few days).

Thanks.
