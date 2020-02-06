Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB6C33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910C524658
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSX6DFtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBFSAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:00:14 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41860 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 13:00:14 -0500
Received: by mail-pf1-f174.google.com with SMTP id j9so3487836pfa.8
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glnvAFQoOtOqW4NeJAM1BdJTGJRn1A6dS6Mewx1m4Mw=;
        b=WSX6DFtB12b5IDNjWYbrCuGryGBNyw+zwDnikYhtofMGNvSM8kcDPZlYpydlc3bSUz
         78zsG1uv1oYgdP+doUy+gVj8s/GV1CJkKUBY3YplVgycjYUh/ebkIRyy+g+a1Woikxcx
         L+TU6TJWOHrJkP/8WqbyTGWC8Y8522qCcJlL84TpY/5Z4G7PvbwtCYwQXNWYJZM93vrM
         aT68H+26wyZJ7CA+976MnpTGWqwLs5uje+S0G8Ua0WO5q95P8BtvuKCtvc1o9Ly34eqn
         lGAj589EnN+hJdCqtuCTf8XN1bW806apQKXWztz2BY+HRBa5plW0GAERSjx/JZ4R+/Vv
         BJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glnvAFQoOtOqW4NeJAM1BdJTGJRn1A6dS6Mewx1m4Mw=;
        b=bQOVrN95FcMd+Dwt59b7pK5XOCQkQKThVMqpdZMuklfHheJIZ/JIWZ0cm0fzWJhazQ
         F0hc3bl83rhdmtWvBQIGRzXH9gMZpx/5tcb0rkBj5SPTrn+CzwdJC10OZBQmdeLJh2Ky
         /d26oxxYrD0FgDjdnqymGqnvqEMfNLUdRM1iHJK8si5R2I/zc+mmw1cO5wEQHBrsjZD8
         FsmlDY9Zrjyc+I07MCJDotWWHQGn5VC6c+VZYrXA7UsYY53kGHkxaOzBhHh/h3xq2yNN
         tYRP8aSWiXjuWTCM5lOflnpcMPB3ntUxW3U2cQv120D6latFc5CUdrKbGeq0AXfJ/o+n
         Mh3w==
X-Gm-Message-State: APjAAAWgi4Hmekksi/gWOBEo90tMV7GO2TDjbFLL+odtocP8QKuRiK2Y
        XhJcYU38aPx8YRPyDCCVr+tbDhyOmYz9Vy/rI78=
X-Google-Smtp-Source: APXvYqzwFrMvhQCFBhqCzGFEEkWyuWZxrBoQFGT7QN2DU4MA8s7TTdyH23lbdYkaeNGCf13ReyvcLblJIiIs0gUz/7s=
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr4897027pgb.383.1581012013695;
 Thu, 06 Feb 2020 10:00:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
In-Reply-To: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 19:00:02 +0100
Message-ID: <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com>
Subject: Re: Printing a uint64_t portably in Git?
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Feb 2020 at 18:54, Han-Wen Nienhuys <hanwen@google.com> wrote:
> What is the right incantation to do printf of a uint64_t on OSX ?
>
> Apparently PRIuMAX is to be used for "uintmax_t", and not for "long
> long unsigned int".

You could cast it? Grepping around, that seems to be how PRIuMAX is
used:

  printf("%"PRIuMAX"\n", (uintmax_t)var);

Martin
