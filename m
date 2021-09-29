Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F241C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DEE60F39
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbhI2W6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345988AbhI2W6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 18:58:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730DC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 15:57:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so5510159ybb.15
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tbefX+8HOmyxwVtFBsPPUV6npnlwsw4GxV9Gdvtfmp0=;
        b=JNi+p8bXok4b8LsS8t87LR6YTvHWNCISnI4aFUOxpEHieTa5fe/l8Y7xEr1eVTElsF
         rpuDZKiUI517dnTCKsDRkQwhpDhnulDnsdFTGLhggHJMj6LCdkNbeqrNbIRrH+yt7U4u
         KNIl44voewH3M8g66MTDkEFyv3Nzsw1BXYr5nuWOWhNu30j/nZZ0DQh/unfastl+wgHi
         TFLjjvcBu33+nvVtUiusIq8QFNanl5k6QHEK0HOn6P0TdzuR4ITzSGmiaX+tUDEwXYPC
         lm7XffLQPt+NR5RE0sr0XuHbQDpL0ewmToLH0QyP3IA0uZL3gkee2ePXUdTABoGQoXhr
         zHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tbefX+8HOmyxwVtFBsPPUV6npnlwsw4GxV9Gdvtfmp0=;
        b=XSpLhMbZ8MSGY9PK78aDD/UX7+rDreFmU29zeNM1x6nr03+UTkNkB7xGiy2QWpB/qN
         qp4nQKM928RZBhHvwe2/eAbAwaXKI5Ce6eaLjpPPkkTuQ7SbBe8cqCRCPAxtT6d4DaHF
         GVcra3b3+li2izsNc9a3U7fpK6QJENqXjbWuo/H0qNgxlYFToh+hUv+95yWGPOCXgkMc
         ZCWxYqgyzgSkBtc+E7iFRw1VEmkUKymN1TatD37xOVp1xw+K1BI8KEIOn3d980nZ/o7K
         hbQLUCooyGtEuwE/uDxzMnlYimqirsMLePCTMa7dNfVBM1G5J+d6hHLZ6+DrRqaXVE5Y
         QHAQ==
X-Gm-Message-State: AOAM530da82bHBeOI1UL9oT8HbxlSpqUFfrVIfO+md+sffgox1BZojVl
        hYwHKcM4iHUmZmVr8sEnEtoBKsk+Q72NKA==
X-Google-Smtp-Source: ABdhPJyVoiC/s37+tzH47jPb7JcTNZNZbLZcdf2i198t+NRlfAxUdsVTSt0aUdLF4kSWoetrED6v++mzWNE20Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:ce14:: with SMTP id
 x20mr3058605ybe.68.1632956220232; Wed, 29 Sep 2021 15:57:00 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:56:58 -0700
In-Reply-To: <ebe894b4-af25-f79e-c43f-1839e075908d@sunshineco.com>
Message-Id: <kl6lr1d7ourp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-3-chooglen@google.com> <ebe894b4-af25-f79e-c43f-1839e075908d@sunshineco.com>
Subject: Re: [PATCH v2 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>   test_expect_success 'git-fsck incorrect offset' '
>>   	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
>>   		"incorrect object offset" \
>> -		"git -c core.multipackindex=true fsck"
>> +		"git -c core.multipackindex=true fsck" &&
>> +		test_must_fail git fsck &&
>> +		git -c core.multipackindex=false fsck
>>   '
>
> I guess the newly-added `test_must_fail git fsck` line is checking the 
> fallback case then `core.multipackindex` is not set. We could make this 
> check a bit more robust by _ensuring_ that it is unset rather than 
> relying upon whatever state the configuration is in by the time this 
> test is reached. Perhaps something like this:
>
>      ...
>      "git -c core.multipackindex=true fsck" &&
>      test_unconfig core.multipackindex &&
>      test_must_fail git fsck &&
>      git -c core.multipackindex=false fsck

I think this extra robustness is worth it. I sometimes find that the
tests are a bit too interdependent to read on their own, so this is a
good step forward.

> The indentation is a bit unusual. It aligns nicely and is, in some 
> sense, easy to read, but the two new lines are over-indented considering 
> that they are siblings of the corrupt_midx_and_verify() call.

I agree. This was a typo from me, not a conscious choice.
