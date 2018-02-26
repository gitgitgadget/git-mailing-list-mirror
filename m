Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4FD1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 23:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeBZXJi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 18:09:38 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51333 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBZXJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 18:09:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id h21so20560015wmd.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f+00ggHMMoThYQQTV8Wxu0S48kQpjBqmi9bUgMlqaCo=;
        b=b766hsjJnyvf7xfM3BCzxA5xDsIzinhHwfqiRGrhG+Bxz2WPVhhdzwss1k0cDG2es9
         LAlP4osMFnNclEO9Fukpy8kkIqLWH8Zoecm+KFrBVaPXAfprE+B3XHeHxm+tOWuRhrCa
         X5JfDk5Yovjdu8xFJjd/3sqw1A3/pZmVfph0elH/LVxwy5C0FbXdY9pd672vNZFX4yNW
         +rVMQ3Z/47RBseHhQeZWcacIY0r28p4m8iR8ZQxOefTiRXli0MStvqefsVbkwD32SNqT
         QkQYsYY0cd5MbOJVNdUPVEO1IKOE4y4I9lZYkQ3+NIiQ3ZLhGpzpBvyy0J/6i7PqEvvj
         b8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f+00ggHMMoThYQQTV8Wxu0S48kQpjBqmi9bUgMlqaCo=;
        b=BStaKn5fvfP+vJmgaM96voA+hw8E6YHLhc8ducVNYn2LefrDxsZVaDjD8wQbw18/Ez
         J8pWuCV3qBlfLGsnAzat3a+LNL9GG5358GQpBS84uNvy3ZSCl7nG1mrlOLXV/7D4FY92
         rSEVtJ2d8eX5fzZx6zJjIbd17pAlwMQbK0YPfjP/ARZD4zYJ1GnHFFznGnOoVXTcZ9lM
         bNspMJqAJagHwAZHnJzMwpl4iBaBbmYuHKQyZOcrmMZ4YfORwNr6Rad6mY6aHwlbKH9n
         uB2qI5lczERkh0JkP52OlaT4IHm8wG2d6FzOJY4c5H0Rc3Zmtd9Sb4/G1Q+/x3pqSQJl
         wHJA==
X-Gm-Message-State: APf1xPBvsa4flxa8u+rt87Hkyb+6kCdmE0cmCNK0y6tAWN46dS6AAf26
        VtIsCD783RSoLAYaHinPAB7n8iDf
X-Google-Smtp-Source: AG47ELuXeFwOSC4JtqJcHHPj+UyokxmoRuxRM6RsCLa9bT7onADg7e/rTsJBrBXRtWcCvHoms7YDSg==
X-Received: by 10.28.122.12 with SMTP id v12mr8893313wmc.66.1519686574735;
        Mon, 26 Feb 2018 15:09:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q11sm8515118wrb.74.2018.02.26.15.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 15:09:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
References: <20180214180814.GA139458@google.com>
        <20180223095640.25876-1-pclouds@gmail.com>
        <20180223095640.25876-3-pclouds@gmail.com>
        <20180223222950.GK6619@genre.crustytoothpaste.net>
        <CACsJy8AUvAv61wM5hnvhyCaOd_oKmMbhAyDGJ9pmkiSu_WveZQ@mail.gmail.com>
Date:   Mon, 26 Feb 2018 15:09:31 -0800
In-Reply-To: <CACsJy8AUvAv61wM5hnvhyCaOd_oKmMbhAyDGJ9pmkiSu_WveZQ@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 24 Feb 2018 10:44:30 +0700")
Message-ID: <xmqqfu5nqrf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Yes that's the intention. But after writing cover letter for v2 and
> sending it out, it looks to me that this thing must stay until all our
> code is converted to using the_hash_algo (I don't know if there are
> more to convert or it's finished already). So an alternative is we do
> the opposite: default to GIT_HASH_SHA1, but when an env variable is
> set, reset it back to NULL. This env variable will _always_ be set by
> the test suite to help us catch problems.

If we were to do the "do not blindly initialize and always
initialize explicitly for debugging" (which I doubt is a good
direction to go in), then what you outlined above certainly is a
less evil way to do so than what the patch under discussion did, I
would think.
