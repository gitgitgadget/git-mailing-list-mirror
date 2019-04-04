Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BCC720248
	for <e@80x24.org>; Thu,  4 Apr 2019 08:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDDIao convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 4 Apr 2019 04:30:44 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33717 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfDDIao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 04:30:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id q1so2607728wrp.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6i8CDbL5FOOkSvllJj/bholv0YNMdmrKYl/owkapVw=;
        b=nC4M5n+IlVZNJ1dA13AW/Msq+w3yvI51VpQsIHh3TC1EMvpoHEBjFKyMMKQkSR7wlf
         T9xGyBnot1UEAvPUMrsmxMhidA/FZd0sCrkjyrGeGV2CQ1CQsaaYS1kPcpBcCEjGZkwx
         Z58JJ1LVLQLHlEbGI6It+SkQJZaUHcnaZ4h0YmmYAYi4Wo5xI/ITaxnchBXBQkztT5Ha
         ORyCh5bSsxKqIF0/N3Ek0A7ATAj4yskNAHLQdsVPe8lzRELWYrDgx9t7ULHw9a5kDkwl
         XRi4164HHdKQFQzuxHw0XbL2RXj36HaKF3xiLz3W7+Un9fBOHsPOF3dXVhDA94ZcNL9Y
         r6Mg==
X-Gm-Message-State: APjAAAW1O/l5X6q4LXdQG4vsBMFDbP+XEBsg5bG6k1+Cfki26CWAHISx
        6C0c4Mump1TVbNxfxscukj/SHLyEB8R9Egtygn8=
X-Google-Smtp-Source: APXvYqwyj/wweHq9mNG7amgwCxRSI8nHO2zoJTUFITlpS/DyFNgjiaOznJ4KoOCv+MRCx1XcyyG2Lv8mrDXBfpV1Tgs=
X-Received: by 2002:adf:d848:: with SMTP id k8mr3056228wrl.185.1554366642271;
 Thu, 04 Apr 2019 01:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2YSPzAiJW1tH7xm9bqh00VYZrpFS4RQLZ4HK7aWoPm2RxD0g@mail.gmail.com>
In-Reply-To: <CAG2YSPzAiJW1tH7xm9bqh00VYZrpFS4RQLZ4HK7aWoPm2RxD0g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Apr 2019 04:30:31 -0400
Message-ID: <CAPig+cSqH44wWRiESm=UA1k9V6S_jmF-hyQp34XaUJuZWQ1aYg@mail.gmail.com>
Subject: Re: fatal: ... is already checked out at ...
To:     Mark Kharitonov <mark.kharitonov@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 3, 2019 at 6:15 PM Mark Kharitonov
<mark.kharitonov@gmail.com> wrote:
> C:\Dayforce\56 [release/r-856 ≡]> git --version
> git version 2.18.0.windows.1
> C:\Dayforce\56 [release/r-856 ≡]> git worktree list
> [...]
> C:/Dayforce/56     f9c36d3a2b [release/r-856]
> C:/Dayforce/56     f9c36d3a2b [release/r-856]
>
> Item #1 - how come I have two instances of release/r-856 in the git
> worktree list output?
>
> C:\Dayforce\56 [release/r-856 ≡]> git co onboarding/r-856/james-config
> Switched to branch 'onboarding/r-856/james-config'
> Your branch is up to date with 'origin/onboarding/r-856/james-config'.
> C:\Dayforce\56 [onboarding/r-856/james-config ≡]> git co release/r-856
> fatal: 'release/r-856' is already checked out at 'C:/Dayforce/56'
>
> Item #2 - why cannot I checkout release/r-856, if I am already in the
> right working tree? I suppose it is connected to item #1

You probably hit the bug reported in [1], which was fixed by [2] which
made it into Git 2.20.0. Specifically, prior to 2.20.0, you could get
invalid duplicate worktree entries like this:

    $ git worktree add foo bar
    $ rm -rf foo
    $ git worktree add foo bar
    $ git worktree list
    ...
    foo  deadbeef [bar]
    foo  deadbeef [bar]

If you don't have any changes in C:/Dayforce/56, an easy way to
recover from the situation is to blast the directory, prune the
worktree list, and re-create:

    $ rm -rf C:/Dayforce/56
    $ git worktree prune -v
    $ git worktree list # just to verify that duplicate entries are gone
    $ git worktree add C:/Dayforce/56 release/r-856

[1]: https://public-inbox.org/git/20180821193556.GA859@sigill.intra.peff.net/
[2]: https://public-inbox.org/git/20180828212026.21989-6-sunshine@sunshineco.com/
