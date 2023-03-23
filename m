Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9800C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWXhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCWXhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:37:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA12DE5C
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:37:34 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-53d277c1834so3222617b3.10
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679614653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTkAND/qUaKOiZgCM/8yqh66bQgEDB+PTW8O454bWAA=;
        b=MitkhuCQE5xGv0qtgnHv43yeuBoBi9P+Jkx2oMDxTDSGPqpi/s2NGDODf6p941s08J
         v9UGB/jBurYZTy69ohoDX+/kX3thXVZBeJ9RuhWsxIUTDrnU388P8UEU9AcE2MhUXNBM
         PL9i4TKmRuvXsunokNuJTKVz3S7/vHgcnqIUey2iBzGiU4kOJSipvsh8e4uaQv08Amvf
         1IowID5a9qfV9rnUB/2fb/lFH0NYtDYCl2+QqJ8mrRi2qiG/ATDrwHswDIGNw4XWY+2P
         OWCBn2/35z4PfR139hAaFau5mOORjUzrsorJ26xqgq3Hqz9BSooj66Ub/yO8g6vrMU7w
         N52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTkAND/qUaKOiZgCM/8yqh66bQgEDB+PTW8O454bWAA=;
        b=SANZAVlkBGYCfsb7TmluEeDgQEVl3XTNsawFt1Dpn73ZKCpzVj0L02S//Tyf4weNI3
         m+UYqp2Q0M0Wg4Ac/+YDGCdhJhEHbH+JXsH18N5Gd//dWNyHOOAkaCzbrs/N+qAZB1eE
         XRlmYEBJYiezoQwCB6VPoMHm9uTkuTJO875mK/QTFoTt9ozWwU5vieGIYapJ05hVpC5Z
         0wxOI9M4Rw0P1OXulgLQkaeHDgQC+SU2mzV2FXHUiJuIN23ma+L5ZOSYyYGkBriORnB0
         Kimjw9msjnddZAViZYJwtlOYn4JJ8C9B2Oc5RFeBN+MU9fXkGXibougzgLzPCDK2jFzY
         k6Yw==
X-Gm-Message-State: AAQBX9cP1x42E1Al+IHUkrtxwvC5sNur7AtTv5km1BboiW/TrPOWn+9/
        wUGGDWKmVK5nfXjYf1yyWqjGThaL4I201fzCDLwDDvjmXpI=
X-Google-Smtp-Source: AKy350YQ2w3xxXqMiHtnyY6tgXfFRG7t+yKMsRvBlHe60blL8VXMyYefhXLG4njIfaJywlKi+LnebgAzVOmQlMLwXHk=
X-Received: by 2002:a81:e308:0:b0:532:e887:2c23 with SMTP id
 q8-20020a81e308000000b00532e8872c23mr143031ywl.9.1679614653143; Thu, 23 Mar
 2023 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 17:37:21 -0600
Message-ID: <CAMP44s2AMrXCN6f6v-W0sqb++TVfHf7Q1miJE7iZjZOVwFQa0Q@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 3:45=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:

> As I mentioned in standup this week[1], my colleagues and I at Google
> have become very interested in converting parts of Git into libraries
> usable by external programs. In other words, for some modules which
> already have clear boundaries inside of Git - like config.[ch],
> strbuf.[ch], etc. - we want to remove some implicit dependencies, like
> references to globals, and make explicit other dependencies, like
> references to other modules within Git. Eventually, we'd like both for
> an external program to use Git libraries within its own process, and
> for Git to be given an alternative implementation of a library it uses
> internally (like a plugin at runtime).

This is obviously the way it should have been done from the beginning,
but unfortunately at this point the Git project has too much inertia
and too many vested interests from multi-billion dollar corporations
to change.

I wonder if a single person who isn't paid to work on Git commented on
this thread.

I don't think these kinds of laudable efforts can be achieved within
the Git project.

Cheers.

--=20
Felipe Contreras
