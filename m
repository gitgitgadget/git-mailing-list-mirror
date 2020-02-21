Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B7C35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113F24650
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOYhg6bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBUNoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:44:17 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43763 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgBUNoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 08:44:17 -0500
Received: by mail-ed1-f52.google.com with SMTP id dc19so2364671edb.10
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5G7SyKBS8NIY4ZsOsC0VNO6azRU0ffAHBUdFN2zqCM=;
        b=IOYhg6bqGomysCavcr0pPkorQmOLrpRzFMyZWMBA35glD7tM7csbqWt/gsEjz67kt5
         UcHEpSE8sOmfZD7OvB+jKDoir4MHhlOE1ntYo1sFcASihCY6Itgb+DZCSxjOQ4ugWlm+
         sbsD6JN6hcX/kNCROopAkF7ACra/T09W2Ej35/I15nqPtnaBz4kiWctlJRr4kH3wb5V0
         WgQd/bf+o1O+Z0tDgOx6UMuGgcG9RMWnDvqr6p5x/UVJrseJa3zWT+BFxXLMeQR/mrN+
         Udw1HfJEf3/sw10VHUz15qyBzTQB7WgrvaZOjs7IO337m3r8Cvk5nYXzNe53L6lHIQjo
         3CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5G7SyKBS8NIY4ZsOsC0VNO6azRU0ffAHBUdFN2zqCM=;
        b=YSPiQGuaFsq2Bare1KLbow8O+Bx95jghPwCvYbQtVh2thrYi2GXaA9goN12mnh/2DO
         PWV8BZnJHFcw90H45q5KJLb5QHsOzPK5PstMGufGpujLu+rWTghxZAkFEKkl9pjqLIW6
         sXTwP1BzspjkF23mKZpLd0WH+QHuVAKIhaii2JCi9yMsS8w1zZpBiTNLsiZ55g47tzxV
         k2xAR+iQWqX5gG0UrtHyUtxF/jVFpBXBqMr0Bnw4WWPwtFMLPALEGZwnqjfXyIQsPk8G
         LovSpN/ObmqpEVdJ8I3eFkxJWBN87p9U2hsuLo5qMk0lry3NRiVq3bufCePZNk6YOVsv
         VZBg==
X-Gm-Message-State: APjAAAV80RgosCPq2rBvYcBIGjxDwEx7H/6jNonIbvnPmMtAHk9GXwn1
        RVKcYDddVA8CJ2heZEhqJWOzDyWMQ5+IFLzfe7Q=
X-Google-Smtp-Source: APXvYqxrHWTZSPY8DpLFm/ZXuJxFqxSSbv3Av+FIOATFKveUVAbJOrBkNiWpkLj1DWtHUg+NqRtJKP7ng8Z2WKifi+o=
X-Received: by 2002:aa7:df09:: with SMTP id c9mr33849712edy.133.1582292655016;
 Fri, 21 Feb 2020 05:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
In-Reply-To: <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 22 Feb 2020 02:44:03 +1300
Message-ID: <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 16, 2020 at 11:39 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> For some time I have been thinking about trying to get more former
> GSoC students and Outreachy interns helping us with mentoring.

Hi Christian,

I'd be happy to co-mentor an Outreachy intern with an experienced
mentor, hope I'm not too late.
If so, please guide me on the steps required to get involved.

Thanks,
Heba
