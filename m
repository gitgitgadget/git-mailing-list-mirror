Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DAC38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 04:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjATEqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 23:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjATEp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 23:45:28 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD51C6393
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:40:40 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15b9c93848dso5086304fac.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9uI0wR6ApI0/JXTzj0oZGnZqXncfUQcuDkuAN6qLO0=;
        b=F3LsktsCNHfv4HU+c8oeN+4HM6s3uk1y8e1qvYqTtAU7CRGDqEv0uj1Jf3L804kJV8
         dtDAGlidMW2GFQ4P4l7oPfG0wAt/08e+3bSLVcSRxr4XsqfJNAFWA8GM5W69KKBwcc4r
         x6TQbBtjyzb5QR2JFcvD6aZ9GUiINKN3npk0pV3gB27IQjSJKstWsdHGU8qfzvcVD+bL
         MR5JrLJNf/5fQgNdxOUzvSv3zfOJWY5UYKlxFlEOPDsHAF2LWNXGI9a3UCLrh+9Up/NK
         r3ZYpwAr6Mg5ggeOV2B9Q2Iy2tMBMftflpUJvLOHr53rB3tln3ngR4AI2DSIO/LO+f+w
         itVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9uI0wR6ApI0/JXTzj0oZGnZqXncfUQcuDkuAN6qLO0=;
        b=xKEX1mJtcu3KrjvhmDSSZzH3JYUrwrqHMz3+gXhF4Q6Y8NjztLtLFrjp95ml6pFioy
         wt6+j7QVvxgITxIs0k346o6CJ1hz8eQspLci5t6l0NR+tqV4hF4l+tJXRRomuLWIEHIw
         KrW+r5bSSFE93lmCPXk90avLCFpJPTvNh6dNfvlqywzEgBOU2pYC3medZcJ5T4BOOBYQ
         knoVAMWjfBZdx9X8EsYL26NifhSPGo82RQcFc9+6/IRXeFRzQWmU1UtW5H22pveTKgMg
         WFyaZCMynne0KxvuVKFe49cnoweVS20I1OJ0ilb3/qhbQ9e4yhhd/zPxh1+ufhY2N0fc
         lKEA==
X-Gm-Message-State: AFqh2kqtmu5NmILkAVqtf2g9XwOLQEBuO/49IrZOSGYI4dTT7fdWbqr2
        rNy32KWUdJ5yXdeM23n6SuQtFaUAmBKt/HugsaiPk+Wn3PE=
X-Google-Smtp-Source: AMrXdXuWU6JurNod1Rx5x5cvawwDhWiJJehytLnBZa6jzL8etM1BAwmxn5LixsPmPDBlBHejzGIUMNF15YkAeMQITeY=
X-Received: by 2002:a05:6870:bc01:b0:15f:33b4:879b with SMTP id
 oa1-20020a056870bc0100b0015f33b4879bmr914875oab.59.1674189593006; Thu, 19 Jan
 2023 20:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20230118061527.76218-1-carenas@gmail.com> <20230119055325.1013-1-carenas@gmail.com>
 <xmqqa62dzyst.fsf@gitster.g> <CAPUEsph5phu8z=nYJt=zRh7q40-BwKuzhVQ-F=iLQppd9gR5hA@mail.gmail.com>
In-Reply-To: <CAPUEsph5phu8z=nYJt=zRh7q40-BwKuzhVQ-F=iLQppd9gR5hA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 19 Jan 2023 20:39:41 -0800
Message-ID: <CAPUEspikKmUMxCDYY7RC5Krozx3_v56sPN-uTBvjHDjWmvZjig@mail.gmail.com>
Subject: Re: [PATCH v3] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should have known; the test is affected by the bug Rub=C3=A9n is trying t=
o fix in:

  https://lore.kernel.org/git/eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.co=
m/

Where the order that the worktrees are found is not deterministic and
so the ignore_current_worktree flag to die_if_checked_out() might
trigger incorrectly.

Carlo
