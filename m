Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A640C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B9E6113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhGTT1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:27:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53120 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhGTTZs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:25:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63F94D368B;
        Tue, 20 Jul 2021 16:06:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HyXfpK5ZVW3R
        87qx1JzRnmRW5XcxQYx4mtlDKu136ZU=; b=jqVIAG/1h9tIwCuaXxxBFkxCU9ZJ
        hvELymUwMyypK/mHKjMhaEbikEgRc3ZbTa8KECkd4qxBTcR2l7MlrM6NkRUZSxpU
        OCJhSzYLWkz7iHuYW0HnrsGTLbdb7GCuojpcmenjQuCasbwzs8gowYNAtPm+sSf7
        p2bB1N0PsZ+eh80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C018D368A;
        Tue, 20 Jul 2021 16:06:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA077D3689;
        Tue, 20 Jul 2021 16:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 2/3] bundle doc: elaborate on object prerequisites
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
        <patch-2.3-a0f95ce3a1d-20210720T141611Z-avarab@gmail.com>
Date:   Tue, 20 Jul 2021 13:06:23 -0700
In-Reply-To: <patch-2.3-a0f95ce3a1d-20210720T141611Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Jul
 2021 16:20:25 +0200")
Message-ID: <xmqqsg08hhs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5423A3A-E995-11EB-A2F2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +A revision range such as `old..new` will produce a bundle tip that'll
> +that'll require the revision `old` (and any objects reachable from it)
> +to exist for the bundle to be "unbundle"-able:

Will squash in the following while queuing.

Thanks.

diff --git c/Documentation/git-bundle.txt w/Documentation/git-bundle.txt
index e7a685e533..6a45ced017 100644
--- c/Documentation/git-bundle.txt
+++ w/Documentation/git-bundle.txt
@@ -202,8 +202,8 @@ history that leads to the revision `new`:
 $ git bundle create full.bundle new
 ----------------
=20
-A revision range such as `old..new` will produce a bundle tip that'll
-that'll require the revision `old` (and any objects reachable from it)
+A revision range such as `old..new` will produce a bundle file that
+will require the revision `old` (and any objects reachable from it)
 to exist for the bundle to be "unbundle"-able:
=20
 ----------------
