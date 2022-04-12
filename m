Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B9C433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 18:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiDLSHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358606AbiDLSHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 14:07:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C41A073;
        Tue, 12 Apr 2022 11:05:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g20so23316907edw.6;
        Tue, 12 Apr 2022 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z9NQi1ml/pNs6k8iFZmY0TUp/xSTyZP8LgV9/lOgFis=;
        b=ibbIomvT/EBEch/llY78xJmulZ6hYp7HHP+xatYlWvfOAVZaMu1EhWY8jc0lv4Jh4g
         GymFM0rd62Sn4GwW1d00Z62p2GB+vvAzB9Mq6tuLl/a2YImSPXlmnILZ0U/0+tsGX2C4
         0ry5snn1VT9Ppa7YQuZ4cFMx2hcC4f8GOZ6s/P5NzUsp1Q33Zfohn1sVO3FPr2GEOgeb
         hKHHSJOSooTO+QD883W6AEWaphQF+c4/tNqemtsf/2E9ThCJ7brKloKqE/D4qyKs+t9u
         uwieWr2UPUwEG9X7EJ5iRD9bAZNpMl2iFqmatRoiTS4+94TWeFKiLbpEfFcQ5AcKykJQ
         DuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z9NQi1ml/pNs6k8iFZmY0TUp/xSTyZP8LgV9/lOgFis=;
        b=dahcl3BvYRChPl5PnNu5lEH2kE8sKypAMhxw3t3dEMuZAdKSW2b48G0M1aJSzm7s90
         Qr4meI/mVXXOHZnXPDcEtQclQE3WAgJHA22SKkLVxXCwtG8AGEvYIdevlFqP1Cpw4+PD
         vprXDql4ZSQ7uxuZ7o6/SEWpKf2/Yxj+Fvj+r5NFRPwqesYdhZNmGaOspBezLlbYt2JT
         tJ7DvqHESofP78m2GgQuKP2TGppG5faM0tB27r/9AGt1KJhpxbLujNS76FlL7AnI2MsL
         //m+ToM5sxRsSp7vSVaLYT2HYvDsS4AEGp6bpfdEmSXM9WmxJ4mz6bbzcNXBlTAXBkPW
         2yzw==
X-Gm-Message-State: AOAM533P2ik9A7sTIu8gX+YfOhXyc/GpAA5OJGiVT5hoZz/d1Itn5JQT
        76Hh3QYSEb9i+OTfNEoZqKI=
X-Google-Smtp-Source: ABdhPJyIABxge0CAv6F9qxtvjbzi7Tdb8OYw4iQMENg06sAb5pGDm4C5oS30mSLjHnonVoaiUhP0+w==
X-Received: by 2002:a05:6402:644:b0:41d:77bb:d36d with SMTP id u4-20020a056402064400b0041d77bbd36dmr13842082edx.381.1649786717735;
        Tue, 12 Apr 2022 11:05:17 -0700 (PDT)
Received: from szeder.dev (62-165-238-123.pool.digikabel.hu. [62.165.238.123])
        by smtp.gmail.com with ESMTPSA id bn3-20020a170906c0c300b006e50416e24bsm12673650ejb.98.2022.04.12.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:05:17 -0700 (PDT)
Date:   Tue, 12 Apr 2022 20:05:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.35.2 and below for CVE-2022-24765
Message-ID: <20220412180510.GA2173@szeder.dev>
References: <xmqqv8veb5i6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv8veb5i6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 12, 2022 at 10:01:21AM -0700, Junio C Hamano wrote:
> The latest maintenance release Git v2.35.2, together with releases
> for older maintenance tracks v2.30.3, v2.31.2, v2.32.1, v2.33.2, and
> v2.34.2, are now available at the usual places.
> 
> These maintenance releases are to address the security issues
> described in CVE-2022-24765.  Please update at your earliest
> opportunity.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/
> 
> The following public repositories all have a copy of the 'v2.35.2',
> 'v2.34.2', 'v2.33.2', 'v2.32.1', 'v2.31.2', and 'v2.30.3' tags.
> 
>   url = https://git.kernel.org/pub/scm/git/git
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = https://github.com/gitster/git
> 
> CVE-2022-24765:
>    On multi-user machines, Git users might find themselves
>    unexpectedly in a Git worktree, e.g. when another user created a
>    repository in `C:\.git`, in a mounted network drive or in a
>    scratch space. Merely having a Git-aware prompt that runs `git
>    status` (or `git diff`) and navigating to a directory which is
>    supposedly not a Git worktree, or opening such a directory in an
>    editor or IDE such as VS Code or Atom, will potentially run
>    commands defined by that other user.
> 
> Credit for finding this vulnerability goes to 俞晨东; the fix was
> authored by Johannes Schindelin.

This fix causes trouble when attempting to 'sudo make install' any
non-tagged Git revision:

  $ git checkout v2.36.0-rc2 
  HEAD is now at 11cfe55261 Git 2.36-rc2
  $ git commit --allow-empty -m foo
  [detached HEAD 237ee2a6ef] foo
  $ make
  GIT_VERSION = 2.36.0.rc2.1.g237ee2a6ef
  [...]
  $ sudo make install
  GIT_VERSION = 2.36.0-rc2
      CC version.o


