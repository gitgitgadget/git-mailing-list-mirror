Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDDC433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiAZWUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiAZWUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:20:15 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A2C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:20:15 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id i14so911736ila.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2MbI8BJAvRybUw/q7CPVus6Scr9641Rz9uiSyNNCZCc=;
        b=sgOKc8LX49/yWpKHuRmD1ZRXYwUSEXDuivZbPbKj+fqVlpvzssxMGwOes5NR9r2xHk
         FcHX3Cgmxt7vn/+jbuQEErfE3kgbF49XpDPcV2kz2rK70q7LKDif9egN63nJl1lwksyQ
         4cMipl4yrc0LrUlRb/C6+I2kw1EpeduYsXw9nALBCf/Oj0rgw0EnCSwY4CjcNJfEiyvn
         J1E4Ytj3YGOUVki4uAA8clD8XISgvv/9clZ00vqdmPEoH1v+DeeWNZbjSC0juyf6+yAD
         DdWjLVMUZvI/9LEiq/G2obVy0jqFrWnWnjjwiyOE7T122bQKPxkBnt28aenwNeNRuX/x
         PETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2MbI8BJAvRybUw/q7CPVus6Scr9641Rz9uiSyNNCZCc=;
        b=bplAR0Ehm07UYw3sYCa583JHEtu9hSjxnnBfnSrRZAqCYjXdAj9x8bczP2KzluHqak
         0yYaLZ0VFbg9bEt96631Dn9kasOQn+698UmwXdhkZgeKsBj/V1jiwvZaRih8pQRCB7xa
         Uxx6uXJAKTyQ4/GoyC2Ggz7Bs+xa0MgeZaFFfHmnxcV/xCd8MuaJHdGdBRUWj7SydsJp
         hjUAwDu2wg6Xn7KamPEnPZrTFNb+f9k4mgwlGDQfRNNv3XXzLM5qJCxSEfHaqhZ9dGBw
         tp80jKG9AuJ268goQScgzk0OI1N/UV6VU9czhTPXTQobWBzTtnK4g2wf0/4oKsqo5bIV
         4ieA==
X-Gm-Message-State: AOAM530TV4XoXcJrj5L4gYfFgSTubIBqQ1bIAHiHoum0zeIvx/Lka5s5
        kxiH4Stk7vz4SOA9vWXF192ImfrOumQl8w==
X-Google-Smtp-Source: ABdhPJzUQGUUO6UiA/NeNyqf2txvr2USg5F0cE35XNYkLP5r+OVGUxuItCOHfQdCeDYhIz3REUrBKQ==
X-Received: by 2002:a05:6e02:13ed:: with SMTP id w13mr867097ilj.184.1643235614957;
        Wed, 26 Jan 2022 14:20:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r189sm6995639ior.2.2022.01.26.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:20:14 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:20:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Implement `scalar diagnose`
Message-ID: <YfHJHbMKA1u+A9LF@nand.local>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
 <f48cdebb-ff49-24b0-973f-b3e7954e11c8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48cdebb-ff49-24b0-973f-b3e7954e11c8@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 10:34:04AM +0100, René Scharfe wrote:
> Am 26.01.22 um 09:41 schrieb Johannes Schindelin via GitGitGadget:
> > Note: originally, Scalar was implemented in C# using the .NET API, where
> > we had the luxury of a comprehensive standard library that includes
> > basic functionality such as writing a `.zip` file. In the C version, we
> > lack such a commodity. Rather than introducing a dependency on, say,
> > libzip, we slightly abuse Git's `archive` command: Instead of writing
> > the `.zip` file directly, we stage the file contents in a Git index of a
> > temporary, bare repository, only to let `git archive` have at it, and
> > finally removing the temporary repository.
>
> git archive allows you to include untracked files in an archive with its
> option --add-file.  You can see an example in Git's Makefile; search for
> GIT_ARCHIVE_EXTRA_FILES.  It still requires a tree argument, but the
> empty tree object should suffice if you don't want to include any
> tracked files.  It doesn't currently support streaming, though, i.e.
> files are fully read into memory, so it's impractical for huge ones.

Using `--add-file` would likely be preferable to setting up a temporary
repository just to invoke `git archive` in it. Johannes would be the
expert to ask whether or not big files are going to be a problem here
(based on a cursory scan of the new functions in scalar.c, I don't
expect this to be the case).

The new stage_directory() function _could_ add `--add-file` arguments in
a loop around readdir(), but it might also be nice to add a new
`--add-directory` function to `git archive` which would do the "heavy"
lifting for us.

Thanks,
Taylor
