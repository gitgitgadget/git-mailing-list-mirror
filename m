Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33ABC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47AC61100
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhIUFAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:00:41 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37784 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhIUFAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:00:41 -0400
Received: by mail-ed1-f41.google.com with SMTP id bx4so25071306edb.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3RNRVFUGjZ3kaLd1idXAlo+pKvkdaEa4vQRaxhncHo=;
        b=ZqOLXSyDsH4KVqRbkcksADizUSVCE6V1LXUC7FEHOQrcGH3OxeRdbQhL1WisrcqBwV
         bumkWMxxxmJYxSCxkwKxYp8cYOGJ/9HMjsWzGMhIUg+oLi5vuLW9mthRaljnLEt61FAP
         npqtPD2A7nM4J6kaxBioCVJ4X3qeqaTJqB6Ixj+BSdV1NO3X1po8RCCcOkI23VnY5nU1
         WujtWXBsrvUPrGSQeM17PIUo2vfqCK5413moPAc807ilz4n8uup0GNvVnxBn626eQhYj
         k9KYuP2gGbv8F0f746KgoSeVqWeo9YQoxsNxNRx8Kw3r3T9kdEjMC2mMI7O3DiqzxdLk
         BtcA==
X-Gm-Message-State: AOAM532lVc02UCLY9GVlhwOtXOBuFzBa7y8S7gGiVRDdoP7pCEPmx59Y
        d4pbZdzoEW5QgzpiFyQ4gW7srCXD2Zrowkro4EzJB2cQY1o=
X-Google-Smtp-Source: ABdhPJysNouVUlPnFuy3yfk3XAZvXKS4S8R1iuDHEyIEGvochWehn/1RjLFrVKFOVv/0Gx43YRTRwkLHQK73ha5DTmw=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr32498223ejd.568.1632200352192;
 Mon, 20 Sep 2021 21:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <20210920223226.25877-1-chooglen@google.com>
In-Reply-To: <20210920223226.25877-1-chooglen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Sep 2021 00:59:01 -0400
Message-ID: <CAPig+cR8ZRGVrNsf6nbBsjuLt768fr=SB+bY_bD+tQpkzrL7FA@mail.gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 10:22 PM Glen Choo <chooglen@google.com> wrote:
> In the "Sending v2" section, readers are directed to create v2 patches
> without using --range-diff. However, it is customary to include a
> range-diff against the v1 patches as a reviewer aid.
>
> Update the "Sending v2" section to suggest a simple workflow that uses
> the --range-diff option. Also include some explanation for -v2 and
> --range-diff to help the reader understand the importance.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> @@ -1029,22 +1029,41 @@ kidding - be patient!)
> +Make your changes with `git rebase -i`. Once you're ready with the next
> +iteration of your patch, the process is fairly similar to before. Generate your
> +patches again, but with some new flags:

I wonder if "Make your changes with `git rebase -i`" is a bit too
terse for newcomers to understand. Perhaps a bit more verbose:

    Refine your patch series by using `git rebase -i` to adjust
    commits based upon reviewer comments. Once the patch series is
    ready for submission, generate your patches again, but with some
    new flags:

>  ----
> +$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
>  ----
>
> +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
> +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
> +helps tell reviewers about the differences between your v1 and v2 patches.

This leaves dangling the question of where the range-diff is placed. Maybe say:

    ... tells `format-patch` to include a range-diff between ... in
    the cover letter.

> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
> +you may notice that your v2 patches, are all named like
> +`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
> +prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
> +be prefaced with "Range-diff against v1".

s/V2/v2/

> +Afer you run this command, `format-patch` will output the patches to the `psuh/`
> +directory, alongside the v1 patches. Using a single directory makes it easy to
> +refer to the old v1 patches while proofreading the v2 patches, but you will need
> +to be careful to send out only the v2 patches. We will use a pattern like
> +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).

To avoid any sort of confusion, perhaps:

    ... "psuh/v2-*.patch" (not "psuh/*.patch" which would match v1 and
    v2 patches)
