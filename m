Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75510C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365C222D05
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgLPAZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:25:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPAZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:25:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0358509E;
        Tue, 15 Dec 2020 19:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NR/ausZ9I24k
        ylOmOrZ5nXQnJNI=; b=Rd3BujRIo1ndkgUQLrZ3f9jKslUexouW0BnD2Rfvu3zV
        8582dk0bROTiIb7FvdSKRth3Q29hWznQWzmcO6kzeZ05URdRHlx71JAQidquLDqK
        lYLNn0L+al40VxIFSiyllSYSngdlOuJLR2sCDxFr/M5MJnA/pr5fGEl2VafuR0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bvGNnX
        E5wXxpChOeOph8RUdHe4AjPEl8hTcarkFU+b96nMISYjtwSDT0wy+PrDwS9LxcQI
        8diRXrSUhnoBYLM8uLYTvHlCOBPaAvGx7f24kXhh7oAH2GzJ9wNf7rUJqY87pCkp
        QK4z+VgrUOSPnTZX/YTADE5dapt4nQVOzGobI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B52A38509D;
        Tue, 15 Dec 2020 19:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 037618509C;
        Tue, 15 Dec 2020 19:24:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] strmap: do not "return" in a void function
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
        <20201215235027.10401-2-avarab@gmail.com>
Date:   Tue, 15 Dec 2020 16:24:21 -0800
In-Reply-To: <20201215235027.10401-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 16 Dec 2020 00:50:26 +0100")
Message-ID: <xmqqzh2e61je.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B4C44DA-3F35-11EB-B4D8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> On SunCC this is a hard error, and since this code first appears in
> the v2.30-0-rc0 release it won't build on Solaris SunCC.

I think we already have a fix for this.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  strmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/strmap.h b/strmap.h
> index c4c104411bf..1e152d832d6 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintm=
ap *map, const char *str)
> =20
>  static inline void strintmap_remove(struct strintmap *map, const char =
*str)
>  {
> -	return strmap_remove(&map->map, str, 0);
> +	strmap_remove(&map->map, str, 0);
>  }
> =20
>  static inline int strintmap_empty(struct strintmap *map)
> @@ -249,7 +249,7 @@ static inline int strset_contains(struct strset *se=
t, const char *str)
> =20
>  static inline void strset_remove(struct strset *set, const char *str)
>  {
> -	return strmap_remove(&set->map, str, 0);
> +	strmap_remove(&set->map, str, 0);
>  }
> =20
>  static inline int strset_empty(struct strset *set)
