Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7194DC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHITqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHITqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:46:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9ED10E0
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:46:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC2AB18911E;
        Wed,  9 Aug 2023 15:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VsHGCrdI886xNtjpf5Zz+HaId/yKjFt3OOyWr0
        3jvh4=; b=AQobFt6TaBwvguJiVcrHymcpqkHIuZDAMt4E7iR8CjoCWFronmdQHY
        gUZSmPj3UpsmH9gn0csaOgS4NTgDw27MAfPPKWcmwx6ANz3Fy9PLr0XlQ8OHhOGC
        gUAJG5ohDE4hcxvsRld/PJOZJ1FeAphVqCoTej1dD5UVx1MU3rJc8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3ECF18911C;
        Wed,  9 Aug 2023 15:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50D0218911B;
        Wed,  9 Aug 2023 15:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9001: fix/unify indentation regarding pipes somewhat
References: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 12:46:36 -0700
In-Reply-To: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:31 +0200")
Message-ID: <xmqq350sm21v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73D34E06-36ED-11EE-BACB-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> @@ -61,8 +61,8 @@ test_no_confirm () {
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$@ \
>  		$patches >stdout &&
> -		! grep "Send this email" stdout &&
> -		>no_confirm_okay
> +	! grep "Send this email" stdout &&
> +	>no_confirm_okay
>  }

It is hard to see what is going on here, but ...

> @@ -1197,7 +1197,7 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
>  	--smtp-server="$(pwd)/fake.sendmail" \
>  	outdir/*.patch &&
>  	grep "^	" msgtxt1 |
> -	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
> +		grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"

... I do not think we want this.  A long pipeline should be written
without extra indentation like

	A |
		B |
			C

but more like

	A |
	B |
	C

If we do not have it in the coding guidelines document, perhaps we
should add an entry for it.

Thanks.
