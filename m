Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB35C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 05:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAIFnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 00:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjAIFnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 00:43:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37BFD0A
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 21:43:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q64so7649590pjq.4
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 21:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SE7oEkl+vmDeUS8bgYAe69utMVnsesfPXE5tPHOxGgM=;
        b=mp579zlIjMe5yfjoKK2jaQeZNQOKJnKnXiVkzWk7apmR3Cr//mPzPUAeM7MpgxybhE
         rKszzJ8lbFO/nw4kN87dsPeWR/12fTlo2SP4T6wFy+Wl/uwDJD//dfWFG/bpEhGluKq/
         Hqjw+IqnRqAOq8JOcsxlNdZfWQdXSpVOiesNFcYh3F/ljONvRdrz0WsAO49gjeJUAbGH
         e8P2G+plfgI5P6XnKaH7LUfzHQfTfdwAJgxErQCfFMKetvHZ8jgt3TVXlbbttnolHt8K
         +mp5Sh9vG0rcj2lVGsNRHcrL+36NVGGe2/UCS3deBc3H5sPuUbfezJ1fwH+1+50SVsU6
         jycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SE7oEkl+vmDeUS8bgYAe69utMVnsesfPXE5tPHOxGgM=;
        b=1OsUFM1BT+QXpAlIya3L6JZYmMCIOhBlhEwKqu9UScdeWL2QaxcgnXD1lOBmBqCoUP
         mU6L51OrcEi661CAtX047P6KatJRouaFH3f3qnrwdWRgbFlza5k39nDSHPNg3Q2fNppf
         e32in4Jx4HTEZRnU4sWszHcCzCA2hwfepVLaRvOCZfl8F6P6SaeuGrIRaBhAgckOkJoN
         s2dK2vYiXsrums/ao8/KNtGAkpCQeBrqMZuX6STOnEi9wb8PxgjDggaIXDCqF/yd9lWp
         iuVzQwSmGxjDJdf1e4+Z4LEmn5tk8NqHt+/I9bvHqr5DmaTVKqhMOusBoHJmFJZWdNwg
         Um7w==
X-Gm-Message-State: AFqh2koORC+iUWqiKIrBSF5OW/SedI/6WCR6EsxL1qLhIo7nMxwI9aVn
        Sjp1ZvBikXO3D1LUq03kPz0=
X-Google-Smtp-Source: AMrXdXvf3GFuFmMILNTz0A1bfXvL6E2Wshx6UhSp/LHLCjZ/VqBdYxuB2JOreKt2EBnqpt6Ohcpwbg==
X-Received: by 2002:a17:902:d544:b0:192:757c:b111 with SMTP id z4-20020a170902d54400b00192757cb111mr54261908plf.21.1673243014230;
        Sun, 08 Jan 2023 21:43:34 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001894881842dsm5089266plr.151.2023.01.08.21.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 21:43:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
        <xmqqwn5wuwvs.fsf@gitster.g>
        <CAPig+cRMdJy9FdL1_rwuMKcA3F3p4g3RF+0mkh12pqN0aUoUiw@mail.gmail.com>
Date:   Mon, 09 Jan 2023 14:43:32 +0900
In-Reply-To: <CAPig+cRMdJy9FdL1_rwuMKcA3F3p4g3RF+0mkh12pqN0aUoUiw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 9 Jan 2023 00:03:37 -0500")
Message-ID: <xmqqo7r8uut7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Yes, good idea, although I might phrase it something like:
>
>     Environment variables such as ... are exported so that Git
>     commands run by the hook can correctly locate the repository.

Excellent.  Thanks.
