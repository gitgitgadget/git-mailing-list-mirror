Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5280DC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCFTB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCFTBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 14:01:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4FD6C6A5
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 11:01:01 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id n18so9210236ybm.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678129260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvz1GJXChuQU/Snt58WSvkxiApjPxdUF4klHUbFygww=;
        b=SuRJ26ND+Z8SWL22Hu153PzSfqbv9qja3sLLAbjEtTQ1THBi/hERx3qxJLtTyELzyN
         z8Z3s2J0KzgdiilPpmywszba7pJRKV54vYjQWqVvKMhWsvW5fbI9N6tcoHbyIA+nBZwG
         bQyrIJd//OZfpfP1PqV1Tl1SBIteewJzn4V/DMXCBOJh8vKNQ+awZIuQDwOHOBtyT+8N
         wkcaNjQtE+MtwUTyr31Sr7XYtwuciZ7b7DfWswNOxn61whj91bpktWvdDl2X3kiSdt4s
         L6rFtfc8wN4v/jnv6dloc9fXE6DdRzRYq7Q+axUiRSXAsG293deRdv/dsI1q5Vh/IQE9
         VKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678129260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvz1GJXChuQU/Snt58WSvkxiApjPxdUF4klHUbFygww=;
        b=HnQo5cXj83oyzBv0htQGTt3ny0I8HyfjcmvIDvUr2eWMY1ydqFUGAj5dOikX3N3Q8L
         +ektwvxbznKVn1huuiIfknQO8XOcpOct3LooIfUZe5j7QK+EzcJ4zcwHiaUlBlTZUqok
         tWgWkdM0NsAp8QAR4z36wdXyEw+zfsZQldV5dLwLEIZ9vF/IQ+Ox2RdUoBEGffBGm8cd
         liT+GS32crRk93e+LrhifG21fDU+XgW+WxgqHng9Yh8kO11LhpICPROza60cJb+YB/GK
         UwugouIABibDdUlhGL3UIUmS5oMIOTPOySr/mQuPsvk6115nuYFVpR/PHKT1cGrjFriF
         Wyjg==
X-Gm-Message-State: AO0yUKXJMwCREDclmu9BSca6y7/UyCjrp42EBqMnlxBytjo40b4BX6E8
        1q5MKYVPV57ukyKJVD+VTM2YYRq1ll8852+Eq2O86g==
X-Google-Smtp-Source: AK7set861FSDMsURLcjK0YfWupzdcJa/LJkGb6fzMtY2pw4yGUBRH49uYrYvKvgao1sou/9r7OG9FFahTRs7t/+yE7A=
X-Received: by 2002:a5b:40e:0:b0:ac2:ffe:9cc9 with SMTP id m14-20020a5b040e000000b00ac20ffe9cc9mr7077466ybp.3.1678129260364;
 Mon, 06 Mar 2023 11:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
 <20230302220251.1474923-2-calvinwan@google.com> <xmqqv8jiheao.fsf@gitster.g>
 <CAFySSZABteFiyBYp_S7bur7_K1GkxL3A5DiTiV47iU_t8EpWKQ@mail.gmail.com> <xmqqa60pag10.fsf@gitster.g>
In-Reply-To: <xmqqa60pag10.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 6 Mar 2023 11:00:49 -0800
Message-ID: <CAFySSZDk05m6gU5-V1R+y3YnQ5PPduVW54+_gjBwD0rmacsLsw@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2023 at 10:30=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > On Thu, Mar 2, 2023 at 4:25=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> Calvin Wan <calvinwan@google.com> writes:
> >>
> >> > A prepatory change for a future patch that moves the status parsing
> >> > logic to a separate function.
> >> >
> >> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> >> > ---
> >> >  submodule.c | 23 +++++++++++++----------
> >> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >>
> >> > Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
> >>
> >> What strbuf variable renamed to what?
> >>
> >> I have a feeling that squashing this and 3/6 into a single patch,
> >> and pass buf.buf and buf.len to the new helper function without
> >> introducing an intermediate variables in the caller, would make the
> >> resulting code easier to follow.
> >>
> >> In any case, nice factoring out of a useful helper function.
> >>
> >
> > A much earlier version squashed those changes together, but it was
> > recommended to split those changes up; I think I am indifferent either =
way
> > since the refactoring is clear to me whether it is split up or not.
> > https://lore.kernel.org/git/221012.868rllo545.gmgdl@evledraar.gmail.com=
/
>
> I am indifferent, either, but with or without them squashed into a
> single patch, "rename strbuf" would not be how you would describe
> the value of this refactoring, which is to make the interface not
> depend on strbuf.  Some callers may have separate <ptr,len> pair
> that is not in strbuf, and with the current interface they are
> forced to wrap the pair in a throw-away strbuf which is not nice.

I see what you mean here; will reword the commit message, thanks!
