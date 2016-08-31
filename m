Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CE81F859
	for <e@80x24.org>; Wed, 31 Aug 2016 14:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935267AbcHaOcB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 10:32:01 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37955 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933960AbcHaOcB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 10:32:01 -0400
Received: by mail-it0-f49.google.com with SMTP id g62so99219632ith.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sometimesfood-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=uvl9ctcpczCPT2WgsXLlm7UFythnnWY4Pf44y+9o7JY=;
        b=QSu8dUL6AwPKLyeOkMiA0dZqGvEkM36oIbmxSvU5kSONEEuTDQK2/LMGolbnqw4TPP
         qzAOiJ7kB67aFdGVX4QJ57an70IRo2mfLN+n8ydM1l5erG7qS/EjN1Nu2XNSeR2Iu6We
         oXX9VXzOS3UxdAvpf84djVEeKwW+GoiJOSTO8iJU0TERsAfOXMj+tXj6IP3GCk0lqfHf
         QAfuq8yFUIT2u0jU2RdlVLWAFIwYOBPe7hOE5F+63G733RBPF4fIPI0VlrFk15nZjb+7
         fFzKDLNVx8sLghwJLGM34TQovpeeLidJjRVFOHX0M7jZgYK4O01VyEczzlUra6Yuh7fw
         1t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uvl9ctcpczCPT2WgsXLlm7UFythnnWY4Pf44y+9o7JY=;
        b=HAQCoVBH64nW93s4U5yMp9Hi5tP6glRRcdGtuIRzhsxz8OyYAQ5QanylbmH+FQ+0tD
         OZM6cB+Btd2akQlnxfCGxRrNJdqIXMhVKxYTeFOYnXu5Y0F4xcHvc5uZv1bpmlfWU0rO
         GWw1rjGYRsKBxFFG2OoeZmnSNYTVdVpMhFkx/Vteo+zY6dx4wSGYEcd8pMu4Xw8Bwbd5
         XEf1Q9bou/toCymvR/Gc7CeEDRb30ob2P6anXVRWqQGzMbvMuHCC4/ZnR3pT++c7QGRK
         6Pom1o5I6GiUzqUTcXao/l1IUyP+miQpI1bfbIDpTVUVeAosdZSUC8g/Z1DZiAXQG9PK
         697A==
X-Gm-Message-State: AE9vXwOXE5PxpWuYRSdnwim1UzHV/C4yXB5AbhYxfLyFOFM/omTXOg4ylLS4kh6SkKgeSOxqMYzDLNe8ph0oHg==
X-Received: by 10.36.189.1 with SMTP id x1mr882831ite.97.1472653920185; Wed,
 31 Aug 2016 07:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.82 with HTTP; Wed, 31 Aug 2016 07:31:59 -0700 (PDT)
X-Originating-IP: [84.113.132.202]
From:   Sebastian Boehm <sebastian@sometimesfood.org>
Date:   Wed, 31 Aug 2016 16:31:59 +0200
Message-ID: <CAH4qiVc-KZCjcnxfxicO85ocjFhpXpobfZLvcVniLkz5EJoW4A@mail.gmail.com>
Subject: git-completion.zsh does not escape spaces in filenames
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-completion.zsh does not seem to properly escape spaces in filenames.

My git version: 2.9.2
My zsh version: 5.0.8

Expected behaviour: When completing filenames that contain spaces, for
example "foo bar", I would expect the git completion to complete "git
add foo<TAB>" to "git add foo\ bar".

Actual behaviour:

touch "foo bar"
git add foo<TAB>

results in:
git add foo bar

I am not a zsh expert, but apparently the usage of "compadd -Q" in
contrib/complete/git-completion.zsh prevents zsh from escaping spaces.

Is this behaviour intentional, or is this a bug?

Best,
Sebastian
