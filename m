Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8BCC433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 10:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiFLKYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiFLKYj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 06:24:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B360A82
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 03:24:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i16so3343898ioa.6
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EMw7xSu/Ntkzjg2crI8i0zTTEq7p3hhj0wuifDMK6Ro=;
        b=ZpXwPwvN7ZDFvpsy6A1UGJ2UpQkhEl0Y5G6TSYwAJAl7YnrGjAsxDhiuV0Uec/hSi+
         p4nhSDTubzYrYWy/ZXHd8ZUhNvqeM3RmbQAvVwWi8okdwI+XS6H0s/YDxwShzNfiEYCu
         sTqLsdZsSj2UrMbYlQ9cqD+qnhjRNM/Ya3zGR9d+dKixTG1uQ/Wwhlc2IVQB/lDu0/vP
         GWbpGCUhjxAphw9tWZcOCi7/7QIst15YySqSvpsdMyoOj/kfkF2tvpacEP0ynu+p9HdT
         MdkkQjgfIS3q4o7gqHoIR1CgiADGdYy46Tl1p6qgwsr2f3wI0LfKqpQUswDMttguIpEv
         ljPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EMw7xSu/Ntkzjg2crI8i0zTTEq7p3hhj0wuifDMK6Ro=;
        b=tAN4uuLfUw8HE05dexc5YKMrzZdcuCXTuVpgDUdw4WFpkkJcfTqiv4KaBr5rLajEDi
         0QIOn/OMH9hl4d6WfqE8tEPPsWN7nfnHXRU4Jaxj+TQqXpsJWb+K6D1Cp4d7nAKnmB0h
         vYPRrD4hj3OB/ExDZyHmfYmqdQ6L8llYWi6uvOti3yK7HktEpeFLAJMQJqulRQn1Xx3i
         zH7qCaFQekMsR5WZblzN7JJRUfGKFNN/XmCssaUVRZrWl2m/aBauKeHe/l6KpbT731Na
         ogO7RW/IFLlMSJH0Vn0sjVL8pHj2MJa+SlUy+UYt6Ac2Rwly0NK+NYb9u+IBaXWacIpr
         pXjw==
X-Gm-Message-State: AOAM533cxKcnWcxUxFJwalnlGiEVVXfYlHm8etLO9XU6OGc1naT/RYvV
        9opbMi9YJCWTy5hK8C3C8atRmhor47/BP1U6mYQ=
X-Google-Smtp-Source: ABdhPJxM1gggSIJ+TZkz8FIUXEoqYLxHXDh8H9rEYNSjdh3pFqiyHIbaeu3IhW4YFDFudmWRsW+BxB7N5CBa5nFRmo0=
X-Received: by 2002:a05:6638:1117:b0:331:4bc8:3856 with SMTP id
 n23-20020a056638111700b003314bc83856mr27400484jal.128.1655029476937; Sun, 12
 Jun 2022 03:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
 <pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com> <xmqq35gdk44i.fsf@gitster.g>
In-Reply-To: <xmqq35gdk44i.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 12 Jun 2022 18:24:26 +0800
Message-ID: <CAOLTT8SNOYYVmk3fvEc=Vp9MuRp+1H--wh72rP=ORRtffonUfQ@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files.c: add --object-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=94 03:51=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>

> I read these two lines to mean "git ls-files -s --object-only" does
> not even give me the stage information, but that would make the
> command completely useless, so I am assuming that is not what you
> meant to say.  The same comment applies for resolve-undo, which is
> merely "what 'ls-files -s' may have given before you resolved".
>
> If you borrowed a feature from another existing command, say that
> explicitly, which will allow your commit to gain confidence by
> reviewers and future readers by showing that you care about overall
> consistency in the system.
>
>         Add a new option `--object-only` that omits the mode and
>         filename from the output, taking inspiration from the option
>         with the same name in the `git ls-tree` command.
>
> or something like that, perhaps.
>

Yes, this message will be better. I think it omits not only mode,
filename, but also tag, stage, eol info, debug message.

> How does/should this interact with the `--deduplicate` option?
>
> If we are not giving stages and truly giving only object names
> (which I doubt is what we want, by the way), then we can and should
> deduplicate the output when the option is given.  If we have two
> identical blobs at different paths, or two identical blobs at the
> same path but at different stages, shouldn't we get only a single
> copy of output for that blob, as we are not showing paths nor
> stages, right?
>

I have think about it for a long time, I think deduplicate is used for
removing duplicates entries which caused by one path can have
different stage.

But we now care about a output format just like %(objectname), if we
need to deduplicate it, when we use --format=3D"%(objectname) %(path)" late=
r,
do we need to deduplicate its output too? I think we should disable
--deduplicate
when we are using --object-only.

> How does/should this behave when --stage is not given?
>
> I have a suspicion that this whole thing is misdesigned.  Instead of
> making it piggy back on --stage, don't you want to make it an
> independent option?  I.e.
>
>         git ls-files --object-only
>
> with no other option would behave like
>
>         git ls-files -s | sed -e 's/^[0-6]* \([0-9a-f]*\) .*/\1/'
>
> and it is an error to combine it with -s or --deduplicate.  If the
> purpose is to learn the set of objects registered in the index, then
> it might even make sense to make it an equivalent to
>
>         git ls-files -s |
>         sed -e 's/^[0-6]* \([0-9a-f]*\) .*/\1/' |
>         sort -u
>
> as duplicates or order of the entries is no use for such a use
> case.
>
> It entirely depends on WHY you want to find object names, and that
> is why I asked it much earlier in this message.
>

My origin requirement is to do a app which can move one file to another
file in a bare git-repo, so I need to get first file object-name for
second file to
update-index. It can parsed by the app of course, but I think such kind of =
work
left to git itself can help other app programers.

Maybe you are right that --object-only or --format should not be
sub-option of --stage
or --resolve-undo, I will think about how to implement it later.

> And I do not think it makes any sense to give resolve-undo
> information without paths nor stages at all.  Please do not tie this
> with that mode.
>
> In short
>
>  - this probably is better done as a separate independent mode
>    "--object-only", rather than a piggy-back feature on top of
>     existing other features like "-s" and "--resolve-undo".
>
>  - the new mode should be made mutually incompatible with "-s" and
>    "--resolve-undo".  There may be other options that this should be
>    incompatible, like "--tag" and "--full-name".
>

By the way, if we need --format for git ls-files, which atoms should we kee=
p?

I think those atoms are undoubtedly necessary to keep

%(tag)
%(objectmode)
%(objectname)
%(stage)
%(path)

git ls-files --stage just like

git ls-file --format=3D"%(tag)%(obejctmode) %(objectname) %(stage)\t%(path)=
"

but for these follow atoms, I am not sure if we need them?

%(eofinfo)
%(debug)
%(eol)
%(ctime)
%(ctime:sec)
%(ctime:nsec)
%(mtime)
%(mtime:sec)
%(mtime:nsec)
%(dev)
%(ino)
%(uid)
%(gid)
%(size)
%(flags)

Thanks
