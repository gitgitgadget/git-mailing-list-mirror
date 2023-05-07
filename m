Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D4C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjEGUeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEGUen (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 16:34:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40CA5F4
        for <git@vger.kernel.org>; Sun,  7 May 2023 13:34:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9a824c3a95so5088086276.1
        for <git@vger.kernel.org>; Sun, 07 May 2023 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683491681; x=1686083681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR2FkSBOJliAJH6QUuIuCYavXjxlUtuTW6CriwTy4Vg=;
        b=ODZID5LHUvuqdlyHuzyISObGs56JyTGay4KQ6Q907oZ+6N/+vO0j0+2xFsgU2Pg9OB
         H6I8AWxKJNpAlvxl8wsv/Vno2JpklMb0nHYE6VmqMQU2Gtl4VVhu59mba7tSa+zxJOCf
         T3mHITbRBpaLoD/B1EBhY/jc6dJEt59tR1IeKDmpiefGqYCBjV7UqSBWIvhisPqEYoou
         0qfF0HrhIJA1hOB59No+l5KBLNrZ8ZlRbjko0TXbZkGHbPJYCPb70rC1LasnB9eMCHd5
         /sotqapqWYWRxMQ4ZHq6AHqH6eW+B85EVw6M9aT5OGkFOdxQt617krfMWoR72mUjcvFg
         e/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683491681; x=1686083681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR2FkSBOJliAJH6QUuIuCYavXjxlUtuTW6CriwTy4Vg=;
        b=Vt+fOWPfHXv7uXvavLjXgb/Gf6AsXRvpDAshAdlwgPgL79cD37+F3xK4pv9i/NmV/m
         Qy0tZuXyBAx3BcmLd/vHn1gaVJP/GTXTgY/L3czcZOX88rFnd9jI1OkO1A0BxekfePEi
         BK4BWOlNRLyHh7d3fYE2n/bdQz4nZ2x1gxt9KmL9VCxfrFypmq63vjteIlekYHENqEpy
         uTw1fK7w0vKKiAdDWDsFInIDhBpB7phjHsr+Wh+6Sygbvr5muYKRM5PmHcOqn1VhDGkU
         RG+1CcQoZlgNLWXXun0tWabokyLiIHXIKLwat4ilW7NZ50p/JjkJotIkIFuZI0IWTLy5
         HY8g==
X-Gm-Message-State: AC+VfDxAVzE0ZCYQBsDM00F1hkwYkXW2ldfpjXYeI69nDMrIN4efFN+/
        8rnHkopaxdgnhDle4ibWtao1Ulaz2n9PbCF3QUXjzPFSda0=
X-Google-Smtp-Source: ACHHUZ6ehCNaBQZnpjONTzwGcFa+gDGwQ1wo6Qa/tQ+9qGR56bsveaTLfRW1W3U7+OvyDalUman+tLASFZKfr7NK+5E=
X-Received: by 2002:a25:2412:0:b0:b9d:bede:2366 with SMTP id
 k18-20020a252412000000b00b9dbede2366mr9300624ybk.20.1683491681522; Sun, 07
 May 2023 13:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
In-Reply-To: <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 7 May 2023 15:34:30 -0500
Message-ID: <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
Subject: Re: Weird merge records
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Dan Stromberg <strombrg@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2023 at 10:20=E2=80=AFAM Thomas Guyot <tguyot@gmail.com> wro=
te:

> You shouldn't change the user's config - you can instead use
> command-line switches with git-pull to force the desired behavior. In
> this case (which is also the default if there is no pull.rebase config)
> it will merge with the remote (and that merge will be a fast-forward if
> you have no added commits).

Actually no: it won't merge the current branch with the remote, it
will merge the remote with the current branch, which is not the same.

This is one of the many reasons many git veterans recommend most users
to simply avoid doing `git pull` [1]: it very rarely does what you
want.

[1] https://felipec.wordpress.com/2021/07/13/why-is-git-pull-broken/

--=20
Felipe Contreras
