Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFBEC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhL3Wgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:36:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhL3Wgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:36:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D45BE10F00A;
        Thu, 30 Dec 2021 17:36:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hXTWrj6DwxDq
        ln9KRF8wXM2eTLZnScVlOTkPLuQZr1k=; b=gpxN9bXke3+QXDUzwzQQI7irWb7T
        /So1PgnNx50zOw9SQxWTfVJC8j+rhWsA75QAMqwQr7xrzUHA3ApEE+CwpPCvLMMi
        U30F2KdCgq2EzuDlfzwzLRvz+ZuINeKEBIjwUXsDFRGGTicaLmT0dH8mC70dGzi8
        zOmznTojqYAWDDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC63610F009;
        Thu, 30 Dec 2021 17:36:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AC9410F008;
        Thu, 30 Dec 2021 17:36:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 07/11] i18n: factorize "no directory given for --foo"
In-Reply-To: <4c17e08b9d3a42375c7082d5d2275ea8cc4fab99.1640804108.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Wed,
 29 Dec 2021
        18:55:03 +0000")
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <4c17e08b9d3a42375c7082d5d2275ea8cc4fab99.1640804108.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 30 Dec 2021 14:36:44 -0800
Message-ID: <xmqq4k6ppvnn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F7BCAEF2-69C0-11EC-9C45-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

>  		} else if (!strcmp(cmd, "--git-dir")) {
>  			if (*argc < 2) {
> -				fprintf(stderr, _("no directory given for --git-dir\n" ));
> +				fprintf(stderr, _("no directory given for %s\n" ), "--git-dir");
>  				usage(git_usage_string);
>  			}
>  			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);

None of the originals of these three uses it, but I wonder if we
want a single-quote-pair around %s.

