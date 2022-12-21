Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF0FC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 06:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiLUGJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 01:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUGJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 01:09:14 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1331108A
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 22:09:11 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id q10so9700416qvt.10
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 22:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRFmyjiMG+Vpa6xIKnpVlZmNIfaMXm3cInWB8I44JvM=;
        b=M3z042l2vtgXGvvRN4B4fC4LkXkaNdAGGYG+LJTLNjx+pW3CNwJBGAFH7YEPqlJspV
         vxncIqFgKz26hCOU9lMBhxqkb6u1M7IJB58xG6ZePbEqJdggvdJmiDZJyPduO7AOlUqu
         oR1Qo7SiDv2p99GwdATb/BcXnC7gMe2V9FP+ZvuglL8Ef8+SVLm5dlsPEpb1QOhsX81j
         v3rILfMYF4+OCaWa0LFrHWg0aWf/4ZwIYj1d0rjcNihOThi+O0S4lLkwpE6UAyZ/58qj
         FoQmtksZ+kUafGctu9Q24OXv1wR2MHOo6I50SGEOdazeJaNQz19nGUBmIzlLYbg4e0cw
         5LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRFmyjiMG+Vpa6xIKnpVlZmNIfaMXm3cInWB8I44JvM=;
        b=FKS570SIMFtuNaxN6GzbDLWFnA8O2GLtu5y6KfUAsBEWoIbZINojLaLEETiKuwbbnY
         khuHn/1NlXSWCoru35FLcBLxkXjh14VsXj6ugMRJNIlih3WaKTo0xQBtuGWDFe5NCEJu
         NOSo4ghLsZnj4cAoGK2tYeHlFFpVEMwHUA6QMXfl1gVp3SDp4LmwEObjKzzLhzmGzPwD
         kGUf3uOU7oU2DsJ+6wCTxizXxRjLFJYRL/9tlmw8eoi46wtVdfrFpjT5XxCWxHznFl2P
         lEZxNGNGqJnoI4OrsLUw1//5WnYueopcGKWeXyq01gzAr7sfRNByWmgWG6ZtyWHJ+a/A
         q15Q==
X-Gm-Message-State: AFqh2krblwlCEvqIMse5pzLnmsg7++oSWUjP4VTs6LbbjD3iTgdsjm7U
        IExmuf5gMO6KyiZwtLXRIXVRw0jyHgX1iwhMJMKGow==
X-Google-Smtp-Source: AMrXdXt3i39i4T2SnwQmSTIynGnUEne5s0TRwmP9x6DNQbbFddPcpNH5GYfHJXU+pEPZvtMESkewjSSsOWnKsFrzEcU=
X-Received: by 2002:a05:6214:80a:b0:4e2:cef8:c816 with SMTP id
 df10-20020a056214080a00b004e2cef8c816mr46949qvb.51.1671602950812; Tue, 20 Dec
 2022 22:09:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com> <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
 <Y6Fle8gzVU5si3T/@danh.dev> <CAGT1KpV0igMKk4FvapuZCdJ7kFS+_cNe2ouczQsomheOGhgLZg@mail.gmail.com>
 <Y6JnEQY2VWU8gSZX@danh.dev>
In-Reply-To: <Y6JnEQY2VWU8gSZX@danh.dev>
From:   Chris Webster <chris@webstech.net>
Date:   Tue, 20 Dec 2022 22:08:58 -0800
Message-ID: <CAGT1KpWBVcmxCJf=j7ks7azrX=oj3zLqbrThOjjPLqKu+8rBAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2022 at 5:53 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
> Yes, I think, a patch to move the whole block into a script, maybe in
> ci/ folder.

Maybe before the next patch or someone could create a check-whitespace
workflow action.  Can this patch move forward?  A script would involve
validating parameters or env variables that are just workflow context
expressions now (ie more complexity).

> > I am not sure what you mean.
>
> I mean we can write:
>
>         echo 'Run `git rebase ...` to correct the problem'
>
> With single quote, we need less escape.

What about ${lastcommit}?  Yes, there is more than one way to do it.

thanks,
...chris.
