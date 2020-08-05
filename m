Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F23C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0E3207FC
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBvT12j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHEATB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHEATA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 20:19:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB5C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 17:19:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w25so10183119ljo.12
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ba9TW4zuagjRa3TOwQ2uJyxheUyPiKWhRH8DDS+bsbc=;
        b=CFBvT12jWHpBs3WAdeFMUaJvPCLEOcAWtHj9M4XgxIsCtNU2rgmCxVKwlHHLqtx0IH
         XqCLSIQ1e6+mPLVLnYJayf8rnbbAmHfz5EOpd/wGvVwFT0pbyxylRTNbRaRklcuamL4C
         uQdNXvuaLCDLrKDIEABr4+x4VA4TEZrlzZLvexptJItdRvq1cmBDDyyG2fhY3F/5N/nl
         w2SP+I8/MPlgbwKptPcUdWjAbAsbQyVHiaoVenMOpU6DBV892pgoijPxGjbq9w6V3mv5
         gNbzoKNLxGF3/hUo18IZy2lZwiqbcvRcNCSl3h6d01eUzqNO6ZX4uaQDunxqfnfEHcz8
         EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ba9TW4zuagjRa3TOwQ2uJyxheUyPiKWhRH8DDS+bsbc=;
        b=VaQ402aQB/DEbQfMkUuTUievB9yvOyUCenOPWiTUTTKDyRG9a1+mf/aUSa72HfQMPE
         bsVsy2UGAwMb24dhElu8q1X45nB0fjwiZPdhP30NcW6FIAzkWZtI71SFvfZHhe9/rz/w
         9BS3oqQzPv6hzXezjdpAh2c8lFvdZ44QS8FbDEEgsj6Jq0sjd/rF8Mf+dGsVIm2yZQ4l
         qNKEB4MrizWO/X0ZrLgev1nk62icaN3689P8wVjGKiBok08BvUB0Cu7cNbZ1Ohpw2w7f
         BHlzVxoXObdcCvHLTmOIbtWJlBtCakxF0i/J8jeSAStqc3iOV/juBf8k2QVfRMN/u7Fe
         uulg==
X-Gm-Message-State: AOAM531kxFV716ShpsHPl0487uxTrZBFI6P1PGoafQTnNi1pWOvfQh0D
        F89GHRHbgsbHWxMVlmT3MeM4//dfGtVcP1AxaoSlvXYw
X-Google-Smtp-Source: ABdhPJwXMOnuAFBBbL9l5/8WAeMtSMg/pU/o++Ozy2MH6rU40TGjukoy24S7KgEkH2w3DmSgVhWjFhrh6jt7yUq/2eI=
X-Received: by 2002:a2e:9946:: with SMTP id r6mr151221ljj.127.1596586738145;
 Tue, 04 Aug 2020 17:18:58 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?16DXotedINeh15XXnNeV15HXmdemJ9eZ16c=?= 
        <inoamsol@gmail.com>
Date:   Wed, 5 Aug 2020 03:18:43 +0300
Message-ID: <CAAWR3A9po-zMVFdQfDs6R5F_rf0UvSyfByLj-vYZiXLb8+j4Ug@mail.gmail.com>
Subject: Why is AuthorDate displayed on git-blame?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everybody, I wonder about the decision behind git-blame and
git-annotate date that is being shown.

If I understand correctly, the AuthorDate is displayed, and I'd like
to challenge that decision. Consider the following case:

A feature branch having commits authored last week, but merged to the
main branch just today. And to the sake of discussion, let's say that
the branch has a bug.

When someone encounters the bug on the main branch, he would probably
want to know when it was introduced - the date when the bug started
to affect him. However, git-blame only shows him when the bug was
originally authored, in our case - *last-week*, which is confusing
since the main branch was working just fine back then.

So I wonder why was AuthorDate the date chosen to be displayed under
git-blame?
