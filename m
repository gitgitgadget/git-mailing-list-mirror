Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E68BC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCC361462
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhGCODC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhGCODA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 10:03:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE57C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 07:00:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so5087405pjl.5
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ImIjd5bnWYU7Cj8sVGNrt9OBOYQhlIifZWY50OyrytQ=;
        b=Ul89Gnn6DUUwLAjmK4JW9MwJNKVQ7UtghW9wWw7HKANMuWloWseoVCTBZ2568IZ/UC
         HIyU0hmzYMLxzQSn7Io+yE90j+tG8xjeHEz975xQeZkeGOjX4I0/SuB8fUXagoUb+R6+
         U1ZF5JRFhTLHnil6+Qvj7DDOVwl7pMviWrdToSifnTro2m317dxSaoagSQGkhFMG0Arm
         UMXrio70KZ/Ky1zjO9TfDgFPrLYnIFqfGUDVX77taXvY5IC6JZ3Ll+PMBn2NPZZqn6Pt
         FliV8xhqpV07fu2LFmhHt4rOavTDlKiEpsypB71nzpfTtkNta3uRebfmWynIvvsvuMrz
         pPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ImIjd5bnWYU7Cj8sVGNrt9OBOYQhlIifZWY50OyrytQ=;
        b=ohkABGGLusm86N57ukMTbTb4Ddu/UHV/F8Nij0K/mfOBItw4g8YmyBbhToOE3f1FMK
         ewJHl9Ucua+JsAl1TooJig9bPQSHkgsWMOt3kW2OobT0oq/MB52mhcrgYDePyrphV6rZ
         mAsFXD43sMCUwRl8r3NrVggie4hMtlc9yfjuCgwfhD6BmF9h1S42DkmhohuZwQPm3zdi
         5u0joKWQuOpDN6YDmoIt+//cYjDkYvXNuDKILUtN5IySos/2dMqwu3DxvoOlnoGDWXNi
         zitJxgnld9Gq8RB6RYwI89/ZRbKwWH7M+GxD5ALpQD4DRc4k8FQdW3gDwUHtjIHezayV
         KUjQ==
X-Gm-Message-State: AOAM533P1lTQj48iTdzIzrn7wuVbUdjiR+si8496fdD4kfHup5koipBK
        5JzDzB/jzthf2B/VR3ovkhk=
X-Google-Smtp-Source: ABdhPJypqS1MfLu060yz4Bhva70H32akL0BHIlIBFFgka/HHHVWD8+js61pP0yZxAIZw6ldi9Zx/gg==
X-Received: by 2002:a17:90a:8b0e:: with SMTP id y14mr4838941pjn.191.1625320825973;
        Sat, 03 Jul 2021 07:00:25 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.73])
        by smtp.gmail.com with ESMTPSA id s15sm7103136pfu.97.2021.07.03.07.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jul 2021 07:00:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: The git spring cleanup challenge completion
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <60df97ed24687_34a92088a@natae.notmuch>
Date:   Sat, 3 Jul 2021 19:30:22 +0530
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
References: <60df97ed24687_34a92088a@natae.notmuch>
To:     Felipe Contreras <felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03-Jul-2021, at 04:19, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:
>=20
> [...]
> Other than that, it's fair to say that *everyone* needs some command
> aliases to use git. This past month shell completions have saved me, =
but
> not completely. I can't imagine how a newcomer must feel using git
> without any alias.

TLDR: I don't think young, first-time learners of Git would mind the =
lack
of aliases. I cannot speak for people coming from other VCS's.

------ Long Version -------

Hi, maybe I can help bring some perspective on how newcomers view and =
use
Git. I help run an Open Source club in my University, and one of the =
first
things we help a lot of new contributors with is teaching Git.

I have conducted multiple workshops over the last two years, so I have
some idea of what the usual struggles and pain points are. I also have
some recollection of what it's like being a new user.

Most of these new users have never used any kind of VCS before, so half
the problem is the overload of all these new concepts of branches,
checking out, staging area, committing, pushing, pulling, etc.

Users are not able to properly map the name of these commands with what
it actually does. Most of the issues stem from trying to memorise these
commands as a series of mantras and applying them without knowing what
is actually happening.

Users are confused about why there is an "add", and then a "commit".
It seems conceptually similar to them. The difference between reset,
restore, revert (and even rebase) is also a pain point, because those
words sound very similar.

Combine the lack of understanding of what Git is actually doing, with =
the
fear of losing work, and you get the perfect storm of a difficult
experience.

For most new users Git is unusable, unless you explain to them the right
mental model of Git being a graph of immutable commit objects with
pointers to access their contents. In my opinion, trying to make this
model more transparent to a new user is the best way to improve their
experience.

What new users do not have a problem with is a lack of aliases, because
they carry no previous expectation from other VCS's, as Git is always =
their
first one. I can imagine aliases like 'co' only adding to the overload =
of
information if an instructor is not careful. FWIW, I have never seen a =
new
user complain about the length of the typing, it's usually with the =
plethora
of unintelligible (to them) options that each command has when they open =
the
Git man pages, which adds more fear.

I do not have an opinion about default aliases, I only had a narrow =
point,
ie, on the list of impactful things that helps Git newcomers around my
circles, aliases would not score very high. Those who love the command
line among the more enthusiastic learners will set those aliases =
themselves
anyway.

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

