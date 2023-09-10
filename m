Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01849EE14C3
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjIJB7z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 9 Sep 2023 21:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJB7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 21:59:54 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254312F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 18:59:49 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-64f383be0d4so21222246d6.3
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 18:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694311188; x=1694915988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXH2Mbz5LiyRmIfzGBREd072LgozEQNdCD+EFNTGsKM=;
        b=HxgmjPJ3TYQ572dy65g2JNYIEoMd9H5p1ex898F9XqQk8XlKRKF/Xb9WsHNfKodqrB
         VFKilkFwHRJDDDUTvJbM3YuNEHuIMaDrgNONbrEDxEe53OAMgnvlBUD7STalS3jWcUcs
         mH3LAgKCuo4zlDmj9FGNu11GReMylXghsRM8kkK+PZEOhvfmknvZDAWsY33jn9lCjm5/
         nvhu3DdIUDNeypCVL9AdcARIdIbyLgXzFj6qu2gAFJe2gkFyyzAv63Xc9c1tPDp8gOKv
         w0wvHfJ1Coowrr+P1xlH6lGYLHxpPGtD42UdiC1aMEfKrbbKH1MOebPJZz7ld09DlZvL
         omyw==
X-Gm-Message-State: AOJu0YxBBv+U0riHv6NuO+Fw/j1CIeNXlQNGw7jkJpPQWXBCCR3EUnRw
        gJdU62jVYWhIF4ZH/bvljCqEoAd+7M/4eTnso4xak5fD3Sg=
X-Google-Smtp-Source: AGHT+IGBAcpW2/sFgd8NcrbZvlNUgWGu+Raa/Uixv7qmqiC63PSB8i3Y0LbDxkvjr4RGQSz6zBvgmkfxvwX1nS1yP3Y=
X-Received: by 2002:a0c:e102:0:b0:64f:9023:7dd9 with SMTP id
 w2-20020a0ce102000000b0064f90237dd9mr5964192qvk.42.1694311188638; Sat, 09 Sep
 2023 18:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com> <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
In-Reply-To: <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Sep 2023 21:59:37 -0400
Message-ID: <CAPig+cR+rZ4+Qyfz5YQVMixW0oC65iOzxymwOaUnPqSTVScW7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: prevent misuses of --invert-exit-code
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 9, 2023 at 7:08 PM Rubén Justo <rjusto@gmail.com> wrote:
> GIT_TEST_PASSING_SANITIZE_LEAK=true and GIT_TEST_SANITIZE_LEAK_LOG=true
> use internnlly the --invert-exit-code machinery.  Therefore if the user

s/internnlly/internally/

> wants to use --invert-exit-code in combination with them, the result
> will be confusing.
>
> For the same reason, we are already using BAIL_OUT if the user tries to
> combine GIT_TEST_PASSING_SANITIZE_LEAK=check with --invert-exit-code.
>
> Let's do the same for GIT_TEST_PASSING_SANITIZE_LEAK=true and
> GIT_TEST_SANITIZE_LEAK_LOG=true.
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
