Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66CBC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiLGBUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLGBUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:20:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06F2D740
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:20:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n205so19057499oib.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0gp0orPQ6/uMYe6fgAGpYUgYjRRKifXxdTg3m5rcRs=;
        b=RlTQ6j/14oi877ouaBLpS741ehdTuh7T82tPjuEjtMqjyx5U/gHO6gNo+q6sMonAYr
         yHCJzBM8AMsl2vWu8f/JIPMKkCtg3exTcfq/VrfGyOCfs9IaUfM++0ApUv1kxU0EJNF5
         ocOW05OVnoHP4+kWPZAzJOrrCrZPKYXXSEhAdiebeXkUJX0TlJthbSznQZbj9AHN/PiO
         9JGn6Z4Js8y/ElJ0yIyRWwkt42IjC0v9DCYzsAgv9pHxEBPkMY/HiztUjgVrFm5Zbf+L
         WibOuWMV/fAp7HDcP29stGrWqH0gNWIU6JG8a2Mtc5VsoHFE51wfeIiOPS1Eg+y7iNH1
         51+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0gp0orPQ6/uMYe6fgAGpYUgYjRRKifXxdTg3m5rcRs=;
        b=5Xp/IYuRaI8fY56J16ZkVl6kdT2feR/w2F34fQzE+1MitxPFI81hZlvDHs9nkzZkNO
         PlKEiEVl6jDblsq58/CQvayTPrJw4XQubjksQAOxjj6oKdHz24CN3j7Uz51Ctc6qHBS6
         jIMoCZMBm4QcvodaoV3JWWfmJGrNiKcjTetzcoGjGV2ratjapsevb938qbvvR69nikNG
         NccCEe3hvwjx9v5xGhokhbuPrvkS33o2XN2AuHumkanxXXnY8WDdMD0OdZp2Ii+a7VN/
         wRrKgJx1mVUliDOPg9GQlJSJtz6OoDKkYrWYZadVaslvO5wzprW7wVfcb08SLfbOLQO4
         AAjw==
X-Gm-Message-State: ANoB5pnuGVUm+MjgInJzHl/k99LiWed8eG38Liezg8JY+cXtWP9MHKNp
        NJBzX3iRsoY9bD4XG5FXCDk+hCUagp/mSTb/vG0=
X-Google-Smtp-Source: AA0mqf5NWcqram1HKdsWmC21o6tKzKyqVL4fi3B5N5ZweM0gPbThVWc8xfFUSDqPsuRFeI7C+9HU7h0oh6+URH3pbSY=
X-Received: by 2002:aca:c44:0:b0:35c:3ea1:40c5 with SMTP id
 i4-20020aca0c44000000b0035c3ea140c5mr5640304oiy.54.1670376011896; Tue, 06 Dec
 2022 17:20:11 -0800 (PST)
MIME-Version: 1.0
References: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
 <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net> <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
 <Y4/pO55b5DtPnavg@tapette.crustytoothpaste.net>
In-Reply-To: <Y4/pO55b5DtPnavg@tapette.crustytoothpaste.net>
From:   Gennady Uraltsev <gennady.uraltsev@gmail.com>
Date:   Tue, 6 Dec 2022 20:19:44 -0500
Message-ID: <CACH4KQSJ_3J4qvbbv1+4URg4hpXAur3pzvMouXRkF8WsLVWhRg@mail.gmail.com>
Subject: Re: Git credential store conflicting configuration leads to
 unexpected behavior
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gennady Uraltsev <gennady.uraltsev@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you! I did miss it. I appreciate your time.

--
Gennady Uraltsev
<gennady.uraltsev@gmail.com>
(https://guraltsev.github.io)


On Tue, Dec 6, 2022 at 8:15 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-12-06 at 23:53:05, Gennady Uraltsev wrote:
> > Thank you!
> >
> > This makes sense and the solution is simple. Is this somewhere in the
> > documentation (honest question, I am not being a jerk)? I tried my
> > best to figure this out before bugging people on the mailinglist.
>
> Yes, but maybe not where you'd expect.  In gitcredentials(7), there's
> this text:
>
>   If there are multiple instances of the `credential.helper` configuration
>   variable, each helper will be tried in turn, and may provide a username,
>   password, or nothing. Once Git has acquired both a username and a
>   password, no more helpers will be tried.
>
>   If `credential.helper` is configured to the empty string, this resets
>   the helper list to empty (so you may override a helper set by a
>   lower-priority config file by configuring the empty-string helper,
>   followed by whatever set of helpers you would like).
>
> The `credential.helper` option mentions that manual page.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
