Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093BC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB326052B
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhEaRCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhEaRAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:00:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A3C068F93
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:14:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so12561181oic.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hp+GX+x8niVKX8ZZwUKbjOLDxKYGHf/BO8P/hPjX6vE=;
        b=KFPzBs2znr4tQdDNSyojkT0QYFND8XxrGonZB7cFbwv82d6W66361EUL2KNgnoPw9W
         DrgDVqvGidNE5Snnf33dmWzc0MMOiukKwTeBY2uafT5OWJAfyPDAyDWs26KNce7meuqZ
         JjWzLpy6WY7d+HZH1uEAP9kAriiL6PBzXz9CWCRmNIBzHhqLWPrDFFBYDqIGho2bxwxq
         9A3qTRVVrbwN72TBgxCgM1PT2uT09JY5i5P4r+q1UsH+i42NtVI8pYPoHLAWdwRlPfyr
         WwSghqTJBxLeRciIxHofSa/a2d09CB2phukqQUe6BZn9e6rWNIflVyCPuWPYGBdn8Ots
         jhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hp+GX+x8niVKX8ZZwUKbjOLDxKYGHf/BO8P/hPjX6vE=;
        b=jfWHEzebJGdXL5msQ1QklGVhIH4BtJWFwjMuhoJYVyq8buuAQZUxwVpjnVXRdVFv9I
         m5nKAuHuDQsGuhekJMICjg+5zCFIbPozYgccpGlxRxYC2MdWN45Dqz01yT/TQgCu1CTL
         Kt0u+PkERRicn598oIv5xyAgIpVi7uUwhXpa3/DE+pPb991nk34mIrj6JhWndV3XMkyb
         xIC2rPBict7M5n2WOUtw1a5a0e9hsdHfCK6YYpsZEF4+S6/65dj+zLeVj1Nriy5pn4l9
         sKUsbBBbdlSAsZPGGHEegqUdl5/5i3fjWZvfpe4+YiowZR6NtfIxiGn0VAfUNKoZSXTQ
         klpg==
X-Gm-Message-State: AOAM5307hQjq4gnwHYeIJsympQ6o5lGwkS0+CZXc20/0tRQtYbFRc0W/
        To8XTXRUqJt/0sul12wIIzg=
X-Google-Smtp-Source: ABdhPJzsaITQ780jlaVfE+U1ycVvRpnl1CYE36W0PaOVGNElPbTwjelJ5I2/+M0sl4HK2bdSVVZWIw==
X-Received: by 2002:a05:6808:153:: with SMTP id h19mr17556830oie.117.1622474063868;
        Mon, 31 May 2021 08:14:23 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e83sm2818959oia.40.2021.05.31.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:14:23 -0700 (PDT)
Date:   Mon, 31 May 2021 10:14:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b4fd4db5dee_24d282088c@natae.notmuch>
In-Reply-To: <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Am 30.05.21 um 21:09 schrieb Felipe Contreras:
> >>> The current branch is pushed to the corresponding upstream branch, but
> >>> as a safety measure, the push is aborted if the upstream branch does not
> >>> have the same name as the local one.
> > 
> > Except that isn't accurate.
> > 
> >    git clone $url
> >    git checkout -b fix-1
> >    # do commits
> >    git push
> > 
> > Does that push the current branch to the corresponding upstream branch?
> 
> I see. Then maybe reword to something like this:
> 
> > The current branch is pushed to a branch with the same name on the
> > remote, but as a safety measure, the push is aborted if a corresponding
> > upstream branch does not have the same name as the local one.
> 
> In your above example, I'm in centralized workflow, but I can still push 
> the fix-1 branch to origin without having to configure an upstream 
> branch for it.

No, you can't:

  % git push
  fatal: The current branch fix-1 has no upstream branch.
  To push the current branch and set the remote as upstream, use

      git push --set-upstream origin fix-1

Isn't that problem the one you originally described [1]?

The behavior doesn't change if you don't specify the remote:
`git push` == `git push origin`.

> So this seems to contradict with the currently proposed 
> wording:
> 
> > If you are working on a centralized workflow, then you need to configure
> > an upstream branch with the same name.

My wording is correct, and that's precisely the problem.

Maybe you are thinking this patch series implements the fix I proposed:
it doesn't.

The two patch series merely reorganizes the code to make it simpler and
easier to understand. No functionality changes.

Cheers.

[1] https://lore.kernel.org/git/065528bf-b496-83d3-767d-2a78e50a9edf@gmail.com

-- 
Felipe Contreras
