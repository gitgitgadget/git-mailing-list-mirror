Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207CC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjEATWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEATWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:22:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45182E5
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:22:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4d96e14so11815903a12.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682968931; x=1685560931;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9y7oJCmOyuBT54Xyyvjo/ftPxx3PBG7pXXYepMhFOYY=;
        b=endxlkApFnikijP0cmfYD1NBNDhCfh9SL57XNREWKN+KREO48Dx5PF96RoVmTeVgDC
         DXJ4D+SrIU3xHUEr+lXb3ypvQez9HvCOgOsaNx2oonHWTlJQCuSQBHdRAPdmKdZhb7sQ
         dVdrBZuYnyx3sYs/pAPzIMhkOVyFpFxsdFVqYCVy10bNsaKpLZoYkzXiFseikuKyquVk
         8CnnL9B8QmDXHcICjsGroXley4+loizmT4EGUAMzWfqbNfvFv3n3fuNCa3j5+HRNPjIJ
         E7K58eVCuFsJ+E6NiF+RliUSe0Qge55oj7yx/M9RsJgr2E+hiCk2WiP0IWJV0SEpr0yE
         6+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968931; x=1685560931;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y7oJCmOyuBT54Xyyvjo/ftPxx3PBG7pXXYepMhFOYY=;
        b=cMqzrWmRN/wThMBilsSLXTA+LAdLdOtQgcLqpXy+vL1Ej+HQs83qAHMMDHVhjZKd2c
         Jk9UZAy90J6XUbKfUYYqXECKTplYLh816pnNadKFUlC+pvD6rvlLtwDkKVvxCL1Erya+
         jwUTP6FMpdtB0oUhuLyujc6+A+RyH0mNlkz5twODATRkkQome+epoRXhXMKVWLUmSUrU
         jjNGVdT5+dvbNzpqb3PI0EIc53bv0vk2F8t0vlwBH/wNrL23fGXkcoD35WMYKAbV8BVB
         DmJ+JFhONBnwb9Ce/W/B8diSPJvbi2AsTSoMX0yyXeJfy0UsUPPvWcbuIpISlo4qhs7d
         5U5w==
X-Gm-Message-State: AC+VfDynjqUpODxiQz9b5AhYULanb5QMldHGYgi3UA4af3ryOAMoQWHc
        E+Eaq20YEQCksVsllQG7uRoo0cZPG3Ve7FRSDyepf98Wc4Q=
X-Google-Smtp-Source: ACHHUZ5/hTR9+AqJYmXZExU+6iqTbIzHfg6rkbI55UHg8ra/ML00uXav/PzsWu6mVRWa24DCwNJHgjSovgnIer5KWSw=
X-Received: by 2002:a17:906:ce4a:b0:94f:1d54:95d2 with SMTP id
 se10-20020a170906ce4a00b0094f1d5495d2mr19368851ejb.15.1682968930822; Mon, 01
 May 2023 12:22:10 -0700 (PDT)
MIME-Version: 1.0
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Mon, 1 May 2023 11:21:58 -0800
Message-ID: <CAC4O8c9Q4oPP+RgVuOHfz9G8+3v5rDHMXoM_QJvArQGVWSHu-g@mail.gmail.com>
Subject: git-submodule docs for status command should mention --all option to
 git describe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs currently say:

     status [--cached] [--recursive] [--] [<path>=E2=80=A6]
     Show the status of the submodules. This will print the SHA-1 of
the currently checked out
     commit for each submodule, along with the submodule path and the
output of git describe for
     the SHA-1.

It took some guessing to figure out that it's actually the output of
git describe --all for the SHA-1.

git describe alone says e.g.:

     fatal: No annotated tags can describe
'eb44efaaedcca34fc43c451f5659ec2e80bb2bbc'.
     However, there were unannotated tags: try --tags.

So I tried that:

     $ git describe eb44efaaedcca34fc43c451f5659ec2e80bb2bbc --tags
     v0.4.0-devel3-14-geb44efaa

But that's also not what git submodule status shows in my case:

     $ git submodule status
     04bd93953af4d0f624a5103a8ac29caa4d0c64c4 contrib (heads/master)

If I understand correctly git describe will never find heads/ refs
(barring pathological names) without --all, so it seems that it would
be best to short-circuit the above fun by including the --all flag in
the above documentation paragraph.

Britton
