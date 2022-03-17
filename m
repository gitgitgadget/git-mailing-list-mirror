Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A4C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCQRl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiCQRlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:41:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75A3160688
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:40:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E60341016CD;
        Thu, 17 Mar 2022 13:40:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cq9VdR8m9/U5
        i1/5eABgmiFZwUlyZT34CmE7cbX5WoY=; b=nLnGbk/t5CQ0nP2JiUspgD4x1nQi
        P0heIYKAw5ZlH3fuqxqXP54bp7luWoBzmbd+GRc18zdJNX5UtG05xJlM4Ot1sct9
        t4hz6z1T7aCNPiRpNgW2rYYkIL+hOBx3v80fAUejEuURzFK5ROzVaSi9ZhL+Fq2A
        TcLqTxrKRYF9MNw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D82201016CB;
        Thu, 17 Mar 2022 13:40:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9F071016C9;
        Thu, 17 Mar 2022 13:40:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/5] packed-backend: remove stub BUG(...) functions
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
        <patch-4.5-c9a7004bc38-20220317T171618Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 10:39:59 -0700
In-Reply-To: <patch-4.5-c9a7004bc38-20220317T171618Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 18:27:18 +0100")
Message-ID: <xmqqlex8h40g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 467A8B92-A619-11EC-B78A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -	.for_each_reflog_ent =3D packed_for_each_reflog_ent,
> -	.for_each_reflog_ent_reverse =3D packed_for_each_reflog_ent_reverse,
> -	.reflog_exists =3D packed_reflog_exists,
> -	.create_reflog =3D packed_create_reflog,
> -	.delete_reflog =3D packed_delete_reflog,
> -	.reflog_expire =3D packed_reflog_expire
> +	.for_each_reflog_ent =3D NULL,
> +	.for_each_reflog_ent_reverse =3D NULL,
> +	.reflog_exists =3D NULL,
> +	.create_reflog =3D NULL,
> +	.delete_reflog =3D NULL,
> +	.reflog_expire =3D NULL,

Yup, the entry in vtable being set to NULL is a more direct sign the
readers would appreciate than a name natural for the method, whose
definition needs to be consulted before the readers can realize that
it is a "missing" method.

Very sensible.

Thanks.

