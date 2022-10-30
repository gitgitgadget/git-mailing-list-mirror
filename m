Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C5ECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ3SHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3SHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:07:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E1BE1
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:07:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p141so8286937iod.6
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUMTe1qJLvYPwIr4iBsm9oQwcDqbTFujApTPARddlZs=;
        b=QYx98U+oY0JMjQx6XO/XI+SiR+vdHWRTanvYcBLpjHUDxUqi6TakmwfDCSqpeBhdU5
         KaBaxRAGuUeDRK129n1OqEHYU7E6rxf/WYRun3W+5YNg/p3wJpfBmKEePW+S1QNT/0Uz
         +Cw+v+8th9dxoPAI6lcE+xwTr/rWNThbGzN5UBZ9H+o0t7tJHaqh+AYJKX3SDw62GHYQ
         WAdDw9ZROh5/4BzsMvZ9JjPh+w2GH0FRLaEA30/b4gl9W4nPjIzbi3AFIqSAvUwfEOyk
         CRSZY7DK21KCVrZJzIjs/fKS1yhIIAQX/tgUf4i68/7CIHSaHWKAs79JhWSvJZ5SjRKK
         M6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUMTe1qJLvYPwIr4iBsm9oQwcDqbTFujApTPARddlZs=;
        b=E5xvvtB2tUGSNfbRLGQl/3G4n2/yjcwLyMjoLFalk+mNaQOrHE5VuIebAwDjVb8LEf
         +eu1WO/WBKOCR+MkwSM6SUc0R7HCLG1E4y1HHciFd1bSPHjar41GqEAp8QHi6dPTjBhF
         tOyzId6vmTnA9+2uSPco4Cv4XdciEUgm4XFFMaf3jR1GhWSfcNVVPnwoaaY6s6B0vdVL
         874X7iid5RCs5u0oU9WZnXlff9EyimVRsMzMFdXnYzD+Psr3LjGEhryBhyjH+3GsDEhX
         hI2b0YA+hVdRe6r0mdd8eIaLHnxz9Rs72+OUA8o0RhcP6Ptnb/hQOz7XP3RfSn+3jDVZ
         1KzA==
X-Gm-Message-State: ACrzQf0TLjFMLOQFKK3Iz12GCxrKp0nJomVaUxUTDyOV+EkDlYFc0NE+
        4w3ZNDtzZ5btsRH+n84ZfhH5Vw==
X-Google-Smtp-Source: AMsMyM7B80i8Z6JAqSlV1FrXPlmAktRdp9utlyVUwY5E+mOhOX0Iv90sOO+hapPino/tkxBNN+NQcw==
X-Received: by 2002:a05:6638:31c2:b0:363:496e:b5a1 with SMTP id n2-20020a05663831c200b00363496eb5a1mr5414096jav.237.1667153254634;
        Sun, 30 Oct 2022 11:07:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v3-20020a02b083000000b00374fe4f0bc3sm1820327jah.158.2022.10.30.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:07:34 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:07:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Message-ID: <Y169Zbtvr33rBQvc@nand.local>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20221029092513.73982-1-siddharthasthana31@gmail.com>
 <Y11rnKwuR0q47ngq@nand.local>
 <CAP8UFD3J3Q4UTGo5aaDDVth1hXLXAt53322z3TSNWTVRNiJ8Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3J3Q4UTGo5aaDDVth1hXLXAt53322z3TSNWTVRNiJ8Xg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 08:06:19AM +0100, Christian Couder wrote:
> > Why was this split off from the original series? I don't have a problem
> > queueing the two topics independently, but an explanation of how the two
> > interact would be appreciated.
>
> I think it was split off from the original series because it's a
> documentation fix that could hopefully have graduated faster, and
> could perhaps have made it into v2.38.0. Or perhaps it could make it
> in v2.38.2 if such a bug fix release is made.

OK. Can we please get an updated round that clearly indicates which
version it is? There are several messages in this thread with the same
subject line and it is unclear which one reviewers are happy with.

Thanks,
Taylor
