Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E7E810D9
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjI0NqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjI0NqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 09:46:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB48139
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:46:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso6033470a12.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695822379; x=1696427179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j65siwB3SIfB/OdyEwbaGMMQGBBaxaoR9/UpYHu9W0E=;
        b=VEzDdBd9kJzJ1fY33O6HfQLlblTpUJHO6nLEhQopOskwl009ihxNEEsUEmGyEYjnrQ
         PxlzCMAtnM6kaTGtr616Rym3Ly4W+GdtbijlJzQ5LKJfhRO9gmeT1YgzZ3H1f/ZCDVqE
         ebi8eRBcjaePLRjtwJ9aNzWJI37/OY6jlMyD1YffBb2cuOYc67JJJmK4JhpEbGel3eoL
         UyH6akQ5NEpB0vgaGh2Nd3QXWas6y2ujQif/MYNQi5Il2GWdgyVMJLgbUfazTzwBoM7I
         PeP9S0vbeW0qCGq1pbRhj2wLmzEQuwmlGNRmzJDvsDurTdaxkA7Gtwk1m2arPO6ohAWJ
         6ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822379; x=1696427179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j65siwB3SIfB/OdyEwbaGMMQGBBaxaoR9/UpYHu9W0E=;
        b=vvZRYhtzragfUOOJ2EaJiWc8NQqqwCWSTHcL5i7WBStKkLSlXJWenS8EmcRWyluhwY
         IR6406VMTl7psR+sTak0Dm/Qi85Fdy1ujGkSBnWYyw6wwhMYc4cOf4qCKthm5k46zbi5
         AFLkdTdGKV3DlRb0UaBI9KrSJygMTS4eALufPoFqYrIkQO8E3gebVBfg76BGl+AwG7W3
         JjgAa5jVZTg7/K2Cyt93fqjUrdNeYxxeD9xTlZ7285Hu4xttKX0zDy+pqq8fQfdoevJD
         DcWOnEz9gOLFi1yWs01sW3jzRrv1wSt4H01btHbrAEX5KQIcwmlOEkjsh6kwFp1h4cqX
         bChw==
X-Gm-Message-State: AOJu0YxtyQSrgIXTw68TIiWfnvnlB9nfd7jkkAAUYqMu1GIq3h1ftJoR
        dF/KqW0AGKvKWk6wIJ6O5MXS95p3jJ6erWh2R616jirW11g=
X-Google-Smtp-Source: AGHT+IHvSxAJDflKTl1yHRQR5InmnEvCLEz2OtLr1wf+BiSMgnt/YvTvfOGSb657NiOv1l+aYPu6vVM/mDhzxaLj7bQ=
X-Received: by 2002:a50:ec87:0:b0:52a:1d54:2531 with SMTP id
 e7-20020a50ec87000000b0052a1d542531mr2192604edr.30.1695822378530; Wed, 27 Sep
 2023 06:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbkdometi.fsf@gitster.g>
In-Reply-To: <xmqqbkdometi.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 15:46:06 +0200
Message-ID: <CAP8UFD0FLsEV4y4W8Vkr5PP_7F4x-nLdHUVx5WRP8BuJnW869A@mail.gmail.com>
Subject: Re: [silly] loose, pack, and another thing?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2023 at 11:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Just wondering if it would help to have the third kind of object
> representation in the object database, sitting next to loose objects
> and packed objects, say .git/objects/verbatim/<hex-object-name> for
> the contents and .git/objects/verbatim/<hex-object-name>.type that
> records "blob", "tree", "commit", or "tag" (in practice, I would
> expect huge "blob" objects would be the only ones that use this
> mechanism).

Yeah, I think it could help handle large blobs. I guess it would rely
on the underlying filesystem to store the object size.

> The contents will be stored verbatim without compression and without
> any object header (i.e., the usual "<type> <length>\0") and the file
> could be "ln"ed (or "cow"ed if the underlying filesystem allows it)
> to materialize it in the working tree if needed.
>
> "fsck" needs to be told about how to verify them.  Create the object
> header in-core and hash that, followed by the contents of that file,
> and make sure the result matches the <hex-object-name> part of the
> filename, or something like that.

What happens when they are transferred? Should the remote unpack them
into the same kind of verbatim object?
