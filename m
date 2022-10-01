Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46779C433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 01:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiJABNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 21:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiJABMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 21:12:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F92B7CD
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 18:09:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B93A715ED97;
        Fri, 30 Sep 2022 21:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=783qU95wnumVeSw146w85hLjW
        zR98WgJhf9UdTMjHeY=; b=x4hSQCwtFImsVkEgQ3jqjXj16zST+lNxNvGQtDy1+
        Iz91h4S9XM12Ysu+7tkkmQHH4H45CCteWEeNML1B6dQ0eX6Hatyfp1wcx29V4ezW
        EVzxEC+DR7wbdruGEScn/e2QJ5w07zksAoz/Dmw61of7mKvyU4Xljbri8+46oJwV
        +w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD95215ED96;
        Fri, 30 Sep 2022 21:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0066215ED95;
        Fri, 30 Sep 2022 21:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/36] doc txt & -h consistency: fix incorrect
 alternates syntax
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-11.36-7794c3d6ef5-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 18:09:02 -0700
Message-ID: <xmqqy1u05p01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A40C60B2-4125-11ED-B43E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix the incorrect "[-o | --option <argument>]" syntax, which should be
> "[(-o | --option) <argument>]", we were previously claiming that only
> the long option accepted the "<argument>", which isn't what we meant.
>
> This syntax issue for "bugreport" originated in
> 238b439d698 (bugreport: add tool to generate debugging info,
> 2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
> create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
> "bugreport" documentation and code.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/bugreport.c | 2 +-
>  builtin/diagnose.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I think we saw exactly the same pattern in an earlier step.  If the
patches in this series are split along the type of fix, then these
two and the other patch fall into the same category.  Another way to
organize is to split per file boundary, but I think these two paths
are fixed up for different problem in later steps.  I think split
along the type of fix makes much more sense, if we can, than split
per file, so I am almost OK with the current organization (probably
with this squashed into that earlier step).

> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index faa268f3cfb..23170113cc8 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_i=
nfo, int nongit)
>  }
> =20
>  static const char * const bugreport_usage[] =3D {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format=
>]\n"
> +	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <fo=
rmat>]\n"
>  	   "              [--diagnose[=3D<mode>]"),
>  	NULL
>  };
> diff --git a/builtin/diagnose.c b/builtin/diagnose.c
> index 28c394a62a5..474de9ec647 100644
> --- a/builtin/diagnose.c
> +++ b/builtin/diagnose.c
> @@ -3,7 +3,7 @@
>  #include "diagnose.h"
> =20
>  static const char * const diagnose_usage[] =3D {
> -	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>=
]\n"
> +	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <for=
mat>]\n"
>  	   "             [--mode=3D<mode>]"),
>  	NULL
>  };
