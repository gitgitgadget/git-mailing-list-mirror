Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DAC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC09206F4
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 17:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUNobET8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgDUR4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgDUR4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 13:56:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C8C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 10:56:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g6so7744518ybh.12
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lncGKz0+MwA2vLhHmTqazpkbVKldc+2OZUkHcUfuVhk=;
        b=PUNobET8nbyNzbhP+t2TBFiG8TaqqSrXBC5gISIZfRO5q7b5bK4o5CDQ9/hSj90Ikg
         6YYam+yfGWNgoJ46zQ5ySZtcSMlusgujGj4hv37ug+IDGF3yOwyRA9oIbXuppJvEHiJK
         /r1uv/HngpOSMogrjEFO7XtBro61H6Fn9BuKHVegTG0xvbsDFK2qNLdhT60av0hp+8T8
         kOz97xRk9S3Azd3pe3Q9oSNlfkQzHKL18D0EhEdiu9M53iLKjSatyiNTgaTlGe2ocbyG
         VvWmPLq5N/c5aJ7HDYxHxFOPwJWrsjGD5RIvUKXyds4eGqfiG9w/7S4/PP949et1Afly
         DkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lncGKz0+MwA2vLhHmTqazpkbVKldc+2OZUkHcUfuVhk=;
        b=sd+M4Pv4Yo5FK6kakQqMkWa8BcxVHTwRKJGtvHow5lgZTLmbr/RVOC9+15qEO75cCv
         Mc4YOfsDKYuJdfjONblXaBmPaRClGV0nRNM2P2VFXWPW1rtakJwtWkqiZoV6/JBcKR+V
         uRhUVCIECHeyqvXR1HWFQX3oqMHxmHqw9dkKackD+EG1yTCaDkIha0iZgoDdLRs7ee2t
         bQwAlePQuOJFpHy8k/OOEVO8ea17+4A6i6k6F048atZXykMO54avamv7LOKQAsT96sTO
         JLMlMkTyoqIXKmhaZDOxmckwKhStk3I1q5sYQ3FxoHWNKSn4sTAEC2e9SQzOdqRBbF4N
         takg==
X-Gm-Message-State: AGi0Puae4DeXb8Uv439uEUvo/jFI94bYhzQHutrOGy9OOQfl7PdW/2RI
        6FBL9FQ0PNkDYLOYAFMfmMbGqKKCNMEKNqckm39UYP1X
X-Google-Smtp-Source: APiQypLDusyZ7K2v7S2TxzurLSPHZy/JjSYvSrSgVb8W0ws3Zok3T4KQ0eGk4/32yJHUByhlQIGimhl+aIlyyJpassg=
X-Received: by 2002:a25:7e01:: with SMTP id z1mr4648224ybc.230.1587491776222;
 Tue, 21 Apr 2020 10:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANp3UNCnxh2Acwvj6tU6GCES3UzQ1JEmAr6qwFL236VVHrRnCA@mail.gmail.com>
In-Reply-To: <CANp3UNCnxh2Acwvj6tU6GCES3UzQ1JEmAr6qwFL236VVHrRnCA@mail.gmail.com>
From:   Sparr <sparr0@gmail.com>
Date:   Tue, 21 Apr 2020 10:55:34 -0700
Message-ID: <CANp3UNAhWTt4ONhb7tThNJdaQSNQF_RMysmz12d8741+UPMb9A@mail.gmail.com>
Subject: Fwd: feature request: enable config option paths relative to config location
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, setting commit.template to a relative path loads a file
relative to the current git repository root. I would find it useful if
there were a way to specify this and other config paths relative to
the location of the git config file (.gitconfig or
~/.config/git/config or another specified config location).

My use case is distributing dotfiles to a group of users who do not
all keep their git config in the same location. I would like them to
be able to put the config and the commit template in the same place,
wherever that is, and the template be used without needing to change
the config contents.
