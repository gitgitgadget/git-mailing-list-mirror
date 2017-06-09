Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433D81F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdFIQMZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:12:25 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34550 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFIQMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:12:24 -0400
Received: by mail-vk0-f54.google.com with SMTP id g66so29911667vki.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=TZ6jhzFtTT3oM7TVQjAsKXU596mDGPu63de3UnsU1Uw=;
        b=kPh669V4tqKwW5Z07SME02dCuqsX8JkA2KhEc0ddUZJ/QRH7z9g7BTATn9eE2K4/FR
         DGlyqx85s8jO7BNQ18OmaMl5xpcfe1+e+7QHGtvYFMW96YvVeNsBdb4qYB+DjWtm0Evu
         13uF0KANZ4p1Fs1t9o5qPQIH4AOOW0279pWVDCOlbb66YH/ULfTmh+U21UYSQyBmECcf
         aLqmPkoHkZcBGRxDcwyMGLuorMuEB9RAsk7+ArOAGsEjJ841hGjEYfNR5BqdhWa2WDo2
         FiGptNihZvVqhehI0z460gxkUQ9e+Sn/Qn2ulQoRFx1WHhwwiDqwgRxAC/umEYZYB61G
         d8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=TZ6jhzFtTT3oM7TVQjAsKXU596mDGPu63de3UnsU1Uw=;
        b=Cz2PtZqhD/BiUxotRmZ+mAI6PTT+74EaOADeGPHEudIEGjWC2NMM7uvz98POnIDqYM
         pbdu3L9VWuNudJe9JlSVzBLx/JkLowP7OQFC937b37X05wGgwPBAfcxjXgm4vEKXwxHQ
         RATz2v+k/pOWKugKDPYc3Tg7j+x/Fy2ZJrKa3k8oOugwo6Pgkd99CWeV32ydxoyMj8tS
         A27mlYkslhtfW2HJzzbjBOAhnDNnc+trI2CJzyXmnsGiG/C2xoJwPAyDouCVnFL4kfsX
         k4ovOYHJj/Vz85/e/tcxj7xDcmeMSw3C9r3VgMUK6506pXhrMOJRwwfmvu9p8yU68H1v
         ZQwg==
X-Gm-Message-State: AODbwcBk26pF0hBe9vmq2z9+Eobhag0qISJJaox+FH9/C52YVRCTpkcA
        43gd+KTi1Y/la0Cxr+SzngZJFOLad6KF
X-Received: by 10.31.189.148 with SMTP id n142mr22198660vkf.53.1497024742959;
 Fri, 09 Jun 2017 09:12:22 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.234 with HTTP; Fri, 9 Jun 2017 09:12:22 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 9 Jun 2017 11:12:22 -0500
X-Google-Sender-Auth: pX6oZUqU1uyorThwjg5Np1MAqZ0
Message-ID: <CAHd499BBNsai4SScOe6kADsgbGRLyGnDKyUcm8LZL-w8c9Webw@mail.gmail.com>
Subject: How to git push mirror local refs only?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I want to update my remote fork with all my local branches.
Normally I'd do this:

$ git push --mirror fork

However this will also push everything under `refs/remotes` which I do
not want. And it fails if I specify a refspec parameter with --mirror.

Is there a way to achieve this through one or more git commands? Note
I'm doing this on a non-bare clone and have to keep it that way since
I'm pushing branches I actively work on.

An intrinsic benefit of what I'm trying to do is that the mirror
command will also batch delete branches on the remote that do not
exist locally, which is behavior I want since I do not need them
anymore.

Thanks in advance.
