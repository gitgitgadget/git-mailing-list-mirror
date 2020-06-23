Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02EBC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753F52073E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oagDbovl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgFWPzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:55:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8AC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:55:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so15752014qtr.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CiwIVnb6il0v1w0jkoGr8wArt3oCZcqOdNqCdJAPq+8=;
        b=oagDbovlxw9rnta1/vY0JR/vaEVpT9nKjl6u/RKaRuDQgcCgmoZfIkRSAeB+ulRP1V
         EKtjUf/grx+Kdnn/vLerXglTqLirdhm6bQ3HgSGkPD81qp2/XGg+i7ua8AJlixILfZtZ
         Ua+7x2iagHQzl5fQW6Ffd/z0BeGjJWVYr7lrs9u2DTxyTo0XibCXNbSCi78PQjRW25oI
         GtgdlMxFW8R71oCSk6GuChUcQZmNLO2lkJtyA4DWc2rM1fmygeexgj8kkD7QVv3uIwRu
         bgtbBNZau5wIdf3ROV8r0hCy3MtDovMJkY4UWpck3PdD3qtYFATB79aWeGDDCX/0e3oI
         274A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CiwIVnb6il0v1w0jkoGr8wArt3oCZcqOdNqCdJAPq+8=;
        b=VYNaApRYMZlshxfZGirUmlQov6vOVYi71icnp/TvfLfA++ZegBuCX2E35+Qn12cNRx
         CLb1oyvoDtVw8rDaxw/oYqQsoQ+UfBWcv8iuGXbWKKza+0Ptgyu2dyTyoW4SM17Ehv2f
         0sZMQfb2p7mNCydxZ1BIdf5imVDwna+HfmYgC5gPH6cILAbX/Ptrl9dhYiIKH2oq+8TT
         DPTpSHbTHWRikWNMv2lHkUIc0XYfGFfm+ktVUmJ1taivgHhM04zcpwDFcgUl+g8+tMvH
         m2FZrEIzSbfQJbnGbZ4sIwyxP28ccCehMoRGHpzzSwHQzJ4UHcO4UQWJms0LDCJ3EDvf
         JjrA==
X-Gm-Message-State: AOAM533ml0K4mVMWENiq7u2TNPfItgDVopQTgb7jpqdYBWtLthARFTaF
        W/PipK19SxbE6q7UeorvkD0Q2TWEzOQ=
X-Google-Smtp-Source: ABdhPJyK+qrZ5uCEi0DX1sUnhYYNolcj82RM+GKy8FXT+AWr02rTrts4fBogoix5tGTBAXQmRPs1mQ==
X-Received: by 2002:ac8:46d6:: with SMTP id h22mr22438687qto.145.1592927742319;
        Tue, 23 Jun 2020 08:55:42 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p11sm857190qtq.75.2020.06.23.08.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:55:41 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:55:38 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout: teach --worktree
Message-ID: <20200623155538.GA2014954@generichostname>
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
 <2a434d328429907a304ad6aaad4c1d9261d27831.1592124367.git.liu.denton@gmail.com>
 <3c223d33-7f3f-7f4c-df91-3b72271308cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c223d33-7f3f-7f4c-df91-3b72271308cd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Sorry for the late reply.

On Tue, Jun 16, 2020 at 05:01:53PM +0100, Phillip Wood wrote:
> I'm afraid I'm not sure that adding another option to `git checkout` is a
> good idea. The behavior of `git checkout` is already complicated enough
> which is why we ended up with switch and restore separating out branch
> switching from file updating.

I think that since this option clearly applies only for a
restore-type action and there are checks in place to ensure that
the user is not attempting to use it for a switch-type action, it
doesn't introduce much more complexity than the `git restore --worktree`
option does.

> Given `git restore` provides a way to update the worktree without touching
> the index I'm not convinced we should be further complicating `git checkout`
> especially as it defaults to --overlay unless -p is given which is confusing
> in itself.

I don't think it'll hurt to provide more than one way of doing it. As a
pretty long-time user of git, I've been having trouble picking up the
switch/restore commands in favour of good ol' checkout due to muscle
memory. I agree that I should try and switch over to these new commands
but old habits die hard and I think it would be much easier to just
provide this option to checkout.

Thanks,

Denton
