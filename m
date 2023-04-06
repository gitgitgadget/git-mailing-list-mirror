Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE01C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 02:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDFCbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjDFCbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 22:31:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0547DB2
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 19:31:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54bfce685c1so45557237b3.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680748299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WiPFuLrMrd2ZoSyFtRDBFNB+f21d3+ItUF/Bpc5a1g=;
        b=kkn5UEXxBSY1RTQm6R1pFXZe+9+tPFhW+gyUnXyZ8Eq1PjZ3pQixla1bjwCmFwVAEK
         /5iXG2hHnectgftHTVqSzW+MUX1ooTse8tId/A4JKjxasRG/yiy4XFGNa6L5KB7YThH+
         HZ9DPFQAH+DlpdadmYU90aSAedhG3SWSGV7nn6mGul798Yuo5lmFAZJtw89Ok/3rpoqz
         bs6mfE8Dis+/FIhkKoj2AdtGw9go/+D9cWniAhE7hHgq8okkEBRHFazy0c8uhoBlGH8g
         FX3p9q1pKGYwqkZ3mgRO10kVNhKVUrQYGnlGhsvFEGOtdXBx7swDsbsRBc+yWvBU/Qkx
         ECuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WiPFuLrMrd2ZoSyFtRDBFNB+f21d3+ItUF/Bpc5a1g=;
        b=xz7X5ZiNGLoSX9y1CWH0qhxcMBm40x4O2DNBJWjE/kAHTuGicMvPuSBEeJxfg74tqb
         W2hG8aAZ8iok3rQIqwCx1OKvsCUJ/mxw2cgjsNCQzOCLhWYCSazBwfzLu5W7iLhi31Jd
         RygWpIyzlHNRAIjTgfk4COusFUwnxhWB6SSmhZZfcymj+Bq09MGAgfzzKYXwnyn5zJsN
         rBFaHKpbds021Ex0bqg8B4FBYvuG+GhjfT4Gk9z5S8KfVjdTr6teicXuQQuOK0OUtdbT
         Apu/xdX3XSjgyJM0fgx4nMitqWf0xUVjMLS0LQ359BkLng9X+0D4WwGuaqKM4KoYO5/v
         8bxw==
X-Gm-Message-State: AAQBX9frSh8rme9dx8kPKJZnYF5pfvLIkAuuspDaqC+Bdd82p/6age1N
        6WusCR5KadsRLM961Dnundk9BGGFdkFMPlcE0Y0TVFWVZI0=
X-Google-Smtp-Source: AKy350ZdNWoaH/5O4ta8zOXuOoX3jTFC/HkzrRCIo3NNU/AUt78eaD8JVh7wVBTHcKDJILL6U1sPvJznr2dcjDYynHw=
X-Received: by 2002:a81:c406:0:b0:534:d71f:14e6 with SMTP id
 j6-20020a81c406000000b00534d71f14e6mr5014242ywi.9.1680748299397; Wed, 05 Apr
 2023 19:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzg7nw5gq.fsf@gitster.g> <CAMP44s1ePrbxQc3KzU8A2Z-ZMXTaJHyt5hh9JsY337kd=OvOCw@mail.gmail.com>
 <xmqqa5zmrlnt.fsf@gitster.g>
In-Reply-To: <xmqqa5zmrlnt.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 21:31:28 -0500
Message-ID: <CAMP44s3xZtXH+XcD9b_W7f+XSsZBx5ky5D-0_iYSHuK9A+Qt=w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2023, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 5:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > Any reason why this patch to remove a workaround only needed for ~2005
> > software wasn't picked?
> >
> > https://lore.kernel.org/git/20230322000815.132128-1-felipe.contreras@gm=
ail.com/
>
> I did not pick it up because I did not see it.  It seems Todd gave
> an ack on it---I will queue it and merge it to 'next' soonish.
>
> Thanks for a ping.

Thank you, I thought that might be the case.

There is also this other cleanup patch that removes a workaround not
needed since 2008, but that one did not receive any feedback.

https://lore.kernel.org/git/20230323221523.52472-1-felipe.contreras@gmail.c=
om/

Cheers.

--=20
Felipe Contreras
