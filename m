Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC65C43217
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKIXRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiKIXRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:17:03 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981355A8
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:17:03 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l6so234574ilq.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSj856Zg0FWOaReNJ53skxRzhCRD7/U8F3uhuTFg5KM=;
        b=6e4HVRvWymYOTH/9gqcVU+IIwKeZm+AzeFgJbkjtNxhFWzyoilsNkGOEyhpWVvs/Sx
         7GuNVvOJXLQvPaY7kVJc/8ZXigL4Qgq8tBHK+85nqd6Yc2Hw0SDlBXBotocLRlAXyRrP
         o9ryYcXgyLkg5C72NZcOy0pkubQgIN/OwKhphI6JQromKwZg2mzZEniAjVo3WcHjXavJ
         CV8M7NCZ2eL+wpEYbdgrTtqH6gBprE2+vaD6KQ3fMejq3CPfVbH2qNZRr0GkIWlzuulI
         prO7SxV4whTh0PVM4bTZWDJqfgBmPcI5MrwFnnBk/Ax9ZMH3bvka/MHZSeuYDWL8vnkG
         mORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSj856Zg0FWOaReNJ53skxRzhCRD7/U8F3uhuTFg5KM=;
        b=kTOXk1H4WVmq8hASqKQMKxVQWXQQ18UFsazusE8RIjLXsJ2aaBT7PR/fU0tpEUjEx/
         bOPiWtz3PJ5o8ShZ7kHuHMyPnobBuZe67EtpdUCkKXZ1lQHOcm84Ugic0N735BI4BKdw
         Z+Cei2bRWZy6vUDDGn/SwmlcalTqRWKGaSFELq/uZcj0ZxfTykoTtMa3x0eh/yu3ceJk
         PslnlcRJoK06IxEyOmrU/baaSoI3sXD1Al/hnLo7tsDqKizeveaDw5It4PwbeaLvUtHr
         NLdI1fiJJ2flyxC6R/zB4L0L5PGYrS8ZTJJz9IFtMFnKgfuddIrnHqNunexdIgyKfrub
         enMw==
X-Gm-Message-State: ACrzQf20DMR478AU3r9bv9P3MLWRIjmsqg1+JxlsTWgoZAipH3zTYFjN
        jPT4Ur+yOQvxLV1XXYLTikYzBA==
X-Google-Smtp-Source: AMsMyM5SfO7cVE24ey9J3I6QYaL4s4M0iJh0nOCvptW+Nre59XPTRFWDhSUm6PN6zNslfgmFg2d7cA==
X-Received: by 2002:a05:6e02:ec3:b0:300:9d51:311a with SMTP id i3-20020a056e020ec300b003009d51311amr32146055ilk.52.1668035822749;
        Wed, 09 Nov 2022 15:17:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a056602058200b00688faad4741sm5974240iox.24.2022.11.09.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:17:02 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:17:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] rebase: stop setting GIT_REFLOG_ACTION
Message-ID: <Y2w07ci8Lg0GQXSQ@nand.local>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
 <221109.86leokp0vm.gmgdl@evledraar.gmail.com>
 <28100f66-bd3d-d564-cb40-44b65ef415bc@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28100f66-bd3d-d564-cb40-44b65ef415bc@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 04:30:47PM +0000, Phillip Wood wrote:
> > But for now this is a good step forward, and fixes the leak that's
> > "unique" t this codepath.
> >
> > And of course, just makes managing the "reflog" variable nicer in
> > general, as we're no longer talking to ourselves within the same process
> > with setenv()/getenv().
>
> Yes, that was the main aim really

Thanks, both. Let's start merging this one down.

Thanks,
Taylor
