Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D4C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 21:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiCXVbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbiCXVbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 17:31:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B45110
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:29:32 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x9so4056383ilc.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AUPlkox8RvE76k6l3P7dUitsKMRJJx4LaLcQLF7h0TA=;
        b=vK9Wv6BxH23pfNpILewgv2tnqsnomL46w4Dw4kMfHLsEsntA/U1d4lwh3Lk6CEp9eL
         74v7qLFtCtJYkEPaS5O1YHI7y0WDa03WDEfrdccG4PuF2/x8wF03tB4j7JmTEVm+eI6N
         QTxbL9Dh8jFuhaNEHMLgocnn/4Q065nF+DzbjipDLUlEUglPfTTzJvTds29wkWqLa013
         j6Nol5tU3aGWEMvwWJ/sekxbebt4a0ArK44X9LfyMkgUdq4epXYY6zxSwDQyFXcQ+g+9
         aHQiU3az1wS65CkZTFfMqeW9wpLKv7+JNA6KfFX8tVYhRtLq/5DTZ6uuygUEGyEmXYhC
         2iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUPlkox8RvE76k6l3P7dUitsKMRJJx4LaLcQLF7h0TA=;
        b=oqGjLbApsy3AC+WPJLPXFKitqTsV9TA5tST7rcJHMrMa3vShTa9dp/gpRFv3Viw5Ml
         YzV96XUmE3nlFMY/7WjdBeL69axU61VkbpQXba87877ksagVgKeznx3PT8ONq9Rd4s80
         kCzlvCXxU1Nt6kNdwu0uqrrFBzffGyoCvJMSaBqFN1akAflqyybBKeQSM+OdHnunxBRy
         H0Wpc3AI44NxKo9Z3YrUVrxHO1Y8RnRtIoYjcib+1ZtRpSx5C/uxPHTEPn/Dtf40z4qQ
         GCoGhmK/GQ2PHY/jvaya/3yGb+QkGJM/Zu7or1sBXGjxpInoE0VOdEM9v4siqKKMEkNy
         flAA==
X-Gm-Message-State: AOAM531ORAhuaTn1VqxVfnwdI7VBpX+wiOQIBK7Z1jfzWLzkPoNDQUjK
        cmmWgPOzMKqF9PdBE1U/TxFPiNbBPeWf4lUI
X-Google-Smtp-Source: ABdhPJzQNrmOii/JDyQjWBQCwv9N/MlCGv+65G9BT8SKfGYIxWM49hesgOeAsSIwRui/ruquW+v5Sw==
X-Received: by 2002:a05:6e02:1b0f:b0:2c7:9a3f:6e84 with SMTP id i15-20020a056e021b0f00b002c79a3f6e84mr3526719ilv.32.1648157372144;
        Thu, 24 Mar 2022 14:29:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm2005953ioj.31.2022.03.24.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:29:31 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:29:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Honza =?utf-8?Q?Proke=C5=A1?= <proke.j@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: bug report: pre-push hook
Message-ID: <Yjziu8nU/SZ7SyH0@nand.local>
References: <CA+ZGDOUKrNRdf-7+SBoVhPkAmyHEtt==AJ=jBDWGkOUcz=n4BA@mail.gmail.com>
 <CAJoAoZmo4bJgGdYQeM4XtRJHOpm4z7Gvg=qpUc4xa7Ap=v++UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZmo4bJgGdYQeM4XtRJHOpm4z7Gvg=qpUc4xa7Ap=v++UA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 11:30:16AM -0700, Emily Shaffer wrote:
> > What happened instead? (Actual behavior)
> > Tests seem to execute on the background, but I do not see output
>
> I wonder - are you printing your test output to stdout, or stderr?
> stderr of the hook is printed to stdout of the Git process, so that
> may be why.

I didn't think that we redirected the pre-push (or any) hook's stderr to
stdout in the parent process. I wrote a small pre-push hook which is
just:

    $ cat .git/hooks/pre-push
    #!/bin/sh

    echo >&2 "hi!"

and then:

    $ git.compile push ttaylorr --dry-run 2>foo
    $ grep hi foo
    hi!

But I might be holding it wrong, since I am not a frequent user of
hooks.

Thanks,
Taylor
