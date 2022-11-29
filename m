Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEEBC43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiK2B2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiK2B2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:28:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08C22BDC
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:28:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d6so11942419pll.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE9xbb5dwzWCQdgf927oihC6gUb8e0SadHAzyr+CWyM=;
        b=SsZ1TNUXsO9b0vs4NiyoKH/+Hd4Eq5nIA5m8SfnpyDwxLbsz3KIy9h4Zc7BneIGr6d
         MzYXwFETaiX5qOtW76Kb+eOstL97FVdfstLdCnyShaMDSYKMCGox7Ie4l5U/i3CWTnk3
         peznTGBzSBS8Yd5wjGUNbVZFME+RRNJW/T8XGhXxihmaYcKGJVGYve9B6oZK2Pjpign8
         q4lkrN+b1goF2BtXFqAsLu1/mfDmZD/aP5paz9mLZwFu2cI+ViyBOFyiqE69WWkzrgsz
         Vy1/vFzUKvub5lWzBK1QA+RIIelnezQcFPkhnmi4upXrJ3Ye184imoegw0ZirWWPG4Nd
         UIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lE9xbb5dwzWCQdgf927oihC6gUb8e0SadHAzyr+CWyM=;
        b=IHUICFsss1q0+Cuax6yqwT0SMdEZpBZfLijKTmJhreTDwVuZoURQjOlhF0fCjKn5Bb
         alR6AI73+XAsWu3C915Xlo89sSfnoRlvYs2+VE01Syia2shsyiFQ98tIakvhq6pIjCp2
         KK01TMVn4hu1YLmHIYEbKJ1RFVz79pceL6jRoJVXfW1KTGO6QwvjhD8TBNDAY0f+WWv4
         dImyGKfo9e6ymSl2bKpBoDJiSzl7c0qLKQTVXaz6asj48iWJZX1hy+OzeJHSHDKhai7r
         EOSREQuloJR2JRcqo/yePZNWRD2lnhnB9T4H/2ge2liwVo8SKZmeaddlEL87iuD2wPtl
         Da/A==
X-Gm-Message-State: ANoB5pnGpO/SXId3Wfe2NTM+6+X8ZZDSthIY/9vNKRzIfj531McyNasl
        mmBtWLTGLMXhPpP40d1ntEe/leXe/0ab8g==
X-Google-Smtp-Source: AA0mqf5d1EGPnCciCcpIn2GCbPlmSryt3vs1PF8wgFvNGikJbTstGnkrG8n1FWYpNtknmKHa+ziT1Q==
X-Received: by 2002:a17:90b:4b42:b0:20a:e38c:8c5f with SMTP id mi2-20020a17090b4b4200b0020ae38c8c5fmr63345831pjb.217.1669685329787;
        Mon, 28 Nov 2022 17:28:49 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p16-20020a634f50000000b0046fefb18a09sm7209179pgl.91.2022.11.28.17.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:28:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: push.default and "git push"
References: <CAMhVC3ZHsGJs8XJPZOPYCWBCHJOkp8xnau=5xH_Bj33JUZ4DNA@mail.gmail.com>
Date:   Tue, 29 Nov 2022 10:28:48 +0900
In-Reply-To: <CAMhVC3ZHsGJs8XJPZOPYCWBCHJOkp8xnau=5xH_Bj33JUZ4DNA@mail.gmail.com>
        (Yuri Kanivetsky's message of "Mon, 28 Nov 2022 23:32:04 +0200")
Message-ID: <xmqqo7sq4khb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri Kanivetsky <yuri.kanivetsky@gmail.com> writes:

> (1) What does "remember" exactly mean?

Because your matching push updates only the branches that exist at
the receiving repository, you do not have to remember in your head
which branches you want to keep updating over there and write them
on your command line (i.e. "git push there this-branch" to update
"this-branch" in "there" repository).

You do not have to ask your configuration file to remember
(i.e. [remote "there"] push = refs/heads/this-branch), either.

Without having to make an active effort to "remember" on your side,
"git push there" would notice that they have this-branch (because
you pushed there the last time to create it) and you have updated
this-branch on your end, and update that branch.

That is what the verb "remember" refers to in that sentence.
