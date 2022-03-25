Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8219DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355446AbiCYBSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiCYBSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:18:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF14BD7FD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:16:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35D69189840;
        Thu, 24 Mar 2022 21:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mfE7GnlrPcZL
        k3Kw51d5mJAH3BlkucKzARUMTh9VdP0=; b=ePx26dn8cnn905JNPYcfxd8JSoV0
        jKmhHkiJd4hy38m+XBxLYqN3/anxxfa1RiibBIhP4piSYt+0DxdA6fNWkLf7aQJL
        imI1yoB0YFPfjPT2ianLdZsVL2yHRpf2n7GP3JY8DXKPVONqHtMGLM1yyhqoDNrJ
        Zo58kjfNPZv3WuA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F7ED18983F;
        Thu, 24 Mar 2022 21:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93DF818983C;
        Thu, 24 Mar 2022 21:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 18/27] revisions API: have release_revisions()
 release "cmdline"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-18.27-424fac7ab95-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:16:36 -0700
In-Reply-To: <patch-v2-18.27-424fac7ab95-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:08
        +0100")
Message-ID: <xmqqsfr6de6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37ED8F50-ABD9-11EC-BD8C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> in-flight semantic conflicts.
>
> 1. https://lore.kernel.org/git/YUj%2FgFRh6pwrZalY@carlos-mbp.lan/
> 2. https://lore.kernel.org/git/87o88obkb1.fsf@evledraar.gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>
> fixup with bc0e0439040?

WTH is this line?

> diff --git a/revision.c b/revision.c
> index d9e2b171f6d..f44298299a4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2933,6 +2933,17 @@ static void release_revisions_commit_list(struct=
 rev_info *revs)
>  	revs->commits =3D NULL;
>  }
> =20
> +static void release_revisions_cmdline(struct rev_cmdline_info *cmdline=
)
> +{
> +	unsigned int i;
> +
> +	if (!cmdline)
> +		return;
> +	for (i =3D 0; i < cmdline->nr; i++)
> +		free((char *)cmdline->rev[i].name);
> +	FREE_AND_NULL(cmdline->rev);
> +}
> +
>  static void release_revisions_mailmap(struct string_list *mailmap)
>  {
>  	if (!mailmap)
> @@ -2947,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
>  		return;
>  	release_revisions_commit_list(revs);
>  	object_array_clear(&revs->pending);
> +	release_revisions_cmdline(&revs->cmdline);
>  	release_revisions_mailmap(revs->mailmap);
>  }

That patch is quite unexpectedly small ;-)

When I created cmdline, I recall liberally stuffing borrowed strings
in the array, sort-of knowinly making it unnecessarily hard to
"free".

Quite pleasing.

