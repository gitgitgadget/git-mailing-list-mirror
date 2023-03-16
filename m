Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F4C6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCPSL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCPSLy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 14:11:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9790DC0BD
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 11:11:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t83so1439670pgb.11
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W53x1XZcaPsXIUfAjesJGWV1SwCU6No7dcDtDNbFufQ=;
        b=WeCDOg+FTq61BxraCbN+UI/xj9vN+1uKWc4PBYP5YTnf/mp3ublVPTclt4h/REAy97
         Qi7nLDo6tnBl6//7cqdRmakAC/eDr6V+MG2hf3JfeyCdFY991HjcPLIPHPrZzGsf6G/n
         OkePincIFfMo/ZzQ4LV7WTlNup/XjSihl4MtC6kmbQbRrj9ddOrp7L96M8K+MSc5FyBW
         x6Sao1daNAHqiugkVEo9v4OwTOdoKTqX1JopQbmNxxAKyZZHDEzuYSh0JGoa/BU9h7iP
         N89j0oaSyNAiAxb7RH8N6vcmU5raTmNxvfezBU+ZC5ix9UTzQhZXvDfM66qxjyvlF6+H
         wN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W53x1XZcaPsXIUfAjesJGWV1SwCU6No7dcDtDNbFufQ=;
        b=DPkHN65s+WbhB6NrSkvTKHzkIoilWXs/kUpmCep26PtTh77d5iu1WAKCxWLMqkVO1R
         dU7oKBa+Tw8KssF+AbuelAkLVieAnCvXWnGiXABfgnu9yxHEghRjQK0bAMX7BZwRB4V7
         F8GRflJtJbGdUE7rNCQms4a3gmGpPFXCWdfk//BRpeFHyNAMkbzDrVjXxB4gBIsxiA7I
         6Mi1ODrdqVnfXz2etXK5tgml3OOAyvU2OZykhjD+YOZQtF63anB4GHjvKjEDNFYNUUeB
         6ee6AbAdJ1oCFlB35UiNY5Q0zCGt0qm84+1ugpmKmk7Ynd1IR1kpgx82bxT3CSyKQ+zo
         PVSQ==
X-Gm-Message-State: AO0yUKU7h0Dk0yZmNt+WfG/p7duR3kXZX2QItXovAuGdcEsJFNF+To1G
        RAxcNVaiA9M7MZIkQwcl2XuZe+YxFKTnzb4Nues=
X-Google-Smtp-Source: AK7set8ooI88w808Lc0DcXl2Rlltm+lt/MDu9UIbgfuz11RjEnP+j37LfgfWzKYm9n58xnXDzwzrW/I0ED8tXe7bIs0=
X-Received: by 2002:a65:52cd:0:b0:502:ecb9:4f23 with SMTP id
 z13-20020a6552cd000000b00502ecb94f23mr81084pgp.5.1678990301345; Thu, 16 Mar
 2023 11:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com> <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 16 Mar 2023 12:11:28 -0600
Message-ID: <CAMP44s3hH0Gw71UAm10Os=6YJ4RAoAJxC3exN_jekMy6-JRsVg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2023 at 11:57=E2=80=AFAM Glen Choo <chooglen@google.com> wr=
ote:

> If users cleanly separate the two concepts, I think it is quite clear.
> (I'm not advocating for this approach, but) e.g. if we pretend that each
> behavior were configured separately, like:
>
> --[no-]rebase-merges [--rebase-merges-mode=3D(rebase-cousins|no-rebase-co=
usins)]
>
> I don't think there would be any confusion.

Not being conversant with these options I agree the above isn't confusing.

> (Having --rebase-merges-mode
> be a no-op without --rebase-merges is probably even more confusing to
> users, plus this would break backwards compatibility, so I don't think
> this is a good idea at all.)

I don't find it confusing. And how would it break backwards
compatibility if --rebase-merges-mode doesn't exist now?

--=20
Felipe Contreras
