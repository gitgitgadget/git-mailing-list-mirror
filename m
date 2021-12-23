Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B57C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhLWWmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:42:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56984 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWWmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 17:42:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A668D16B589;
        Thu, 23 Dec 2021 17:42:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GVSywTrIAdi5
        MD5+B0X0nUI8Ezx5o2aD4jrB+39ydoQ=; b=SFGUZ/BjU0oVPj+YTLMjpkTp5bB5
        dYZIKR1XoZrsQlND/coTU51KhuuN7fgtZhLJ94kSf96k7ktPBzVlBlWDYEipnA/t
        uBOU5SLjmLu9eHe/B7LN/aVhocBb9/pXU0UVMX9BNQ3tBqhFcyS8YgNFnIxjOjGj
        8b+5dS2Gf2zaFcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EF4B16B588;
        Thu, 23 Dec 2021 17:42:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9920A16B587;
        Thu, 23 Dec 2021 17:42:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 2/6] object-name: explicitly handle OBJ_BAD in
 show_ambiguous_object()
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
        <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
        <patch-v5-2.6-ee86912f1c1-20211125T215529Z-avarab@gmail.com>
Date:   Thu, 23 Dec 2021 14:42:10 -0800
In-Reply-To: <patch-v5-2.6-ee86912f1c1-20211125T215529Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 25 Nov
 2021 23:03:40
        +0100")
Message-ID: <xmqqr1a36j0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9161FC36-6441-11EC-8450-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
> index ae1c0cf2b21..f1948980dff 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -100,7 +100,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrup=
t loose blob' '
>  	error: unable to unpack cafe... header
>  	error: inflate: data stream error (incorrect header check)
>  	error: unable to unpack cafe... header
> -	hint:   cafe... unknown type
> +	hint:   cafe... [bad object]
>  	hint:   cafe... blob
>  	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path n=
ot in the working tree.
>  	Use '\''--'\'' to separate paths from revisions, like this:

OK.
