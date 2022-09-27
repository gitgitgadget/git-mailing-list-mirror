Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB407C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiI0Upa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiI0Up1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:45:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C21B285B
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:45:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 63so13655459ybq.4
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Xsabp3/mJqaFiNRu1pH6MTpIIkki6YdWJ/eK7ntFJL0=;
        b=khfgKwFrgOJt4xfOnmsMTjmtPzkic9uZlJ0ZQFD+sJ9Q76ymEVSkjn+fUnhvFHPlk2
         Ria45DZEjfNDCXhd6TBeniOyK16RmPaAMhLQceDidJ5ah+4is5G0OFwZqL5fchqcx9Mf
         llXoGkUtOfIwpGdJD0Cbhn/rcs6ISyXDqoTPiDjJFbN1At6MoeRFTw9yT+0JfCrFMAET
         SfSNry2HqEePLVLrA7WWZuJE+MtgTEbhNodgNwpJ+Rb4DHmmFnd0q3fjMACh9XBCZXzS
         gberosboQsjVHk2u2hYiH9lIdkNrGQlCLRdhlZNR0kX8AprtoGdDI+GjdsxtXvY4JKCk
         tjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Xsabp3/mJqaFiNRu1pH6MTpIIkki6YdWJ/eK7ntFJL0=;
        b=yCk9dZ7ghWkDz3tIjdojkHqKJnmzIc6idMAZjNVGBq2tP4Y8GbtLpmdZiZbrKL4Wlq
         62z8Yqf7GFPmag1ooFde5qWBOjfPYn8wxk/0Cqhq0nF0ui4BVzhcVXTX+BnTdgGZjhUn
         dKeKhTW/TgZ9M9gFc2N4SJmCfORy7XUIdOZ60GAEyo1f1H67vR/ZegnJvCaPhRbHuvL4
         pSJ6YLLyw8R3J6cLEkEpXETY9KZtSqPL22l/fXSq7G8CPtVNu7LIs/ClsmkKHGiihXQh
         cZsho2W2diUbje8x/HAHTYehnXRt/wkJRVESXjqzsdPGxCruG4JT5t4HVKHeYTwvcsxz
         QVHQ==
X-Gm-Message-State: ACrzQf3Zu556aSdWmjaxO3EEQHOjf3LRnFHGhmH3d3mhuiyMmNCkeZYT
        ArAUl9DhxxnYaVwxcOdKREi3Cgo8FQCj1aZ5r5dgtQ==
X-Google-Smtp-Source: AMsMyM4TP9brRWxKpype1DFHKlu6Aj6bHr/6gPMtNaazl6W9w6QvX4TlBq8aqYkdbfMrEQ5eVaIB7XKrQ/w7aHrc8wA=
X-Received: by 2002:a5b:5c4:0:b0:67b:89d6:cbf5 with SMTP id
 w4-20020a5b05c4000000b0067b89d6cbf5mr27056023ybp.286.1664311522388; Tue, 27
 Sep 2022 13:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g> <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
 <220927.86ill9yymv.gmgdl@evledraar.gmail.com> <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
 <220927.86fsgcy5j9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220927.86fsgcy5j9.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 27 Sep 2022 13:45:11 -0700
Message-ID: <CAFySSZB3hp2WWk0bL77FBR91ueJ1eJFtuVCoyE-ooVT77Vo_vw@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Okey, if it's not blocking a re-submission of yours then I'll definitely
> wait until after the RC to submit the above, at least, but if you'd like
> it earlier...

I just tested a solution where I add pipe_output_fn to
parallel_processes instead of having it as a variable. Not only does
it work but it also solves my unbounded output problem, so this is
no longer blocked resubmission.

Thanks!
