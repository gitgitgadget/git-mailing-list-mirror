Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8347C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjBBQGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBBQGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:06:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB755DD
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:06:47 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h9so2271477plf.9
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/USFvwUM2pw9re17AOx8ztv7Mi5dXR/xACCI3DmLrmc=;
        b=qvCueb+J59bW5fnpUrYp/Omd7DURLRsvL4yM3nmgeGc3XB3FK9m14lMLVHPT/A2Ex8
         2mdkL/a2JeOIKChzBCeBKBFvD47XW53Dv9VzKsIoIh548JB3wo/QsmzUPVcwG3K+O9Gl
         AaGvjqgvyH0ul38BuVk0G15vvkWwKMLYh47zEyt6HIHZ8hO01WfE5iLDluPk6n3UuPfb
         8sHDCyNrP+IYc4TL8WpXghz4DikOYmgrfH+53mNOe/ftxP4c+++BBUFcQuQT31HN0iwU
         sguWlcCdwNL2gqY9VH5FTydtHI0o3B2qDD0mLWhM1eIn6jt4Ox7CE8oxsnZZAxYRCcOP
         qcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/USFvwUM2pw9re17AOx8ztv7Mi5dXR/xACCI3DmLrmc=;
        b=NmQuuXyVE63Fhti2J+731iW3jbE5NBX6WEbeZ2qUV+m5pntHRU4z1/bjlI+/+oI+gX
         zGicF6uAsngZqYFX80c540N7KYxJ96oBxuE1ViZxpJOeDPZIGE/ctE+A4cjOhzXcNIvu
         37DR4BBf9GHQpGDnZzo7hv/1H8OhUxECqmN/dLTl0QwLw4WJ0AhIJRuRgqtf/yEmTurH
         kXbwbhs5CR+IhP4IrtfdPothNAJv224b+Y0ltEBd4zx2ykPpQpT/LM3RB8Vj8H3j5Dk+
         UqBiBV2GB1/NlAKJO1tyn1Pp3CV1BubVTTIaFBAw5Jlz437UY/2KMNZdrBD0Yt4HTh/q
         iuKQ==
X-Gm-Message-State: AO0yUKUgxtW7LQiZrcKvqrkn43tm5bRIxrdVH/+fmC7E52NDpGo1Kw0u
        +DcR+TYNIWw7Eor8MA2ztnw=
X-Google-Smtp-Source: AK7set/l4cMuAvBIk/u7IzujwdNdNE4nrckdB+U9jwuxqujeUjtrTCOOF8YW6PzFSF+ceTemkYs1lw==
X-Received: by 2002:a17:90b:1a90:b0:22c:8ba3:f59b with SMTP id ng16-20020a17090b1a9000b0022c8ba3f59bmr6978453pjb.20.1675354007161;
        Thu, 02 Feb 2023 08:06:47 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090acc0a00b00219186abd7csm56329pju.16.2023.02.02.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:06:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Harshil Jani via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH v2 0/2] Remove MSys Support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
        <a4ce7778-c108-99ff-f97e-2ebb8cb605aa@gmx.de>
Date:   Thu, 02 Feb 2023 08:06:46 -0800
In-Reply-To: <a4ce7778-c108-99ff-f97e-2ebb8cb605aa@gmx.de> (Johannes
        Schindelin's message of "Thu, 2 Feb 2023 14:59:39 +0100 (CET)")
Message-ID: <xmqqlelgvyp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'm fine with these patches, too. Here's my ACK.

Thanks, will re-queue with your ack.
