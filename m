Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C7C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F219207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aymo0gd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgJGUK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgJGUK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:10:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6872C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 13:10:55 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d197so3889105iof.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fwg8Pb2VvogpRKU9bgl9LdD4H4bRCENM5K2GVJW2SZs=;
        b=aymo0gd/wvv5TvGKuj25cL6RAQPT/zCbonk+jwwNDeel1xr1ZkhqVzP7WpFCcupX3/
         i2q/cm1ciSLE92nFEZoJVoL/TMjpOXM+C8YiYcY8JnVzRrfqpJpkpSQ1wr9TJ8h4EOkE
         u0TQOZEpNNkncmzp7wJr1o4OofPtgaNAjjTQK1JBfM86uPmnBH290RxzsJ21VO4U35qG
         lRRZ6q0PH8HifxI0wuQ51IBvkv5k1IGLTFK+f27TvwwNxUMoXh/8gHhu9r/LMKciC82X
         dv+OiCGH+BH8NWnvbpS5QZzyUzbgM1/gO9562PmqQBB6f9DUFbzE2dMeSqsqOtQlIwh3
         QoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fwg8Pb2VvogpRKU9bgl9LdD4H4bRCENM5K2GVJW2SZs=;
        b=Op9Y5KUjoxhb3WWObg3X8Vt8jXV4jG79jeQhBl25/1A9Hgv2ZCniSL1qJwTKIdSHzl
         cbUo8slkd8xbU1kk9Nw+33XJZ91f9hP7X9BRrsPqr4eYFMNTJbUOOEb1lOLryP1bzRIQ
         /LNwcOxaWYYTJBH5HxKdKP9C/PouVlT6ny3MJeWzhFiuXIdktggmirkB9uwQFrKu4xz6
         L0koK1UUlv+gXkOu5V4zkmzQaj5SpM/DIs15xqSPqaz2TXroC7WuSKXzZiijrbUIyEtN
         /K+T5f7itWlAtv0ckZLQVNruo8Pq5jERensbhCHzM8R8rhIx8B+afafXEF7hjMqg11Mv
         0t6g==
X-Gm-Message-State: AOAM5337nUIJ0pcUJVTkS7tdGulxuwgvdaX8uFdLvDdjpdvZU/EAAx8a
        syQT4083KoMvitEPX3u0dXcBg31rn1Lyj6bEleryMGucd5k=
X-Google-Smtp-Source: ABdhPJyWR7jez9oU8mm5TYBNbrAuhvGQeU8am4y2ANpQqVxL5fbkFM63TGpcqT6DwWwDcZH9YwnTa6d0uTAA/Yt8BSw=
X-Received: by 2002:a6b:dc15:: with SMTP id s21mr3513638ioc.162.1602101454706;
 Wed, 07 Oct 2020 13:10:54 -0700 (PDT)
MIME-Version: 1.0
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Thu, 8 Oct 2020 01:40:44 +0530
Message-ID: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
Subject: [Outreachy] Introduction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

My name is Sangeeta and I=E2=80=99m one of the Outreachy applicants.  I wou=
ld
like to work on the microproject "Unify the meaning of dirty between
diff and describe".

While looking at the files for `describe` and `diff` commands I found
that the `describe.c`  is present in builtin[1] folder whereas diff.c
is found in the root[2] folder as well as builtin[3] folder. I could
not find any implementation of --dirty in the diff.c present in
builtin[3] folder. So is it that I have to compare the implementation
of describe.c[1] and diff.c(of root folder)?

Also, I was curious to know why is there a builtin folder when many
commands described in that are described again in the root folder?

Looking forward to working with you all.

Sangeeta
[1] https://github.com/git/git/blob/master/builtin/describe.c
[2] https://github.com/git/git/blob/master/builtin/diff.c
[3] https://github.com/git/git/blob/master/diff.c
