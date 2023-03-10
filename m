Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6CC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCJQ3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCJQ3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 11:29:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B45D1ABE1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 08:25:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id fd25so4000318pfb.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFeYPQsSiFXjEy8UJcvUpD8d3Vji49bH+JP726NS4Ck=;
        b=RaZGm1byVn3WyzVAD5WGvE82rV1ammUYspOw6oDw2JiM9lAHg6J8MMKu0RInPB2n+5
         IJ8HuEUdXMGEPjtgDxQY2H8DQYoAutCYGy3FIgiX6tGP/KK7xe/P/ju3rw8ZDB4D2qlj
         myRyIawnTzQOLJiA5TuqlYzWwH4qvpdmZRkVSzDcHnHpX1w+EZvE+zFvFRkzTz5lskhw
         zAIGiEIkLYWsLOWHYHYYHR2EzuOCOxHCclotYA+m8ZmROx8yeBCJZ7g28bLuMluZqCLd
         Yd/Ca2ztJ6GerZ7BtscLJARxrVZIbpTj0xat8Anmjp9Jr+ytAg14tC92vubUSsYkorK0
         cBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFeYPQsSiFXjEy8UJcvUpD8d3Vji49bH+JP726NS4Ck=;
        b=Lp48OEWMzPCELHwWd/HGO2jo/AzxzS4E4d/ZJfVd6keGq9QXOY2dny4cP31hOs+KjA
         H1gW1XmewySQViYVCYpviSkAUgkGgp+dsTuy+0tEgMA/Z+DtrgIXXnbRr5yqiZyxe4Ak
         SK7GMXnNA513mQmebmTbk7Wa9XXQfsDUKixSRxmW3hPs/G5yzBqnFlo8jIwPPUufBvcG
         /7Xo5xld/jBlg43DTvLiGN7XAs6O7yuDcqFXzppr/OFy/urI+4gsvb4PqpRyt114/Dtx
         /9UEzjCtRWawcJJlUsagNDJBOfqzqqAsX2PgdstGH24PHYheYt+DdAVagyfqjr+MuH0W
         uhzw==
X-Gm-Message-State: AO0yUKXyAiU//L7nRsPcXJyui0RNuOv/69fT3emJqdyprgzlJPUUkNLj
        EOJlkgGZ/QGer9b9Gp2Y6L3UTpa6lDmsqt+ybz4=
X-Google-Smtp-Source: AK7set8mUIIBNm4V0rdgfOtu8ZXyRYi7pfKLzX3aQbGVBqicFjB2U9/s1Tm8Rz96SQk7+mgZgST0ikTx3AJk4IOseF0=
X-Received: by 2002:a63:7349:0:b0:503:20b2:483c with SMTP id
 d9-20020a637349000000b0050320b2483cmr8972048pgn.2.1678465537833; Fri, 10 Mar
 2023 08:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20230308192050.1291-1-royeldar0@gmail.com> <20230308192050.1291-3-royeldar0@gmail.com>
 <xmqqsfefrn4q.fsf@gitster.g>
In-Reply-To: <xmqqsfefrn4q.fsf@gitster.g>
From:   Roy E <royeldar0@gmail.com>
Date:   Fri, 10 Mar 2023 18:25:26 +0200
Message-ID: <CAOfFamk5wWFuUgn4uEo0JV0siLzH=ybDB_Yr-9oL3OM4taozuA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] status: improve info for detached HEAD after clone
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

First of all, thanks for the thoughtful response.

Junio C Hamano <gitster@pobox.com> writes:

> - Adding new code here would mean that the result of parsing @{-1}
>   and what wt_status_get_detached_from() will report becomes
>   inconsistent, no?

If I understand correctly, the result of parsing @{-1} is the commit
checked out before the current one, so grab_nth_branch_switch() gets
the commit we've moved _from_, whereas wt-status::grab_1st_switch()
gets the commit we've moved _to_. After a clone, there is no commit
we've moved _from_.

> Yes, the head may be detached at some object that is not a local or
> remote branch.  But what is so bad about reporting the fact
> faithfully, i.e., that we are not on any branch?

I thought that we try to avoid showing "Not currently on any branch"
as this message is not very user-friendly (see commit b397ea4).
Furthermore, showing "HEAD detached at X" where X is the abbreviated
hash is more consistent with the behavior of the detached HEAD advice
in "git clone", which says

        Note: switching to 'X'

> I personally do not very much appreciate the extra info that is
> given by saying "HEAD detached at X" and "HEAD detached from X",
> compared to saying just "Not currently on any branch", especially
> when these X are not concrete branch names or tag names but just
> hexadecimal string that needs to be fed to "git describe" to be
> turned into something that makes sense to humans

It might be better to show "HEAD detached at X" where X is the concrete
tag name which was cloned; but since "grab_1st_switch" digs in the
reflog for that information, one cannot figure out the tag name that
was used when the repository was cloned. I didn't want to complicate
the current logic too much, and IMHO showing the abbreviated hash is
the best thing we can do, and it is already what we do in certain cases
(e.g. after "git checkout --detach").
