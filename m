Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269B7C27C42
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 21:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjHPU7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbjHPU7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 16:59:17 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857BE69
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c505786df3so155575fac.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692219556; x=1692824356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJrqpdxqLBMj5xO1fz6I3qX4wTITxYU8G493eB6wYq4=;
        b=LZmm2ds9NadWm0S4sjFMVFxkXDiR/Hx3Fr2JaKJFPCU5dIfoFGlWptK6OcAl4FvNgH
         zFteFlg5cT9h6V13XbiFOHlV4yuIdaskYdpKUV85XMAjdAlfXo5LyMuZ2UJJ85D08i8N
         Ru9idMeNkA3t9ANZ8owPWAmkmjuIBDrsM4INzWiPAvq7kU0GOEyB3xXc68K6eDrJhsyh
         7WlT4zoznRLT7kbMxldIcWAr0YKIqAQg3Mvog6FYbBpR8ihUpbCuhCW+gO3sIR1Pp6w2
         q53GFVDb+wqRafgGY8QX/EsQb/AjKC+WmOEdodOlI+DyJ8cveIjFwojli80aLJb1FbBK
         DFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219556; x=1692824356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJrqpdxqLBMj5xO1fz6I3qX4wTITxYU8G493eB6wYq4=;
        b=ZaLgO79/VlbakHQIHhj9Yj0cOouTxl0ZLMFnP7hQixGKEBDQPoBkZu6RyTKKX8PTyS
         LxK6ng59FS9u3WB2K0MuZTL1U+EVqPHybKcfeC160PWXQfii2/BefWi4XL2N2KGtjJhj
         bxp5dqdxFjNBjWlRphB+IoGK9H7bGZwbx6RFXxFCXzBngvBDS1TuB26tCvJsNSkIRkWL
         i0W298EljLSZNIHfO6bjgLVStb5H2hTElFFPYZSIAgPyfjKhuneH6Po8y6DHBcw2lP+/
         6RZCdE+RPdMJtAAEr5hy8RfwGWgF7tOKjZ305wu6XVEBy9vOWV0eHXhD6EcqrvqHnUHi
         l5UA==
X-Gm-Message-State: AOJu0YwmPX7xRihv3cuFXwhd5lbEbTpwl4aIXT5oPikqMeM0bbkUsfAk
        MiUQPaLrZfQyxor+MEkcH+aULEhubdybZB50eywOUwWyNDE=
X-Google-Smtp-Source: AGHT+IEBci0S/YlHBaL0cA63Frh6G2rYYZbRmHnMPeGWuh+CJjXCdIDZkV5uh0uVtnOzdblOY8wk9+uYk5zVntcKRJ8=
X-Received: by 2002:a05:6870:7008:b0:1bb:6c17:271e with SMTP id
 u8-20020a056870700800b001bb6c17271emr583245oae.8.1692219555806; Wed, 16 Aug
 2023 13:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
 <xmqqttt0hzl2.fsf@gitster.g> <CAOLa=ZQPmtqT9OHxh5uFq0rg+9L02tnmh1UE52em-rXPmFR6yg@mail.gmail.com>
 <xmqqbkf6g80f.fsf@gitster.g>
In-Reply-To: <xmqqbkf6g80f.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 16 Aug 2023 22:58:49 +0200
Message-ID: <CAOLa=ZR666sDj269SSDa26afqMxUq2Qr6TJnMSKOkVuqoKX43Q@mail.gmail.com>
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 8:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > The provided reproduction recipe unfortunately uses a linear
> > history and therefore, is not the same as the example provided by
> > me. Here is a reproducible recipe following the same commands you
> > used:
> > $ rm -fr new ; git init new ; cd new
> > $ echo foo >foo
> > $ git add -A; git commit -m one; git rev-parse HEAD
> > 26fb965d7439c1760677377bf314d8933de0b716
> > $ mkdir bar; echo goo >bar/goo
> > $ git add -A; git commit -m two; git rev-parse HEAD
> > $ git checkout -B branch
> > $ git reset --hard @~1
> > HEAD is now at 26fb965 one
> > $ git add -A; git commit -m three; git rev-parse HEAD
> > 91ef508167eb683486c3df6f8d07622b61ed698d
> >
> > $ git rev-list --objects HEAD ^master
> > 91ef508167eb683486c3df6f8d07622b61ed698d
> > ff05824d2f76436c61d2c971e11a27514aba6948
> > 8baef1b4abc478178b004d62031cf7fe6db6f903 abc
> > 086885f71429e3599c8c903b0e9ed491f6522879 bar
> > 7a67abed5f99fdd3ee203dd137b9818d88b1bafd bar/goo
>
> Thanks, but the above is not recreating the same as your original
> (where did "moo" go???).  Also "git rev-parse HEAD" for the sanity
> checking should be spelled "git rev-parse HEAD:" if you want to help
> others looking into the issue---anybody trying to reproduce will NOT
> have the same commit object name, but the point of these checks is
> to show the tree object name, which should reproduce for them.
>

It's not re-creating the exact structure I had in my original post, but it =
is
a shorter version which demonstrates the issue at hand.

I don't see the importance of "moo" here, the original repository structure
was something I was playing around with and found the issue.

Sorry about the misspelling, was just trying to provide a more deterministi=
c
method of re-creating the issue. And I think that it still holds true.
In the newer
example you can see that although "branch" and "master" are TREESAME
with regards to the "bar" path, the tree for "bar" and its children
are still output
from git-rev-list(1). Even though we specify "^master".So ideally only obje=
cts
reachable from "branch" and not reachable from "master" should have been
output.
