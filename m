Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6305EC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjEHQju (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjEHQjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:39:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065A72B3
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:39:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc3a5f462so36717a12.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683563915; x=1686155915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEG9JpjcpRUFtUJ5OOyOdDQzLpJk4S2EUWAva1B+x0Y=;
        b=3ts8C+FD5Nkck+yU2HsOjRHMO7MumXTUlZrj9RP0M5Qj/aZT1okgOFAbdPbpnH1bx7
         GhCWPSPOsFdAM9buMpUofB9H3vISjNvbWPiPpkfnK+id0l4K2JM0Svm2ndIUyJeDOeP0
         agM6J/v2OpUMrSZGl4efDNnqmHZi6/ReJJtEX2fUlGsMHbrUYCuJi7TAgPQuJth9+42x
         V2rkBfEMQvZEkKgO8KDv2h9PpMSmZyKrNh5DNRD+b88gdyqot+jpJeltaehLm+TSp2l7
         +eOPWUKHMgyEYI+YiCDTmxrkrhY0C5r/fIPJH4FifDUkTF2UlNptcdDjroZiMK1IEWih
         MOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563915; x=1686155915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEG9JpjcpRUFtUJ5OOyOdDQzLpJk4S2EUWAva1B+x0Y=;
        b=NPK0yWTd9wSNWr7WuZzUvcNR686xjh4enM/GhOOENIPfKArAfJU11IhqHmJW6y5AxN
         MpMStuCA7FRwddkQATJJfstRGhQhRXWNr1kLVg4rmhyiKURZ8Ecx1iBCvDJQskYRjVa3
         Mv0JPUMSEHXE3hRiG42F3qEXjvaWgwHkPvZ9I/2ZbHA2M7vdG2KmIeaQQvFLkpMe64+z
         DISL5m2k8+9j1HkvaHfUaDMqQQl0Z2jCwqlIKKUf98sDDZ86UozOQgH+auwYQxUhY3Mb
         1cUtcdRIoix/IDs1oZy/PwXpJ89Y0h7ZODFlNjTqaF+yQxw+pn7g1Z+CtThiA+ewub/C
         bFzw==
X-Gm-Message-State: AC+VfDw0VQp9I2IiE8tX6uDootuJW9Oz2AajDSNn6LMV/HpfBvs3uN0O
        eeFdXsRp4tQL79/nQp8CgN7m6evBS5Yn4jJd3ie6zgbqaTmOIzFajJo=
X-Google-Smtp-Source: ACHHUZ5na1/FeyyLwwmkuagDffL+nR0oHFCWJPG5QDKX5NDyigwbF0k76dKaOPi1jFhiTnlCOaS9Hv7As+3QcVU0Mf4=
X-Received: by 2002:a05:6402:50cd:b0:50b:f6ce:2f3d with SMTP id
 h13-20020a05640250cd00b0050bf6ce2f3dmr148707edb.0.1683563914903; Mon, 08 May
 2023 09:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
 <20230503184849.1809304-1-calvinwan@google.com> <xmqq5y96csso.fsf@gitster.g>
In-Reply-To: <xmqq5y96csso.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 May 2023 09:38:22 -0700
Message-ID: <CAFySSZBUdVT3KJ-RQ_98v2iLuTN=NMUo1xBq5ZEqHhwPjV47NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] strbuf cleanups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I intend to reroll it, as well as rewording the commit patches 4 and 5
as per Elijah's suggestions. I didn't originally realize you were
referring to s/environment variable/global variable as the misnomer
(since the dependency I was removing was from environment.h)

On Fri, May 5, 2023 at 3:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Strbuf is a widely used basic structure that should only interact with
> > other primitives in strbuf.[ch]. Over time certain functions inside of
> > strbuf.[ch] have been added to interact with higher level objects and
> > functions. This series cleans up some of those higher level interaction=
s
> > by moving the offending functions to the files they interact with and
> > adding documentation to strbuf.h. With the goal of eventually being abl=
e
> > to stand up strbuf as a libary, this series also removes the use of
> > environment variables from strbuf.
>
> This round hasn't seen any comments (mine does not count ;-).  The
> 7/7-only v3 still says "environment variable" to refer to a global
> variable, so I am not sure where we stand.  Is this back-burnered?
>
