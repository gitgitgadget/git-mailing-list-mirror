Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A6C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJJQ62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJJQ6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:58:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C1748D0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:58:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so10756907pgs.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLbdUfM3GI+AVfPy0LtIHpWZEbobXTWNmN8YZuks1e0=;
        b=qHztPfU+QHkoojh1mS1Nn3yT04Bbsz6LOiddK/FBqMlLnKG3+KUg1a6dW0ECyo6bQN
         PY4xxrLLQVmO25duxlwDGCFaWRuzj6fBP2ooScaI0aErJg5Ef37MCbCAu+vIOkEPSzO0
         wvldCEubra7n9b6R6lrTnxq8tohNF9T9ZGKQWnJMPOLqiAuFQFwjvrt3w6nObdQ1RxzZ
         A6TzN46EeRwIH9l2WJmX48EGhrxJwLvLaMteHj8BsNqPOIpvmRuxSOVhF2L5/F3ae4g5
         0b0mlh6hSQamw49UcFEFC80P7p0r6pyDV2Fiddyjy6pFRXea62Ubxp0MuExPOUPv8LWY
         u4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLbdUfM3GI+AVfPy0LtIHpWZEbobXTWNmN8YZuks1e0=;
        b=D2+hSb+emjqVklNkenGJ/h5+t1mG3nEQYrt9pQiYAvuBAfWi1kuRGX2FNUAy5j772V
         um3b1ihK97eqIHVfkWf7b96J2iyRBIgWSYOqegBINetom23P7mNVBDK3reZ6w0hCUnTu
         5EHVNY0ZyXZY6zveGyZA3pFhcrdyw3zLwBvmUj8ZiK6D0ePeVyAb1K7+OEfQkOTBEvy/
         /eh7+WG8w04wAB+U2V7oq2P+umyvSSIAdPa/N3vM+Tj5x9bvvTPRLyiOI8pEUWtM+Ve7
         6h5MXrqSFaYtooBrB1+UYhGUUAs9YJeB34S2KXggEvrKbANTIfKC3M4xnhMrqfhv9gkB
         3xUQ==
X-Gm-Message-State: ACrzQf1QtcikFGMm+jyxnZg1tpzJMNnapegDmYtq91ea5FQPzHTJ8rfP
        QnoKTFXtWfByK3Fmc1ANmsisngIoHEeUjIXobzU1skC3NBKk/RY6
X-Google-Smtp-Source: AMsMyM7lulMs7um6/dDJ5GCO/WNYkLtWQctqNkN0HROTba6lfc89R4gdOpX0pgAWtI7hNiM3S5dzBZkEfNFqSkbbhkQ=
X-Received: by 2002:a63:fc66:0:b0:44d:75a0:a727 with SMTP id
 r38-20020a63fc66000000b0044d75a0a727mr17185843pgk.589.1665421082184; Mon, 10
 Oct 2022 09:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com> <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
In-Reply-To: <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Mon, 10 Oct 2022 18:57:33 +0200
Message-ID: <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe WSL can be used?: https://learn.microsoft.com/en-us/windows/wsl/install

On Mon, Oct 10, 2022 at 6:55 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 10/10/2022 12:22 PM, Christian Couder wrote:
> > On Mon, Oct 10, 2022 at 2:19 PM NSENGIYUMVA WILBERFORCE
> > <nsengiyumvawilberforce@gmail.com> wrote:
> >>
> >> I see most of the articles are UNIX based, does it mean that I should
> >> have a UNIX based operating system in order to contribute?
> >> Currently, I have windows installed 11 on my PC
> >
> > You can install a Linux virtual machine on your PC and develop in this
> > virtual machine, or you can install the Git for Windows SDK from:
> >
> > https://gitforwindows.org/#contribute
> >
> > It might be best to install both development environments. I will not
> > be able to help you much with development environment issues if you
> > develop on Windows, but if it works for you, that could be Ok,
> > especially if you use GitGitGadget too.
>
> The git-for-windows/git fork has some information that is helpful
> for developing Git on a Windows machine [1]. This also includes
> details about recommending a Linux VM with Windows' Hyper-V system
> because compiling and testing Git is so much faster on Linux.
>
> [1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md
>
> Good luck!
> -Stolee
