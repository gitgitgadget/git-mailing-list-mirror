Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD2C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 22:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjETW1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 18:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETW1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 18:27:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB09184
        for <git@vger.kernel.org>; Sat, 20 May 2023 15:27:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so1437168b3a.3
        for <git@vger.kernel.org>; Sat, 20 May 2023 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684621643; x=1687213643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/mcdC9xr/7NFYc2E5Kh9RPbsT5yvP/3edFC+3XIhtQ=;
        b=aPGARSiNWbUoe1EUyXuumpy0wlKLl6Pe2f/iaClbJkKNMqEuC+jBTQ+G5R1lqAULsM
         KL1AVS4aM7DnEFm6Z6FLTa6hGMxIG6D4+3CSB4Nqy+Ye9d0dAUTAF3XCVDyPmr+309GC
         kFIOONaDOpUCzhJkq2vYBEpcF1b3e9Mu90wYbxJsoQKpcdcRaOsVb9vH/ezCFOBsvece
         RFYnK3Go3W3kVzyE4lSemIjlz2qs8InrjilvxzBu18s+2F+gu3EXZU1ehb/lljDezuqr
         Zl8acbT0TEYy7bnmmSOvUK1D/5E/0DgjZFrS3BqCyv3Sh0zT5IiG7l6kLUfBamw8KpQ7
         C7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684621643; x=1687213643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C/mcdC9xr/7NFYc2E5Kh9RPbsT5yvP/3edFC+3XIhtQ=;
        b=hYEooXVS3O8NEglcX13rjb3NtPrknfcwJub5jadV5zVRx2CCNkHCiINM1N8cc+1S0L
         D+3t/jzkSPNSLQmtwOg/j+Yug4/27O+ysb/wHblP88noCCMn6m17RyFYJOmE4u/E0Kx3
         vm79CFbfgR7fQZGi5dxGw5ePIp2lQZwr3owja7K5Ib3IKwYwXv6oL33cQRpc1G5UqacA
         elMCoNPthk6tO3KcjU/eMpB4M0cE7UTH9qxF87LaWJC4L8XkkO7CFFUij1L/Ba3t73zj
         yo/sC3xpRYdRHLYCuu55O9IpXu/tRdcJ26b1czVEffBsnUroyZFztWJ52h8N87eJUAYn
         3/nQ==
X-Gm-Message-State: AC+VfDz2d/S1N+4BdLUuMuQKP/VZWlxe+qsrfQe9Z/Fx5uThtj5saOhy
        qDp+FJK8spTCxGlf7dDNnrY=
X-Google-Smtp-Source: ACHHUZ5spzZATn4+3tLJEXV/PWbdMsmCFQykKc6XqGt5hlUSmsYIEonjkTL3aYebLu+klIu0juWAEw==
X-Received: by 2002:a05:6a00:15c7:b0:626:2ce1:263c with SMTP id o7-20020a056a0015c700b006262ce1263cmr8770050pfu.5.1684621642847;
        Sat, 20 May 2023 15:27:22 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b0064d32771fa8sm100904pfn.134.2023.05.20.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 15:27:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Minnie Shi <minnie.shi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: I think there is error in merge documents - current branch
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
Date:   Sun, 21 May 2023 07:27:21 +0900
In-Reply-To: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
        (Minnie Shi's message of "Sat, 20 May 2023 10:01:55 +0200")
Message-ID: <xmqq353qk59y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minnie Shi <minnie.shi@gmail.com> writes:

> in summary the sentence should be read as
>
> Before the operation, ORIG_HEAD is set to the tip of the current branch (H).
> instead of
> Before the operation, ORIG_HEAD is set to the tip of the current branch (C).

Not C but G (i.e. the tip _before_ the history is updated).

I notice that we overuse "current" there.  One is to refer to the
most recent commit on a branch, the other is to refer to the branch
that is checked out.  For the former, we say "the tip" in the other
sentence, and it probably will make it less ambiguous if used that
phrase.

    Then "`git merge topic`" will replay the changes made on the
    `topic` branch since it diverged from `master` (i.e., `E`) until
    the commit at the tip of the `topic` (`C`) on top of `master`,
    and record the result
    in a new commit along with the names of the two parent commits and
    a log message from the user describing the changes. Before the operation,
    `ORIG_HEAD` is set to the tip of the current branch (`G`).

My reading also hiccupped with "replay"; the first sentence to
explain the command says "incorporate the changes", and that may be
a less confusing expression; "replay" somehow makes me imagine that
the changes are cherry-picked one by one---it may be only me, so I
left it as-is in the suggestion above.

Thanks.

