Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA6C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBHNuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 08:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjBHNuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 08:50:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB45358F
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 05:50:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f34so27108916lfv.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9S7tvARXNA4k0HA9JAIQ4GJ4WZKP88rvZBgl/HH8Ew0=;
        b=WUlPg9nm5+i1plauyx9SNqpNY/JgZDU8AjL4WJmZnvVKi52BGasY/UNDus8EpI1dfZ
         SICES53910YhH4dY9u0lNc/dQ+j64sDgc7BE7+nJP4JLziOJiYsGOrDlS1eC6bC10Yqi
         +JyHZpjXKU13TN18OimRowFEr9xjny/42Z1YZ6lPKisSZws1Zy3SGHoMpQHh7xpn+Yq3
         O7MIaLEAK+QxQnFAuxsx/sCZCisX1DhVsbvXeFIvC+NfhT3k4FXUvZFezmj0o0+FH7+F
         G+6lryehRW19hUwpXoxDjeYhOjGLpIU7SAuA/1TFTPpR5iz3u+JqRt5uvO2qZSm1RpkW
         Whjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S7tvARXNA4k0HA9JAIQ4GJ4WZKP88rvZBgl/HH8Ew0=;
        b=QziGCPA/c0Wxnm6YTnnZmhwlX7JhCRgmml+ZIxg/kmqJQmPnvT/jsiEvBpXF6RbHkS
         ueTEglmjaYIli4Z2SXneWIzE1hEDHZKVK9QWoamY0VPXqAHMBrId//xdZD0T2WEtVwCO
         uMcQA2b8Cyqs7u8wJUsm/3SNAjQKFS1aMFasyJtlzY8gRBQA5iR4bPHQaBK6ZMUuQzW8
         Hd8c+66mzz4Ty0X60V7kma+gX8XWX47HpIatTGY/x4JVhMW/IDdgtdaG2Ni2lBOveeYs
         D5/7mmcXhJM6roF21hW/oIjdWKJ/gHqYpNcwPQv2PlnuninoxuEnWHVw4lo88ezJkSTN
         pTOg==
X-Gm-Message-State: AO0yUKVEL5iXlgsvE9zvVvHoGUDtheKyKOWcT7mMx5ewiw0PJjYuKOIX
        dP2ajZH+qJi+gSAl037qKvquMIRXbDtsHPncf/AogbVW
X-Google-Smtp-Source: AK7set/Ztdmol3ryvASjdRvNU69JLT8Yor30JdyV5UA7+/F4KjwTTwEB/Kg3N7JHcRkEP0QT06lemXixtZBQoqjkrGU=
X-Received: by 2002:a05:6512:924:b0:4d8:20fa:51c9 with SMTP id
 f4-20020a056512092400b004d820fa51c9mr1737759lft.59.1675864209455; Wed, 08 Feb
 2023 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
 <xmqqedr0vd1l.fsf@gitster.g>
In-Reply-To: <xmqqedr0vd1l.fsf@gitster.g>
From:   William Blevins <wblevins001@gmail.com>
Date:   Wed, 8 Feb 2023 08:49:57 -0500
Message-ID: <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This still feels "weird" to me. Other pattern matching tools like grep
and sed don't have exceptions to their behavior like this.

Can you reference the unit tests that verifies this specific behavior?

On Wed, Feb 8, 2023 at 2:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> William Blevins <wblevins001@gmail.com> writes:
>
> > What is totally unexpected.... is the most simple search for ABC-1...
> > ```
> > $ git ls-remote --heads git@github.com:owner/repo.git ABC-1
> > <ref>    refs/head/ABC-1
> > <ref>    refs/head/feature/ABC-1
> > ```
>
> Sorry, but I cannot see what is surprising about the above.  If you
> have these branches locally, you should also see these refs in the
> output of "git show-ref ABC-1".  Refname hierarchies work just like
> pathnames with directories, and without glob in the pattern, tail
> matching that honors path component boundary is very much the norm
> in the oldest part of Git, i.e. ABC-1 matches refs/heads/ABC-1 but
> not refs/heads/XABC-1.
