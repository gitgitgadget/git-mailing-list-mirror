Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7DC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiKVADJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVADG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:03:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059E7208B
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:03:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g62so12790387pfb.10
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTKx0mL6IA0LpBqp8EMFv12RrObJQyB+ufPwMUkWdW8=;
        b=PXfx7K/iPKI7QXM4PvroCRT65ajglSmpiKxB85p81pW+vdLVaELbFXlIXyHNxOxZl+
         rwPAy108ZcFSAea3qg4KGHnu40ZE3CfybMrgR9O/rkOx+p/R9xGibB/SIFT616EaVyxg
         jELzdGfvJPnz2RhD79cGRI0D1Fj7sE0GqEiPgxdCpGZ17NuIcaVuAhdM5XdPRzrBxTfO
         TgHXghxo0ka+xkam5VGlrDml5z1OP2B52f1UXczRRB+BPtu6ua1PTRlUnR7hOIO7jVQt
         baW1iimnXw5NA/C9o4P7ggLus3fe70hrawIvl9P7kpIIGSqaQJG5tOHPbiLtnrIzrD2W
         xtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTKx0mL6IA0LpBqp8EMFv12RrObJQyB+ufPwMUkWdW8=;
        b=6Eg7Z4h3G9FDfhOoNr4/Y0S1zXaym67CMVO4kRexiSpn636QEoDzatpdWa37xcdYaR
         Dy4PmjdJfeZjL/p2a15EcIdl7jWXQ0lgVjhhsHeAMWqiWaiDoKxlrqi3HqFaq+00Nr/H
         XG12ZaJju3T0bCWg/4C1qpWrmzyghWsh+86RQNfDCA8ARmCmVK56st6YHl1zS/6PbRH8
         oiy2Nh4hzmnZg8nH76uy/nrEiQ2n4YeS3cm/3+Mlev2pgoyBnAYZYSzG7j+UV4X9IMXB
         jMKZAOUBMGoD2l50FMHkEglouZDooUz4c7F9vUFWIM/2YqQ57DGg3QvhdBivR6LY/6tV
         /nmw==
X-Gm-Message-State: ANoB5pn+ATSf3YDlmpDqvq8lW+v6TRc+vCs/5A8oeG4RcfnOn/6PygFI
        Myym4idBH4BSaXGHBFP1UQs=
X-Google-Smtp-Source: AA0mqf5w4+Vbr0GaR9i1c1oWJUYn+eo9KsjUW43txMeX/6CQKf+q2ula0iN9tGdK2wvkx+B42X+9zA==
X-Received: by 2002:a63:f354:0:b0:476:db6f:e79d with SMTP id t20-20020a63f354000000b00476db6fe79dmr988783pgj.399.1669075384680;
        Mon, 21 Nov 2022 16:03:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b001743ba85d39sm10322690plr.110.2022.11.21.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:03:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 09:03:03 +0900
In-Reply-To: <pull.1429.git.1669037992587.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 21 Nov 2022 13:39:52
        +0000")
Message-ID: <xmqqwn7nua88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is relatively common for users to maintain identical `~/.gitconfig`
> files across all of their setups, using the `includeIf` construct
> liberally to adjust the settings to the respective setup as needed.
>
> In case of Operating System-specific adjustments, Git currently offers
> no support to the users and they typically use a work-around like this:
>
> 	[includeIf "gitdir:/home/"]
> 		path = ~/.gitconfig-linux
> 	[includeIf "gitdir:/Users/"]
> 		path = ~/.gitconfig-mac
> 	[includeIf "gitdir:C:"]
> 		path = ~/.gitconfig-windows
>
> However, this is fragile, as it would not even allow to discern between
> Operating Systems that happen to host their home directories in
> `/home/`, such as Linux and the BSDs.
>
> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
> system name, i.e. the output of `uname -s`.

As I am not confident enough that we made the best choice that would
last forever with the initial attempt when we picked "uname -s" as
the way to switch on "OS", I wouldn't call it "OS".  Perhaps

	[includeIf "uname-s:Linux"] path = ...

would be what I would pick.  Other than that, the feature makes
quite a lot of sense.

