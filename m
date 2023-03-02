Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A0C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCBXKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 18:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBXKH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 18:10:07 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133A16AD8
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 15:10:06 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-53916ab0c6bso10709377b3.7
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 15:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8FelYPByQzJt1nrMn8N6bhdjJ/JMPOdU5HkbSBosmk=;
        b=EuJM3Do8MQSJwasJI5z6RyDT3wTjadpPha13KHQIV5Qe1IRVQ8AoVvyHlpCwF46g8S
         hX/wzwqfNA4U6bZhuBRDW0A45Hbxntz6X8IRLMQlPUpwkqPswN4s5D+W5Phx0m0G3Sxp
         jb5WcoOTgzOP9etxBwxkFSQelumeWZkM1d19WyeQooJhTiw0MhbHBfKqlS6+CZagQw6n
         PA/0b6i9/bisJ6AF9MKJ0UisFXLIHRGCVy+BqJu/QkqrnaXBACgdHjppwslBy9txPxrT
         zZJQXxohmj5TTUETIHB/m69HRS1PH98qCnveTSxdtP6T/BgfCAHy2SI0pmYAto/4J9q6
         M1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8FelYPByQzJt1nrMn8N6bhdjJ/JMPOdU5HkbSBosmk=;
        b=usGwcsyG+dW3UvMF17yZVltbf/7Rbce3wtS3NwFQ9n44lTP5fr9lOsHV8BuwPZJbKb
         dNxPvExyfdwwjZJb/iXZ2TyfDzgH+Urypw9slts/j3Fo4/pqml3dF7mNBU1Wj1XATg7E
         andMkR2ja5/4whcAiNo2PZHo5Ufc9V+5HeiI5l9AMobMb+zpIVyV/x6o4Z8YW3cKI7YA
         z/9xoetUtFePJqyeFzor/ZxrKYaK52bgjY0l+3xx7qW1uytVXN0BiPjqYt6GdXMjUl/Y
         XATR+TODHwBYroUDElG+dpcR1542eILnqRO/yVtJDhMBPuW1MJ7Da6SrUgjdsxX/BFNc
         Uzog==
X-Gm-Message-State: AO0yUKVB7ICWz5nuanbZNwRwOgB771lQKVx+RKvdFbntlMKvwqnfZl8V
        CpfamAXMAwYsrTfUoc9OJVWS4d//NH16dYEchdA2iA==
X-Google-Smtp-Source: AK7set8pOym/RP/EarYAwRH8LD2Qsuwo4JlALtwYClk040X+CFO0LajwUKSuFgsF/N8PZLCy8zI6xdsABSCe7qS3xEs=
X-Received: by 2002:a81:b664:0:b0:52e:cea7:f6e3 with SMTP id
 h36-20020a81b664000000b0052ecea7f6e3mr7251253ywk.10.1677798605881; Thu, 02
 Mar 2023 15:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230228185642.2357806-5-calvinwan@google.com> <xmqqpm9tpdmw.fsf@gitster.g>
In-Reply-To: <xmqqpm9tpdmw.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 2 Mar 2023 15:09:54 -0800
Message-ID: <CAFySSZBqN+a-mP=+epz4rELYH_aLnrTC+VRFFTvib0W0nUBQ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tests: remove duplicate .gitmodules path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, steadmon@google.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 3:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Swapping `git add <submodule>` to `git submodule add <submodule>`
> > in a previous patch created a .gitmodules file with multiple
> > submodules pointing to the same path in certain tests. Fix tests
> > so that they are run on the original added submodule rather than
> > a separate manually configured submodule.
>
> Doesn't "git submodule add" have a way to give a specific name other
> than the default taken from the path?  If "git add sub" is converted
> to "git submodule add --name subname ./sub", wouldn't these changes
> become unnecessary?
>

If we converted to "git submodule add --name subname ./sub", we would
instead have a different set of problems. For example, instances of
git config --add -f .gitmodules submodule.subname.path sub
git config -f .gitmodules submodule.subname.path sub
and other similar lines would still need to be removed to prevent duplicate
paths. That, however, seems like a better alternative than my current
patch which replaces those removals with different ones.
