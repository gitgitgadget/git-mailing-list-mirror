Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C247C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3536A206D8
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzFN8fGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBUyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBUyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:54:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A12C061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:54:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e2so10790977wme.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fa3/8g5/ex4LV5rceHlfN4EeOwZ6B76AGW/Ry4CAXvE=;
        b=bzFN8fGzLy5fz074XD4M1GGBphvbo7P+VlUlnplINeCFqMkY/foiALmVuFYWM05/cz
         zH7K4dMp9X+mHCu6RZPs9EK9qB2CFn9s680ajFgrtSRVZpDGieeJBIjPy1u4iHyW9b1L
         XcOHn6F4hmGPYKnnMnbwIEtHRecfMUWswYexGY2Pne5o/frBlHiWF8cLmLq/hs67BPck
         rosl8TRXAKXciMMPcwtIiGaBtsQQDBsNrqJjh+sqnK14sbWluRCPCEwD+PgA/dyNvLsP
         XTXL9vURjd/TLoOL5dkEWxi3p+2Th0fq5i3C6GqeRewU8GjZtqalYDdyaZqt888yeY14
         5P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fa3/8g5/ex4LV5rceHlfN4EeOwZ6B76AGW/Ry4CAXvE=;
        b=aTbBG5BOdSD+g8AGgXahrqui52s/hvEigaSglvKcwWEkiLH3fMwp8ta2FNj59MBl3c
         1AadHC+fF2Hh8IoXd0+w2mzqOJs5Dmx5L2/0JnrSCSdZP4sJKAwqotyDjOdu5WrD1Ow5
         xx6vyPEcCP71wN1FyAC2RHajXTD46KGYqpQ01z1p4n4RziltPLn3lI1Cd7lX9qWEG1Iq
         R4xGHFd+xxe5D7rWlqW6ffDrL8C3mZNWo5iE2mPjkPN1R+M3TV6mF4Cy1rCULz4fn1eh
         fChCXnWNSAnkFUhf6plhHZYrim/MntuRkWqKqRIm6yVvubo1t9CRXA6Sp2+skTs5gs9p
         4Hjg==
X-Gm-Message-State: AOAM531HAJtRGiQmG3R2zCgPgAlAEk/LR7PUHY81OqKYXnn9plavJ8TO
        qIQszdMo3f7kpeDuFFYauGgeRNg03XnJ5uCzQbI=
X-Google-Smtp-Source: ABdhPJwcacqoPi/oht07i2hSTKw5Uq2lNsuwYPITMpRBbbpoBSI+x7kg8JpLjJWF1FmszM952wNIeOfFYIHCNo8J3Wg=
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr4202wmc.55.1604350476871;
 Mon, 02 Nov 2020 12:54:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
 <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de> <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
 <xmqqwnzbbfsi.fsf@gitster.c.googlers.com> <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
 <xmqqtuuc7wgu.fsf@gitster.c.googlers.com> <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
In-Reply-To: <CAMP44s1+bJMrmJWeAQx18S-=spoKb0BmzWyJ4WgzuE+rNuf0cg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 2 Nov 2020 14:54:26 -0600
Message-ID: <CAMP44s2V42MAi5R9XG94MxD9Ap1p6Y9FBAJOL60PSQSZspb3TA@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 2:49 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> You don't *need* to run the dialog, just touch a ~/.zshrc file.
>
> This should be enough:
> ---
> autoload -U compinit && compinit
> ---

Or put that in /tmp/zsh, and run zsh with:

    ZDOTDIR=/tmp/zsh zsh -l

No contamination needed.

-- 
Felipe Contreras
