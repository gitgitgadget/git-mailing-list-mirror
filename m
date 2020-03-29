Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D4C2D0ED
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 07:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE4820748
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 07:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC2HXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:23:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52518 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2HXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 03:23:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so16279056wmk.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 00:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qnt4T/1TQf7KNfTuLqKlzqH0C+MmvDLLFY4GpsLIHBQ=;
        b=fWsp8oHn6SHAzPK7IEQEOcugdNzIQnGMuGRr9XEomqwJjIYb9Mj3Uc9y/Osxvout+c
         YMNrRM/baSPs3ZJKuyoSo2AgrqSkkVL84eLmMFTi+vNH1Az+Y9eYlpSNGSAT96BmXyT2
         r9kEXgoywKU3oS1qefOzW2FRZhu6OF1hme3ltPbhSJuGHpOqLHK08UOfnZr+hj7iLB6E
         8ZPOH+O1aw0vvtTa8Jw4Aa0p0bSaHDB54aQ3CxlWxFkO9guy1c/Tg0yi6v0J7Mc6YZVP
         +H3BRdrNgAd6D1eSpq3PaZOWpU67Y4gN/SsTn1nWUZzNa9Npx7Dn1gDQxEyshf2vArK2
         pqtQ==
X-Gm-Message-State: ANhLgQ1EjqXJ28Wc/cOTp1o2MtVId12HeJhTtuhO+D8iOKs8eTJ+olfb
        sMx8jhaR8VNRQOxGVwU+HyauAKY3tkSdO3e/iPs=
X-Google-Smtp-Source: ADFU+vv9yfxcMB8gR9Y1WEEosnVYbAzrU5Cwr4eCRfMH6FfCVq0I7DFCpuz+ZIYV+qY5kLeDY1/x4bZJNk9e5Xu8BLw=
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr7082297wmf.130.1585466602968;
 Sun, 29 Mar 2020 00:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net> <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
 <20200328105418.GA639140@coredump.intra.peff.net> <xmqqpncwca6k.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqpncwca6k.fsf_-_@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Mar 2020 03:23:12 -0400
Message-ID: <CAPig+cQfu_bPYzgaqOmAqSYfR1WGnZu0i6FfwtpH=dPAgd3h-Q@mail.gmail.com>
Subject: Re: [PATCH v2] t/README: suggest how to leave test early with failure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 7:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Over time, we added the support to our test framework to make it
> easy to leave a test early with failure, but it was not clearly
> documented in t/README to help developers writing new tests.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/README b/t/README
> @@ -550,6 +550,40 @@ Here are the "do's:"
> +       test_expect_success 'test three things' '
> +           for i in one two three
> +           do
> +               test_something "$i"
> +           done &&
> +           test_something_else
> +       '
> +
> +   Because the status of the loop itself is the exit status of the
> +   test_something in the last round, the loop does not fail when
> +   "test_something" for "one" or "two".  This is not what you want.

s/"two"/& fails/
