Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086AC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbjD0Sqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0Squ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:46:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E475B2712
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:46:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef31924c64so793101cf.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682621207; x=1685213207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXY/qxcE2fr6sIwTMbTLKwMQzgeB2+ORp4hH4Kevyw8=;
        b=rMoyZSyYaZ1SKulqoMdGpG0OTm86EJJCIp6V01sINK3jdkSmmhSI+goOAgdaSEWztc
         /0YZ1yMpPxyX4dSww36UAHYiTKqRLSA99wOPNRQK9D7w4pgsfhZUgY5MBLi12QL3Ptdi
         WyxGVir7GeC5xpdSAj/4x3jF4OiBBaifB3OoMNl3pTTf4w2/wMVauBkF9l98dn6G3jxb
         hagmkS3udZ3TRGlDQCLO2m/avDW/W/ZJnBv9xPJR+eJjpJjreHLC1U4YiWaX0bErmnfv
         G1EXDD2Tp0dMdvJgNyloVfEZiZAU4XIvXKyugh2hvoPRZLQXM/N+4qXrNHIDJzxZbQGh
         7yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621207; x=1685213207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXY/qxcE2fr6sIwTMbTLKwMQzgeB2+ORp4hH4Kevyw8=;
        b=FBa13afc+16uUJDyQand5+h7NMGAXDVuUcgwr9IVWMHbdfHZRC2RKZWRq/B8L//tbh
         IS+ytVQqgRo+9fXOWbqmI/US1O/WOtXSerDcwETAYKQj7HcC1lgn+uZXhwMMjeYAuIag
         YlECPR9MuY5VTkmAsB1DaWynpgVll8IPbdbYX0q3PnXq1+/BbweC2tlC4WDfKCskqebW
         fpf9dVa8YHz0PyJvqzcaNV/Kt0hga2zEoB0IMMDv9A7jTQoD4z73ote4d4xC6ehv0erC
         sUPeVYt27cc7nlwoM99S7a/kX9soKlzctZOaEZqKWjr0jF+3gp+HWISGZDMdHM3wSZkg
         m+ow==
X-Gm-Message-State: AC+VfDzvzXbujs+KapN+nWkVmf1kz21aCRS4RHYi67R0AcB/r3wS3MjX
        1KhQqS0lqyc/87ixu9K1MYFjRSg0Y7CXfPdgRYtOEF62mIMul8ql8hCPPw==
X-Google-Smtp-Source: ACHHUZ4bUsyTwwACq5Wlwa5u+Q6i3Nb3NiogBPE1eHgxyGGReueS0OZKz4JJKfwQ39Wqbg0Q53se/tUSUdj5/J/6teM=
X-Received: by 2002:ac8:590b:0:b0:3ef:302c:319e with SMTP id
 11-20020ac8590b000000b003ef302c319emr42685qty.8.1682621207065; Thu, 27 Apr
 2023 11:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com> <xmqqr0s5jhj4.fsf@gitster.g>
In-Reply-To: <xmqqr0s5jhj4.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 27 Apr 2023 11:46:36 -0700
Message-ID: <CAFySSZAXLnPjndDpXeUK9x1ZK_OuCPV+DyuHSC6O7=3oYx68Vw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 11:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > ... Unit tests additionally provide stability to the
> > codebase and can simplify debugging through isolation. Turning parts of
> > Git into libraries[1] gives us the ability to run unit tests on the
> > libraries and to write unit tests in C. Writing unit tests in pure C,
> > rather than with our current shell/test-tool helper setup, simplifies
> > test setup, simplifies passing data around (no shell-isms required), an=
d
> > reduces testing runtime by not spawning a separate process for every
> > test invocation.
>
> Good goal, except that unit tests are not panacea---our ultimate
> obligation is to give a stable behaviour to the end users and
> end-to-end testing is still needed.  We would benefit from having
> tests at both levels.

Ah I seem to have misworded this section a bit. I didn't mean to say
that writing unit tests in C would replace our current shell/test-tool
setup. I meant to make the comparison between writing unit tests in C
vs writing unit tests with our current shell/test-tool setup. And I
agree that we would benefit from having
tests at both levels.
