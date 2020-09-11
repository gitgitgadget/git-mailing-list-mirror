Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D665C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F63F2220A
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 11:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABtzJUtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKLrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIKLrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD747C0613ED
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 04:46:56 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id p13so8714859ils.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tXqAt7N55GycjIdyeQ5esKO6pn3zH1M4nKJafOQQqZE=;
        b=ABtzJUtCu4iBfEtADsyCHud8I3vZMxavpsL+vpjbPu/T6/64C/rZIg2jpegusyN5yP
         zKzs1z1HxjMju5KdEDJA0tw59FY8rhPPILZTAqwQvAtE3niKa965euWymdMDO2ta8xAc
         zmmq+7YqgsXlVZzZfOLk2/Z3jBtg1anbXukXCp2gp1iwAKtJpVZlsh9TMD/0cHgthHoF
         qNkohootVlGIgFWcF6PCnB91mvA8Hqft41n+YYwScSqBpv4y2JcnfblMxIbBegGwkvsW
         JV5NvY9AMTWf6Z9VZGQzkJulBwWrDgfYgJdo4PQ5HolOq80dw9yTZFcGuM7K2b6YFLTI
         RWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tXqAt7N55GycjIdyeQ5esKO6pn3zH1M4nKJafOQQqZE=;
        b=R+jAE5lHEvZQNyT+yYSZfMfvbSfFRGz1noTINzLJGPo+lqR7SKrlmvmFIEEslYur9r
         k7Fw4DTqnzLjh5SDH3LB8em5dlTBNtMqXMH1ozkWbjUiLBCyGgOm18juLw9arCdvaJ8n
         jW2qprdPJfGi9VeOG5GlLjI/kTI6fEdkk6y/tM6Irtjl7BmCqgwdS5zFKK64A2dTQ9y8
         5DjIcpzm9mhfX7jTVdpGF6TM+2rlv+uerqEA5YYr1rq2yN6S0h2ts2d/LD1iqf3hB/h0
         zW98FasqZSswYTsXCUEPKoR+lCgMslT/kWUCsCACMRse24gxGoOA6gCAXKHv6ojBseEN
         BVgg==
X-Gm-Message-State: AOAM532KpcbN/44DP6CV5Wa3OioFgMtZCcYUkkEX16snrCgrsJYxM3Tl
        pQxi7SrQ2eUA76M343BevsMxbktbKtT2iD2lzL8v7iOuo4k=
X-Google-Smtp-Source: ABdhPJweaXhzs72d+9d9erfXQQCgD5X/B/g0QsUzF+yTe5WaPZ6O5nIIN1F3KvlLYdfJ0zslchsxwIHkHwsExwq6Hqo=
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr1313187ilc.213.1599824815643;
 Fri, 11 Sep 2020 04:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
 <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
In-Reply-To: <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
From:   =?UTF-8?Q?J=C4=99drzej_Dudkiewicz?= <jedrzej.dudkiewicz@gmail.com>
Date:   Fri, 11 Sep 2020 13:46:43 +0200
Message-ID: <CABJqhQMST-n6-uEDpFCUSsYueF_=7ZLPCtj_mQnu679oY99ZVg@mail.gmail.com>
Subject: Re: Cannot run `git submodule init` on Cygwin from script with strict
 error checking
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 1:30 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> Hi J=C4=99drzej,

> I think there's something odd about the way you're calling `git
> submodule init`: it should normally be a separate execution that
> wouldn't inherit the `-aeu` or `-x` settings from the parent Bash
> process.

Sorry for not including the test script. Here it is:

----8<----8<----8<-- CUT HERE--8<----8<----8<----8<----
#!/bin/bash

set -aeu

export SHELLOPTS

set -x

git submodule init
----8<----8<----8<-- CUT HERE--8<----8<----8<----8<----

I use "export SHELLOPTS" because I want these flags to be effective in
subshells. As a workaround I'm currently calling "set +u" before each
execution of "git submodule init" and my script works, but it isn't
very nice and IMHO shouldn't be required (i.e. it would be extremely
nice if someone fixed it).
--=20
J=C4=99drzej Dudkiewicz

I really hate this damn machine, I wish that they would sell it.
It never does just what I want, but only what I tell it.
