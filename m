Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C419C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CEA61287
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhFHMdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:33:05 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:33301 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFHMc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:32:59 -0400
Received: by mail-ej1-f53.google.com with SMTP id g20so32386719ejt.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3RZ+vT116kHlGpa7UV3JFesWtEN9BvLjJpSFx1tnBVg=;
        b=PIZeMwW8I8AQQ4jE2PpYQpY6zpuPKl3xwhl2yYUS5ECDqYiq13ZzpN7Gi9fH/co+x0
         NT9w+ZgdrRYyv6S9CH3DI2XAQCJBCYnspYl3MPAATGDbTLB/Vi+BN0zTLg9QDE8JdQBI
         vjD94YDx6CSaBkzgUvIkRA272KqKmf3lTVXG+TIPf9BZ//n39PYJfoA6C3XgPQ5V8xAx
         gSWDxrm/FBRd9jgRNosGTpTYjJ5wCjib8X+vEGsYcUomRtwyjq7RoyPebYY3XZHwxIak
         J0rQE37/t+KTA0EK3s1K7LEvgNzD9wiHoTC+TSb37SUqhi/9gF4hWTqLWHAmZ56jUj4a
         j4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3RZ+vT116kHlGpa7UV3JFesWtEN9BvLjJpSFx1tnBVg=;
        b=YyQrppb3D/HZz07MmP6RMS5o7OSvOtTiQlkXYtCGyt6Z0VUTaftFQ0E/wTAB46F6c+
         Jn8bNbLqwT7V9rcucNu6GW/OQi4eO9hyXcu41qF9M1yMb0W6HSK8HREM45YwvdA+c23X
         IMC14HFxg6kBsQcPV7i1QR6LSrwxodswiZs/APPrJ+WjC54Z+kjXJgdECxNdPbUFIpGM
         FRHnGr7Vi38xacg41KuYqJsT4lXcphE5oJe626FzHM7vEocjpzTGf6/59I1un5u64/m+
         QlDu46olMC40abzP7D9DCyo5UKKsB48zAGUJ5D8EqKDE3pSkSAp3RDq2QD3U1EIJVD3/
         laaQ==
X-Gm-Message-State: AOAM531cv8X6Z1RsOUzwcHWUXIIdF5hoCdapd98dMa543ZBXggi+lAYx
        sr4z2IbaQRrsAR55cJqo3D4=
X-Google-Smtp-Source: ABdhPJzY3SptzGOU8B2wOmwh/OV7PKFutK3d0XMN/PUdD1usRkR9xpTi2Zt0E0EtI728XDl2ymE/Tw==
X-Received: by 2002:a17:906:3b92:: with SMTP id u18mr23008263ejf.450.1623155405674;
        Tue, 08 Jun 2021 05:30:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id kx3sm7546965ejc.44.2021.06.08.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:30:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #03; Tue, 8)
Date:   Tue, 08 Jun 2021 14:25:54 +0200
References: <xmqqeeddq7h5.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqeeddq7h5.fsf@gitster.g>
Message-ID: <87r1hc35f8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 08 2021, Junio C Hamano wrote:

> [New Topics]

Missing here is Jiang Xin's 2-patch series to fix a portability issue
with the "git bundle" tests:
https://lore.kernel.org/git/20210601144901.31375-1-worldhello.net@gmail.com/

It looks good to me, and it would be good to have it picked up for
merging to master sooner than later, as it's a rather isolated fix for a
portability issues in the tests.

If it helps consider it to have my:

    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
