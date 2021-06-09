Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E083EC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC31613C0
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFIU3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:29:33 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37653 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFIU3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:29:32 -0400
Received: by mail-ot1-f46.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso2219416otj.4
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Jtc78f5iBvL7nY/X65dpaRbU6o/udJT0V6SGqbRkn9Y=;
        b=axTwFomqDcW5+tJA0pZbuIBQ/dgpEWm1zkmSU46n5rUlvhWdRI8rNBwn+FLRhnYUvL
         UZZs7HRdYwZ9Ax2aZZ5JXI5uN9ibziRnaJ0Pe4dUcngsQH3wpHIux/29z8FwWeXPXF52
         Ki5/+ZHT4X6hJyRfyJrznflwyE4HbECwmb7xap9bp5uBKGAZ8vNiQR1Pw+c4vaOl9/fl
         uZJ1RTZoUfYSl/vtxr3bW8hPP5T0g71mvY7O01bjsaqxMTet5n5I8pV80E9O8BeaOioJ
         0RQuwSiC40imR7ooVFdx9rAOhdjPqNzfUQQEYJMwMH/p7iyhTwUN976/da9ub3EoIIOC
         B1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Jtc78f5iBvL7nY/X65dpaRbU6o/udJT0V6SGqbRkn9Y=;
        b=SAFHo6UMggCRZzy+cl2hE2gvLqFZPD7zi/XpZ/fGmpreS+ytuE/WL9WjCHqUte3jLc
         gQZWo3c3lvor1lnykcE7kIyRdp/+ZxuMVkR1/NqY/4BBjb7gYhdYJ2RNFfOBJmzg+TcT
         puG7B/zT027YNBqD/7d95olAkCIl81ZChPQ6OgS65sKAklWyy7p6vERWP7h3GHQiOt60
         aObR9UoVegkY1XFxYkeu46YzpSOf/U5SB2MBoPSefGagt70/S9e5cJYOedzimRTse+gJ
         ezK8XC70/lyZvHarhFmd3qwl18yQpN4kgWjGwEmI47nHNaSaQRqIOHk04ct5RLSPu6Gi
         uUGw==
X-Gm-Message-State: AOAM531a1VHVtAlVGnjGPUOIZMZcCpal8UbRF79DNlurX5WzsHX0YZNt
        xa141CuC1QS7kG1GEWhp2eg=
X-Google-Smtp-Source: ABdhPJw/2TOKaECx+5qc/ihAphj7eyF7wjzAnyuA+4m2Wqe081JY3ulYh/cBFUMx0ikxbmHPpuuHbA==
X-Received: by 2002:a9d:475:: with SMTP id 108mr1011184otc.69.1623270383471;
        Wed, 09 Jun 2021 13:26:23 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x13sm208706ote.70.2021.06.09.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:26:23 -0700 (PDT)
Date:   Wed, 09 Jun 2021 15:26:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c123edcae35_aa2ee20886@natae.notmuch>
In-Reply-To: <87czsu98ar.fsf@vps.thesusis.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch>
 <87czsu98ar.fsf@vps.thesusis.net>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Susi wrote:
> 
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> --- a/Documentation/SubmittingPatches
> >> +++ b/Documentation/SubmittingPatches
> >> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
> >>  . `Acked-by:` says that the person who is more familiar with the area
> >>    the patch attempts to modify liked the patch.
> >>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
> >> -  reviewer and means that she is completely satisfied that the patch
> >> +  reviewer and means that they are completely satisfied that the patch
> 
> Say wait a minute.  If that is a "singular they", then why was the "is"
> changed to "are"?

Great point. I doubt any linguist would be happy with:

  can only be offered by the reviewer and means that they is completely
  satisfied...

Unless we are in the context of African-American Vernacular English.

> I think that belies the fact that there is no such thing as a
> "singular they".

There is such a thing as singular they, but it's not what the proponents
of this patch think [1]:

This is a good use of singular they:

  Everyone returned to their seats

This isn't:

  We thank the anonymous reviewer for their helpful comments

Cheers.

[1] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they

-- 
Felipe Contreras
