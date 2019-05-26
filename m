Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE671F462
	for <e@80x24.org>; Sun, 26 May 2019 20:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfEZUth (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 May 2019 16:49:37 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34059 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEZUth (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 May 2019 16:49:37 -0400
Received: by mail-lf1-f51.google.com with SMTP id v18so10602847lfi.1
        for <git@vger.kernel.org>; Sun, 26 May 2019 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJg/yCjfVM3Ozhpb5ZCNN4WebegqjDbfI7FMAeP5e48=;
        b=GD3ZVbCtAZQtaJFSDPqrCMmGJBcOkN8aadPzlAK4DlrCkWV1mtFgYPxuS4XgVoIFNB
         07DttpIS7YSA6RHknmleBz7ZadImeyD5hn2YsmsOhxL1gJeJcYNAfteCCxReSzZW5Sy7
         HXffCAFYiq7pFrgWGoGWbWSP6Y+fjHTJprbE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJg/yCjfVM3Ozhpb5ZCNN4WebegqjDbfI7FMAeP5e48=;
        b=nsl+hi1X+CpWThDJljumJbL0duFn5TrPvNbl4CXvzhevP5V4Ek4HvbDyTnaoxkxQk2
         WABsCUllKic+7qoC0NPZ+ch3K4i+CY3Btc+X4nTVsiwBPovTfFG3a/QE2TRxPm20pAPn
         uknK19O+oTU1FJfif/RBIcNdKUwmIQY6KRboShBiQPqQCRS5fd5tTyAFAix5O7Ll6mv8
         OiMyepio7ePrEU6X5yHRfxQtvhNGqyZfkTpkVOCpb1iExtYGLbzGnzhe6rWQcQnliR75
         HERTNvXR7ATLwqoHMHneDFkgt/N7xyWDJPg5cd7s3S6Qrus8Fq3sZb93O/0XrCino21E
         tf4A==
X-Gm-Message-State: APjAAAWpvSXxH9LGFy/sUcort5uKuX8C9VdPmdUgXG//oWPy0PKzcuJj
        KWs05N5lt16hCZuEWRZ1+mSAOYkcGqE=
X-Google-Smtp-Source: APXvYqy3k2/nySSrPzGa9H28yN+yF6X5uuDGVpnh0W1oXydLT9fIHBWj9lR6wB2h9G3h55GK8Uh9vg==
X-Received: by 2002:a19:7716:: with SMTP id s22mr843027lfc.64.1558903774285;
        Sun, 26 May 2019 13:49:34 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j69sm2185084ljb.72.2019.05.26.13.49.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 13:49:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id n22so2858355lfe.12
        for <git@vger.kernel.org>; Sun, 26 May 2019 13:49:33 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr10136807lfb.134.1558903772902;
 Sun, 26 May 2019 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wi3YcO4JTpkeENETz3fqf3DeKc7-tvXwqPmVcq-pgKg5g@mail.gmail.com> <2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com>
In-Reply-To: <2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 13:49:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
Message-ID: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.2-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Junio Hamano C <gitster@pobox.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 26, 2019 at 10:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The interesting thing is that not only git will treat lightweight tags
> like, well, tags:

Yeah, that's very much by design - lightweight tags are very
comvenient for local temporary stuff where you don't want signing etc
(think automated test infrastructure, or just local reminders).

> In addition, because I _locally_ had a tag object that
> pointed to the same commit and had the same name, git-request-pull
> included my local tag's message in its output!  I wonder if this could
> be considered a bug.

Yeah, I think git request-pull should at least *warn* about the tag
not being the same object locally as in the remote you're asking me to
pull.

Are you sure you didn't get a warning, and just missed it? But adding
Junio and the Git list just as a possible heads-up for this in case
git request-pull really only compares the object the tag points to,
rather than the SHA1 of the tag itself.

             Linus
