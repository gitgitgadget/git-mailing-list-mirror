Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411D5C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B8623B5C
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihoqx6if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFTQQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFTQQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 12:16:32 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF7FC06174E
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:16:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k13so7302831vsm.13
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Uo4FPFnpIZ0KgQyFFHxDCQibLB/wNs3j0kZO1FpVrws=;
        b=ihoqx6ifoJ8UDCxfpMfwk0B0VVNZDdWUJYfXqOeZJ83T6kdjeTTgTT5U4jwFUzVD38
         twOTGrKO1q7gpqPEMf9tqJFw4n7rjgyigG8NsVFpZRO1/AEDjWSJcGxo2/3S0q0Jjn8r
         JIyIQlZQI8rsPyvm/cc2La+O3CYVwRuOMVe3azQ9GFUU7xnm3PB9Nn069/PUzg+0lqPc
         5Zy6Lbt2Kd9zhnUQCLjBRurL5iJxgzFTfC35SuoWYIQrzfukh1TZaInY7oJVFcGAU6Q+
         Um8W2sxgbtUrgI5oC46p9ssch4Lc3jO0A0QXkgyZBheogUEveYZcKiO509yX7NDtKs9h
         vL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Uo4FPFnpIZ0KgQyFFHxDCQibLB/wNs3j0kZO1FpVrws=;
        b=VluRr+I0z5KJkaI5jSR/Zo/y5KwcVFvwmpMIl8HotJ3Fdgw55EDl1y1FkVh2ARWmGX
         hS5H43pCMyD3rC1V/AxN79DuL6kJV4WI40rpPTQukiB5wsPjXZ68uTu3Zj7ILUDAMCY6
         BDYK25ieTm9q6EWjU4WbmXVujbMjq3mN0eChIK3OkYXb+G3bHNJaUb2Ai53zVuM2q9n0
         JkWUP4tScProTIHTRWQnznAT0qPSxhLDvFRYU5jR6PCZCV+4K1Svxy30g+sP4MShSBap
         +rwvrQCJIMXpOo8ZWq59hJBGpNJ7+W2OoGL8z7WiYUUppbngFRe//Bx9J3p3sVTI4LMb
         JSgA==
X-Gm-Message-State: AOAM530Qrh8j6lldsmzRSAbKzBSVSFtcXD6vYsz91rAzbRqwsCBTmE/9
        pgRRI4u9laT3uCCBeGf5BKHzdexogQizGkNYP8sT7Wad
X-Google-Smtp-Source: ABdhPJx75zFqizphkB+4ZbzQQBxbELmi2SBATBADDVtM0/n+3DP0Lz4v4HhqYyRqsceXV1F6qMYBF06hDh7ITabpNqc=
X-Received: by 2002:a67:ed41:: with SMTP id m1mr11216629vsp.189.1592669790762;
 Sat, 20 Jun 2020 09:16:30 -0700 (PDT)
MIME-Version: 1.0
From:   Solomon Ucko <solly.ucko@gmail.com>
Date:   Sat, 20 Jun 2020 12:15:54 -0400
Message-ID: <CANtMP6qbX_U_0sWtUvNQVtMboMLJshsHc=n-5eA4_XXNGEnzLQ@mail.gmail.com>
Subject: reset --merge documentation typo?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, accidentally sent as HTML instead of plain text.

The documentation for `git reset --merge` states:

> Resets the index and updates the files in the working tree that are
> different between `<commit>` and `HEAD`, but keeps those which are
> different between the index and working tree (i.e. which have changes
> which have not been added).
> If a file that is different between `<commit>` and the index has
> unstaged changes, reset is aborted.
>
> In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
> but carries forward unmerged index entries.

Where it says "`HEAD`", should it say "the index"?

Thanks,
Solomon Ucko
