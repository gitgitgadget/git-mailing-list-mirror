Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCEC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiGRUMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGRUMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:12:50 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458A29C89
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:12:47 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10bffc214ffso26849856fac.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21I/us/nOf/954HX3RnlsxxFA/v+MAD1lSmFK9Vs7QI=;
        b=I2xdEBwn7kkZ9H0mewu+chu3+LCZtB7D0wGiK9MKsETxCJmpjXOcySbPlQFYBYIBr0
         h750GLt7+WrrON2oLLDqcoE08sx8bCwsx1i02+pfK+9lXK745IJ0cG68rCDc7xG4KGY9
         pP6oGWQ49yKDGD+k1QzIU4TScryCDFTa61cR67XTnlF2xWTi4PgHTOTvHnvopr8PuJ9f
         mtSJAcjQVFpRcq97jyYRaAlMgux6To7a9iHO1n++0DbQH6xFAUpWRfAYR/C/aTu+N9Iv
         NpAomVtibA5dMxqCkp0TAIk59XSlxuqbLUWYSNKQoyb4vxQjZJgejEqS6SI5wClpv/d2
         fjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21I/us/nOf/954HX3RnlsxxFA/v+MAD1lSmFK9Vs7QI=;
        b=LiWdyv0eYIaWCRsfQJVvtAiNHbiRwCh1bt2ftEKswMC8vUEhUgDmGG76F1uy2aQHOQ
         BrAgZiOUoISf4xZ6783FtiCbQRNQPdTdpZiYUurbLIk3umDRX+/fyqFZsKYtwcgWMC/Z
         Tvuwgo5WisU8YZSyK2JOzdgXSKgIHmaFpmnSKZ4JcfG5pCZcr56hxfB9k9WUBN3jGZ1L
         psp/b1YHXKrXkntIqJ6T5+hVmHJiY9Un/Ugt4WtL0SauCpDvma9g1K63/fX+JYizLiZr
         2+F81PWv5UIowdFWgxdDoFj7DaLVHsDY/M15QpTJWiYv4RedgzE9B5NHpGlcYvsDHWFw
         wl/Q==
X-Gm-Message-State: AJIora90lf3aCTOkJrsOdg7xTg1X2wa/qOtHo44YJxJF42ND5PkbbjHg
        buhEsXDqeqSSnNgT72BTbOy+kaxq78z30JV0Kq0=
X-Google-Smtp-Source: AGRyM1uyHjPE3C6sii7vfca3wsTbsoUS1bDxqWv8RywqoFR14gr5dT66wUv6EZcqvV52ya4meWRuqL+PTpTekNFcAco=
X-Received: by 2002:a05:6870:61ca:b0:10c:1358:4eaf with SMTP id
 b10-20020a05687061ca00b0010c13584eafmr18226384oah.111.1658175166861; Mon, 18
 Jul 2022 13:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
 <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com> <CA+X_a+zbG_CDP6D0zxozRoUmBeWm4dVxQ=xYRqFeWrk+FR5p0g@mail.gmail.com>
In-Reply-To: <CA+X_a+zbG_CDP6D0zxozRoUmBeWm4dVxQ=xYRqFeWrk+FR5p0g@mail.gmail.com>
From:   Sim Tov <smntov@gmail.com>
Date:   Mon, 18 Jul 2022 23:12:35 +0300
Message-ID: <CA+X_a+w-tDv+Qq7dnjSaFrFpYanwBbx77UGFpDinyeWUYQaB2w@mail.gmail.com>
Subject: Re: git: detect file creator
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thank you very much, again, for the very useful suggestions!
>
> > > 1. Do you have an idea how can I list all the files **created** (not
> > > authored / committed) by a user, so I can implement a fair characters
> > > counting?
> >
> > If you want to adapt your current script perhaps --diff-filter helps,
> > but...
>
> I added `--diff-filter=AR` to my original command like this:
>
> git log --use-mailmap --no-merges --diff-filter=AR
> --author="CertainEditor" --name-only --pretty=format:""
>
> and it seems to do the job! May I have missed/messed something here?

Now I see that if one editor renames(/moves) the files created by
another editor - the former gets credits on all the characters inside
those renamed files.
This is bad. And it seemingly stems from the fact that in
`--diff-filter=AR` means `A` OR `R`. Is there a way to do `A` OR (`A`
AND `R`), meaning if a file was
renamed then list it only if he also was created by that same author...
