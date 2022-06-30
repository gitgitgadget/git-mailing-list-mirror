Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1599C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 00:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiF3AHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiF3AHb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 20:07:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919D2983A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:07:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd6so24344667edb.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uG6WDyQFFXbhxSUTXHgSydR3jHJn/UvZZQFIpWMhyUM=;
        b=TR3dm6M/Xvzl4SpqD5QX2XJIMg8gTytwUv5wWG7ZcH4VpkU0XhXcZm2xEqFadN75KA
         bkiqDt3WZefvFoFbTKWt3DAQRA3VExGJiq8IruioWegWj8EaKYenOAC1WMS3yj/8fwBX
         y40/UbrmYg4ryryXXfQZcadKTF/VM8rBsaArjSoXXEFoDHxHZAf30A6yP4WsNrWeAYjE
         Nao5KC9eOi4cqxkgrX6SEiJKD76/wA5RjrBuuIstisA2+x3oKaX3325b1LYYtJUo2Xq7
         wJvJHiIJA6sGT8XLr3w2GEgGEpeDuFAt/nCoeVlbR4wM9lVqNLrIn8ND1jA190u49z84
         oX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uG6WDyQFFXbhxSUTXHgSydR3jHJn/UvZZQFIpWMhyUM=;
        b=I8zv+fj4n1H/vHyD67gFi2HtkXOesuV2iZswXqaVqxSE/HpsupMb796r4Y858RfKCW
         WZa0zEVc7s0adXXTXSrVdZc3wVFyWu75WbopJkSxeVpBLupyvGTA9ANCaK1QBPsnorUK
         zh7JlITTaQRgcfgL+I2zUs2kxquVv9LTGZbus5+2SeRg4NDSfYEPc0WMj59+GIlF5kEN
         KiGg/feocE3VqeGi2eLryLR/Qxs7xzJKT/xWTwuG0wfIt/t97slOIASEiejSiwgo02pd
         +wXeSAehKsQe+Vfrvlfaz5BAXiaAu65VvUOWVC4kjsr4xUfyuf1poLvFWbLgP39/6FQX
         AHHA==
X-Gm-Message-State: AJIora8qZxUzYZjVPwGCTpYokLV3/37ZRx5KygVu/sNTZxwGvpkRZxar
        4LokdajrICK9kRIjnf7MkwxfTc0RsOgBze/dbOQ=
X-Google-Smtp-Source: AGRyM1v44tCggaFct4gcJgZk2lda7eldK/lv84y4wkFFqpWe926It7WPn2H4l7YaFnH5PCf9uRAI9rL4x8suVNPpajA=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr7609588ede.323.1656547649507; Wed, 29
 Jun 2022 17:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <69d6204184363e491acb68f744ded0991be63a47.1655871652.git.gitgitgadget@gmail.com>
 <20220627223017.2852209-1-calvinwan@google.com>
In-Reply-To: <20220627223017.2852209-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 17:07:18 -0700
Message-ID: <CABPp-BFphDUrxnW0tC0yNZkHPgwSEtxod2Q4UMVjE3beaA0=dA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 3:30 PM Calvin Wan <calvinwan@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +# Testcase 12l, Both sides rename a directory into the other side, both add
> > +#   a file with after directory renames are the same filename
> > +#   Commit O: sub1/file,                 sub2/other
> > +#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
> > +#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
> > +#
> > +#   In words:
> > +#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
> > +#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
> > +#
> > +#   Expected: sub3/{file, newfile, sub2/other}
> > +#             CONFLICT (add/add): sub3/sub2/new_add_add_file
>
> Grammatically, I could not understand
>
> "both add a file with after directory renames are the same filename"

Oops, that should be "with" -> "which".

> I also found the same issue with `Expected` that Jonathan mentions. I ran the
> command separately and got
>
> CONFLICT (add/add): Merge conflict in sub1/sub2/new_add_add_file

Yeah, repeatedly revising stuff is fine as long as you remember to
update all the parts.  (I was swapping which directories were named
"sub1", "sub2" and "sub3" to see if lexicographic ordering might be
related to why this simpler test triggered a bug in the "recursive"
strategy but Glen's bigger testcase didn't.).  Anyway, I just missed
updating one of the locations while doing that revision; sorry about
that.  Will fix.
