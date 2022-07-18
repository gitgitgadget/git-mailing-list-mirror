Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78152C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiGRUkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiGRUkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:40:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070D632449
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:40:16 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10c0119dd16so27033849fac.6
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjbO9Y06QIPruHeFGvBJp6z57X6wN3nd4Y3w5ClOuZM=;
        b=IztgpJGb90xgEexghMB/Al6PqN+HsGYGTrJ9S/tDGUBLo64mz4sY+lozfsRt4MXh97
         vkKM1yL8kp45UvF88VVZva/1Osd04T4s8EShuXhghwnKzMMhMj2LEHonJOz1xl0NjzXO
         csXPOHpIiRsD/D4ud6Bdlc7AVLqcTbkfjwePuXs9RGmTYMen3itQoAkB2THYRP4R55QJ
         4lvuRhBYBjHNMWfCK6UWTvqt4fGhx1Xsd6jCsRTRMV4x/ztE68/n1nCRwGdxeAFDBc9R
         XbFzHyLPH8I0Ks/X2KDeYonj9OS8CkOKxieg8LWn2egOwbRW3sRQ1gZ/ShP1Nl4HC5H7
         1NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjbO9Y06QIPruHeFGvBJp6z57X6wN3nd4Y3w5ClOuZM=;
        b=AVSmnQ9woQQ14yYuike0M3Dv6EWAukFIIguKZWi9hXfW730Qo8Aa+Ggv4OGNRkZWgm
         sjzPXKmOKnDPKMBjwejh38JvRT/jxZ7kN+YOeUzLntfgIFgf2sBCn6yLD3ruBhOXRewL
         yYUobVeBciuVA/NbEc6jIT0eWg2Pv/zB/XeEF+zd3VfjyXl7ejx6IiHTFQfLxFPdRfo6
         36VqHG1p8zOZtzYC2PKznprkX1ULXmfnJxB5Z9oV0qBadghjryOPHNKtGl4W0SHiSXCk
         9L6a3w2uhBVd/lllh57ww4pWVaoCOBzZyve+OYa/VoAFRgnIZSuTYIPWPjqW6xkKOJ8X
         ctOQ==
X-Gm-Message-State: AJIora+sOu7K38XbVLoBTNFwdSQsNgKYZRONzikbpYf0Ms7FSbb3QiwP
        qbprzKSjCokB5M5VaKGjb80i92ID4aZ9NePcvKQ1ltuVTkQ=
X-Google-Smtp-Source: AGRyM1vlNWMSiTVAGdqRak+qEsqfU/kpmRHpEa8VFywFaWI22wSCpti9P8UZ7+oe3FjvRgtgPMbbpU0WNWrRyH/WWgA=
X-Received: by 2002:a05:6870:61ca:b0:10c:1358:4eaf with SMTP id
 b10-20020a05687061ca00b0010c13584eafmr18278185oah.111.1658176815084; Mon, 18
 Jul 2022 13:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
 <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com> <CA+X_a+zbG_CDP6D0zxozRoUmBeWm4dVxQ=xYRqFeWrk+FR5p0g@mail.gmail.com>
 <CA+X_a+w-tDv+Qq7dnjSaFrFpYanwBbx77UGFpDinyeWUYQaB2w@mail.gmail.com>
In-Reply-To: <CA+X_a+w-tDv+Qq7dnjSaFrFpYanwBbx77UGFpDinyeWUYQaB2w@mail.gmail.com>
From:   Sim Tov <smntov@gmail.com>
Date:   Mon, 18 Jul 2022 23:40:04 +0300
Message-ID: <CA+X_a+zd52cB2h9txxxUeNV0t5s4-ARj+ApDb2+q=MYrY4-dwg@mail.gmail.com>
Subject: Re: git: detect file creator
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Thank you very much, again, for the very useful suggestions!
> >
> > > > 1. Do you have an idea how can I list all the files **created** (not
> > > > authored / committed) by a user, so I can implement a fair characters
> > > > counting?
> > >
> > > If you want to adapt your current script perhaps --diff-filter helps,
> > > but...
> >
> > I added `--diff-filter=AR` to my original command like this:
> >
> > git log --use-mailmap --no-merges --diff-filter=AR
> > --author="CertainEditor" --name-only --pretty=format:""
> >
> > and it seems to do the job! May I have missed/messed something here?
>
> Now I see that if one editor renames(/moves) the files created by
> another editor - the former gets credits on all the characters inside
> those renamed files.
> This is bad. And it seemingly stems from the fact that in
> `--diff-filter=AR` means `A` OR `R`. Is there a way to do `A` OR (`A`
> AND `R`), meaning if a file was
> renamed then list it only if he also was created by that same author...

PS: the only way I see to approach it is to create a mechanism that
will prevent renaming
files by anyone except for the file creator (the one who Added file).
Can such a commit hook be created? If yes - how?
