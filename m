Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E8E20970
	for <e@80x24.org>; Fri, 14 Apr 2017 17:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbdDNREi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 13:04:38 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35766 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754343AbdDNREe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 13:04:34 -0400
Received: by mail-ua0-f176.google.com with SMTP id f10so28792220uaa.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DYRIOqsvTbek5NZ/7JxXTJtqKOLOEm2QF7nxO/k6h1A=;
        b=rDbb8O5b7d0CIfY8ktKSryORkD2rMSyIfvnStVZFnESnZG5V8tu3sMfHD4ygGDGpOq
         h8WKYQEXxVfmog93x2/BBvksW3UP9rT4IdcdPrXA8aiExHhXNpXP15ALiPgWJpr1Nv80
         BVCvY1V0s3mbdQ2X6rUsUHM+0Fq53C4zYA9of9B91TiDWUcZY+AQd4IxVVaPyXH2g5z/
         4itM/d7ekO5ov+b4/E8sgjXXc8Z0Oqekh0mkMCrwIAgDQUJ6EDFrcxOEnScBwlTiY402
         StmOs3zj5jNS/mDJ9CMDQz8bxSqhSArcccT7gpe8ZWSR5u5VLKmHMnzWSGPeN8BZZ6NI
         fjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DYRIOqsvTbek5NZ/7JxXTJtqKOLOEm2QF7nxO/k6h1A=;
        b=ZHpjZs1u3jGw6CmsY/mwBariTesTkzAoZfHKrwo7YaHhEO3AYOc3FB5XB/jHKu0NkJ
         Xq9+QrUTYDgFaicQCcFzIXbcoVAUzjEYYrKRdZELGlSffW9FIgY7WNdIFea1OFd6Flik
         MC1I2FF7Zj1zAWaV4f5z/UAELijFRm2Ox0e9J1x8xWhJszUDvkT+kTg68ps+ODamIYBo
         stIUVo8wus1KUpBtaqsPYb2mJ8mV1kdjknBpHIn8JsYRG5IVaTcP8JJ9Lohoh9dFRIGM
         xKnUm+9aj4Z0Gk7NU/E1umlzUma5Hn6rlmwqpGNiV98xlRfJOuW/UtldMWLOoCX64omb
         MYsg==
X-Gm-Message-State: AN3rC/7sFe9KvbREI5nUTZBR3VF0Db8ZUkFf+kAkgprszqPKy+EhgAIa
        yulTZ+17PhV+i8ApUE9uwJHKIKSmcICj
X-Received: by 10.176.25.18 with SMTP id v18mr4359250uag.81.1492189463663;
 Fri, 14 Apr 2017 10:04:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.2.149 with HTTP; Fri, 14 Apr 2017 10:04:23 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 14 Apr 2017 19:04:23 +0200
Message-ID: <CAKPyHN1W175wm1doQHF71vB3PHpU2o=xtEAcZMqZtR=U_Kv0_g@mail.gmail.com>
Subject: includeIf breaks calling dashed externals
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Duy,

heaving an includeIf in a git config file breaks calling external git
commands, most prominently git-gui.

$ git --version
git version 2.12.2.599.gcf11a6797
$ git rev-parse --is-inside-work-tree
true
$ git echo
git: 'echo' is not a git command. See 'git --help'.

Did you mean this?
    fetch
$ echo '[includeIf "gitdir:does-not-exists"]path = does-not-exists'
>>.git/config
$ git rev-parse --is-inside-work-tree
true
$ git echo
fatal: BUG: setup_git_env called without repository

Best,
Bert
