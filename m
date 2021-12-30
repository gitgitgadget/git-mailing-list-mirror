Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF9C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhL3Wgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:36:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56961 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbhL3Wgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:36:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EED110CFEB;
        Thu, 30 Dec 2021 17:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=69nB0a4jOSOz9uAoKjXkK9cXL
        LoHPfXAJFHQ2LA1NnM=; b=MMgtxklWYqyMCWC9iVjIVC02CYATbLbqh+YiZKJ5W
        y2SiKW6ByeY7PaqUspdPE4VF+x9uIIn1ansL90Jcl8ylpyaE3IoZyTJ/DthTwrK4
        HtmYp9ylT8sV2E8O+akC4J/sn4kRxa5pILkldWC6Rmtf/sdRysL78vYAkOdJoFnF
        eg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 776EB10CFE7;
        Thu, 30 Dec 2021 17:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2F8710CFE6;
        Thu, 30 Dec 2021 17:36:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 11/11] i18n: turn even more messages into "cannot be
 used together" ones
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <12c5da8108752cd70b5b0147fd58c7280ebb3099.1640804108.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 14:36:45 -0800
Message-ID: <xmqqy241oh36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8B38A38-69C0-11EC-8B29-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Even if some of these messages are not subject to gettext i18n, this
> helps bring a single style of message for a given error type.

Makes sense, but ...
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 067ec53d69f..dcaa3b5f395 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -566,7 +566,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
> =20
>  	if (pathspec_from_file) {
>  		if (pathspec.nr)
> -			die(_("--pathspec-from-file is incompatible with pathspec arguments=
"));
> +			die(_("'--pathspec-from-file' and pathspec arguments cannot be used=
 together"));

Don't we want the literal `--pathspec-from-file` outside the format
string to prevent it from l10n?  Or have all the changes in this
series to turn _("use '--concrete-option-name' in message") into
_("use '%s' in message") with '--concrete-option-name' as an
argument done only to reduce the number of distinct format strings?

I just skimmed the rest of the patch but the above comment seems to
apply to all the hunks.

Thanks.
