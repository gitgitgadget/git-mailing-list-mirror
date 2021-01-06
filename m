Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEDC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E39F23136
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbhAFUeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAFUeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E9C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 12:33:33 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u26so3988528iof.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL3AVwY5h4K4WSkbNBPflTr7Xh4uvTHFvkrUUjD3zcs=;
        b=tb1wI4ZGdtJUnTKQpI6Sq3zU4tfL2V+icc4FS+NAruxWdxa5h96JVyaCBxPeSWofkn
         TC8t6Db2MzqoxL4s2GG0Y9fK6S46k1tKQzlN254YGnllMBCKeO8+N5xCWO2ZawZeGyol
         B3Lb0tECdYDM4FieFKffxkJe5UoByqbMZ5i+K53AJQ4Q7I2kv2FaZ16+GtTBVQ0/Feqt
         AVRJTgfY64l6RcutNLJOq+qUZSkg0E77IfLJh0wDzPaUyGzVjmtMk0tyYsAXqxMIZnPC
         LQl2IJio+zFTjWxrxMG5OYYbHRM2UE3THvrbVUOCJ77TmLuoMK8GxGOZEwUBM1K8anwc
         YA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL3AVwY5h4K4WSkbNBPflTr7Xh4uvTHFvkrUUjD3zcs=;
        b=WAh5yMgD5QiFw4RKFHJbnSKUR07WBW1nLcFa03VCRUJaCNnoGqTVNzNLA8Yae0uXxp
         HzCBtTfAzOmbnW/1NcBbOPdfdSYdnQX/+lcRIcpr0ffiT737BUA90/YJ504Xi4AG9Dek
         oOvfD1cFbQhz2qWzEikk208w42TPmDgbDz125GPyvcdrdCT1Xe14NY5jdAzxLrXWwpLO
         4sHEMzcXliRV8EbVCuzh040Gws3mqF4KKAqdpLE6Ve9hoQsBxNdW+J9H+vra7yP1sbk/
         8bsgKp7dKLAzPW19o+1noDIWCqmB/jL+3Rn+qmT6T/Bm/pPKuZmI1zP3ZDbmHloKnpZp
         vPew==
X-Gm-Message-State: AOAM530ukePvRtv5M15lgVe1+e6uJueggmZnwbyJNL9r2ukRtJHrTk2K
        w5H+pJ3sJrUUEQLx3e5WGHBgUbiBHFsMwxLtrmH8rOK4
X-Google-Smtp-Source: ABdhPJzNtN2CnQAck27oGCxIt8RpxcihRK8e5HQkTha13dVGrkWTGZ9ITUaLH1equEKdh8Pi0plytrqALOietrsxHGs=
X-Received: by 2002:a6b:b7c4:: with SMTP id h187mr4268563iof.76.1609965213282;
 Wed, 06 Jan 2021 12:33:33 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CAEE75_1fnvzOid-xfNOtd0eZfh_y8QizfLGAP_ceOeTQdJy2tg@mail.gmail.com> <CABPp-BHzPkZu=s=ssmcW=jxg3bOmbL2CkbiQn6N7-Dor8H0BaA@mail.gmail.com>
In-Reply-To: <CABPp-BHzPkZu=s=ssmcW=jxg3bOmbL2CkbiQn6N7-Dor8H0BaA@mail.gmail.com>
From:   Jim Hill <gjthill@gmail.com>
Date:   Wed, 6 Jan 2021 12:33:22 -0800
Message-ID: <CAEE75_3qtAwhVgHjvch4gMaF_7MTcRf=YzomeTYfpG6H=FB-5A@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Monnier <monnier@iro.umontreal.ca>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 11:48 AM Elijah Newren <newren@gmail.com> wrote:

> The rm command presumes the file-backend for refs.  That might not
> work in the future with reftable.

True dat. The pure way is

    git worktree add newbranch $(git commit-tree `git mktree <&-` <&-)
    git -C newbranch symbolic-ref HEAD refs/heads/newbranch
