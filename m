Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A3C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLGX6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLGX6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:58:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A613F0D
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:58:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g10so18558423plo.11
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W5u2juIM0OCNUsQ/lXBRMf/cY8Pc32JEgaamRm8HtQc=;
        b=Q7sNk57dANXuQltsiENyCMASs5mrynOP89aRmPXXmOSD7g8KBrCZ2RwiAc5ci4/hvb
         /sfuz9YR0tuX8vjHwwFDxejgdCnWBg+1ayI0mTYWzOQtfJ6JNVcdn0lsBh/UoXQ6RIH0
         zawlpm4xRzmKFmEq8dhXwrMsRqUC0VN4D6ZFg3/GKBx3QkdHgt7gLchwFm5Urzv0TiqM
         B31R2SoRhQuRl+7Cr1SC4AFIthUYfBaoRIRkmQhG82/PKj1I61F667Uhm/uNVP/hSbZU
         WlS/+iPX5v55j1Qfqu1Q27mkp4FBkCIS0rBXUA+e9fbFgLes3jdy4PKzPIX/x1iD+fLQ
         H8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5u2juIM0OCNUsQ/lXBRMf/cY8Pc32JEgaamRm8HtQc=;
        b=G/jyICVCi2ZRiyKdRR4eSwWck6yaAYIHuFMVDhFq9ApNOqyJ39vWbOGT/NsgkcNLTW
         YehmLIEogJYboa+W3APJjECqcBN/N1fUkDnHV6ROzGRYS3PSTrrEJWuvdmxjyYNM/QTc
         w6fz1eeu7wGVTxhcRZ5sWYIUsT1XElK1XFvAx6fkbj2ywoGwbb66L9X3X9QT9v4CGd1A
         9/zidXBSykLLVh4AVxUmQHuH2Tm4mrNu7nQb4Eqf3WANqaFwS11ac1mhpJnK280BepZI
         4dqiTicerdWfrIf8fiThQVg8CrEkHMSooDDsMamQpr5XHhE2nHISBOD7KF6QwVxcV/wN
         HHcA==
X-Gm-Message-State: ANoB5pnQ/DFenA7/JWXEJaZt8cgUd4BHMW6of/RvjGqgwFr5m2kGp80t
        OsFqa3gxG8HaD/fWxKtb+Fm58XKs2Ei/jw==
X-Google-Smtp-Source: AA0mqf7jTxRPyPTQM0+ZHUY1PZDaYOdOs/WWIffQbuiPa3iwyxmuDz8Cvo/e75UtTosUnEfc6V1Ttg==
X-Received: by 2002:a17:902:8204:b0:188:ec14:bf17 with SMTP id x4-20020a170902820400b00188ec14bf17mr1213784pln.11.1670457521651;
        Wed, 07 Dec 2022 15:58:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001869f2120a4sm15113976pli.94.2022.12.07.15.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:58:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Avoid using deprecated features in Git's GitHub
 workflows
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
        <Y5EWUNbR1X+GrrNs@nand.local>
Date:   Thu, 08 Dec 2022 08:58:41 +0900
Message-ID: <xmqqv8mm4vgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Dec 07, 2022 at 02:34:36PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Johannes Schindelin (4):
>>   ci: use a newer `github-script` version
>>   ci: avoid deprecated `set-output` workflow command
>>   ci: avoid using deprecated {up,down}load-artifacts Action
>>   ci(l10n): avoid using the deprecated `set-output` workflow command
>
> These all look reasonable to me, minus the first one which is already
> on 'master' as-is (unless I am missing something, but see my reply to
> that email).

I think we already have set-output ones figured out and queued in
'seen', and the third one alone cleanly applies without any others
(and replaces my botched attempt ;-), so we are in good shape, I
think.

Thanks.
