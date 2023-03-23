Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B549C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWU5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCWU5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:57:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8E23A64
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:57:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k17so15684360ybm.11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679605023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPgC4FUtbAyWb6mIBcNHN4p4gtY4LGN/YO08LVdDE5Q=;
        b=MIYzXiMAAb51pJO3zoWrii0kdv8DTOF1Wv6YyhHlVb1kSgM4Cl19GNWE5wMG7hsYWy
         kMxuuJsQ12qas46GZMLfQKmcBAjZlvLfDHiRYK2mUrLQFsWVlveWPVB9mHxgJTKouNw+
         WyVTbruxAYsF21lbh2kISLKbG8CSJmEnytABIhbz5dEm7hAgvZi8WTJg3ruLCN1+dB4o
         Y8s3qnALc6Cn0IybtQXDZ+pAi678BRnN5Dn8uZbLZslyMcy/K1c8kVZ7UkPB+qdewN6Y
         zFJYJxU41w1zb/AB12JLFgJcoQYYFNgeiyf4mvmk+niUCzXwGFfexG1rjG20terGM6fP
         5Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPgC4FUtbAyWb6mIBcNHN4p4gtY4LGN/YO08LVdDE5Q=;
        b=ElfM5fWZ6yVCjm9+eLufy8J4vIImppAxN0KKMjAXf27pighTtDJ1Tu9KFkdWsm7pX8
         VY13eYMGm1PRvGajaRQibO3l1ZUwkIVjf1FQ87Hv66+sT+Wy4VsBUogyEBOtLkQLA8Yl
         235B0CwxGZkcnmH7PnD2EVUU1m6FC8iWWdnb1PMwbg/EJrNGZaLFc+8svWsQdEKMiG5J
         izPPLdwydqK9xdybnm3D5zklVcdll8SrcpiB3PY/1AtJEHaDJaeY165r0Un2hUPHD9l9
         q6CrM50ropPUwoVC9/Tpjehed6WGG8OaKHf5jjWd6wjIeWHkQMI5FkmnxM4hOtIWgdim
         v9qg==
X-Gm-Message-State: AAQBX9cAinXpeYKY5Wjau1bynLvAIdoWAcvqpRLOkQZtlK8Z9DCyUKdm
        O127nIcb0iQkvDsStJXeYWuLZbfyEGwJqcttjdn/XholK5Q=
X-Google-Smtp-Source: AKy350a1s9W52bSFczDwykNXvlHuK/b3JfX5R8uPE481mkFS5kfg655+wDWfG5o91cee9N7hM4FsWvhD8eJXhhptMos=
X-Received: by 2002:a05:6902:18cd:b0:b74:6c88:7bff with SMTP id
 ck13-20020a05690218cd00b00b746c887bffmr15258ybb.0.1679605023283; Thu, 23 Mar
 2023 13:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZBygZbz5E6jVNp3y@ugly>
In-Reply-To: <ZBygZbz5E6jVNp3y@ugly>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 14:56:52 -0600
Message-ID: <CAMP44s3Bxbs6gvzXT336TtXpis6BK2tzYCGhnmMWdYfLgp5zSQ@mail.gmail.com>
Subject: Re: limiting git branch --contains
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 1:07=E2=80=AFPM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
>
> moin,
>
> git branch --contains can be a rather expensive operation in big
> repositories. as my use case is actually a rather limited search for
> commits in my local wip branches, it would be helpful to be able to
> specify exclusions for the rev-walk, say
>
>    git branch --contains deadbeef ^origin/master
>
> suggestions how this is actually already achievable efficiently are of
> course welcome as well. ^^

Because I saw no way to specify only the actual commits of my
branches, I wrote a tool: git-smartlist [1]

In particular the negate_upstreams helper, which basically goes
through all the branches and does topic1@{u}..topic1
topic2@{u}..topic2 etc.

[1] https://github.com/felipec/git-smartlist/blob/master/git-smartlist

--=20
Felipe Contreras
