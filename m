Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FFEC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE09D2072E
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoTbKjia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXBFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:05:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40700 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgCXBFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 21:05:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id e19so15525578otj.7;
        Mon, 23 Mar 2020 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce7ghwbl6moWeoJ7H+elE8g/gTwzTq+V4pdCT2RTKnQ=;
        b=PoTbKjianUmQfZTfV/iWwL8SiKSJHK9TnjSTX0+r2+Bh9y3woLJ8qFfVe6G2Q/yyIH
         EY/1T7TUrVGv2iSqlW8YJMX2w0DIOY79A4gzyNnFR8KwsegMypyNJB9u4atRz+DqQAa2
         RzXHOyfUQRGHSBctY2ZKMP8rW4sMBOI/MWKfyGM4t5BfK7AI9/1fGNkhEaNRNYefFsZc
         i3X7SlZ7FQ++QBuDmKaZKTTodDbOR3uHulE28qWDWdAWWqY/+xjcVdM7Jso3tGSRA2wv
         4ZXLy3VvDODzlJZI+hWkt3R+LxO5vYU+JOscCoYGKqgaWxPCtkvmSllh/anmI2nKE4jn
         c95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce7ghwbl6moWeoJ7H+elE8g/gTwzTq+V4pdCT2RTKnQ=;
        b=dzVqaOzhmPaEGZvWEQQpPxlnHI5qVw5CouugAJdmP7IBMeCZdgX0J21n4+v4QkqZou
         5CycNLK3VSRopnm+jNOp6u/NNWjB9DP94rJu8BnNkGmCbWFpcBo32vuSzpafkVRiKjQo
         IgM22Av3Fum8Luby/CJ9JKNZSPQhaW7yt1JsFcq2KbofkJbm/1DFymLUSVM+g9UUnqcK
         WF5gbf4NP9FvBhLck/nb6DehoXLQvNmYOmvjC87XGiPo/3DSAwSSaNxuAAPuKcb/+ndX
         WhnzGdx/f4Hfe7GpDjtFoRt1q2/2EEbsJdEZe675C7soT+W4u7nh9afgozEY52hypE6u
         KiWg==
X-Gm-Message-State: ANhLgQ0G1O2As8Eb/+Z9nkBVZnPxxAZzgtgDX03eOfub2pNCremapXyh
        mX5TRBSXFsH9TVAVdNXQN7Mw91VWA29XXN1ScFk=
X-Google-Smtp-Source: ADFU+vtzRIEAKZOksidg1JXq5o0b5sxHaDLH1Ts0A6brN1RBaTkYpSUrVsWYYXEoGn7n22NAlWAHwMbCfZ//MQk3Jag=
X-Received: by 2002:a4a:3b50:: with SMTP id s77mr1262094oos.53.1585011934220;
 Mon, 23 Mar 2020 18:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7477u6j.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa7477u6j.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Mar 2020 18:05:23 -0700
Message-ID: <CABPp-BF_sO+bx8HFPFpVeZStft4oZ-wHRAbNFmBEOWnya99Aqg@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo v2.26.0 (Was: Re: [ANNOUNCE] Git v2.26.0)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Mar 22, 2020 at 6:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest feature release Git v2.26.0 is now available at the
> usual places.  It is comprised of 504 non-merge commits since
> v2.25.0, contributed by 64 people, 12 of which are new faces.

The latest release of git-filter-repo, v2.26.0, is also now available.  It
is comprised of 16 non-merge commits since v2.25.0, including a change from
a new contributor.

The public repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via pip[1] or a variety of
package managers across Windows, Mac OS, or Linux (and maybe
others)[2].

New contributors whose contributions weren't in v2.25.0 are as follows.
Welcome to the git-filter-repo development community!

  Sirio Balmelli

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md#installation-via-pip
[2] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md#installation-via-package-manager

----------------------------------------------------------------

git-filter-repo 2.26 Release Notes
==================================

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

* Fixes:
  * fix cache of file renames and myriad problems with subdirectories
    that had the same filenames as parent directories (#53)
  * handle typechange modifications when first parent is pruned (#61)
  * avoid dying when using --analyze with --refs (#65)
  * permit trailing slash for --[to-]subdirectory-filter argument
  * use more expensive prunability checks when needed (#64)
  * relax the definition of freshly packed (#38)

* Performance:
  * multiple performance improvements for --analyze (#52)

* contrib scripts:
  * fix lint-history to avoid dying when we get file deletions (#51)
  * point people to an issue where they can find more linting examples (#45)

* Miscellaneous:
  * Installation improvement (#55)
  * Various documentation improvements


Changes since v2.25.0 are as follows:

Elijah Newren (15):
      filter-repo: permit trailing slash for --[to-]subdirectory-filter argument
      git-filter-repo.txt: fix nested bullets to render correctly
      Contributing.md: start with git guidelines, then mention exceptions
      filter-repo (README): link to upstream docs
      filter-repo (README): streamline prerequisite wording a little bit
      lint-history: avoid dying when we get file deletions
      filter-repo: avoid repeatedly translating the same string with --analyze
      filter-repo: accelerate is_ancestor() for --analyze mode
      filter-repo: fix cache of file renames
      lint-history: point people to issue with more linting examples
      filter-repo: avoid dying with --analyze on commits with unseen parents
      filter-repo: relax the definition of freshly packed
      filter-repo: use more expensive prunability checks when needed
      filter-repo: handle typechange modifications when first parent is pruned
      t9390: add missing '&&' in command chain

Sirio Balmelli (1):
      setup.py: test for FileExistsError on symlink
