Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BDC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 11:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBJLIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBJLIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 06:08:41 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CC71001
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:08:40 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id o8so3730339pls.11
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaqzINjU2IgSc9J77OsITW8JEUPgg4AWxaOPFf0iths=;
        b=5pCMtAJNKU1R8JIeL/ugcM0eZhbmw10b6V82d4bBE4mjwZem/HivPRdhCVFJU0/STK
         kkODPGskk8VYwe1wW98BGf/Mj/IpnDgSD+gclViHAEa9eT1LF7qrKzURn7IjL7DAavIr
         3PxBDD7nWN44aPBmk7lL5XxIu9Yf78x85NRBlOCx+Yxb7HITWy7Rl6GctG103BYZtmbe
         qbRU9P7Umt8PhXzOTAvJINmzg8x7PPa+yIz2nxHRhxHWPkt99G+8jHM0hIwLXs264Wnu
         juq+9ZBfD+X/fssfdHtXKMRTiBnuHCBfQoNxIj9EYMEPUFmp60+gIPdsJ+97jDu08RHT
         xTGw==
X-Gm-Message-State: AO0yUKXgpLVczwMfzsuli5nfl4dFfABQZYhbxNAqY5pp/4O7YyWazmp8
        HNt47elMBPMXcaeJi5wUQE3qZXVFWvUiSKSYykttV0zOalk=
X-Google-Smtp-Source: AK7set+rW6ya8nRlIgW+p1g6bdSZ/PhzAVLwbk1zVHPEFiBXSnEUwOPJyVxUSElUMRVeQHXGahDDQmf4OoVvMWkIliw=
X-Received: by 2002:a17:903:22c1:b0:196:4e61:b6b5 with SMTP id
 y1-20020a17090322c100b001964e61b6b5mr4343762plg.2.1676027320114; Fri, 10 Feb
 2023 03:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20230210080110.32983-1-vinayakdev.sci@gmail.com>
In-Reply-To: <20230210080110.32983-1-vinayakdev.sci@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Feb 2023 06:08:29 -0500
Message-ID: <CAPig+cS-9gbxb3tWqaWtsjfiQR60GQXpfCKM7-neu6AH8rUvcA@mail.gmail.com>
Subject: Re: [RFC][GSoC][PATCH] t9160: Change test -(d | f) to test_path_is_*
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 3:05 AM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> Changes test -d and test -f commands in

s/Changes/Change/

> t/t9160-git-svn-preserve-empty-dirs.sh to test_path_is_dir and
> test_path_is_file respectively, which are helper functions defined in
> t/test-lib-functions.sh

This summarizes the changes made by the patch, but readers also want
to know _why_ the changes are being made; in fact, "why" is more
important. Previous patches similar to this one have explained that
test_path_is_dir() and test_path_is_file() are superior to `test -d`
and `test -f` because the functions provide diagnostic output when
they fail, and that diagnostic output can make it easier to debug a
failing tests. So, if you reroll the patch, focus on explaining the
benefits of the functions rather than explaining the mechanical
changes made by the patch.

> Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
>
> vinayakdsci (1):
>   Change test -(d | f) to corresponding test_path_*

As with the other GSoC patch you submitted[1], this one is also
missing the "---" line below your sign-off, which tells git-am where
the commit message ends. As mentioned in [2] you may need to adjust
your tools or workflow to prevent the "---" line from being stripped.

The actual changes made by the patch are probably reasonable (though I
don't have CVS libraries installed presently, so I wasn't able to
actually test the changes).

[1]: https://lore.kernel.org/git/20230209164552.8971-1-vinayakdev.sci@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cT1EtPO2FLvTsw3SjgCgk=ovNwY77hsX6p7ETKiq8aNog@mail.gmail.com/
