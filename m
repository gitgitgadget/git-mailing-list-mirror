Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62742C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjDDPiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjDDPiM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:38:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A809C4C16
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:37:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so34339340pjl.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680622643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xicS1mBfFrUDIGYrO3/9nfuwwopooO9BX/F2/6FyEKY=;
        b=N6cXwmB2qEKL/TI5VcA0QH3BSqr9YkLieA4eTlqJd4xGkOIhnEt9uDReObrC05RSze
         xJy1DKNI0/8BMPieFC4PDPlmDKHGTDjCUi+QYWO8FJxVJSkewxJggydT5c5mm9X1FThj
         KnLbCdYsbpuLSdaGbGpSrPF6I6LbRubJrkff51mO6kcTM5f/z9xWjFxJzZ1K0O3JOcMY
         //O5rEuz4WplU82PjJ5qhhV+i0p8q0Il4dJ01/Ajf4Hi6E6VtdSNh0Mxu4QQ+1fmh4nC
         4lXH5MfWVSPjDWeceFOiBjLU0aeMFku2+jgXwy8r8j+SnILfzTNYX69ln/hG5t3jFBlo
         VjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xicS1mBfFrUDIGYrO3/9nfuwwopooO9BX/F2/6FyEKY=;
        b=CS53OaiBcpDJ/aHMUAeh/yfnM6IuZL+Wr9ALFcLniJ6MLkXhG5lv2lVVyixHui8d/2
         uasGX8zf1BxeOOXxIR2HuPaI7cC+gb/KeWvvHgQB7d3fvKeUKW8izGdZ5Uuh9Lj+uRC5
         lIwvtoHOJzI/Nz7YhOn1eGC0Z87yNX+Hnnkc0YK0kS7kUo8Rjqv8Y8X8CJuS9yHQ0FJa
         AN+SRy1hkA2ENhF7xutJBSiHrPRe0W0RtK8UbA+XCX1QyJqY6NmlNUFbva54TSvwJh0K
         Km0qfq+fKW6L55D5mTupTaz3ISylDo6qWX630UVWWE4Sl17LzYzDfLGLBhAZfqFR3nl2
         HAtA==
X-Gm-Message-State: AAQBX9fyajOkWNUg0R+NIdkpoAXQYWSgBwLnsc6j7plAJC4Uv60hTv3V
        0qMnCnDG3iFZr4PMZcD4H/FGgR78urw=
X-Google-Smtp-Source: AKy350Y24nCJu24AR3edRZow9KV8FGUPBCee6o4Cxj0f89uRFGLJGLbXdhISfN+6sulb4A92Yu2r3A==
X-Received: by 2002:a17:903:905:b0:19e:bc8e:6421 with SMTP id ll5-20020a170903090500b0019ebc8e6421mr2603372plb.47.1680622643424;
        Tue, 04 Apr 2023 08:37:23 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0019a91895cdfsm8525941plk.50.2023.04.04.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:37:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thorsten Otto <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
References: <3473764.PTxrJRyG3s@earendil>
Date:   Tue, 04 Apr 2023 08:37:22 -0700
In-Reply-To: <3473764.PTxrJRyG3s@earendil> (Thorsten Otto's message of "Tue,
        04 Apr 2023 11:58:38 +0200")
Message-ID: <xmqqo7o33bgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thorsten Otto <admin@tho-otto.de> writes:

> "git diff" does not show a diff for newly added, binary files

The command is working as designed, either for newly added ones,
modified ones, or deleted ones.  In your sample output, we can see
"Binary files differ", which is the default "diff" for binary
contents.  It is in line with the way "diff" by other people work.

> What happened instead? (Actual behavior)
>
> The "git diff" command only showed a diff for the text file c, 
> but not for the binary file b:
>
> diff --git a/b b/b
> new file mode 100644
> index 0000000..a64a5a9
> Binary files /dev/null and b/b differ
> diff --git a/c b/c
> new file mode 100644
> index 0000000..ce01362
> --- /dev/null
> +++ b/c
> @@ -0,0 +1 @@
> +hello

As the primary purpose of "git format-patch" is to convey the
content change between pair of states (i.e. change to bring the
state at a particular commit to another state at a commit that is
its child), it implicitly enables the "binary patch" option, but for
"git diff" which is meant to be an interactive browser of changes
for human consumption, the "binary patch" option is off by default.

You can run "git diff --binary".
