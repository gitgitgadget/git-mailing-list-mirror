Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25AC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80920714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=economicmodeling-com.20150623.gappssmtp.com header.i=@economicmodeling-com.20150623.gappssmtp.com header.b="E6Do2pJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgCWPJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:09:52 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:39187 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgCWPJw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:09:52 -0400
Received: by mail-io1-f50.google.com with SMTP id c19so14456454ioo.6
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=economicmodeling-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E+Lc5KJqy36lxq23k7buMr77soLcS5Zz4BFWbJIKRzc=;
        b=E6Do2pJH0vKLm2tMpnch49K7GcezvSd0piCy3I2P/3CyfVuuG+7vNp1MrWVvSWQtGp
         1iQpgk55sQ+aqxqVsn4orfjYbVJTWL+D3C/DaBLbPuR/jsNphY9/Ze3aX4hXC1cjqVqm
         lf6WkM2XyHZljRaodkOuhDE3C/4O1YzuHWxuy9xHr1U+WccNIXKa+PnJ0qKgMh4zK3lh
         tqy/gB2LIobNwW24+4Eeohl56VLMbO8Ab4mjhkadqcGzF+JdJe01CrawDuvqkKWL20z4
         6kPod8WlJo8+G0v/MD6WwzbTrnHI9rVQ1zU216slptsoOOo57AkJe7W9KLaZXJNpqrY2
         PfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E+Lc5KJqy36lxq23k7buMr77soLcS5Zz4BFWbJIKRzc=;
        b=YdLimxsNlsO4xqhxgJ1EzxftjlCQ/OrDu5lpCJCTJmwdSsXwQjrhHlo75tKcNWhr0n
         ixnK1KaulDVKkBFjLgQ5U0nBINCMoYfQc0wTXQOSuU+AWV0asrzjfsFSvjI+Yh9LJhAh
         hBA15plhm0GdIee2Ug5rvwN586vXTBD1ds3ZDlMKi3VvDATE9tc+81+dwvAOYY+F+3Xi
         xRQMj9Y3NbBiaebTQ/0hsCIH/pybnCaBq63sz/uWA2bPyQpVqv1Rt3m84+pHl+7CRh2s
         1bod4vh4I5g0i5GLo8MUQj/hFgTVCWITk/WYKG52b7t3/utrm/hO4nhl1jAuVOsoiFY2
         LRPQ==
X-Gm-Message-State: ANhLgQ3t2hNvXbBPWjSlRAcpRyORkpAGnfFwqvTsFEK5/fCdsgLJmO02
        jpE3HMoeafChTOE1HTHlCK3qq+LyEw3RS8UAv8MTDg==
X-Google-Smtp-Source: ADFU+vvRbFbqI/mfvYHdNGcMLgHbmTmEj5C0dHqkdeyy5bYmIXgnD7XK9k7dEL46AUniEedYBzfaxHZoBQeT88GE0Do=
X-Received: by 2002:a02:ce43:: with SMTP id y3mr6984396jar.34.1584976190286;
 Mon, 23 Mar 2020 08:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
 <20200323011117.GC6499@camp.crustytoothpaste.net>
In-Reply-To: <20200323011117.GC6499@camp.crustytoothpaste.net>
From:   Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Date:   Mon, 23 Mar 2020 08:09:39 -0700
Message-ID: <CAAjm7GZXNXcGMp7p2f+UoDUWMPY+Z4aFHv35tynteVSKDf2Fqw@mail.gmail.com>
Subject: Re: Relative url values in .gitmodules confusingly sensitive to clone
 via ssh vs https.
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.20.1

On Sun, Mar 22, 2020 at 6:11 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-03-17 at 18:34:09, Benjamin Shropshire wrote:
> > From my perspective, this is a bug.
> >
> > If I clone a repo twice like this:
> >
> > git clone https://github.com/user/repo.git ./https
> > git clone git@github.com:user/repo.git ./ssh
> >
> > And if it contains a .gitmodules like this:
> >
> > [submodule "x"]
> >     path = xxx
> >     url = ../../different-user/something.git
> >
> > When I `git submodule update --init --recursive` in each, only the
> > HTTPS version works. the SSH version confusingly seems to try to find
> > something at ~/different-user/something.git or some other path in the
> > local file system.
>
> What version of Git are you using?  This works fine for me on a recent
> next.  In addition, I see we have tests for this in t0060, and adding an
> additional case for this appears to pass.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
