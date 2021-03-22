Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD821C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857DA61998
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCVRNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhCVRM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 13:12:56 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F54C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 10:12:54 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id j15so3974834vkc.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1f8J1Fd0I1myMX+qqyXieyPzMAZOCiayuaHkknlWPo=;
        b=mzvzFw0r+hmE5JHBJIkhL+cJ8KgELRAOsttQdnQkLv1B4+FPsg5houz7ph5TOsg+qz
         d4y5MzHc1adhE5Ho+Zn9hFMaUeoCJu4rpH/6cCjjpPqoly4wIjbFu5oGLhwAGkrSg33F
         vOhkDdXJzlzdhGrcW+dVf4RVlCuLWk7KY+Bp7sqoyvPvBgcCgeng52q3HRrtaRTf3BZx
         bnc+gmKJk0UZscktP2h+Ivj+m3CDRb/xkd+AlLzQ7JO37P5tYJrMnSHarMlKG4HElZDz
         QUWumtFtbydDOF1iDWVgSI/b7sKjU7jUDbjHwqCQ3ntX7tbrItVToXcSnozwc+i8PQ2X
         aRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1f8J1Fd0I1myMX+qqyXieyPzMAZOCiayuaHkknlWPo=;
        b=fsAhsFc7skJO310NvSJnvIOn+Aq29uPz0a8k0NqkIkag9vh8wo0GxnXEW01lO9gD52
         YsyOLHytK2BeKsvF1teJw9AFynK8bVBP920VysjuhTUGjih1b/6MwuOkIzOk++YEpJId
         3OC33E04wfULV4RLx/OntQMRoffrPveSKsM2aACC4eVCx+8F+sxSx0BYWGsCvjkWzbf1
         o8B3IVcHo4kfSW9LfWyORZ1ZOhe6khhizSHM+sXtZpII2EPn3/qwKGjUTz/FzNz3LHNb
         6Acvb7yBM9a9gDf8tW7uketRqRSOjvNWo6ZbYpTyAxOHIUuBxY9z/k0AjSLxlDi45ID4
         W1HQ==
X-Gm-Message-State: AOAM533VSj6z0TMUDA9AAcqYKg67jvBJVErBnu569ipyJcoR1i86sVpt
        aUP/Ih9oQC4JJOSCEELrvDUUYMzA2ZEPqwH8+2aSBw==
X-Google-Smtp-Source: ABdhPJy3QwKrS3eIC9uBWUylZiO9murhnN/a8glTpMUZKNHfebdNPTSddes7JBz63cda7fB/t0SXkOplueZz91Y2ELo=
X-Received: by 2002:a1f:4644:: with SMTP id t65mr1043230vka.0.1616433173855;
 Mon, 22 Mar 2021 10:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <87eeg7qpyr.fsf@evledraar.gmail.com> <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
 <87blbbqju3.fsf@evledraar.gmail.com> <CAFQ2z_ML8s0Gk4Zmg+2mxzkfP1AbL=zkeUG0yKEtoege7it-vA@mail.gmail.com>
 <878s6fqgze.fsf@evledraar.gmail.com>
In-Reply-To: <878s6fqgze.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Mar 2021 18:12:42 +0100
Message-ID: <CAFQ2z_OVbcxZtb-hS1DZ3X7FpdQD25W0VqtGLXdkQ4bjgCPS-w@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 5:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 22 2021, Han-Wen Nienhuys wrote:
>
> > On Mon, Mar 22, 2021 at 4:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> We can know with !strcmp(rows[0][1], rows[1][0]) whether the latest
> >> update is a ff or non-ff (it is). As opposed to:
> >>
> >>     $ cut -d ' ' -f1-2 .git/logs/refs/remotes/origin/seen | head -n 2
> >>     8b26a41f4bf7e7c0f097cb91012d08fe8ae30e7f 0f3a981cbd5be5f97e9504ab7=
70cd88f988fe820
> >>     0f3a981cbd5be5f97e9504ab770cd88f988fe820 fdd019edfe6bc60d0100d5751=
c41e4f6ad28a2ef
> >>
> >> Where the rows[0][1] value is not the same as rows[1][0].
> >
> > I'm confused.
> >
> > rows[0][1] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
> > rows[1][0] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
> >
> > they are the same. I don't understand your argument.
>
> Sorry, I mean same =3D ff update, not the same =3D non-ff. So I flipped
> those around in describing it.
>
> But in any case, the point is that you can reliably tell from a log of
> updates whether individual updates are ff or non-ff, as long as you:

?


$ git checkout -b non-ff origin/master
Previous HEAD position was 59f4325222 Add "test-tool dump-reftable" command=
.
Branch 'non-ff' set up to track remote branch 'master' from 'origin'.
Switched to a new branch 'non-ff'

$ git reset --hard HEAD^
HEAD is now at 56a57652ef Sync with Git 2.30.2 for CVE-2021-21300

$ cat .git/logs/refs/heads/non-ff
0000000000000000000000000000000000000000
13d7ab6b5d7929825b626f050b62a11241ea4945 Han-Wen Nienhuys
<hanwen@google.com> 1616432938 +0100 branch: Created from
origin/master
13d7ab6b5d7929825b626f050b62a11241ea4945
56a57652ef8e4ca2f108a8719b8caeed5e153c95 Han-Wen Nienhuys
<hanwen@google.com> 1616432948 +0100 reset: moving to HEAD^

How can I tell from this reflog that "moving to HEAD^" is a non-FF update?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
