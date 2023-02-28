Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8BC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjB1SKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1SKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:10:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8D32E73
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:10:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g3so1837959wri.6
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677607832;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDYYIkfE0TUcAfUzOolwAbyfFANanb9wsDL7WvRqDWw=;
        b=UnW2Lq72/+ng7z2+3Ktop6GfYA4cdim2NzdIumcR2aWq2abOlnV4yvvuuMtuRtNCmC
         +baNTFc4dTAckXOUdfvCMDNEhFqjnOK3nqZ3TLnnXT8NYE0S9WA5O2/dO1zR/oFcBL7W
         eQsw+KuazdcJP24RtnOnXFaTgOBIw5xjeVjJN50x6dAZylwkkD1H/1gFeAq0/idpIBi8
         qwCFtrRv/k7wJPhMfnes2BRco644BJX5tyHd400kCwab7zYMz8MbIq2L3mFknJEHrsNb
         4fQ6ROP6gjhEgE0GqL+jdg1B4zNnoBVNSsuqwHyHPWbUOqJGQLbzXWUZbfG3w+K4Crjf
         Hogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677607832;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDYYIkfE0TUcAfUzOolwAbyfFANanb9wsDL7WvRqDWw=;
        b=L9UxFirs+CB3PnCdyaekrHvXXtklXg946gb40En7hyltFE6crnzEkdSXCzJfl5D+WZ
         150i6X7B24ESAuh8GVcRO3FmMxOXhGCwwxZDTEUE6Q3TkS3DxQ5dXaAsNw251GBLDtLU
         pxJn1vPiwoLjo3XYO73zQS5s4dzOHDhx3y210CREZpGaCQX7ub32RDew9/Rr2JPvo7tK
         T2GFQrFqC8WVhN1nML4XnUhq+0DZNq2VOvQOSFOWzJSrddRvzFVds0zUqOFsHuOKG5nS
         CqgIK0jhpDsyuRXf+2B5VeMi6g3ZFh+3TCetU/hnsa0cfYpqdmW40bKr5po+Pel2Qokz
         Jrnw==
X-Gm-Message-State: AO0yUKVh+wh/niP/oaJhk4iXwqDrwALFhxWWNzFv+8Z8dnBLDNXnuRBW
        V33upWhCiKVyss2ytVtzD7Ocb4PP07i5ouSLKSg=
X-Google-Smtp-Source: AK7set8q4fI1jaqEfPcWTHTif9ujafZKtAHKRb5BUvgkjzHteh6acKuJTvzKBSE71fhDzheUyKvGy30aJdDzguDAJgQ=
X-Received: by 2002:a5d:4561:0:b0:2c5:7f20:ce9b with SMTP id
 a1-20020a5d4561000000b002c57f20ce9bmr659059wrc.6.1677607831638; Tue, 28 Feb
 2023 10:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230227050543.218294-1-cheskaqiqi@gmail.com> <20230227050543.218294-2-cheskaqiqi@gmail.com>
 <315e70e0-ac1f-2f19-f1cc-6b8b24ffb1fc@github.com> <cd7b9a2f-4f52-9da8-19c3-2c5cda7b8160@github.com>
In-Reply-To: <cd7b9a2f-4f52-9da8-19c3-2c5cda7b8160@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 28 Feb 2023 13:10:19 -0500
Message-ID: <CAMO4yUF4Z1R_eQJw2AW825DjSjVH5W=u3wn0PYdQt27rN2-XPg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] check-attr: integrate with sparse-index
To:     Derrick Stolee <derrickstolee@github.com>, vdye@github.com,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi  Victoria, Hi  Derrick

Thanks a lot for your valuable feedback!  They are really helpful!

These two days are very busy for me for preparing the midterm. After
1st  March, I'll start to address them in the next roll or start to
Investigation around 'git diff-files=E2=80=98  as soon as possible .



--=20
Thanks & Regards,
Shuqi

On Mon, Feb 27, 2023 at 12:57=E2=80=AFPM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 2/27/2023 12:18 PM, Victoria Dye wrote:
> > Shuqi Liang wrote:
>
> >> +    prepare_repo_settings(the_repository);
> >> +    the_repository->settings.command_requires_full_index =3D 0;
> >
> > The test below doesn't do anything special related to the sparse index,=
 so
> > this change is unnecessary (and, as far as I can tell, will break in so=
me
> > usage of 'git check-attr'). If you're only looking for feedback on test=
ing,
> > it'd better to leave this out.
>
> This change is part of the performance improvements given by sparse index=
,
> but the correctness test you've added only ensures that the end result is
> correct, not fast.
>
> It's possible that even with this change we hit an ensure_full_index() ca=
ll
> somewhere in the call stack. To test that the sparse-index stays sparse
> throughout the process lifetime (when possible) create a test that uses t=
he
> ensure_not_expanded helper. There are several examples in t1092 to use as
> a starting point.
>
> Victoria is right that it is helpful to first establish test coverage of
> the builtin for correctness reasons before making this change. It helps t=
o
> add tests for cases that would require expanding the sparse index, such a=
s
> checking the attributes for paths outside of the sparse-checkout cone.
>
> Once the correctness tests are in place, you can then make this change to
> the builtin and add the tests that check ensure_not_expanded, since the
> change at that point is _only_ that we are allowing the builtin to
> operate upon the sparse index without expanding it immediately after read=
.
>
> A good example of this "final step" is [1], which updates the builtin for
> 'git diff' as well as adding _only_ the ensure_not_expanded tests.
>
> [1] https://lore.kernel.org/git/897611682af64ba6bd0d2dfcfeae56cfe953c45e.=
1638806161.git.gitgitgadget@gmail.com/
>     [PATCH v6 6/7] diff: enable and test the sparse index
>
> You can look at the surrounding patches for other ideas, but it should be
> noted that both 'git diff' and 'git blame' in that series had previous
> correctness tests in t1092 that only needed _edits_, instead of being
> created from scratch.
>
> Thanks,
> -Stolee
