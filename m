Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2FC11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2F261DA5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhF2EzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:55:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65167 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhF2EzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 00:55:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCBD0156A45;
        Tue, 29 Jun 2021 00:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Ju2TPFF+PFs3o5haFhGAXybms
        zALbd3mP95as8e9IA4=; b=a2SsrlHZL7QffuzKyGlnbVIkriJkZ7C3gzyLPM39w
        FEGEkNPrZhum3TGL+rdliq0nmplis7GTVQLQ7JsfEDJbw9JNQQF99pxYFOekOeDw
        ywqSknO6EK2S97WX21jyfIBGMKtqKMT78s+4ZkT8HbtrFo8tWv9Uz91ZZRMfuzjS
        3M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B58AF156A44;
        Tue, 29 Jun 2021 00:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 036CA156A42;
        Tue, 29 Jun 2021 00:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] bundle doc: split out thin v.s. not discussion
 from <rev-arg>
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
        <patch-2.3-63f871a0c72-20210624T193730Z-avarab@gmail.com>
Date:   Mon, 28 Jun 2021 21:52:38 -0700
Message-ID: <xmqqr1glz2zt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5018B1A-D895-11EB-8D3B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Split out the discussion of why you should or should not create "thin
> bundles" into a new section, away from the discussion of our handling
> of the rev-args syntax.
>
> See 2e0afafebd (Add git-bundle: move objects and references by
> archive, 2007-02-22) for the introduction of the documentation being
> changed here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-bundle.txt | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
> index 1b02f8b7468..f231f42b12f 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -42,7 +42,8 @@ header indicating what references are contained withi=
n the bundle. The
>  header is (mostly) in the format emitted by linkgit:git-show-ref[1].
> =20
>  Like the the packed archive format itself bundles can either be
> -self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
> +self-contained or thin, see the "OPEN (THIN) AND CLOSED BUNDLES"
> +section below.
> =20
>  See link:technical/bundle-format.html[the `bundle-format`
>  documentation] for more details.
> @@ -139,7 +140,20 @@ contained in the union of the given bases.  Each b=
asis can be
>  specified explicitly (e.g. `^master~10`), or implicitly (e.g.
>  `master~10..master`, `--since=3D10.days.ago master`).
> =20
> -It is very important that the basis used be held by the destination.
> +OPEN (THIN) AND CLOSED BUNDLES
> +------------------------------
> +
> +When creating bundles it is possible to create bundle tips that are
> +either closed or open under reachability, i.e. those that contain all
> +the history needed to get to a given point (closed), and those that do
> +not (open). A revision such as "master" will produce a closed tip, a
> +range such as "master~2..master" will not (unless the full history is
> +contained within that range).
> +
> +Another name for "open" bundles might be "thin bundles", as in the
> +`--thin` option to linkgit:git-pack-objects[1]. Under the hood that's
> +what `git bundle create` uses to write bundles. When thin bundles
> +it is very important that the basis used be held by the destination.

While it is true that "thin" bundle or packfile must have been
created with a commit range with an uninteresting end, presence of
the negative end in the range does not necessarily mean the
resulting packfile or bundle is thin.

If you want to introduce "open" to mean "some objects reachable from
the tip may not be present in the resulting pack/bundle", that is
perfectly fine, but "thin" is a different concept.  For a packfile
to be "thin", it has to be "open", but an "open" packfile can be
"thick".  Even though they are *not* orthogonal concepts, "thin"
packfile is a strict subset of "open" packfile.

What "thin" means is that such a packfile can store an object in a
deltified form against a base object that is not in the same
packfile.

