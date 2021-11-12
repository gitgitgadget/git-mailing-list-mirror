Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA2AC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF36C60F41
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhKLRKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhKLRKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:10:07 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45171C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 09:07:16 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id l43so20219729uad.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 09:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=x6bU7w3mijO+a6UpHUNTX9RLaL5+UZO01BY8PocUklA=;
        b=S4dO29qdAvwiMCnI102vQ26B5b5jXRZtyaDVc6YwK0O3qzwN//mXKW2NjPMueFj4ak
         tpQ90i37vVlW7nKsqCxfexZwNNybytdOIABZgF4HLhQfVGx+I2G9t72AgL0LxevbJOHk
         /mSh+fMRTXbSLx82xNLLvJi0iyBb/x0MHcSUM1n/4WevaO4NUr21PozWLQTNsHp3CSKq
         DqoJYNHy7TDViZf9ekz0cA1Q1VV2zpFUCjeR3/s3cLQbaw6uDnw5HA4FtXdMZLIETVc1
         n7dRaaSjiDao7/No0qRJsjN3zYpSkjzVpZQ1uZgWEb21xEXEckIgAZcehxAZzErsLYGO
         EAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=x6bU7w3mijO+a6UpHUNTX9RLaL5+UZO01BY8PocUklA=;
        b=TsEBPghohAgT7G9h59VbIk+OVBGKBFVXcBrnYf8OZymIUT2JSQ6PYkc+4y50E1CUJU
         +8168X0ZfTGMlUKFN6lcMT50f77q0GVgW8w8sbmkfN/gUbAuYCxgM0fQeDez3lUkYA/0
         cpsyu9dQWtZ4jiWi9YktT8pQIN0tgsW7emwZxPtlQPt0cQYhsVK0tJlUGBa9Z2kZdA2N
         Vrvcg6ymqbY6pjAppvTIuSamHbBWhsqaK8/lJOWC/WFH2HnJ5tQ+meDgwvI7ZvjgrsUk
         2eoohOBEUkLPNn1+r9Kl9UlN3iV+xTUwX7s/l7orAuKaQa5eXEqPxyGXDpKjffZWGWB6
         lrTg==
X-Gm-Message-State: AOAM533S4aoEekiriFQ4nkY7puCqR0Izdlkj4Kn4OZFy0MLbkj2ApkVa
        GA+r8ajytG8Ozgmq/ji+veis/XPgB723VUamv722ZqEVlw==
X-Google-Smtp-Source: ABdhPJxy9bjhaqEUdDeC3EF1+J6tsW/usyNrQfwCL4kHN6isPIlqJ5heNkl++FynRJuqliTsU+7+YUTS//qVXVPKinU=
X-Received: by 2002:ab0:74c2:: with SMTP id f2mr24528639uaq.21.1636736835401;
 Fri, 12 Nov 2021 09:07:15 -0800 (PST)
MIME-Version: 1.0
References: <CAA9rTucw0wzghy_onKgSWt=QmVoB1qsV108V7NYApJyV8FCpNw@mail.gmail.com>
 <CAA9rTuf+AwPJYki6O_hEPAS=aZta3HuvQOWLHnRfv5FV0DfYSA@mail.gmail.com>
In-Reply-To: <CAA9rTuf+AwPJYki6O_hEPAS=aZta3HuvQOWLHnRfv5FV0DfYSA@mail.gmail.com>
From:   =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Date:   Fri, 12 Nov 2021 18:07:04 +0100
Message-ID: <CAA9rTud6MrFjhAtCiK7V5jgQ=bUNexqUKTtcDUT1L4=7x+OQgQ@mail.gmail.com>
Subject: Bug report: Githook reference-transaction does not change working
 directory on git clone
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

With git 2.33.0, the "reference-transaction" hook does not change the
working directory to the worktree (or GIT_DIR) when launched on `git
clone`. It is just unchanged in this exact scenario.

MWE:

cd temp
git init A
mkdir -p templates/hooks && echo "CWD: pwd" >
templates/hooks/reference-transaction
git config --global init.templateDir templates
git clone A test

Wrong Output:
CWD: temp
CWD: temp
CWD: temp
CWD: temp

I have seen this problems already on other occasion with other hooks.
Probably the problem exists also there.

Thanks for fixing this if this is really a bug (??).
Any reply to this would help.

BR
