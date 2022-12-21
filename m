Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7CEC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiLULQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiLULQR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 06:16:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0E62EF
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:16:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m4so15202004pls.4
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=n+pLzVkJfRZtdw6RW/vYI1U+uXbCQ1/NrRfZeGJSypo=;
        b=AU7U85j7jqERwAG9zp+D8UZxWnLItI1qRbZw7g7rhIvOFAMjSZb9/VsyNYrmsdgEyb
         Cr4uzeX0gJOeoGpAv4iLZmxtB4rldQ+gF3maus4MVzLJ9BVY2Zi8pBkRbaxtJhuCanjn
         9VX7YpOsY0t1IJ8OwQ7JTxFO5PiBDmIDVbJYa8Ae3matTcTAPwStCWyfT1upQmthToRZ
         8SamLb6JEMfbxbqGkvy7CtjrcqJylRTR1cwTOsI4G969ctoTHLdPB+v9LzJANkczS9rh
         iZhSbtyCIveCUCO6jotWz3IZEyj8fcqLxAXMszY0rxiQ846N4FJzFtGVTHCI4rOwJdUv
         /JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+pLzVkJfRZtdw6RW/vYI1U+uXbCQ1/NrRfZeGJSypo=;
        b=yHqHJxhAzzidIsV7d3YbK4cGWRBT6NIsqmDuXpAR9o23qp2cSYwghJtxNpF37epzWX
         tnzgsFSlOedYeja+vK/0mjdN+SWV1cQoUIv17WOz/O8BpoIwS2rpItyViD1Pg60uCHD7
         XJCQKkWGCO2KgVJGYwktSz99QNSl0QNWzSckOlrhdelITj4sXMqtqNxEyijVWLWPefqC
         l765f6FgfgUrXV+t+HoI6LeNJfrhjjraidqzrKf577Kl8EEMSzWSjn+kkG8XLkeVn6A/
         xNBgx1gKdASGAQZSG/MIRvZixAL1qKFv2Y3Deu35eUv+5PQwIOQyAvVNNAXqrWH4q4v9
         3KUw==
X-Gm-Message-State: AFqh2kp8CSuB6l3JNNxIPdQUfIxUL6Qgrdl5jQyXbZ7q3ejHg3S9YmkC
        DwGoHp435gwG+ujv7tGxbPq7V65LQSKN7A==
X-Google-Smtp-Source: AMrXdXttxVib2FC4/rAzDT5WESxRwKcUgnHG/TSnU0FEj1oXdDYjzM0ReVuxmoVWzFWwy6geqsfbOQ==
X-Received: by 2002:a05:6a20:3d85:b0:a3:587b:56ac with SMTP id s5-20020a056a203d8500b000a3587b56acmr2668491pzi.52.1671621360339;
        Wed, 21 Dec 2022 03:16:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0056d98e359a5sm10270361pfp.165.2022.12.21.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 03:15:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Documentation: clarify that cache forgets credentials
 if the system restarts
References: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 20:15:59 +0900
Message-ID: <xmqqo7rxror4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Make it obvious to readers unfamiliar with Unix sockets.

Is familiarity with sockets required?

Isn't the death of the daemon process that causes the credential
data cached in-core of the process?

>  This command caches credentials in memory for use by future Git
>  programs. The stored credentials never touch the disk, and are forgotten
> -after a configurable timeout.  The cache is accessible over a Unix
> +after a configurable timeout.  Credentials are forgotten sooner if you
> +log out or the system restarts.  The cache is accessible over a Unix

If we mention "if you log out" here, the readers would also want to
learn about credentialCache.ignoreSIGHUP configuration, no?

This is not a new issue, but I am not sure if "never touch the disk"
is a honest thing to say (I know there is no "write this in a file"
done by the cache daemon, but the running daemon can be swapped out
and I do not think we do anything to prevent the in-core structure
credential_cache_entry from getting written to the swap.

Taking all of the above together, perhaps something like this?

    ... caches credentials for use by future Git programs.  The
    stored credentials are kept in memory of the cache-daemon
    process (instead of written to a file) and are forgotten after a
    configuarble timeout.  The cache-daemon dies with the cached
    credentials upon a system shutdown/restart, or when it receives
    SIGHUP (i.e. by logging out, you disconnect from the terminal
    the daemon was started from); the latter can be disabled with
    credentialCache.ignoreSIGHUP configuration.  The cache is
    accessible over a Unix domain socket, ...

