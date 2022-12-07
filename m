Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535CC63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLGX5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLGX5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:57:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24644192A9
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:57:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a9so18567919pld.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDTo+Y7J7699qqxnfgw5x0wnufPM/GECMmeei0C4//0=;
        b=YMN+axxZBGVhMc9c3Zt1HABoq0D6WuLhkgPWCwptNyxFvawFmvepOp8q2adya+8sQv
         OQKdr/wr37XUoyLEMeBoJBOUOi4aUYKdGGjxmFuS/vll2wY2zHpvEAo8xLfp+PBZaWMA
         iOf04lVh9MHbmuP9FbJzv4/gnHx4oFexkfqEt/PokuyUQGk4uVn7Ua2OgSiLZNvmbvD8
         dMpZ/X664QI62PQ/h2ihOSaNYj7JvJ51mWzM+1gpPdzv+R27ehyQDUXMR9wKTJF8djDM
         y15AC8m79Xm3da3/3mzy+WQZqtCXU+fAAFbVv4b5xxvg16y7pgJGnPfRAJRK9k2JUdMi
         03Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDTo+Y7J7699qqxnfgw5x0wnufPM/GECMmeei0C4//0=;
        b=V1PKVjdwwZKydrKLreJ5/HxihZOzmDR/OUQv4MAkWCA8Sw1P6Co9xEQEdgsVjjYD+z
         aN1P05L/uHWIv1qpN4b9KE1+TnnffevxVPjG9L+B3Giho+Ls9RX5qOHdbrUjyDzKf69t
         f7wOCPiNQrn7SV0lSuPhgfYbfsdeXeqNFon/2ny3dWkOlAuvy0FkDFROm9yuLIFuFfib
         dqcXJM5/WZTkQ1Xw1GK6izbQrHBUfwORNcnFDucKa7tDifXMpsP5osiSM4/tvsy0GeEl
         jiizILAGxBfow57zGQcGRarZAIyY/YfCmPIy/NrE9EskJ4WMVEwVpNUwDAXyWkZMYsnx
         Dp8A==
X-Gm-Message-State: ANoB5pkYEVD7ZqpctJIKmAqF3oHJq4hr6NeU3Ddh45RG/DrY4dnMd02t
        8EY2Q6PIJ2/DT5GNzrIHSNWlqFV8hHb7bA==
X-Google-Smtp-Source: AA0mqf4jAgZaOQTB/QTt0TupOni7cN13a3gtws7/AerlFCiM0rAcjqEARIqG48K04Ti9E61FCtjDCg==
X-Received: by 2002:a05:6a20:841f:b0:a4:64c7:a7f1 with SMTP id c31-20020a056a20841f00b000a464c7a7f1mr2526720pzd.14.1670457459762;
        Wed, 07 Dec 2022 15:57:39 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b00576cc60e5c9sm7096416pfe.87.2022.12.07.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:57:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] CI: migrate away from deprecated "set-output" syntax
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
        <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
Date:   Thu, 08 Dec 2022 08:57:39 +0900
In-Reply-To: <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Dec
 2022 02:49:18
        +0100")
Message-ID: <xmqq359q6a30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>     +-          echo "::set-output name=base::$base"
>     +-          echo "::set-output name=head::$head"
>     ++          cat >>$GITHUB_OUTPUT <<-EOF
>     ++          base=$base
>     ++          head=$head
>     ++          EOF

Hmph, I do not trust this part.

The redirection operator "<<-" causes the leading tabs in the
here-doc-text stripped, but the .yml file does not indent with tab
to begin with.

I suspect the leading spaces will all be stripped and not seen by
the shell, so the distinction may not matter, which means the use of
"<<-" is very much misleading.

Let's stick to the dumb and proven

	echo "base=$base" >>$GITHUB_OUTPUT
	echo "head=$head" >>$GITHUB_OUTPUT

instead, which is used throughout the rewrite in this patch.

