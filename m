Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B5ECDFA1
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiJZTlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiJZTlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:41:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85CCA4878
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:41:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o65so14470603iof.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OsYf3lB/xXTm05jnsXVezvcaIub5pipQzL/0DgIpjI=;
        b=XwYhYla8QlBaWNJVNkx6iYuQsktXRrHa7JvQhmj4a0h645Mq4iRGPIlNQMAJEEXL8h
         l7jFCww8y5ZHCaywlT3ZigVrTNHJ+PAMsU0M7iWDIWTSM7QBfMrTwD46nxVVyX6wNbYp
         NtIjwBpxfcDKqqtaKISFElwmRlK4LR8Ug9h7FE8UGJPkSfgoyZhKbBKbdxHxvcTHv8SI
         MeW+XMdGveHWWPy6D0I/JF6dqCU1GN7KsVzBfYYdxllz1ge+iQfA5Ev8nlQoElR1cQw7
         nt7BCPWZK0iw7qiciGA6BujB8X/UbGeS4QAP9Flb3XklqNn/uaF+u+1BUZrHI9T40KiF
         4JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OsYf3lB/xXTm05jnsXVezvcaIub5pipQzL/0DgIpjI=;
        b=vioWCOVVJsjakfMIxruvqxtQ4LzYw3P7SDbDIOXgrtGHPz1I4RHXfn1PvdjzkC//u6
         7m8HGa8pdzxK4FmYLVAui1KqEVBRGbrm/C5kzLqKJ9skJsYSaR3TtxWpTynfhq3/iJxb
         CatAaJEUx6K21qdZK5NAbZjwmnp5q59mbrCS/gFkilcYMnV2JJ9KcxG6UFUQn0QZahUV
         SZqJU+ROwBmH5xyRJYwTkba8AJ2xaof41WWL8sbSXkWf3SRAcPqPcCTEFliX3Q7UlhlD
         IAIUAndAuNBMbZGrhsT7Jas1dx6dVfePQsdOowGCoPW1Upd+CTXbgxocDPC2sM8emJJU
         3e4A==
X-Gm-Message-State: ACrzQf23XnHCe/fDIOMyhbrEi/RBwOdQZP5igYghkV0YtgVsj17cOEtD
        qVlsRAyGJ+o4PdVPHUiRSEcTW/nR/rn9geA8
X-Google-Smtp-Source: AMsMyM5GcVWraT4G5gWr7T5U16L4Pn2EdciMHZTmIaCzorz5nG2avxiU+tuTRk4Tn2ybDYoeNPAuqg==
X-Received: by 2002:a05:6638:13d2:b0:363:f597:880 with SMTP id i18-20020a05663813d200b00363f5970880mr28280431jaj.32.1666813269136;
        Wed, 26 Oct 2022 12:41:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y93-20020a029566000000b003636cb862d0sm2370560jah.42.2022.10.26.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:41:08 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:41:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #07; Wed, 26)
Message-ID: <Y1mNUxjwIMYxS7GS@nand.local>
References: <xmqqwn8mh1di.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn8mh1di.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 11:43:21AM -0700, Junio C Hamano wrote:
> Starting from next week (week #4---see https://tinyurl.com/gitCal),
> we'll try a mini "bus factor" exercise, where I will disappear from
> the list for a few weeks. Taylor agreed to volunteer as an interim
> maintainer and will take over the daily integration of the project
> in the meantime.

Thanks, Junio.

My goal during this exercise is to keep things unchanged and running as
smoothly as possible. To that end, I'll pick up topics from the list and
graduate things from next to master, and so on.

Broken-out topics will be available in my fork at:

    git@github.com:ttaylorr/git.git

Once Junio does his final pushout before going offline, I'll fetch
'refs/heads/*:refs/heads/*', and plan to do a pushout of any topics that
have accumulated over the weekend.

That pushout will be relatively small, mostly done as a sanity check to
make sure that all of the scripts are working as they should be.

Thanks,
Taylor
