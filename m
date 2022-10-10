Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E727EC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJJSRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJJSRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:17:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A945F6D56D
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:17:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s7so3200946qkj.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YlkMQ67yx/5bUx8A+aC7KpsH1boG2isDTy8I+XHTpU=;
        b=VI1XQv7NMyeTe6HsAoVjDu0YxkrI4ggGpPXwcLSNw+Yhwp7I//WUdF6+7bcDlQ6QL+
         22mRf+3zmggXjL3Z01oHk5/FU7BThP9iVxoUjs8bmXgAKyiQfERIQYr/+L/ppEEVN2Yu
         r3IwViVBmSFxCFEHtxsab6+APFRB4MorYJKgCdeP5p+wvHZ8oK+nZpV8vUTvIEy4eGjh
         STkOR4GuMz+FxHe6ih5M5wfDx3FiBPJMz+tWr1UJ8Hr4/O6ez6J/TfGq8hsVZm42CbR0
         FgWn5oJ/ULT0CE7l6gcnymuDfSXKLcbCCzTevvxk0FDa8UR33TbEu6T3tEvdq9y+7yFo
         rnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YlkMQ67yx/5bUx8A+aC7KpsH1boG2isDTy8I+XHTpU=;
        b=X5G0yWZDdxcNCmL+NmCM5XpeLvnckY5F0YBPG4H+uNCSNyy6ClPAQ6YTKSl9Diq6LV
         WJfz3IUFttdt8aQVz9y8RTMNzSoANaR8Dgjf4Ou5pfqhgMsb/8g/dZ2IDsjtorD/7HrD
         bPuv9IFYnRWYP7ya8lJVrHtimfU4TtLxNyXNEprP7h2quosBHaoVWtHz71JcxO5yhRNY
         fj+RwvNAo4vZV5mStYNMzQ/FXB2s2aVhBrbhH6cocibQbYuMD5bOdJkOPx0CrPZrB3jg
         GYEC6Vaz0YNPQ3KXK1Zgpv4kMqc+noNgKVHWWJoWxnL3lLWgxApkccMM3EaEmd/KKvWX
         1MRQ==
X-Gm-Message-State: ACrzQf27uRDC7r9vO8y9bWO4ZUoHRJgNNGjIKOP+SxRFRgYmQj7WyZ7N
        fWxBju7pEAYu41QHRx4ZrtJWhh6YyOnHimKbibU=
X-Google-Smtp-Source: AMsMyM6Ama/RjPY75h3uFTH2x0ydhPNNvNtBkPqolWJsQHa7W2E/MXmeHpOh9DZqeaHrDlrYcjDxShAk/B13bPPZ3Z4=
X-Received: by 2002:a05:620a:4388:b0:6ce:4068:754 with SMTP id
 a8-20020a05620a438800b006ce40680754mr13321127qkp.369.1665425859746; Mon, 10
 Oct 2022 11:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
In-Reply-To: <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Mon, 10 Oct 2022 21:17:28 +0300
Message-ID: <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Luna Jernberg <droidbittin@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thank you all for your suggestions, let me see what is easy for me

On Mon, Oct 10, 2022 at 7:58 PM Luna Jernberg <droidbittin@gmail.com> wrote:
>
> Maybe WSL can be used?: https://learn.microsoft.com/en-us/windows/wsl/install
>
> On Mon, Oct 10, 2022 at 6:55 PM Derrick Stolee <derrickstolee@github.com> wrote:
> >
> > On 10/10/2022 12:22 PM, Christian Couder wrote:
> > > On Mon, Oct 10, 2022 at 2:19 PM NSENGIYUMVA WILBERFORCE
> > > <nsengiyumvawilberforce@gmail.com> wrote:
> > >>
> > >> I see most of the articles are UNIX based, does it mean that I should
> > >> have a UNIX based operating system in order to contribute?
> > >> Currently, I have windows installed 11 on my PC
> > >
> > > You can install a Linux virtual machine on your PC and develop in this
> > > virtual machine, or you can install the Git for Windows SDK from:
> > >
> > > https://gitforwindows.org/#contribute
> > >
> > > It might be best to install both development environments. I will not
> > > be able to help you much with development environment issues if you
> > > develop on Windows, but if it works for you, that could be Ok,
> > > especially if you use GitGitGadget too.
> >
> > The git-for-windows/git fork has some information that is helpful
> > for developing Git on a Windows machine [1]. This also includes
> > details about recommending a Linux VM with Windows' Hyper-V system
> > because compiling and testing Git is so much faster on Linux.
> >
> > [1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md
> >
> > Good luck!
> > -Stolee
