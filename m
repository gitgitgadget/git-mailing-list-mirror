Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C7BC35254
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 10:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C14206F4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl8OkWvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgBQKDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:03:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34567 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgBQKDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 05:03:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id r18so20011663edl.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwgaElpsEm41N39jklx69Feqkx99/75kWUxz3bT9tEU=;
        b=gl8OkWvmr4GLxV5PegaEEqOuzB+cSc1F6Vxb3bZlEcl/fdlNz/fQ9frNHmHLveQ1zA
         KmIZYj0RS0aY+SoNRZpnCi1lsiKD+/2RU7Y5FJTjcDwci+6cTy7abWmqQXlqM5JNR5nk
         ryz8GIlP1isCra1aMn40A+sc/Ab5OhrJTGia4zAYznIA5eK/bvYwc4kqWRmra7WZsBG1
         2WK/G+iWaan0IGjfkRhgRC+q3g/LOoviif4ChZbJC4OVMa3m/c7aaZDsWjObaUosb9eM
         PEx1YJitMxeML+wQhlEHetDfM3ynmVPgcEPfAQSvLhqcgbABSswpZmmN20swlIurpIMt
         HLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwgaElpsEm41N39jklx69Feqkx99/75kWUxz3bT9tEU=;
        b=pXEq/Z8D+uANqMlDWD90CZZOjhn6tg7tfKx9eiwmRIBV9xi8a0kZuh11qgwIB8lJC7
         fuVOuxlO+iK11m3zR28wxF5+MJDR6356zeuZIUbA1HNn1r847ZUGEYtMoUSytLK6J9iq
         ue/K70ivResxB4TJzdFDBRRp0mR/vvX/8Oatg65gfvXSVRtPSWjcX+o0ckG3Rg3nlcJe
         tecbpUlxvraOBJ4EBEpmZt/2i45rAquQlMFBUSvc0w6MJzRy7PzFXXFkVA4AsHpoRz1B
         Wc12Ca1D9fG943pn8gzbE/Fj1TSdmehlA9EKg2k5km2Q0pab63fhLKeX5iogaMojS/ZJ
         jorg==
X-Gm-Message-State: APjAAAVpKGAbIJO3XnXBx9QzGbrWXmNK8E1e7MvMDm044B8bJ1Ha/Bfr
        MdJDFIn5940sT0Y6tA3PJYA1RRdKVCD6SqHh9n6gnRE3H9w=
X-Google-Smtp-Source: APXvYqzTimdWNFgDtmN3ipfnvsbTcGMJdqf1dTCoV0Wble3d14dTsX6AqhBWx+egkzn6LZalFjHz6WFv04Ui+KI75Y4=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr13771978eja.77.1581933809311;
 Mon, 17 Feb 2020 02:03:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <pull.548.v2.git.1581889150.gitgitgadget@gmail.com> <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
 <xmqq8sl1nb98.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sl1nb98.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 17 Feb 2020 23:03:18 +1300
Message-ID: <CACg5j25nNAWqXP6jXUBxkwC=hEd7_9Nw3hfQNpPKgEW1JabxgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] advice: refactor advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 4:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>And I see that now you are going all the way to discard the
>string-based keys to enumeration, I think this deserves to be called
>"revamp advise API".

Fair enough.

> There seem to be a handful of lines with trailing whitespaces.  I
> think I've fixed them all on the receiving end, but please proofread
> before you come up with the next round.
>

Sorry about that, I fixed this setting in my IDE a while ago but looks
like it has a bug.
Will keep an eye on it in the future, thanks

> Thanks.

Heba
