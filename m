Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65774C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778661BB6
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhKQTSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbhKQTSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:42 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C0C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:15:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso1458185pjj.9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QHOLgQ5nw2A73NLTm1Zc3YVEyDGNOyQkZlLoKx0jExo=;
        b=bfSc2qa+gshECAp4UfOh9tgaeINl+xkT+Y3TRoRITUFalHPHf80qWpC3Wj/r7JhdHr
         5VL3vJxrQgBuBrdo+juSJPKOlybZMeEcMrN8Qeb6Ie9r/Z99eBpYLlwVp8RgZPr6qUD9
         V5Bh+zSFP3v37vQRyyIXdY2bRyTW6Lt4QeIvnIG4rP9DMr+kvLwsHQc/0zvzXtyclxwY
         36rHJgQ3zLOwOLewXH6OqpueSAsdS11/MTrLLk3Sbk8asN9ipm9yQ7QEL+Bafve9UNrL
         nAgnEEOAnBfcNM3FfcmuSmclaKYPVFSDPAsTP8xf9u/7zxewPpBNYvspQ6tT+z5wsc53
         NyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QHOLgQ5nw2A73NLTm1Zc3YVEyDGNOyQkZlLoKx0jExo=;
        b=g620iKXuDpQh3qVymUKfqd4gCU9oOncXLRbw/DIgRm55WU3CGDiq3gel6gdB+diqYZ
         WRusHMR6wVa4Ud53STL1L+qjtKfYfPP6Q3ShVabPNNO7nBCocl9nwJDUtmuYz79NLEdS
         AZukW4yNWl/nJnqDEYWYuXuctbW27k6KLsqEl4EEqG4FH7rh/DbLBry/UOnUwaQOMGD6
         pYo0+S7i1WHVtWsovSl3ypekd3kess+xxxgO+AG2D4QyiCuITaCO3gmzAW8OkbVbb+hh
         eaYLIJzyApLz0bPE1pc3Y9blbcQr7B/kU1Ytlc3uwcAnr2bpZOUe1qQg/Hutu0lzF85S
         IrEQ==
X-Gm-Message-State: AOAM531clI/PSyGMpy1A/q/8CRKT8eevOXcO/u6IgsGDYt1sK1BUAgra
        p1IJb4gLasiooUkdRh480jYnD5z3P1PoT1h5OyAMUBpXlgKHqBTXe6o1y39XSBNE62JRskMoEtI
        vAkHBN/N6FadK1Pw30D46FvBB1QpS9dWznkK+rOPgIqUYUH0KuKE5/GOk5YtZU44=
X-Google-Smtp-Source: ABdhPJx1KFJQpWmTDAUV6E64oWyWqFnfFwROXbTFGys7cz/joAHcMWrKIFOY+uzNWttRvmsLhX3bQc3UBSXOMQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1242:b0:44c:2025:29e3 with SMTP
 id u2-20020a056a00124200b0044c202529e3mr9435633pfi.59.1637176542827; Wed, 17
 Nov 2021 11:15:42 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:15:41 -0800
In-Reply-To: <kl6lzgq2ha9k.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lwnl6h9uq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgq2ha9k.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: git-gui bugs due to dependency on system Wish on MacOS
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like the previous message's formatting got messed up somehow...
the correct formatting is below:

Hi! We've received reports that git-gui is showing black windows upon
upgrading to MacOS Monterey. It seems to be the same issue as [1], but
somehow it's only appeared for our users on Monterey and not Mojave.

I dug a little deeper and I was able to fix the theming issues by using
a different version of wish:

  $ brew install tcl-tk
  $ PATH=/usr/local/opt/tcl-tk/bin:$PATH # This contains wish
  $ cd /path/to/git/git-gui/
  $ ./git-gui.sh

Note that I had to call git-gui.sh because that's the only entrypoint
that doesn't use the system Wish referenced in the Makefile:

  TKFRAMEWORK = /Library/Frameworks/Tk.framework/Resources/Wish.app

That said, Homebrew seems to have worked around this problem altogether
by including their own Tcl/Tk dependency.

* Github Issue https://github.com/Homebrew/homebrew-core/issues/39987
* git-gui formula https://formulae.brew.sh/formula/git-gui

Is this a fix that we should make in the git-gui project?

[1] https://github.com/prati0100/git-gui/issues/48
