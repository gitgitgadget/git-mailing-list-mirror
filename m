Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808CAEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFUUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUUCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:02:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1981712
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:02:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so7488345a12.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687377755; x=1689969755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C6pTk7bC80qxVWh6KsC9DENi8PPTQ4gJlN7ff+LmFU=;
        b=N96xOuC+X2kZYUaE4mK2iDMmBDdM5kiq29FDDBuYJf7h5KY8jCL5klOLfkiedj4zKs
         qO8LcrW990TtNmJk6+NCeRcCrKGKS7aX8sBLh9s+Cq8eJHsxhaMoVLfw4WeMbd7CyEaw
         GyJ7PAXbQjqOZDogBaMN9vG34fld+/8y19Z21GUe0iffwp4Y+uvLQXAAe2VGeVwL63X4
         sFLjb60+jE2MqAyaHB3nK7NoJZ1LsOqNwer/rJW4NuYAqn26ngK3AvDNeqctutlBNt1Z
         Z1e8jn5gpvtVcPxFVB4lq5RVt62E3GCEmr1QLLQ+R6K0hbJS2oAMfykxLEm1loR/aIAH
         hJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377755; x=1689969755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+C6pTk7bC80qxVWh6KsC9DENi8PPTQ4gJlN7ff+LmFU=;
        b=I2bxUZk0HFyvy+GpfggQGmlDsx/a1emCTMzwmXf3TvREfL5M1Fp3MDAcZ65vqDZnGc
         S9tt/tS0pJ3l98nw7Mb19ery6HGJCc3u1s5/CPdiQSfqdp2u1mpf4s93FqT+YTVvqv4B
         GPDKQKLIVr8Wonmb14FGvuBBamGBcuEdHpIZ+C671qSSnTgMkqViw5z4/+yM67EdMGAi
         hljS7MYstWGhSKthCwLtw5I+6KvqaYBwRlecYXQZdrjuFF4UdTauSghyyh9lO0yn9ob3
         d8kLA2R5OarUnG3fIjAUuxZSYWn0fQ5SLmnzNF6cwPzAJ37FnLn/Usgs9K9Dvn7rFZJd
         FhvA==
X-Gm-Message-State: AC+VfDw0SGGjgUurSgfqq+PQ6+LOzdXirZ7zMk8elvLBTSjteQ9YdM6S
        KG1qzKHe/T/zP3vGyGEcRfkT8LkOENxGNp59ct2RyhmU
X-Google-Smtp-Source: ACHHUZ5qq1P+om7TnB/MFTYOSMzmy8Y70DDEa/nSzLsY/Rbece+dq6F4kYteNVjnwYk3DSSetaAsyn8Ln/a6ni8GQl4=
X-Received: by 2002:a50:ef03:0:b0:51a:453b:a49a with SMTP id
 m3-20020a50ef03000000b0051a453ba49amr8257176eds.33.1687377754497; Wed, 21 Jun
 2023 13:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
 <20230621081754.GA803861@coredump.intra.peff.net> <xmqqzg4siyru.fsf@gitster.g>
 <CA++DQUkVzz8Zn0x6BR+sAEo_LXFR67Z+JOgMhcY2JpS5UGi4rw@mail.gmail.com> <xmqq352kha1l.fsf@gitster.g>
In-Reply-To: <xmqq352kha1l.fsf@gitster.g>
From:   =?UTF-8?Q?Guido_Mart=C3=ADnez?= <mtzguido@gmail.com>
Date:   Wed, 21 Jun 2023 13:02:21 -0700
Message-ID: <CA++DQU=5fSHcOssVD-qCiX_kpRh-Pa3TeSRMwRggLDWTK0j_XQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add an --exclude-links option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Guido_Mart=C3=ADnez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 12:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Guido Mart=C3=ADnez <mtzguido@gmail.com> writes:
>
> > So would it make sense to
> > 1- Add the file type filter to ls-files
>
> I think it definitely makes sense to extend the filtering criteria
> supported by ls-files beyond what we currently support (i.e.
> pathspec).
>
> I also wonder if "file type filter" could just be implemented as the
> magic pathspec.  For example, we can already use the magic pathspec
> 'attr' (read on "pathspec" in "git help glossary") this way:
>
>     $ git ls-files ":(attr:eol=3Dcrlf)"
>
> to list only those files for which the 'eol' attribute is set to
> 'crlf' (i.e. they must be checked out for DOS no matter what your
> platform actually is).  That is even more flexible than the
> hardcoded "is it a regular file?  is it a symlink?  is it a
> submodule" file types.  And the magic pathspec is understood not
> everywhere but by git subcommands other than "ls-files".
>
> We can either invent a new pathspec magic "filetype" and express
> them this way,
>
>     $ git ls-files ":(filetype:regular)"        # 100644 and 100755
>     $ git ls-files ":(filetype:symbolic-link)"  # 120000
>     $ git ls-files ":(filetype:submodule)"      # 160000
>
> or we invent a magic attribute "filetype" that is automatically
> given to every path, and express the above more like so:
>
>     $ git ls-files ":(attr:filetype=3Dregular)"        # 100644 and 10075=
5
>     $ git ls-files ":(attr:filetype=3Dsymbolic-link)"  # 120000
>     $ git ls-files ":(attr:filetype=3Dsubmodule)"      # 160000
>
> may be even better, as there are git subcommands other than ls-files
> that supports magic pathspec.  For example, it might be even useful
> to do something like
>
>     $ git diff v1.0 v2.0 -- ":(attr:filetype=3Dexecutable)"
>
> instead of saying
>
>     $ git diff v1.0 v2.0 -- \*.sh \*.perl \*.py \*.bat
>
> So, yeah, whether it is done via the magic pathspec or "ls-files"
> specific option, teaching "ls-files" to support more filtering
> criteria would make sense.
Thanks, I was totally unaware of this magic pathspec, I'll see what it
takes to add attr:filetype.

> > 2- Use that to implement a proper git-do-for-paths script/binary,
> > which can take pathspecs, filetype filters, -n, -P, and maybe more
> > ?
>
> The primary obstacle was you'd need a custom perl script to filter
> "ls-files -z" output, but once that need is gone, I actually do not
> think it buys us a lot to have such a wrapper.  Treat the improved
> ls-files as what it is, i.e. a plumbing command that can be used as
> a building block of your workflow, and piping its output to xargs
> would just be fine.
Yup, totally fine by me. I'll just keep that script locally then.

Thanks again,
Guido

>
> Thanks.
