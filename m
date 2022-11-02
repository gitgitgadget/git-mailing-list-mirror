Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E0C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 10:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKBKzH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 2 Nov 2022 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKBKzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 06:55:06 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9D23BC9
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 03:55:05 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n191so14663658iod.13
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 03:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9jhUcnwHIhRUegMFSxJMT3dMv1MrC9e/NjwxXu+9+g=;
        b=d4H3I/Cd/6vLqLUf92CbgsOaRJDK5Hp5Gy8cz53mJ+A7LV6c0JkoQS2Rrgj/qcDSIz
         fZE+ym0ewD3noDIIkFSDC1j/rNVJCIAdA9pAPCKfaXrdTaSmawzXddv0J/lV7ixmMuOt
         4AlK+67wj7UDaW7Vfp3nblr7bb0dX0WG9HZ9+CjGRyN3+6Vw9sxityq2mr4NquYbro3K
         AKC4IxkyCFW5uSQq/HO0+mu1eABZ6klQVaIFRbusKFGuieVOwUa7GwYMSMZjfXRS8xso
         aYbGyT2hU9+BjsbDWoEwjoeUYoZagmoGTNADnmqvw1MmQeHyTqhN0eFWyyZLTcPy1hJE
         xb2A==
X-Gm-Message-State: ACrzQf2hBmZU+FhMxQsINbfrQBcdjyDjOIGhgmGST0ZswIEuoxhNwd9n
        AaHAWyOjo8MQpkMHMcoh4bmVbXEhOsoqyxb5kMQ=
X-Google-Smtp-Source: AMsMyM6YCKrWsRKQeY1BfzhBTRbNox6cKyRp34NV+OHkKYRowTa1zbyJ4fkUB8ubPAiZaFgHl/d/p4oOJMzJRpwJa/E=
X-Received: by 2002:a05:6638:244:b0:375:6804:5fae with SMTP id
 w4-20020a056638024400b0037568045faemr8861214jaq.221.1667386504506; Wed, 02
 Nov 2022 03:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com> <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
In-Reply-To: <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Nov 2022 06:54:53 -0400
Message-ID: <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
Subject: Re: [PATCH v2] Mention that password could be a personal access token.
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 6:36 AM M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> These days, the 'password' for a software forge might be personal access
> token or OAuth access token. These are popular, so worth clarifying that
> Git treats them just the same.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> @@ -21,6 +21,9 @@ in order to access a remote repository over HTTP. This manual describes
>  the mechanisms Git uses to request these credentials, as well as some
>  features to avoid inputting these credentials repeatedly.
>
> +Some repositories accept multiple passwords, including personal access
> +tokens and OAuth access tokens. Git handles all of these the same.

I easily understood Ævar's point about these types of secrets all
being different names for a password, but I find the above change
rather confusing when it mentions "multiple passwords". That makes me
think I may need to somehow configure multiple passwords for a site
(even though I know that's not what you meant).

How about a different approach, calling it a "secret" first, and then
defining "secret" as different names for "password". Perhaps something
like this:

    Git will sometimes need credentials from the user in order to
    perform operations; for example, it may need to ask for a username
    and secret in order to access a remote repository over HTTP.  The
    secret may be a password, passcode, personal access token, OAuth
    access token, etc.  This manual describes the mechanisms Git uses
    to request these credentials, as well as some features to avoid
    inputting these credentials repeatedly.
