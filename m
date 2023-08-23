Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1532C3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjHWT5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjHWT5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:57:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0210C2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:57:07 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5720f3ce5afso146651eaf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692820626; x=1693425426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkrlirHoO4wSPnN4olUOta5+tWDxk2svV+9Jq7LASSE=;
        b=R7M5lw6Ajl1XGC2fR5q8LjMGp9fMgh6ybHRdByMyNyjpPrqKCwATpgIteFsQExIB86
         koxD9Cu6IOallPjwPVnezFBV4SBSevfqD1Ejyf6zVtzTcN4FK1fhOGT8TBiUKTVowFb3
         BhSi1iIKXkWxHxmCwJts/yEho7KqAStftEFFj0AtnLEWfm2E4GS+creSIUWelV8HpNza
         jTQ7/C8gChTyySWHDW+0WDuJeH+llnyeaptNSpECzQ+GLXUZsPF4VUCE4kLutYbAx/j7
         YSy0zLqb3g7GQvJIzkMlkKZ/8+c5JmbrXKozmA86WdZ6i3mG66EPUfkmcq6K68N0KPAO
         8b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820626; x=1693425426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkrlirHoO4wSPnN4olUOta5+tWDxk2svV+9Jq7LASSE=;
        b=Idp5wlEp6YrCrdgEa5MAkABrHYYRjo6k6N0XzTfutuA7mEYsn49OL1B+D6ERAcs4F1
         Feaf4nJMNpxTPrXuavjYAU1ezblfKOhrSUFJDKTf90EJAP+RFP3VVG/aRNu544Lnc5SJ
         bbPb5LuVaysH/9UpSm8YxPYK6vbBdlXd2ilb+odw42CGSyIl33ngj90RcXozUgr7xJog
         +CskyexmTgvL9SE0qQoZCoYiTLZKHNBViA3gnMpo++/ziRm33/dhc/bBE7iQkdFUWj/P
         qLwCjtTWzjBHyPo+dMbwiTokxMd6cMNLgTeDQFpRfptQCkslb31aL191Ltzfjqnbv+uR
         6thw==
X-Gm-Message-State: AOJu0Yxw+1xVGB7E8E+Dgpg7R3CXhdBnq9XSRnKNbL0wJ6BaroPWmuXw
        ADQzL1hT1xWMDG7ts0NddRePYQ==
X-Google-Smtp-Source: AGHT+IHLTNWQbUHxBIY+XMp09TycKre98TgFmTRkAbLH6ruo3Jd8G9uW5B7Of6IMZVyI7Vun94m85A==
X-Received: by 2002:a05:6358:e49d:b0:13a:db5c:e614 with SMTP id by29-20020a056358e49d00b0013adb5ce614mr9432984rwb.7.1692820626595;
        Wed, 23 Aug 2023 12:57:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m14-20020a819c0e000000b005773babc3cdsm3470774ywa.83.2023.08.23.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:57:06 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:57:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
Subject: Re: [PATCH] submodule: deprecate --recurse-submodules=""
Message-ID: <ZOZkjoknPJkhgNYf@nand.local>
References: <20230823032839.731375-1-alexhenrie24@gmail.com>
 <ZOZf4/DYOKqQLjR+@nand.local>
 <CAMMLpeRam03bmO0jnsbKQB7174xv12HJzTtC-6dHFbQDMKB5gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMMLpeRam03bmO0jnsbKQB7174xv12HJzTtC-6dHFbQDMKB5gA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 01:53:22PM -0600, Alex Henrie wrote:
> On the other hand, given that the empty string does the same thing
> both in a config file and on the command line, maybe it's not a
> problem to allow the empty string on the command line. Personally I
> think I'd still prefer to ask the user to use a more explicit syntax.
> Thoughts?

We should be consistent, but I don't have a strong opinion.

Thanks,
Taylor
