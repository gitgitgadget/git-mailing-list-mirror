Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F0C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82B7600AA
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbhIGNet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbhIGNet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:34:49 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F5C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:33:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id z3so1704336uav.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qkt1Y2JnqnWeYepGDYCxfR7rHgLdVXN0sRfeB9a3+Ns=;
        b=bZ+gK9UU2R6tJcqQ8hBkemjBqraOGQFDYgznWuwecaehCj5aNWRcYytnV901cVKeqJ
         q5RZF49kyLYyoj6MHHRn6AnUS8gAFCKQUQDn8w9tCHAjcIxrEGqNFqZnRltZWuNSjaJ+
         d7cAVZ+sLNxgrpXtZooB/V4aFcXw+gEuMnBuiuoP50hrF4ZYXQlOjr+wq7klizsehKCT
         kHS5gzcg6noGYHIGSDV1kDgfTVd1uhWBLSgAVGwnP32n5qHYE+Zd58wsOTA6wsmotcne
         Kf6Ms9rnVM0B2INU7op+MSBSmJ7d8rtJVvSxIgHVS9TzMaD3yhYAFUefrc1KJE/nn/JV
         Msdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qkt1Y2JnqnWeYepGDYCxfR7rHgLdVXN0sRfeB9a3+Ns=;
        b=J7Mr05EbUi+OAMqOs4PYeUAdCNp/m1F/XhwgSGrZhCzmA8Z7NIqWU9Y023WcNJ2qch
         ZLibxGz1hFKDaRv7ZAXmV9KVgJTXrA1smwfF/d/t9ghvEDjEkb0031MBUqdovIQQxxzK
         7RBrl9sjfWbbB5j0pObUUrykevAn9il8zp++ISQmCtRmUOkGd6Hy5WF+ofzF4qoCVTRu
         AskrzlQUZGbz983vryD2Dsl32TzNopg1aCag1dSYFLqfvvll34tWtYPXyY5gZn4WucT4
         FankO7VsmQQqk9o0k3lFNNDpNrqzUVjUdr6oRXmIP1o2wt9m7YsmcOs1jnOA9GFCG+0f
         oqmA==
X-Gm-Message-State: AOAM533cJSQb4UnQPtstXnAM4c2VQyX+PULyF9FoM5jkbSMBhDBp7sPv
        ODPkI1IFsO7cbn3vzPkMMQoHm01Lm4FbS1ZbI9JhTA==
X-Google-Smtp-Source: ABdhPJyPjv0qe7gXwlf5druxkaxDoFB94EjNHPxUTDHtQbM/Cvi2a/ekNwajyFsq+CSt91MbIvFQ/ieRsc47rPH0zSM=
X-Received: by 2002:a9f:25c1:: with SMTP id 59mr8486533uaf.15.1631021621977;
 Tue, 07 Sep 2021 06:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com> <11b296a55e9e450575c64ade1a2cb93a1886b9da.1630947142.git.gitgitgadget@gmail.com>
 <878s09nxh1.fsf@evledraar.gmail.com>
In-Reply-To: <878s09nxh1.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 7 Sep 2021 15:33:30 +0200
Message-ID: <CAFQ2z_Oen0Q5hfpbZdzWgJ8D=EetBNGx7sQ3ZxnJSXC-tSKGYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] test-ref-store: tweaks to for-each-reflog-ent format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 12:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -     printf("%s %s %s %"PRItime" %d %s\n",
> > -            oid_to_hex(old_oid), oid_to_hex(new_oid),
> > -            committer, timestamp, tz, msg);
> > +     printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
> > +            oid_to_hex(new_oid), committer, timestamp, tz, msg);
>
> Nit: Would be a more readable diff if this wasn't a
> line-wrap-while-at-it change in addition to changing the format string.
>
> I.e. the last 4x parameters aren't changed, so leaving them on their own
> line & just changing the string & the two oid_to_hex()...

This is clang-format's output, and the new code takes up less lines vertica=
lly.

If you think this is really, really important, I can change it, but I
think it's a better use of everyone's time to leave mechanical tasks
(like formatting) to the machines.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
