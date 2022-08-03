Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F5C19F29
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiHCPzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiHCPzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 11:55:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABF56B8B
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 08:53:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 316D71A869C;
        Wed,  3 Aug 2022 11:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hNKrO+BEoku3
        LQPBLUvK57UloRh1CsaH87yF67Sueo8=; b=qdzAieEGkxQ0atrFkjL80tAjLY2Z
        MOmZdQVWMf9IUDBldc3MW0YKG333XN9FJXyRNSXLZrRafNRD/bm3kFjlnfFaVmg4
        1G3oj3AAtIXCKM3NbnTEhj9Otd154cZ+YvwYk9CN5fpU7osHy5BCak0qhwfESLqt
        vvGw9uAjZKIsaV4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16D5C1A869B;
        Wed,  3 Aug 2022 11:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 965351A869A;
        Wed,  3 Aug 2022 11:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 07/10] docs: move protocol-related docs to man section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 08:53:33 -0700
In-Reply-To: <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:56
        +0200")
Message-ID: <xmqqbkt1cohu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E39D99C-1344-11ED-A448-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space. By moving
> the things that discuss the protocol we can properly link from
> e.g. lsrefs.unborn and protocol.version documentation to a manpage we
> build by default.
>
> So far we have been using the "gitformat-" prefix for the
> documentation we've been moving over from Documentation/technical/*,
> but for protocol documentation let's use "gitprotocol-*".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile                        |  8 +++---
>  Documentation/config/lsrefs.txt               |  2 +-
>  Documentation/config/protocol.txt             |  2 +-
>  Documentation/git-upload-pack.txt             |  5 ++--
>  Documentation/gitformat-bundle.txt            |  2 +-
>  ...ities.txt =3D> gitprotocol-capabilities.txt} | 28 +++++++++++++++--=
--
>  ...ocol-common.txt =3D> gitprotocol-common.txt} | 23 +++++++++++++--
>  ...pack-protocol.txt =3D> gitprotocol-pack.txt} | 24 +++++++++++++---
>  .../protocol-v2.txt =3D> gitprotocol-v2.txt}    | 25 +++++++++++++----
>  Documentation/technical/api-simple-ipc.txt    |  2 +-
>  Documentation/technical/http-protocol.txt     |  6 ++--
>  .../long-running-process-protocol.txt         |  2 +-
>  Documentation/technical/packfile-uri.txt      |  2 +-
>  Documentation/technical/partial-clone.txt     |  2 +-
>  command-list.txt                              |  5 +++-
>  refspec.h                                     |  2 +-
>  t/t5551-http-fetch-smart.sh                   |  4 +--
>  17 files changed, 106 insertions(+), 38 deletions(-)

OK, I see nothing unexpected.

There is a silent "oops that is a screw-up in the previous step that
can be buried in this patch that renames 4 files and hopefully nobody
would notice" included, which should be removed by fixing the original
screw-up in the previous step, though.
