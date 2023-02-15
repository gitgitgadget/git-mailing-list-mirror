Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9360C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 00:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBOASt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBOASp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 19:18:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444F826CD1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:18:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so17485490wru.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s99xbf3CzwngxESJFGC0cc6yY19J5mdkYkNrND2CLJ8=;
        b=C2JinHZBKADLJjBPO6HguZ+c7OYbnwASWyBfvjxTY4/oJIORn/1pCf5HWImakQAWlD
         okGDusTTwE1lwpm8jywzvJ4bPw1lol8c1kq1LIVvMQ9qxCZcdJZxFqopU5a6aHQq7Lc2
         ETPQI3/9aSlygAyeqYtrDLyxfSgAomgfsr0EF5PVBczSCJmrVp8UV+aSSyovjdvbQskm
         LG/rMbC8rAmO87Z1iMNLfFi7Guj06wY2ah3SPA+9mSwc7erONEUatgy+sC53zVCcs/on
         AIu6BGqbfVO6CS2ST8v89Dzb1//XZcErwKONNiHgAnfM3LtswwiZIyA0drJUKZoh/teH
         2N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s99xbf3CzwngxESJFGC0cc6yY19J5mdkYkNrND2CLJ8=;
        b=cpFGxj50B8uxMUEgu8IxzL3Hq1X40aQESnnXBNvhKqFR9IA31JFWWe6N2mZwc127ay
         kSv+fWHwBqQO6GGNu6P7H48MxY7BGRyCV2BChUa0NiAxq2YK7dNqL7SSfbr9MLq+bRpp
         Dgo2wEbaDQJHMJt6knWhThe2GX2HxutSLU7Ur+4GTBz6i+n5gAquEEvbTEHE6EMTNRI8
         IJrfBDIwkA3IhE3VYpetbFkyqu8okL91QtuTXA/6GoPenjPI4NbFLOKnmN9KbW2Tm1ka
         hBNrkgPJUbqzbseEog+US9IiAujsHKOevZKFMQxvG/D6znqduHTNt9Qxk3VXI5AGHT7l
         uiSg==
X-Gm-Message-State: AO0yUKUCgywJOuEJrnKpolexpHf8kBv4WvHjlzda1j0lMG8xvjOGZaQl
        5karN+h9Hd8ACURo9L/v/ZQUfuSrdVsRHcbHArYhOut9HKM8Bw==
X-Google-Smtp-Source: AK7set/rp3ztgZjXfXJgp93U1hAUKf9muC6r0R6DAIaZMOEph89LNLF261UZNNWnDV2qw3kFSYwkObXAycCFJLPSOuo=
X-Received: by 2002:adf:f851:0:b0:2c5:452d:5a27 with SMTP id
 d17-20020adff851000000b002c5452d5a27mr666wrq.410.1676420322734; Tue, 14 Feb
 2023 16:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20230206211823.8651-1-cheskaqiqi@gmail.com> <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-3-cheskaqiqi@gmail.com> <CAPig+cR9pjxnr6PzyTiPULVvKW6Rc+GMeMTGKKp4F8+cWuZdgg@mail.gmail.com>
In-Reply-To: <CAPig+cR9pjxnr6PzyTiPULVvKW6Rc+GMeMTGKKp4F8+cWuZdgg@mail.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 14 Feb 2023 19:18:30 -0500
Message-ID: <CAMO4yUEAQ9FQu1j4E7hzHtVap25UySOOnvvJyox1Tptr0bK3ZA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] t4113: indent with tab
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric

On Tue, Feb 14, 2023 at 7:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> The patch itself looks fine.

Thank you for your recognition!


------
Thanks
Shuqi
