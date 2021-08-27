Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA194C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8456460200
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhH0Cuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhH0Cuo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 22:50:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5DC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 19:49:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f15so9840872ybg.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMvVjExFxKHIDmpV416cKUCYhmIiFlQgpmCFh/SUD+g=;
        b=lihnvAyPsW8umn6uJECYbI2pCxKNj02mf6y/bBBBKb6fFSjp/RZFBIr4dmfA11a2bv
         yv87GWv9puGHnYgjGULH6vgcBnS1LILvVN3PDuZBIieQOSfNsD3FJrehAP9JVmfzq7kr
         1q2m9q6Twdn9v5cId2j8f2Poysunrenr3AlVU2RHtDW1y9xvJ62mVaLznkfkFfQ1MP+N
         QlrfzdhHJYb5C4E1rAUtXn7R3xyQ4k/SV2/uDQ+jpQ5ufoqaraAknmzTT4V8NNfs8YSi
         7hXDcrn9QET5zKPRwS2g6FWXoY7FBkNUuXZWoFV0BhjOezv9kfupwWRCqae5sDpcglp1
         9RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMvVjExFxKHIDmpV416cKUCYhmIiFlQgpmCFh/SUD+g=;
        b=RR3DKaLl4j2suk66OUhf1uWqFpYr2AcT8f9MgYpZlxdQI67uphN8d8zU/OcefdpD4I
         DbtHjtcHfbGuoECAzaxsOqr2zuKccGQ6az3WCTnk7FP/2EIFbkSFCcqOMk7dAkezA91Y
         5AIvo5s2Avvm6fBIDDN+XHnsrLxmgfBIVMEo8oj5ZG3d4HNEwhUCcCfktEMeL1YDtr4+
         Zt9jz9Kn0rwTJeOpcerRP3wy8AvlsJEK3BtetgfP+7BiDV2lPITXIGth/1i5wxCBxFnZ
         7sZfgCot/l4NRRM36W9ZMkolaaVi4l+7yNWYxJiMvetnXEMXVJrngpI7G5T6a0xM1KDu
         sLBA==
X-Gm-Message-State: AOAM532drJLvtISdaYtFOZEjwz0er49hr/JRgnLbYsJhrBMU6DGePJeA
        c8U/h1cEJUijMLJ2ly8UM2ootI21KnbMQDxAZ8w=
X-Google-Smtp-Source: ABdhPJycWP7JbrpintP1/e+BY6OrsmTvIHOKzupjk8Vnc31Ip5Bvw7sg0GaOEgR4XFIMyI5ene5T4CYB16dGsjXd+dk=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr2287767ybk.403.1630032595514;
 Thu, 26 Aug 2021 19:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
 <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet> <YShJscwm/jMDOCx5@coredump.intra.peff.net>
In-Reply-To: <YShJscwm/jMDOCx5@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 27 Aug 2021 10:49:44 +0800
Message-ID: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 10:10 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 25, 2021 at 02:14:43PM +0200, Johannes Schindelin wrote:
>
> > > Yes, this is a solution I also want to try at the very beginning. But
> > > some l10n team leaders may fork their repositories directly from
> > > git/git, and name their repo as "{OWNER}/git".  I want to try another
> > > solution: check existence of file "ci/config/allow-l10n" in branch
> > > "ci-config" using a GitHub API, instead of cloning the ci-config
> > > branch and execute the shell script "ci/config/allow-l10n".
> >
> > I understood that you were trying to imitate what git/git does.
> >
> > The problem, in git/git as well as in your patch, is that this is highly
> > cumbersome to use. Yes, it would be better if there was an easier UI to do
> > what you want to do, but the current reality is: there isn't.
> >
> > The main reason why it is so cumbersome to use is that your chosen
> > strategy scatters the CI configuration so much that it puts a mental
> > burden on the users. I, for one, have no idea what is currently in my
> > `ci-config` branch. And new users will be forced to struggle to set up
> > their fork in such a way that the configuration does what they want it to
> > do.
> >
> > And in this instance, there is not even any good reason to make it hard on
> > the users because most will likely not need that new workflow at all. That
> > workflow is primarily interesting for the l10n maintainers.
>
> Just adding my two cents as the person who created the "ci-config"
> mechanism: yes, it's absolutely horrible, and should be avoided if at
> all possible. :)
>
> Your repo-name solution seems like a quite reasonable alternative.
>
> (I'd still love for there to be a way to selectively disable CI on
> certain branches, but I didn't find another one, short of enforcing
> branch-naming conventions that the whole project must agree on).

Yesterday, I created a new github-action:

    https://github.com/marketplace/actions/file-exists-action

And want to use this action in the "ci-config (l10n-config)" job like
this, but it appears slower than before:

-- snip begins --
jobs:
  l10n-config:
    runs-on: ubuntu-latest
    outputs:
      enabled: ${{ steps.check-repo-name.outputs.matched == 'yes' ||
steps.check-file-exists.outputs.exists }}
    steps:
      - id: check-repo-name
        ... ...
      - id: check-file-exists
        name: Check file in branch
        if: steps.check-repo-name.outputs.matched != 'yes'
        uses: jiangxin/file-exists-action@v1
        with:
          ref: ci-config
          path: ci/config/allow-l10n
-- snip ends --

The execution of the "l10n-config" job will take 4 seconds vs 2
seconds before. This may because the new action
"jiangxin/file-exists-action" loads another VM to execute.

So in patch v3, I will remove the entirely "ci-config (l10n-config)"
job, and use an if condition like this:

-- snip begins --
name: git-l10n
on: [push, pull_request_target]
jobs:
  git-po-helper:
    if: endsWith(github.repository, '/git-po') ||
contains(github.head_ref, 'l10n') || contains(github.ref, 'l10n')
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      ... ...
--snip ends --

Will check the target repository name first.  If l10n leader has a
fork repository with different repo name, push to a special branch
name, such as "l10n/git-2.34", will also trigger the git-l10n
workflow.

--
Jiang Xin
