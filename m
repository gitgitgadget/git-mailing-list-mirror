Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D529C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052FC61440
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhD2AYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhD2AYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:24:12 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6CDC06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:23:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u16so47549211oiu.7
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=yebFPc7x/XckoiyUzek1GemcZH2xxzf/suzPuHdIN9c=;
        b=Q1U5ElTbSGw26cJEyiUGu67xtjtfhOLfFYWg1KGyrK2nuYvo6oPIlQybMMRa9E4cbA
         6xIwfSnTzhKTAqnvmiAjJH2cI6EK9Si16qr1LHqwB5w/WnXxsF1V5hBYM71r745NsJQD
         2M9a+pLAvSale5/0wBukAFv+WWycPUpatwuF38f+LZ0GGUeXP1zkxLQ/nqwOzvLlNIwA
         wlKNUFttQe+XHuTU1Y/BVpGTtjupIMfaDz6JHhtZ6zWg4L5BSfxLh3K8VLuujrlmx8zk
         9nFCEcI2yoHfJqtYwqaOu31Q2pBbUaueo/LaF1qq5imJoBEqveNUEx0XSPk0eHmWtRLZ
         py5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=yebFPc7x/XckoiyUzek1GemcZH2xxzf/suzPuHdIN9c=;
        b=SCJJW6W2E6m4hpzGMQoX3hRTxnqA9OGnTnawW2MHAEmybJdo1WV+b64ing9eu8JfZj
         DjXISMvv7dS1dL5TCj4zu9dBv45/hu450e7joI81TT/EqcZXH4mzsFsNOgPcZUkO2Bbu
         pbszAQtGCfPtYyQjFcWIoLSXwHRk8P4ZixYkCycOge3q6Ybnd7WIW4k3gOiYcV16Nmdt
         Uzd9IApmcvy7hEggXjWNYdtuGdLxN2ioGlPJL5MxFoLG+vp1HQvv57g4taRLPPDYpomR
         vP5pTl72mB5/yGcj4I6H1mKfiViWYTjDMkRbmauusKyEY2b36zFCrQ1EqFK7MiAdavw8
         /C7A==
X-Gm-Message-State: AOAM532370iOCkLczBFa1NmzJr9iwPtoLlcbXZXbeS+AHGFjRZ3Ori8f
        9TjwEye3N3tAEsQkfwt14/3P2hN0r2H2nQ==
X-Google-Smtp-Source: ABdhPJz4N9oBkX98D6wBDZskRSp2ZrzT7KO+WgiMreA2uuHKRIvnlqTxy37odz6bhnU/TieaGR888g==
X-Received: by 2002:aca:1e16:: with SMTP id m22mr22303740oic.153.1619655805403;
        Wed, 28 Apr 2021 17:23:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id j5sm394479oou.9.2021.04.28.17.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:23:24 -0700 (PDT)
Date:   Wed, 28 Apr 2021 19:23:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?QW50b2luZSBCZWF1cHLDqQ==?= <anarcat@debian.org>,
        git@vger.kernel.org
Message-ID: <6089fc7675b95_a9ef2089d@natae.notmuch>
In-Reply-To: <87fszfafkh.fsf@angela.anarc.at>
References: <87mttofs5t.fsf@angela.anarc.at>
 <60836fa129078_ff602089c@natae.notmuch>
 <87k0osfpt8.fsf@angela.anarc.at>
 <60839422353fc_10cb9208c7@natae.notmuch>
 <87fszfafkh.fsf@angela.anarc.at>
Subject: RE: how to rename remote branches, the long way
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 wrote:
> On 2021-04-23 22:44:34, Felipe Contreras wrote:
> =

> [...]
> =

> Well, that attempt at working with git upstream went about as bad as I
> expected. I was afraid I'd get ignored or worse, get dragged into the
> naming debate.
> =

> Seems I got both, amazingly enough. I guess that I'll take that as a
> "no, not welcome here" and move on...

Do not take my response as representative of the views community.

I do believe there's value in your patch, I'm just not personally
interested in exploring it. I don't see much value in renaming branches,
especially on a distributed SCM where the names are replicated in
dozens, potentially thousands of repositories. But that's just me.

Cheers.

-- =

Felipe Contreras=
