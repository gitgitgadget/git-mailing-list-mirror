Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE63C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6CC610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhGTUV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbhGTUQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:16:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C06C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:57:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w188so604087oif.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YDdXbLdN4vBCdUd4Lxo2BJnuX38Dp12yMHJkfypy5yE=;
        b=nIUi034bnypwIjU9sebGkaZ+sf7k26QrmPOBOynLyqJdSnLcKueF1mASbkKLyzLmL1
         pU1I1+0gnw3vEgf4+KqdwyZ1ElgCsfFZUTX9XapceunUUaY/JKDGGb4PP8rFI63/cOLx
         GYE4SPxhqclxUI2carGWW9YUXuR6DQ7LbyDLZ1w58rGe9BJG7heolCjMxkNw624WmZyx
         0zCIAgx/dtZciERqaapjXdvyUgS3OT81jwpHzuNPj9/0yvRpyfCDRO5npJbWsYBJktNn
         lycPEya+GREkRQMbcWJuz3PdECZtEdFXzZNNCo1aIU95xljO1D7amgTdCSYiiRhVJq+Y
         5cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YDdXbLdN4vBCdUd4Lxo2BJnuX38Dp12yMHJkfypy5yE=;
        b=kxi45SGuwy87MLd9wOA2ByzTkI0XlczJEC/VskxKAgXnnfuFBYP8ZHByaco3ojNPX3
         MX98tWd0L0+6AFqBlEwC1q7pNqXns/95Ue5qxagEuputC6G5xQRYh9MpID3ft1ffFfCG
         4NF57JjA/HBCkpyyJLaluT1jIfzN8P75U0mWDhnQ/AaWxeQY7kQj+LUuGL6MW+TWFxs8
         RQJF40s9EamScFVdzyqYxCA2bQ0PqUzlmMrQo06Zm9l8yq0eyMh7VERCuO5b8IUHSaxe
         F38VAitzeVKHq99k2lFSNKtDVqXk7QkBsHg776EbYGZZCAlW1kOLg+Uyt6XUGKVbURs+
         hWpg==
X-Gm-Message-State: AOAM5333KmhyVglgu7eqzkACOV3vOGxkmZ3RgkUfZP9HBehwuAUVtaRd
        3IBnuIJPLJN7k1gJpt4Sunw=
X-Google-Smtp-Source: ABdhPJySmK2WttBV2ysgbO5jSMwPqmpozOEIF6j+SPVKkSsAdO0iAgDlIk94JkYEQEI4PV3n9Q71Mg==
X-Received: by 2002:aca:75c3:: with SMTP id q186mr3163779oic.86.1626814643886;
        Tue, 20 Jul 2021 13:57:23 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id s5sm4203985oof.29.2021.07.20.13.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:57:23 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:57:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60f738b161f2_14a79920870@natae.notmuch>
In-Reply-To: <patch-1.2-746d727113b-20210720T115052Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <patch-1.2-746d727113b-20210720T115052Z-avarab@gmail.com>
Subject: RE: [PATCH 1/2] bundle tests: use ">file" not ": >file"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Change redundant uses of ":" on the LHS of a ">" to the more commonly
> use ">file" pattern.

While this is redundant in bash, it's not redundant in zsh.

Probably not a big deal since I don't think the test suite can run in
zsh right now, but it's taking us on the opposite direction.

-- =

Felipe Contreras=
