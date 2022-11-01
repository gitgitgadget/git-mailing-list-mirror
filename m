Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19545C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKATil (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKATij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 15:38:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063266358
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 12:38:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 11so13285844iou.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sm7rtuaTxeKobpyEis9OMj4fQvH8Bxuzv0FS1JvPHbs=;
        b=65+tLFVwZUPcFcUBxo36323UaoA4SSUaD42WR0tVNbyfweJwJDXf5k4dVzVbBQDLl9
         fM0E0BfLAwkR+xZtU6Uvp1j2hD5Z/NH+vvV4VQD4aJbFZl5cK3ELrJMwir8OXqYrdfQ9
         n2Ajjb1JV7EHIKo3lcZVCLTS9H7LVl7vzKHgPKwxIT+jqt3PWvuGpBTpaAFx3exFmGVe
         CUeYkq3c5YoqQ9BrxOl0ej8+XDDlsfOQd1E2CkeRH9EAihuSpMxZ/RPE2KP8Hb2YkMER
         n04EvBSVaw50f+9EaBvBdJjGD1fJaGD+LXFhruhkTTbXTwA6LFXVuaO5j2Bd5qirYxJe
         W/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sm7rtuaTxeKobpyEis9OMj4fQvH8Bxuzv0FS1JvPHbs=;
        b=ft+xVU+w4Txd7+CQV8YwTwWzye3WFMSkklj+Gu4zQ4gMKYvG492+SvL0wd+r0F41j7
         8RD35xtKizzMXWBAv0tERg0XrZn7y/aYhM0IMPv93GSQMDLlLVvWuzQjvKCX+5hZoSf9
         QT6n7TW7XcSRPreW3q4mM6PxggB7h8G2llv3GahERl62nyQiw7uPo/V4GH+vPnoEbq5b
         W/32dJH6ndZ/o7PA0QyfF/5E+LXxrQf/bXfAXMM3NXMZDABpyMigA3K4995Aev2nxI+/
         +Kqlk5fJF/41sGhwbYUbFVCjWhaM7vepdUUEhuCebVDy+My4UcLxH9iLAgpbe0bvg4aV
         OTsg==
X-Gm-Message-State: ACrzQf1oNXiKdQQHSG6poGrLGNsitKu0yMDYF139NwDIMwzEWx/yg5m0
        3EKYmwvLLBCiO0SVh/NMIU7AJ5c2/2jbS068
X-Google-Smtp-Source: AMsMyM5dMUtnr+K9DuF223E7EBm/COrCForQW7uELaA6+ivgd+HQAgdmDQVMX7thq04ZLgIw2EqCSQ==
X-Received: by 2002:a02:2b06:0:b0:363:4f24:c7dd with SMTP id h6-20020a022b06000000b003634f24c7ddmr13173680jaa.132.1667331517425;
        Tue, 01 Nov 2022 12:38:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a24-20020a027a18000000b0036348f096acsm4151775jac.6.2022.11.01.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:38:36 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:38:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        git@vger.kernel.org, andreas.stieger@gmx.de,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
Message-ID: <Y2F1u5KJTH+f4CMF@nand.local>
References: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
 <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSryxTbJXrRs7-aCNb6u9qXJnYjX7++Ji8jd=YeYTJfoaA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 08:05:36PM +0100, Martin Ågren wrote:
> > How can we fix this issue?
>
> You can disable this feature by setting the GIT_TEST_CHAIN_LINT
> environment variable to "0". That should hopefully allow you to run the
> tests successfully.

Indeed. It would be nice to get some more helpful output from the
chainlint machinery when whatever is happening here happens.

I've never not had chainlint output when I was expecting it (and, I
often get chainlint output when I'm *not* expecting any ;-)), so I
wonder what is going on here.

Thanks,
Taylor
