Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD5C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCWVJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWVJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:09:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FD20D27
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:09:04 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-544787916d9so416881837b3.13
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679605744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+ZfOj5dwRScDKyR9z7HmN7ByME0nY4VvhUFVrCjihc=;
        b=HZU1/EnPKVcJ7NuBBRheA2XSW27JCRZbEqQVSyTfGdvxwOSZndVn/NkSXN9j1BJ/Z+
         WLG1AO6gvwUJI2/W8L9QnHqMXYrxbF144lXAE+6mo0Ka6f3pqcEKBU2tV7LtwO8ZCuzo
         fR7a3wmIuj0ItNWv/ZJ/wMGCkRkRpg9X9JWgSC+81zY6DBvprE2lJve6OjYlSMFiAL+f
         8gyCv506mt2o97aeztn3MYsgjLeIUA6Ca1KXnsGqukUMNf/LPPfGPZYbGa5zoojwejcC
         QYQqp6x4tXoHbEcrnUmegnoxvtNhTFLblZS0WrhMyMHTVNC5H239EiqHFCd6M93bAuz6
         cj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+ZfOj5dwRScDKyR9z7HmN7ByME0nY4VvhUFVrCjihc=;
        b=Aea3rqzZBKbXzGqZn8Vx5NjD2TFWqagUPyhgDn/cNDf/sD85KchnNJN/WLwkajMoJ6
         yCS5ZDdOjSirce8xpMSG/n8qfVykksHRPmTQk2fkJNmeF/Vcfr4JcGuL5G8k3rXY0EZZ
         /Er9IvYd+qB9o6lFSzzddwjZ7ZVPxfjoZf4fK+q4kr09E/LfLTBc6cPSgmOtwFQnGMAh
         18dypPUmp8oEEHs0HSVO5H3XF5KBNSiYKDduwob7Sgln9QhFurmjaKlo1DXQ8jiwQcrX
         doEmFw146cgSjXG/4NS+fjCm4pICs7ti3UhpkGPCiQb/bP997Y18KqQxIhrrg5LWfhRU
         32LA==
X-Gm-Message-State: AAQBX9dOZNpXrG8etnRCRSKCIRRUawtpdTYJiVm7gm70cbY0CAXVyBVX
        hxo2s736FBANZ5EH4dlr6EGmIRCOO6gMqC464soxdLciF1g=
X-Google-Smtp-Source: AKy350bL+BNSlgW+KKVe2ofsQGfTGpQL3DkKUw/WGZPRI9eP8CZIITRXLP/gUEbm1O3EFRcpe8IyVJZBNDQATi7xQ3E=
X-Received: by 2002:a81:4428:0:b0:52f:184a:da09 with SMTP id
 r40-20020a814428000000b0052f184ada09mr231897ywa.2.1679605743871; Thu, 23 Mar
 2023 14:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-2-oswald.buddenhagen@gmx.de> <2b296b75-3f8d-28a9-a3d8-8134450852da@dunelm.org.uk>
 <xmqqiler8cga.fsf@gitster.g>
In-Reply-To: <xmqqiler8cga.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 15:08:52 -0600
Message-ID: <CAMP44s3g5FZ5VgvF27h4AzqHrxpOvYtG9RRVr=TJTkTAGxBKqg@mail.gmail.com>
Subject: Re: [PATCH 1/8] rebase: simplify code related to imply_merge()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 2:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> >> The code's evolution left in some bits surrounding enum rebase_type th=
at
> >> don't really make sense any more. In particular, it makes no sense to
> >> invoke imply_merge() if the type is already known not to be
> >> REBASE_APPLY, and it makes no sense to assign the type after calling
> >> imply_merge().
> >
> > These look sensible, did imply_merges() use to do something more which
> > made these calls useful?
>
> Good question.

It used to be called imply_interactive(), so --merge did require an
interactive rebase.

--=20
Felipe Contreras
