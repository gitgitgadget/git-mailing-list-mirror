Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B0EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFZVbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 17:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZVbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 17:31:07 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799EEB1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 14:31:03 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5702415be17so28590167b3.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687815062; x=1690407062;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9YP/MiPduPvSy8Fs5WXUZfyfiq8AChCu/Qyd/NgtDM=;
        b=0gKKOCZGplmApl62oGksJcfUbzznVDe9UB6ue2M4W8aE9zRyH7fVOuBd/RNs2YGb69
         RmQz4+9W4DDDpNWTNLIPfT81fU9GoTCm+cENVOGfQ8BGGBxqaF+yPK6whNMrUimxSSTo
         RBXsmOttC9+ZUjhj29K00SjsQhej5q9fedhfCZu6hvd9hE9XR1GGoSoMw8WLhhuH0sv+
         WKj3xH3oNNbx8aLgIR/nktlLnKswFB9nftquqdPUwQpk7BH+20Y+2XoOBP7dBgOczX+s
         lPAiwWPXPt2za55VqUIVRwCBmFd1irI4BtyVICDb7OrVg+JbClCO1+J1pKkHuMpwmT6c
         0ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815062; x=1690407062;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9YP/MiPduPvSy8Fs5WXUZfyfiq8AChCu/Qyd/NgtDM=;
        b=MKkB3GZj91hEUPwcRlS02Em6S6k5P9nRIejXRPLnyimztB+Ddu0GyH2y5LMmpc0YN/
         xYrJ/AksnwJcapgnf+8Z1McQXG4SxMedAKdTSQU++4TQ2D1cZls3hqNO5/xow7nL+kgH
         d+tgf4Tp8uA+3gfrplkCL3iD4rIk2EJa0O5mo/Z51zVqJitx2U3mMWNpmKdz99UzZfsL
         8ZbKfjqMJ6a4QbiGFw0fsZGhkDaih1dAMJUM1HUNaPasF27mFg3noXpsYfG6UJpJSPLy
         R5LRwrmnFsCfGuO8/gzepYJpKPaORX0LV3O5zcxbd4r3y70FdqtpuDaXhth5tuSm7aCw
         5uTw==
X-Gm-Message-State: AC+VfDx/jllXyXUfq8tDlO31uXheA64CKSELhjvi6JUfkxbPz+lx3vdC
        /XQ/L3d1Ee3tsPL7OfFpb7EMi9rMmPXfWnKWCE+L2VWOUTk=
X-Google-Smtp-Source: ACHHUZ6tcphhWYgP3lXh9RbzqCdEOY461P9oJNilpsod8y5+01+iyo0HPZ/kKN2gyQhtGTPBw5SvdQ==
X-Received: by 2002:a81:6e89:0:b0:568:e6d9:7c1a with SMTP id j131-20020a816e89000000b00568e6d97c1amr26167308ywc.4.1687815062476;
        Mon, 26 Jun 2023 14:31:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i82-20020a815455000000b0057087e7691bsm1494788ywb.56.2023.06.26.14.31.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:31:01 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:30:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2023 updates
Message-ID: <ZJoDjnr+FkgrDsKA@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanted to share a couple of updates on the status of Git Merge:

	- GitHub will not be hosting an in-person event for Git Merge this
		year.

  - Instead, we will focus our efforts on hosting a virtual
    Contributor's Summit, the details of which are TBD.

The decision to not host an in-person event was a difficult one to make,
but necessary given the current economic conditions and their effect on
travel budgets for conferences.

When I asked[1] about which location folks preferred for Git Merge, a
number of replies indicated that nobody on their team would be able to
attend unless speaking. I think it's a safe assumption that other
individuals who would be travelling on behalf of their employer are in a
similar situation.

That said, I plan on hosting an virtual Contributor's Summit in
late-September or so for folks who are working on Git to get together.

This year's will likely look a lot different than the Contributor's
Summit we held last year in Chicago, IL. That said, a couple of
requests:

  - If you are interested in joining, and aren't sure whether or not you
    are able to, please feel free to shoot me a message off-list and
    ask.

  - If you have suggestions about the format of the day,
    video-conferencing related suggestions, or anything else that you
    think could improve the Contributor's Summit, please also feel more
    than free to let me know.

I regret not being able to see everybody in person this year, but I'm
hopeful that we'll get a chance to make up for it next year :-). Until
then,

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZEyDcBcGmLznqKzD@nand.local/
