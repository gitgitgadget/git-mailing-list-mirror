Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE7C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiGYOiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiGYOiY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 10:38:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463A13E97
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:38:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so20973935ejs.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O83PpBAraMRgGZj3p7O/DQKK0k3qcVYM2dKoQYX88cg=;
        b=mkGyEWIY1q85Vj/iIfCB8Ed3vi7JC1e5rW+Sjar12On/VYmlwqhrbffP0dmAJKMQLP
         0aoQFAG1go3LTE6zNuI8FoDPIQuSh5sMoXdRklCsBMtZpzU2ucMulY0/igF4DXAhUVvO
         9pLC5Vyj2CKlCaUQubJDwnOjvzwX9TpUBkjI6UHz+srW3NbPeYaMk06QdqNRTbphd2KL
         FgxJGedZAISAWeqMKec2C1d0wwkUjWYDwgA4o0cqVPrCMzcj3XKI3U2ic4u9OdrzACBW
         osDfT4ay1t8YFtxq0KCkSxcf9arYzuco+i9iLcnhIAYGltQYEZabpQNmKpWb09ZElDFa
         gYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O83PpBAraMRgGZj3p7O/DQKK0k3qcVYM2dKoQYX88cg=;
        b=iO483YWnsYL+YdB1rD6OhxYfpWEyKkgcKZxArLYnGOUILpv31OHUaU4LC57ym0EP1S
         a9+YXJYJFhJhxhM/HEr3EhPobO+68Ncv6we4oOb8XBLp8bMtHUFZzb/qk6rRZUfnaBzX
         p3DzcYaQeyXKAkK16OrlEgVt71xE3D1jmkDuzvJNP6vIy+5yd8tP02Vpf/L02zKSCA6V
         UHr3m0dPweCoHCYMzXklY9/beu6AxyASOVPqsluGRYEuaWcONTspsKaJbqv1DRRWYo1o
         B/GmPpa2gWhivvg+GBTRD4xE39ll188zeGQjJeTql5+rrR2fgYjmqrJW1ZsQLhgF9MAg
         jPwg==
X-Gm-Message-State: AJIora8mtrDqu+THlgxSUcyATs9N5FGQKvQIMa+X5cxobEi5X4pxieXn
        Q172vrbBewf6eFCMstKthG80KXUwbic=
X-Google-Smtp-Source: AGRyM1uVzw/Sl3pq+pgdd3yQTMZIlqlQLr+Zeh+cfzhjO85E9o+oUNb4s+x1S51/m7zZO51dlMKstQ==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr10266050ejc.81.1658759901492;
        Mon, 25 Jul 2022 07:38:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7cf98000000b0043aba618bf6sm7235325edx.80.2022.07.25.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:38:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFzDw-005kIS-3j;
        Mon, 25 Jul 2022 16:38:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/20] t5505-remote.sh: check the behavior without a
 subcommand
Date:   Mon, 25 Jul 2022 16:37:20 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-4-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725123857.2773963-4-szeder.dev@gmail.com>
Message-ID: <220725.86ilnlp89v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

>  t/t5505-remote.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 6c7370f87f..f075dd4afa 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -241,6 +241,35 @@ test_expect_success 'add invalid foreign_vcs remote'=
 '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success 'without subcommand' '
> +	(
> +		cd test &&
> +		git remote >actual &&
> +		echo origin >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'without subcommand accepts -v' '
> +	cat >test/expect <<-EOF &&
> +	origin	$(pwd)/one (fetch)
> +	origin	$(pwd)/one (push)
> +	EOF
> +	(
> +		cd test &&
> +		git remote -v >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'without subcommand does not take arguments' '
> +	(
> +		cd test &&
> +		test_expect_code 129 git remote origin 2>err &&
> +		grep "^error: Unknown subcommand:" err
> +	)
> +'
> +

This can be shortened quite a bit by getting rid of the sub-shells:
https://github.com/avar/git/commit/e8eebd4eef6

But that version came from an earlier version of yours without those -v
tests...
