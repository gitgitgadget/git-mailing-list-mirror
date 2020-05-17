Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0505C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 21:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55AE207D8
	for <git@archiver.kernel.org>; Sun, 17 May 2020 21:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSIYPCFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEQV6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQV6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 17:58:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B44C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 14:58:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y10so3998857ybm.12
        for <git@vger.kernel.org>; Sun, 17 May 2020 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iN1H/gG2d0vJfHmJh98/rPu/h7M1eoiLQzHQwxa4sbo=;
        b=aSIYPCFeSTFNjHIE9tAcxUwSU316ej9fDAsOVvqrBzDLhmzqVg/l0h5RVP47TTzAzD
         7Dq/U9AwXPZmECwD6znn221AcbGQu0Acs2ZwA6xo4GT5qC32Uf71d1eNuAUebABz2Cf/
         7d2qTgaBd/MOmXIpVImQlEmtZtM4LsVMy8sELUGQXpToxLxky+yTC5bx5CJRJkFILwxq
         HtAV4z0TghMk2we7h07BWEJFnShajr+S3YrqZ8SM9qyVYQ7pV2GeEcA6F7O0654ZJeWQ
         uGe6ye5nos6NOlLBbhI5oUvz7wgtRglxc7sb4lL9e8CZR4Qlg6NuRGvqiW43O0CJpLnW
         Lizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iN1H/gG2d0vJfHmJh98/rPu/h7M1eoiLQzHQwxa4sbo=;
        b=QccM+Icsup/aLV4v0KCa9baqlJuQeHxbMezTrfT0Fn8OYV2ra8xBNiiZRecu0d86W8
         CulhdGDOMrtX7yBogd/70r1m2ZMb6xvWVc523+ImxybjFU8B2j8n7ESamyH2FAphsrez
         fGR+1B+GrXm0PKC5ilSQK1UfND8GCHp5t12cqJJxflAimJ/2U5ayU6Ncjb9k1NgIb8FQ
         14kqBS/IwKk+2djCoVMV+fzrgq7DZa9nf2yIJhUQtQvBkBpOFGmx2wSn8rLS/0y2vGTA
         VYjsmt4+o/Vil6LM8DYUEv9Y5ktE3gGnJt/O59pVdDlektOQ20v27r+2S49uMLlZKPco
         WC0A==
X-Gm-Message-State: AOAM530Q8gfzdGqA1FfXNAdQ13RNRL8po6ruf8p+SEK6y4Dp3vItTmg1
        UqfR3UMFIX4oN+M02/OpWst5GXaUnVzZFUljx+5rYNu+xa0=
X-Google-Smtp-Source: ABdhPJyjXH/WqcmyIVZb8irwVxtK1S70Fltbqoq09l0nPxDFmgSqlWMFbFoGKlOb5z9G/mWifKheUtWnECPFIakV6yk=
X-Received: by 2002:a25:2e0a:: with SMTP id u10mr19115697ybu.155.1589752732283;
 Sun, 17 May 2020 14:58:52 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Sun, 17 May 2020 17:58:41 -0400
Message-ID: <CAP16ngpd_GbfUkSuBks5jk2vskks5_SRmVHOmfaEUTLoWiD8hQ@mail.gmail.com>
Subject: contents of a .git file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Hope this is a place to ask this.

There are lots of foo.git files.

I'm trying to figure out what's un a git file. As an example,
http://git.drupal.org/project/drupal.git gets the drupal repos.
However, I can't seem to find the drupal.git file. Even a net search
doesnt seem to turn up a file that I can view!!

Any pointers/thoughts would be helpful.

thanks!
