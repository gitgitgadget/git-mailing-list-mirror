Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E79C433E0
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F0E20708
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMV36Qrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgF1KFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgF1KFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 06:05:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97521C061794
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 03:05:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t18so2593otq.5
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xfvQXnvKsVNMdGnNrPPLTcyGg5uw0Eqz3Fo+a8nvQkk=;
        b=LMV36Qrf7ydLJ2k+dkWCAUN6QJdFd+hwEXBYNrszL5I/XqMudemJnD5PfxSXgptn0l
         3fYI7+Cu60O71JwIuyAVJ1mKCnL5hkHFW80lBrGvGoQBl9rqT6cXFxA4x31N6DRgoFT/
         4n0TQYU12NSgIR+vPNsQjIaAnk0lz2fYhIzHjCr9sWJp9bAJH3nGHPUkDrSQvH5CvdjA
         XkpYF0IPTPPqRbCiT/ypB8v+lKXvr0vcrySO+DdPmSpv6eleTnGxIv2lCERx/6bOraEZ
         x1PaHTfgb9WhwoopxGqRiJsD1wb/CJIbWw6fLJ2fZqadQWQUZZiP/xhvpLYXG++WzYtG
         AuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xfvQXnvKsVNMdGnNrPPLTcyGg5uw0Eqz3Fo+a8nvQkk=;
        b=YPF8dhfiWcgtB06d0eQqnVIoNZDeI72epEoI/HlvJhBP211DAC4QUqHaRdSoCpAiKj
         Slehx5KRw8hCk1YNpooc5XsXht7ZekTwSBCd83RanBZd8EFGuzHXLqj30ITlxQF3rdQ9
         DWb0vWCvinL/Rg315CMjc6xx1gJ9DyxXvNHOsAvzy2q3WRWMeVqhcyhSTV+Sh2tJ/V8j
         V8NcUokrIDZqQ9Vx2OFk4WAKtPqmAhHBLDWGN3Zr9lY7Wz+4DaTw7QxIV7z8xAI70WPx
         K+DAvP4vItz3IY7fcLjAoH4BCQUfiyb6w/896Uvw7JtnrJntZMI72tg0UJsNAVhVCcGu
         A0Mw==
X-Gm-Message-State: AOAM532Ul6Oaz1wqeZh9iVrPISAMK5H6g8KagnKmEDhDYFlQXjXugQ8p
        Pf+TUlvJ+HbALbjGybdODi6JZnlJx6qdv5gkcZwCqEdUTlM=
X-Google-Smtp-Source: ABdhPJyzdRdCAXFzuH867GZBmacfpelR6Dgu8K7sfF6DQMvECahN6rsguiYy1r1Hjtwe5l+2yBlEHb07m5yYjoKGOgw=
X-Received: by 2002:a05:6830:60a:: with SMTP id w10mr4975373oti.241.1593338745503;
 Sun, 28 Jun 2020 03:05:45 -0700 (PDT)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 28 Jun 2020 15:35:34 +0530
Message-ID: <CA+CkUQ_-_Rzu00w1L7QeMxT73a_MsD=8kY0+wtuRmze4z+1_AA@mail.gmail.com>
Subject: [RFC] ref-filter: add new atom `signature`
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In ref-filter, we have a bunch of atoms which serves as a formatting
option for `git for-each-ref`.

Despite of having 'subject' as an argument to 'contents' [i.e
`%(contents:subject)`], we still have 'subject' as an atom [i.e
`%(subject)`].
Likewise for `%(contents:signature)`, we can have 'signature' as an atom too.

Currently, `%(contents:signature)` internally uses `parse_signature()`
that only works for signed tag objects. I plan to expand the scope of
`signature` by defining it as an atom and will make it work for
commits too.
Also, thinking of adding `signer`, `key`, `fingerprint`,
`primarykeyfingerprint`, `trustlevel` and `grade`[print 'G' for good,
'B' for bad...] as arguments to "signature".

This change will also help me in using ref-filter's logic in pretty.c
for formatting options like "GG", "G?", etc. To know more about these
formatting options, you can take a look here[1].

If curious about what approach I'm taking for using ref-filter logic
in pretty.c, see[2]

Would love hear your thoughts on it. Any suggestions will also be appreciated.

Thanks,
Hariom

[1]: https://github.com/git/git/blob/f402ea68166bd77f09b176c96005ac7f8886e14b/Documentation/pretty-formats.txt#L221-L235
[2]: https://public-inbox.org/git/pull.658.git.1592218662.gitgitgadget@gmail.com/
