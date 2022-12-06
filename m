Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD183C3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 23:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLFXxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLFXxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 18:53:34 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306BDB77
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 15:53:34 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1433ef3b61fso19375853fac.10
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsXDCUxxGE5bnAp8576gkryrm3WOMBli6VEEkEhS1MA=;
        b=BXul4OfHDvZ0Kv6F7qK3Nh26M9SlYIOVQeT5xmHWN0VzDxBcBYKXfrxwe0RXRmHGXJ
         /uY7nl+Eck8GRpXqMz/nr1TY5oezTJiKcwdDbw2mGUnmCq8S31UR9ovbOK54B/9678qU
         RcredWdpSBHpKBOVB7qBbxccLPHb391UTknQRYk/Hx/kr8y/sOhujYwUo0F/tUyJiUaa
         Fv2jGaPw113pExs7BuhPhGP2lE3On61FU6Js5qJed7bNvXFyURzCKf3PLNRuLnoj6lrX
         6Xd2CtJJCx0NKDyHhlN27QENEHAwwjERQgBpQTvSRvR16NH/KNuJcViQELzKBuAXIBNO
         kx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsXDCUxxGE5bnAp8576gkryrm3WOMBli6VEEkEhS1MA=;
        b=XmyK62QH1aIAkTMPkhkjfr+njwHIOyaaA/MaWYHDZ43yyQmcdwo0OsunEn58StP0Q8
         h6t73debUF+Gdh71O1S938paV9Oz7P8RFfX2iFZ7xwNuAh3kOGfSfv2Y9aCn29dOPBx7
         COwNtTGKb6b9EoWcKOn5UzmMw+2rnSWUCg9a7hOMBDSqxGBpxU7q1swehJU9L431W8UZ
         0+W1XT8ZLpvqUPykwgEQTXV631u2eGp+fnjP32wXzMH/vNXIk2d+WKyR6HmSC9YKcCiX
         FM45r66qyliEjV6dEgJUUonxk6nlcXB6Bw00BoHjiBx04C7p2HRmuGJF7oJluCDs+c60
         nnAA==
X-Gm-Message-State: ANoB5pmzb5T7dnX8C3/LFUsELAQCkNfnkk3Uykt/+J+QM1xy6Uj/fE+X
        /aE+PXZ5OQwkeB+qi3nP+9DClunryyAaLSMxpf8=
X-Google-Smtp-Source: AA0mqf6+ffirTemEMwvOrWMK7Fe38s5Ssjn94p03iVbJaSH+ua1tNJrccZ3IWtoXKU17I80y0mrdhCDl9eNy6Nuvy9I=
X-Received: by 2002:a05:6870:3921:b0:143:c836:8a9f with SMTP id
 b33-20020a056870392100b00143c8368a9fmr22414891oap.54.1670370812633; Tue, 06
 Dec 2022 15:53:32 -0800 (PST)
MIME-Version: 1.0
References: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
 <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net>
In-Reply-To: <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net>
From:   Gennady Uraltsev <gennady.uraltsev@gmail.com>
Date:   Tue, 6 Dec 2022 18:53:05 -0500
Message-ID: <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
Subject: Re: Git credential store conflicting configuration leads to
 unexpected behavior
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gennady Uraltsev <gennady.uraltsev@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you!

This makes sense and the solution is simple. Is this somewhere in the
documentation (honest question, I am not being a jerk)? I tried my
best to figure this out before bugging people on the mailinglist.

Best,

Gennady

--
Gennady Uraltsev
<gennady.uraltsev@gmail.com>
(https://guraltsev.github.io)


On Tue, Dec 6, 2022 at 5:16 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-12-06 at 22:05:22, Gennady Uraltsev wrote:
> > Hello everyone,
> >
> > I have an issue with git credential-store. In my global configuration
> > dir  (.config/git/config) I had the line
> >
> > [credential]
> > helper = store
> >
> > while ini a repository's .git/config while I have
> >
> > [credential]
> > helper = "store --file=./.git/git-credentials"
> >
> > to store credentials "locally".
> >
> > I thought the latter would overrule the former However what happens is
> > the following:
> >
> > 1) On first run the file repo-local file ./.git/git-credentials gets
> > created and the credentials are saved there after the user is queried
> > for a password
> > 2) On subsequent runs the credentials get recovered from
> > ./.git/git-credentials and the user is NOT asked for credentials
> > 2b) **Here is the weird behavior** git ALSO creates the
> > .git-credentials file in the home directory and saves a copy of
> > credentials there.
> >
> > The behavior 2b leads to exfiltration of passwords to a location a
> > user might not expect.
> >
> > Workaround: Remove the line
> >
> > [credential]
> > helper = store
> >
> > in the global config.
> >
> > It seems that the global config somehow does not get shadowed by the local one!
>
> This behaviour is by design.  The reason is that sometimes the user may
> have two sets of credential helpers, one for one set of domains, and
> another for another.  For example, I believe AWS has its own custom
> credential helper.  Git calls credential helpers until it finds a
> credential, and then it sends store commands to all of them.  A
> credential helper which has no credentials for a domain will generally
> respond with no credentials.
>
> If you want to override the credential helpers in the `.git/config`
> file, you can do so by first writing an empty value, like so:
>
> [credential]
> helper =
> helper = "store --file=./.git/git-credentials"
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
