Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9EC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiDAKQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiDAKQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:16:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E141017869D
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:14:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so2343334eda.12
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NGfy4uJel39d9h6Rb2il6TcuNN0hAKpz5bBlUMheo2o=;
        b=oAdnX3Hih3gY/68lBYiYGz2jnJYvNrcU4TFdDUtjZ6RIGFId7HyIm9YXyAHdyHaZEP
         CPvH4jz92f6oR51vRx3xXQdQvpxhLs9+ucNHi8zLnN4D2cBz0v8AmfEocM9en06/WoS2
         uklElq+uALq6rxyokMpM+Sghb4/KErNQcQ7eqBA0jtOqemuRlija+Qx0NKxagZVLihnZ
         pa4IRIZeqA/uGBpEsfmj+ZEVfedpK+n+nhTc+mdVh1zZROs1o8eH1O+xiJ3qWeXZEmvW
         v0iYnK/S8aX6MXUFgoQyjnLBFSL/nR1YJdJ4dT74Eb9nQsJqLDwRyjtodOiv4bpXWpC1
         yNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NGfy4uJel39d9h6Rb2il6TcuNN0hAKpz5bBlUMheo2o=;
        b=e2Ziq/9nYrkR5ZSPVV6gJcs+5YdGa/27lzaT2s7wVrKq+nSQT2wdkreltE2nXDTukb
         RDQ4RbYVtSQR/5sg0C5/UwLlJATqITFTiSh+2gSJvFQfeAR8hu1gaRKClchJCiuMRThd
         aoVbxcjyEuCHfBUDZUxRGpxvFDf6+M5lrjzhmv5cth/vGPmTbZFQaksL1niRMBz8LhNV
         0JwVfUEJVNtzf1TxGUK4UEkugDPfLClP7fR1ybuyRWzFB/Q7H9v7025kLBZd2fMn5Hzv
         y9y7LMAAzLGdklN8bPj82WOPMILDivpAHltDRVdLtwKQFUO5Mz5IePDigLcx74/z1w+L
         HRWA==
X-Gm-Message-State: AOAM532/DpD49dcZSZ/ltoewf1OHaN7mF4P3y1JiBqHmC9m3nvjR2OlU
        76QZ/5OPYBstkB3MPl2K1nq+VTSntTCmQw==
X-Google-Smtp-Source: ABdhPJzLVlcH+Qy6N9S7pLTro4t48RYWIw3U8L3LLpIs4RQdGRBlvJhMcA9MGrZ+g5Ork4vbcXrcCQ==
X-Received: by 2002:a05:6402:254e:b0:418:e716:f987 with SMTP id l14-20020a056402254e00b00418e716f987mr20176185edb.74.1648808097408;
        Fri, 01 Apr 2022 03:14:57 -0700 (PDT)
Received: from vmiklos.hu (92-249-130-49.digikabel.hu. [92.249.130.49])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm839859ejc.66.2022.04.01.03.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:14:56 -0700 (PDT)
Date:   Fri, 1 Apr 2022 12:14:54 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
Message-ID: <YkbQnnB8GSzuAROh@vmiklos.hu>
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
 <220401.86pmm1nmvh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220401.86pmm1nmvh.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Fri, Apr 01, 2022 at 11:57:33AM +0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> So (just making sure I understand this) in this case the --since option
> is behaving as expected in the sense that the information in the commit
> itself matches what it's finding, but what you'd really like for it to
> consider some "adjusted" commit date?
> 
> I.e. to be smart enough to spot that it should include a commit from
> 2021 if all the preceding commits are from 2022, or some other similar
> heuristic?

No heuristics. Just a way to not stop at the first commit that doesn't
match the --since criteria. Here is an example:

Given:

rm -rf .git file
git init
echo a > file
git add file
git commit -m init
echo a >> file
git add file
GIT_COMMITTER_DATE="2021-01-01 0:00" git commit -m second
echo a >> file
git add file
git commit -m third

When I do:

git log --pretty=oneline --since="2022-01-01"

Then current I get:

91a24b6ccba6b1d26c3bd5bcea7ff86e6997b599 (HEAD -> master) third

And I would like to have an opt-in way to instead get:

91a24b6ccba6b1d26c3bd5bcea7ff86e6997b599 (HEAD -> master) third
e259a40784d3d70f3878105adac380c8e8a8ae52 init

Arguing that both "init" and "third" was committed this year.

The question is if there is a way to do this already (perhaps I missed
something in the docs or didn't notice it while I briefly researched the
commit walk code), or in case I want to do this, then would it make
sense to have this feature in git or this is more a "run git rev-list
and do your own filtering" case?

Thanks,

Miklos
