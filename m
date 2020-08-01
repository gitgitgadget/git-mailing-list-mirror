Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7119C433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD28A2072A
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsyogQZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHATav (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHATav (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 15:30:51 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3AAC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 12:30:51 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id x187so5587008vkc.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1C2Qj1Za1dgzqDAOnpoi+2yeDIaRJaDHmoeYikrDYsQ=;
        b=DsyogQZqlqfjg0KEkCOxxBWg9p0/eoCMG/b0m5j+0VHRiLrtKKTCl3yMDgGY9ZFKCx
         dYzzRFtLX5JtWI1jM2RgYYrYx/r0QnSjwREgPdTuBJeaJW/H5TtclxdwKbCTG++j7pvG
         z096dKpzbvfpAkFaw0tIXIbYy9eRyJukdYtJa4f2e8L5l9ISB7nnMb9zRi0pdjFCZEZt
         H4mvD/+vZAjioXO/g4dBCLbRcW5g5S1JyPGjdMhSWccESkZVrvd+x6pjSstYYp73lYUY
         AcYjxPJBogARz/M3Tw8SPbh5DjfM8LK1H4Zozv5T0iiyyv88Asj+Jiwxe6/FmlCHUZoS
         bAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1C2Qj1Za1dgzqDAOnpoi+2yeDIaRJaDHmoeYikrDYsQ=;
        b=iEIuYxFGnno5pJYHUcFIdOhkonN+PkN5SVC+XUhH8vZpLeolq6CBbh7JuUk98+L+g5
         HwfF2TbTRY7S0hAFgkf00kBKD/1ErSzVlcehSyyPFL3qazjjmYtFyXjWmeHh8eZTZEwm
         ui94ZhzkS1hdVPEgktgnMaRgI91ePV97ly81qQ49k5vKzk42J+2UDzCSYPYQAueJx4Y0
         a7udJLHUzZ3hrZQ0O18CdG8IbXq19qIbOklYgtJJix5w6btRDsyTfQWdZEzs+9zAjZjd
         afqMEq52Cb+F8aHdeyQxo/yx9GbokLB7nwgRszLpr8zksLyXPPkN+LmK1JdrumX6rUSa
         qmtA==
X-Gm-Message-State: AOAM531OQiOL0P4CKv0XYml1zFakGAdzax+kumocrezv+w9ze1fWKjiY
        QcLu3/HIZ9mmjkr0hiI+96TKBjDT9GuoryI5K6Q=
X-Google-Smtp-Source: ABdhPJw3RQrqT8xaKBg09mEW1lh3YLvuW0pOLXTsE+87tlZkAltsk7PnHrcCEFWZqTfjI+vq4x3l5E4obEg9paj5YO8=
X-Received: by 2002:a1f:c946:: with SMTP id z67mr6553783vkf.85.1596310250194;
 Sat, 01 Aug 2020 12:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200730002735.87655-1-alipman88@gmail.com> <20200801175840.1877-1-alipman88@gmail.com>
 <20200801175840.1877-4-alipman88@gmail.com>
In-Reply-To: <20200801175840.1877-4-alipman88@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 1 Aug 2020 21:30:38 +0200
Message-ID: <CAN0heSqph3gW0-3bQRTTugxFjjztYp_EjwfCKQzJ1iFxdQKdug@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bisect: combine args passed to find_bisection()
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 1 Aug 2020 at 20:01, Aaron Lipman <alipman88@gmail.com> wrote:
> Also, rename existing the "flags" bitfield to "commit_flags", to
> explicitly differentiate between the new "bisect_flags" bitfield.

s/existing the/the existing/

Also, does "separate between <one thing>" make grammatical sense? Should
it be "separate between <two things>" or "separate [it] from <one
thing>"? Dunno..

Martin
