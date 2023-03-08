Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4AFC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCHWFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCHWFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:05:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9CB5B5E6
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:05:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso2323522wmq.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678313103;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWFvDdlSGZyEoiKf/1w1hxYYP2r+OuiX3xGCECKOEBU=;
        b=dl94jnHPWeZT66ofXofsJ1HH85eeilK3AyOLT0mqNhBQaiFasrTOX0kR+1OiNw9ujf
         wf3IpNf9flc7LfGNcVAi4lqySFEYA/3k0lQX1Iun+9K820xVutdJ9fv/CjK9rEmhwzWp
         0526zaDBya4CpGugPe5Tdp9oiE+7aKkoII/yz3h6cYr6jrlodTO6wiSLIh8azOhlZvMF
         n8F1BiNYOHkSLYJBWZBFp+Ue1LMnLtioL3uDKiue/I4ygQ1JsYjFowZucD5wfBtBhmSk
         LqaP0h9pDZqWKNV6e+rFr99SDLv9LPwQQLXhvZsiL/szBJ1BHN+Y3UInNC97qd21Msjn
         QOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313103;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWFvDdlSGZyEoiKf/1w1hxYYP2r+OuiX3xGCECKOEBU=;
        b=C5EJxFeb3dA+ajwrxPvpmLNAwf1A+ooN0Y+mCyT4Ppx9xH/7Q25kJyx2D/vdkAluah
         8gAl12YnA4TtO4Nbt9J/S0ltkuxK94JBYyTA5IQUe1rePPVwZ2CNj1OQspdmwe5XirSp
         TT2KD+nFG58waQVtgqoFiBqZWlM9k3u/V+mZUTkEMDUsOsUT5dU445coT/LVueTYkylX
         UuZZBVIfvgHU2OqzYDSSO3ZosV6S2kDzVjaNhapY00uVrLEnHX6sEDlk5dq/6V3Ljn4g
         mDwPh2iBqbrwUyGx6bCPPRKqttaAnuVjlsYtofyMOvHB9t1UbxmKo7HOfIiyl4eDuTUm
         RSQw==
X-Gm-Message-State: AO0yUKU+rkXD0RzlG9w2fTiZ0IMP0n1hKjLIFmSI/npjOX5zDCitkYCR
        2xdsXCZlWv+viCgq8A866+aIMb5pWj54siFYPVo=
X-Google-Smtp-Source: AK7set8H5WFyCymzDEGUQklucLuNxbmRubdtn/H0PKV5LsBkxaDn2GPq8CSVR8Vue2CMUdQE+5vf+4UL/fx1wf4labM=
X-Received: by 2002:a05:600c:a3a2:b0:3eb:246d:7ee6 with SMTP id
 hn34-20020a05600ca3a200b003eb246d7ee6mr4527540wmb.3.1678313103412; Wed, 08
 Mar 2023 14:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20230304025740.107830-1-cheskaqiqi@gmail.com> <20230307065813.77059-1-cheskaqiqi@gmail.com>
 <20230307065813.77059-2-cheskaqiqi@gmail.com> <xmqqy1o8xuis.fsf@gitster.g>
In-Reply-To: <xmqqy1o8xuis.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Wed, 8 Mar 2023 17:04:52 -0500
Message-ID: <CAMO4yUHEDtZfu+NgsWNjckxAun9kU+8GoyB_poWT8Lam095Wtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t1092: add tests for `git diff-files`
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Tue, Mar 7, 2023 at 1:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> (Documentation/CodingGuidelines)
>
>  - Redirection operators should be written with space before, but no
>    space after them.  In other words, write 'echo test >"$file"'
>    instead of 'echo test> $file' or 'echo test > $file'.  Note that
>    even though it is not required by POSIX to double-quote the
>    redirection target in a variable (as shown above), our code does so
>    because some versions of bash issue a warning without the quotes.


Thanks for the styling reminders! I should go back and reread CodingGuideli=
nes
more often.


> > +     #add file to the index but outside of cone
>
> Can you have a SP after "#" here to make it more readable?

Will do!


> We create a new directory that is outside the cone, with or without
> using the sparse-index feature.  We know we are violating the cone,
> and have to override the safety with the "--sparse" option.  OK.
>
> What output do we expect out of "git add" to match in the two cases?
>
> > +     #file present on-disk without modifications
> > +     test_sparse_match git diff-files &&
> > +     test_sparse_match git diff-files newdirectory/testfile &&
>
> As "diff-files" is about comparing between the index and the working
> tree, the new path should not appear in the output when the sparse
> checkout feature with or without the sparse-index feature is NOT in
> use.  Does the picture get different when we are sparse?  IOW, would
> we notice that we now have newdirectory/testfile that is supposed to
> be missing in the index and show that in the output?

I'm a bit caught up here.
Do you mean I need to add a test for "git add" also?

when we use "git add" instead of "git add --sparse ", we will get different=
.
Cause newdirectory/testfile is missing in the index so diff-files will not
work in these cases.


> In a non-sparse repository whose HEAD commit does not have
> 'testfile' (e.g. "git" source tree), I get
>
>     $ git diff-files --find-object=3DHEAD:testfile
>     error: unable to resolve 'HEAD:testfile'
>
> without sparse checkout or sparse index.  It is unclear what value
> we get out of having this test here.

Thanks for pointing out the error. HEAD:testfile is useless for the test he=
re.

-----------------------------------
Thanks
Shuqi
