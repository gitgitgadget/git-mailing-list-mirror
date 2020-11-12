Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B4C4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381DB20791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqMXaBK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgKLBcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgKLBCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 20:02:32 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469DC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:02:30 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s10so4316214ioe.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=DHO5qwH8tcn3XHqTnP0s0NA+kHaGh+RwD9Xn8tcmVKg=;
        b=QqMXaBK9w0IZJNOi20Y2WdzNbM8iqeEc25NVkpkCLiFhI6+5tXE3J+pdmf1VMWbn9v
         1YIL8hUb5B7FxHJX/QVcfrZ0jY5svU0GbU4MFZuRDGGZYZZaCfdE9bK5YOajohk0D9D9
         KG9lBLEDZHEtDINLDJqQqSRAE51k8Euri+T/CMO4/n/Pax4iEprip0EwuEp86YS/q7/o
         GKnx9sST8R1/dhKsRe+UEbBpGK1qBPqrvBDHILTD+f+0vMQCwfpbLdEy2hXEBxoMA/IE
         Xvw3qjcJVZxPeL5CoQwdqUMdKn1Aa6TLcXXAjjiBhXL22rlunCBLoFMZmHcz3aPAnxuB
         FOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=DHO5qwH8tcn3XHqTnP0s0NA+kHaGh+RwD9Xn8tcmVKg=;
        b=pdTgIAfG1TAjZq6mAepamEdhBoDWdv8JC1tRHIMU9llPyZHEoOopjNmoT/4/ksrAGo
         FwlmrXL7cW8g1hSih/3yHit2cmvLglAHflzR3cxngiutGL0SzXUirCWanzYD0nZWqyRq
         Lk5Pj9YKlMjd9nhuWqLsqoA+BQrTyk8qDLHl/F7/NANKfX3bl3Wi5ZKshP9XMO5Wu96w
         cxoJH9HqjFvXENksSBcfw/O/xB1SmwYhkJx1bhll5zoqh67RWYPxDo7cVMMrwyhnQTZJ
         vuMwtPg6z1vBtEG+lLcENUwtKdX2V8j59sR2V0WFv5GP70FFGhSk4+3/d4EIRvRUxZdQ
         hjdQ==
X-Gm-Message-State: AOAM531wPTTYfP+/UYwcce9TneILKPdH5EJSUCu1ovi3f+aBrx/encNg
        6v1B3P6z2xMMb4p+G38LVRb2jF+92paEDcoJvAQacXukCnk=
X-Google-Smtp-Source: ABdhPJzWgHfzlqRovKRvxyW9dJuyqYSF2OZsmP06nWjn2Hr6FArPL+6Ne1IzmsFiQ+Erll2VOjN19L9XffBRS8n4k8U=
X-Received: by 2002:a05:6602:2dd3:: with SMTP id l19mr13990876iow.124.1605142949809;
 Wed, 11 Nov 2020 17:02:29 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 11 Nov 2020 20:01:54 -0500
Message-ID: <CAH8yC8m2EAk-=q5PSe+RXy3bBAOnktvK2Y+0+Npgy5TgORxZxg@mail.gmail.com>
Subject: Git 2.29.2 is OK on Solaris 11.3
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Git 2.29.2 completed its self tests on Solaris 11.3. The triplet is
x86_64-pc-solaris2.11.

for f in 'test-results'/t*-*.counts; do \
        echo "$f"; \
done | '/bin/bash' ./aggregate-results.sh
fixed   0
success 21625
failed  0
broken  231
total   22348

Jeff
