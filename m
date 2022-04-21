Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17921C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442267AbiDUWAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356189AbiDUWAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:00:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A24D27D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:57:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8043B197361;
        Thu, 21 Apr 2022 17:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=HslFwAXJaEgrnewJ3FcCEy5dC
        w6auLL/nfsriTzkZZI=; b=H4acD8MfzMICYeQU5pviYLtVGAGyMR1PyGKBm6tNY
        j5sF2E8ekbPUoQcfJxrXT2xifpEZZODUNX2f6SPDIXT37Y6sPT1W3tQlRJxu1Tbm
        ppPcHhWCRWBWPPLfJ9KRSq4sRT3t7m9t9oBqpzihn9UGrHAkw+eF5xznd8Gw9j9A
        sc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77EB319735F;
        Thu, 21 Apr 2022 17:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0486119735D;
        Thu, 21 Apr 2022 17:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] CI: don't fail OSX tests due to brew v.s.
 perforce.com mis-match
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 14:57:37 -0700
Message-ID: <xmqqr15qdrqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F8ACC30-C1BE-11EC-9220-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Junio: Despite modifying CI stuff this series merges cleanly with
> "seen", and has no semantic conflicts with any outstanding CI changes.
>
> For the past days we've again had CI failures due to "brew install"
> detecting a SHA-256 mismatch when trying to install the perforce
> package[1]. E.g. "seen" is now failing: https://github.com/git/git/runs=
/6104156856?check_suite_focus=3Dtrue

Yup, it was something I've been disturbed by and planning to ping
folks about if it continued.

> This occurrence of this issue will no doubt be fixed within a few days
> as the homebrew-cask repository is updated, i.e. this recipe:
> https://github.com/Homebrew/homebrew-cask/commits/master/Casks/perforce=
.rb
>
> But for our CI usage being this anal about the check isn't worth it,
> here's a passing CI run where we simply forced the installation:
> ...
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   CI: run "brew install perforce" without past workarounds
>   CI: don't care about SHA256 mismatch on upstream "perforce" package

I dunno.  Does it open us to a new attack vector in some way?
