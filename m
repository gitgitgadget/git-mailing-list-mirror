Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD8C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BD02173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2WhHAC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgHFA14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFA14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 20:27:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1926C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 17:27:55 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l17so47847106iok.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 17:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL5zgYfeiki3rs90uBvaRJvZzvGk3UNUI+lyczR0Shk=;
        b=i2WhHAC53rr4sIGJqBl1OgS9RqDUdpFfjRPo06RMyokqD2MbA6lTubF6COHELdmUCN
         0e+vbMuv4J0sX0VMD1Lx8RNf//0LTeOjDJ5pdyYk67UfETXYRoLWlIT/rGuvdn/shdsK
         7ygWyUkpg0wDsR1hx/CEke4iety1e4y3tom9Cao0Ywj6FHDjUWDKSdMilMIx7LkED7NO
         D9JfcDi11fNk8E9rs7KgeFZa28foWS3yC50X0XH/w1rES+fwDP8PVh69zMERu9Qj/Q0Q
         Kji734YtZu18XqKDxXKgFxrtJODZlHQvZMyYP7szsYiu3Kl3ut1lc5y+MC+0w8XZgTsS
         CZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL5zgYfeiki3rs90uBvaRJvZzvGk3UNUI+lyczR0Shk=;
        b=YTv9dXIwwTqzPvxPQTS+sXnZWkg4vPNZPxmdd3UqeBNSsZJytmsZEiRQP5V+d/ggBm
         kLWwjc28lGP55p1U/EjdrpEaYyJJMmSwhD9ypOd9HSA3bBFqBd6++Soy4177b6ID38YA
         fCXsCfddPttc9IO2/bEM3e35zy0MuOlyyEGfiM0txED5e+OdIHarfdPZNJoNDQamTUSh
         f7Ney7yI4HmMcaEdDE7j7YjlZizfBRRoZm5aEZVgrKOKZa6U3pdIZFGrqyN6YEZca6pX
         1GCwKVEZ1PF9VzIGmcN5O0W9T4RfWJT+/4jZlEbqgghoW2KRNngJYqrJEUEl3pkfbhNP
         1Bbg==
X-Gm-Message-State: AOAM532+0pXGoKP5Kgl1NCkrCp9GD6aVK37WpPXfCz/nnGZk73bHLzvE
        oxIXaCZsYcn1O8ryRkBnZvFW0xHo9d1rprKCOMRq2eHvGtc=
X-Google-Smtp-Source: ABdhPJwi+9UnFmTJG5wGP3bllbJl1qSLRBCcbdI2hZ/Mgl+0JuymeEyFwloAyqSVPG0t38uDpn4/wkJ/4oJ3FfeEus0=
X-Received: by 2002:a5e:a512:: with SMTP id 18mr6407592iog.26.1596673673402;
 Wed, 05 Aug 2020 17:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
 <878ses4pay.fsf@kyleam.com>
In-Reply-To: <878ses4pay.fsf@kyleam.com>
From:   christian w <usebees@gmail.com>
Date:   Wed, 5 Aug 2020 20:27:42 -0400
Message-ID: <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
Subject: Re: ls-files bug report
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the insufficient reproduction steps.

I managed to figure out it has something to do with git repos within
git repos. It happened to us because of go packages that are inside
our repo. These are the reproduction steps that work for me
consistently using Go version go1.14.4 darwin/amd64. This is the repo
that gets cloned into src/golang.org/x/debug by the go get command:
https://github.com/golang/debug/tree/66ec140f2f72d15dc6133502edd2bb7238b1740c

$ mkdir testdir
$ cd testdir
$ git init .
$ GOPATH=$(pwd) go get -u golang.org/x/debug/ || true
$ git ls-files --others '*.txt'#
src/golang.org/x/debug/

On Wed, Aug 5, 2020 at 7:59 PM Kyle Meyer <kyle@kyleam.com> wrote:
>
> christian w writes:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > git ls-files --others 'some/path/*.some.extension'
> >
> > What did you expect to happen? (Expected behavior)
> >
> > only list files under some/path/ that had .some.extension
> >
> > What happened instead? (Actual behavior)
> >
> > It listed those files and also all untracked folders underneath some/path/
>
> I tried to follow your description, and I don't see this on my end.  In
> a fresh repository:
>
>     $ mkdir -p some/path/d0
>     $ mkdir -p some/path/d1
>     $ touch some/path/f0 some/path/d0/f0 some/path/f1.some.extension
>
>     $ git ls-files --others
>     some/path/d0/f0
>     some/path/f0
>     some/path/f1.some.extension
>
>     $ git ls-files --others 'some/path/*.some.extension'
>     some/path/f1.some.extension
>
>     $ git version
>     git version 2.28.0
>
> Could you provide a more detailed recipe to reproduce the issue?
>
> > [System Info]
> > git version:
> > git version 2.28.0
