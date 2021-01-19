Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38260C433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF86123134
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbhASFXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 00:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbhASFDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 00:03:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F09C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:02:24 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so11369468pjl.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id;
        bh=0yMugCYaBE3ZnUaI6cnccvV1FlqJcu1N71/wKbwFN88=;
        b=hZwv52xqtpROR0yz/f9TgAStkdM+n5mWTuizvhMos7NIyBug0G/9IVK7PgWUU8k+pz
         h9pVj1hKGS21IoXwqTj+zWbzKPG5tMbeL2k+XOcq7j96XZ6hxtXkCPbKsV723xB2NWxu
         RaaWnCiD1wAUpTLFzKNUm/2j1xK1ATLGGaTNO3kkMnmFNIdlIzIkOr/eIap+ZXnE1o6R
         V63kG58coZU9Ori7EfXblMCamhZSp6zamBFVbZ4Gc6e/bpeOF3qi+eMmRQMpFoawO+no
         AV8ct6WA+32yMnqKkbBHgzLxekOSEzHvIM2rUCDLgDCXWk3/gZ3dDZEhhaYa+I3dlhN7
         xlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id;
        bh=0yMugCYaBE3ZnUaI6cnccvV1FlqJcu1N71/wKbwFN88=;
        b=ETK+U2Uqq3oHl9PFtwPZqxCpbCsOeQxU5VjWAW2rJgZZlT0gRO22sfgxtOWG/Yb8IH
         kyz1QYRxgl7iaohbIwqq7Qqpdm3KDRLW7eqL4ibDA0dhPMncwPTq49j4FwWTd4xAOJbz
         l5KHy8ue5mM6mjIgJewlXptMwYUptJPsBTEseDmAiZnaNpbAsdtzgjX75MbyL3vPNc3i
         qmJMolMiXRuOPiYhDcgRqSar6iiEzHTUOpRfCYXfCsi7OyYcg5niRYivkZ3g0fUmTbN3
         BejazZqJilP7hj8L0w9awWpTJzG9mx3i91ls3LpBMpojp/LaPT+qyQ9xRzE6qBQH/X6w
         KY+A==
X-Gm-Message-State: AOAM531YnYXGuWGpQMSD3FGs88BvwZfZVh9ipaZv+0nJA2TLEOfHW3gQ
        kiqwCPLdO1rC2L883nWzVil2rGHxxG2/HTOs
X-Google-Smtp-Source: ABdhPJy4euQuYmGwTLkhonC/0w67a8DoyrzZMkJNQL+t82TlHPMJo3TLn8JlhGxUl0QaawRTpDBoIg==
X-Received: by 2002:a17:902:728b:b029:de:c843:1d4c with SMTP id d11-20020a170902728bb02900dec8431d4cmr53490pll.84.1611032543910;
        Mon, 18 Jan 2021 21:02:23 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id x14sm3441818pfj.15.2021.01.18.21.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 21:02:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Derrick Stolee" <stolee@gmail.com>,
        "Antonio Russo" <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     <git@vger.kernel.org>
Date:   Tue, 19 Jan 2021 04:58:40 +0000
Message-Id: <C8MVAN3DSJM3.PZ62BIW44K0Q@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick and Junio!

Thanks for confirming my suspicions, that there isn't existing apparatus
for doing this, and a new bit can be added as a flag. Thanks for the
*pointers, I'll try working it out! With Antonio, in fact, since they'd
need the same thing for implementing the opposite feature.

As for the justification, to elaborate on what I said in the opening mail:

This option would be pretty useful when used with diff options, to see how
much two forks have diverged. I recently wanted to compare two long-running
forks of a project and see how far they have diverged. I used the options:
--simplufy-by-decoration --decorate-refs=3D"refs/remotes/*/main" -p

But currently with this history simplification, the diffs for both divergen=
t
histories will be created against the last "relevant" (decorated) commit
instead of the last common ancestor, which creates pretty useless diffs wit=
h
a lot of intersection between them.

You're right that the option doesn't sound very useful when thought of in
regards to history limiting by path, but IMO it's pretty useful in cases
like these, when you use simplify to get an 'overview' of the history.

Also sorry for the blank/duplicate emails everyone! My email client seems t=
o
be misbehaving, largely because I tried to tinker with it :P

- Aiyee Bee
