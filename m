Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4AE7B61B
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbjJDOAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242739AbjJDOAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 10:00:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5958C0
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 07:00:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8164e661abso2195527276.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696428046; x=1697032846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfl4Zrj7mpQAtRkhnyIBihH1Vhjv+Lm+tubZ/m2upaY=;
        b=X2Rq1s08QcuUUIgF7S7EaP41q9zLcTuHih8jaQ7Xo44T3XFOSAnZC9lARqBf8sbBZH
         qKHBsrmomNn/81h+CHB91DNwoS6Wpw4dM3HUk+i0ZOKV8u4GdB3qvEaWHHJI2BD1sKgH
         lqMJRlkjTspy1irUu3zMlMRlB91+ZFCxokTVgcR+d4GjeYKvnuaaxZeNOzum4XrwxnFu
         mUJYAtQ/WXEifgCxdIgG3XDpXHdB40kkqFCTjjKmVQ2zPYTewU0t1FsDKckf1GCzSbzi
         +ZR6PmCMmTqQT3rtR+oURrnIQRlw7TIuK4mWEd2HqQCAWiEE9mlBiDNZMNnYwz1Z4Yqw
         Y5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428046; x=1697032846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfl4Zrj7mpQAtRkhnyIBihH1Vhjv+Lm+tubZ/m2upaY=;
        b=NYIrLH+yj3v7hj/aPF12jC0XkYSTcQmrlO1ZhpqFQBAuG3JVIrSTJ0BSei7x+vYFnx
         IfNVlkdb3S/VwVUTrhdLQ2bG/eRAct9eQ3mnzegBiBf26pJIuBMngIyJ90Ggk5+OVjg4
         nCkXmZyxgOaLsE/YytqdqaL70ZpmpnKfasd6BmwefZCq9CzE0kZtHUMXPbQIq5+GUE5j
         cSOxuxtCkUai0t2blVnM0W4vIj9iUTsHEsfRirByYDDWpMn+UvKC2rD8Zx9N73IfR820
         ixWod6aRccacpCahF0u4RTWY+Lv1QlN5nndCXE1zQzWPS241Xvx5Hk0Crhrck9LI7YLG
         Ax7w==
X-Gm-Message-State: AOJu0Yz6xrCC1gTVSALIACFyfhG9a3RCIPacbXP+MvT8tZKoT7bR0MLE
        AjpcoeqgomOs3Z+CREgvEq81uD4KLLHu3O4aASU=
X-Google-Smtp-Source: AGHT+IG+jZa86yctDarYx/7yR+MLDeTxqRf0SH83pL3XpJoyAkII96sdW98ckS3YEpxdtckdLC9RGxKLfPBP2PrWOSA=
X-Received: by 2002:a25:c087:0:b0:d91:b2dd:fa5f with SMTP id
 c129-20020a25c087000000b00d91b2ddfa5fmr681910ybf.8.1696428046041; Wed, 04 Oct
 2023 07:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-3-worldhello.net@gmail.com>
 <xmqqil7yq6ms.fsf@gitster.g>
In-Reply-To: <xmqqil7yq6ms.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 4 Oct 2023 22:00:34 +0800
Message-ID: <CANYiYbF70=8tyuah+wwp2EYiBrExSzHbfEYkEcZz2gesXkJ-vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] transport-helper: run do_take_over in connect_helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 5:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > After successfully connecting to the smart transport by calling
> > "process_connect_service()" in "connect_helper()", run "do_take_over()"
> > to replace the old vtable with a new one which has methods ready for
> > the smart transport connection.
>
> The existing pattern among all callers of process_connect() seems to
> be
>
>         if (process_connect(...)) {
>                 do_take_over();
>                 ... dispatch to the underlying method ...
>         }
>         ... otherwise implement the fallback ...
>
> where the return value from process_connect() is the return value of
> the call it makes to process_connect_service().
>
> And the only other caller of process_connect_service() is
> connect_helper(), so in that sense, making a call to do_take_over()
> when process_connect_service() succeeds in the helper does make
> things consistent.  The connect_helper() function being static, the
> helper transport is the only transport that gets affected, but how
> has it been working without having this do_take_over() step?  An
> obvious related question is if it has been working so far, would it
> break if we have do_take_over() added here?

The connect_helper() function is used as the connect method of the
vtable in "transport-helper.c", and we use the function
"transport_connect()" in "transport.c" to call this connect method of
vtable. The only place that we call transport_connect() to setup a
connection is in "builtin/archive.c". So it won't break others if we
add do_take_over() in connect_helper().

In fact, it was not "git archive" that made me discover this issue.
When I implemented a fetch proxy and added a new caller for
transport_connect(), I found that the HTTP protocol didn't work, so I
dug it out.
