Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B5C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiBPIyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:54:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBPIyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:54:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A554B45A4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:53:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m17so2622439edc.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RpxMCuhLiV5mzhr+1MipfhXdDC1lzQ4VZFdCeuMyAR0=;
        b=fnhOL2Bj+U7hTWBIZ/BFOKSMs094w35eJL1ZjQYhxDP8PN2kUfFFeDS+FSY+91YEDr
         2iz8M3LnLkJGtrntB4ZntjKWiGis/JFkMMYKuz/gBxpi18JhMkRLoOP9NmTfKXMe0Zk/
         sDRROV9Q2b2hct3A/23UbXzqWRDSOS2pAvqQ5yflunRiKYf2b1GZD3QhsnhwX9atbWJ9
         2gZgE80Tqzr4J5mmC+tUhQ/0buJeP0tm3C3q45Fd5BdzYmiVy4J6RgTU0r9GLdk/3OEb
         Pnv9at6tgfCpqYRaOBs7xq93rSjzUh/kbY30BYfDrUTZzHr46ARWuHR3Ew3NEm9arVej
         VDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RpxMCuhLiV5mzhr+1MipfhXdDC1lzQ4VZFdCeuMyAR0=;
        b=7DIKM0rMgpcXWIla6viuDPXtO++w6bPkVCIhZHvEEDCBvJ0thBNgQwmU4cRi0DcCvb
         JmBkPMO65zMdWAINT18//t6LCRqrm6BjObIKyALyY2WsvCnRsYBpkfw41WkdVKqtsqFo
         3EfFS5bnNs+BiSX0j1UauQMXaryEY9Rpth2/bo8ABSdThyLmZ0yOQHFl69I4Ip172p8K
         JjGJlx9C16yFtojqUk5/O0Msq5W4WI8tsV9npeeOz+Eqg1Y316X7lle8euZdq9bCDsQK
         v0FCqNOiH/DaHGibGYVLVmVEeGvk31FnoBYM2fzyPE+IRXCck+cxqMVulqoaajLo6fa7
         JP9A==
X-Gm-Message-State: AOAM5300046kNVOj8nkpR0KVp8+ZOGY0SwkLptoN7oNs6Y9+YTvdjmEu
        VmRRwMxmYMBpnB0WloYsMr66OJEYHULrVA==
X-Google-Smtp-Source: ABdhPJygrsGSobvx+Sd7FF4bcYCkPK6bUc8YrXFymqGQVjELHGNNFvs8OT5SvH/JOIgSGvK7+h5jew==
X-Received: by 2002:a05:6402:142f:b0:40d:e8eb:1dbe with SMTP id c15-20020a056402142f00b0040de8eb1dbemr1806526edx.421.1645001626867;
        Wed, 16 Feb 2022 00:53:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y27sm10712232ejd.19.2022.02.16.00.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:53:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKG4H-0037og-FT;
        Wed, 16 Feb 2022 09:53:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/5] t1011: add testcase demonstrating accidental
 loss of user modifications
Date:   Wed, 16 Feb 2022 09:51:05 +0100
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <d50d804af4e17ff1613ae40e3b5cf1b1bd0986a0.1642175983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d50d804af4e17ff1613ae40e3b5cf1b1bd0986a0.1642175983.git.gitgitgadget@gmail.com>
Message-ID: <220216.86sfsjur8m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> +	test_path_is_file init.t &&
> +	grep -q dirty init.t
> [...]
> +	test_path_is_file init.t &&
> +	grep -q dirty init.t

Maybe I'm missing something, but can these two just be:

    grep dirty init.t

I.e. won't grep report errors appropriately here, e.g.:
    
    $ grep foo t
    grep: t: Is a directory
    $ grep foo x
    grep: x: No such file or directory

The only prior art I could find was the same pattern in your c449947a79d
(directory rename detection: files/directories in the way of some
renames, 2018-04-19).

It's probably good to lose the "-q" too, unless this output is way too
verbose without it. In any case the errors wouldn't be affected.
