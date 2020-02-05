Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE0C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE3E2072B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssCzb492"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgBELeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:34:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgBELeW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 06:34:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so2321081wrt.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EYSqDc8qX+ZeK1LODSuEHa/lRjVvFdeFiZrVN2AnzfQ=;
        b=ssCzb492UMLdmF+JhzP6GHc+A5a273V7hhdFG5ZkBMcIMqP0iaPSmGk8TLOQhInGto
         UJbYmJDHiScIzWXlGMO157P9okoN8SO/OOl2/rSSFVh1dy62pcZVUuQzJkRK104PS08c
         2lTrIwDaSQPSmpAbn7lpyXLDQbwKQRjco+cK21zpEbWbVCbW5nCKHZffnMBhMiqi/Gt+
         v/oDZ33k1K/IvuEVzB/J/jRAoDMp75urmpgNIOPAYZRMOJoAqeXNQ8ywSNhtjLAb7mRU
         7c8uCA22vZ+udpgYzqDXrHUOBPr4lIMKZhE4garX/BCcW5vw+8i6yCVUn3VsSlKvLune
         5PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYSqDc8qX+ZeK1LODSuEHa/lRjVvFdeFiZrVN2AnzfQ=;
        b=RUkDUuI84UXIebQVQGY6Cn2Tstt08ZK7JEno95eWd3nf0y4LLKqHxKbBGuoEAUe3iP
         DnhhN6ZEqk080tq3cg6RerXhF7+8K9mENFef4Vg7OeliYD+LXm6VSb67jIeKVvnNGvyo
         VtUpk0cHxqdjez36f/9ZL8rtxixFr27WdATWKbrCmWsY5hsnXtE5CVH8NBuj/Q38VQS8
         r9xWLR6+tyZ5sj70ZTqboNa6ePkIjmxVMeSds/0pHLX86EXdwwpjsaH8urhui3FyoSMY
         bcdDVa5qTwGjYYGJ3u9e+dV1EtfHDfy77OF0OK8MKa0qaA//koBMr4Z0whr8+e7Fr6P5
         skkw==
X-Gm-Message-State: APjAAAWvWFAmUiHJi/eDs4hzdK7N12b6BwVmFKi5v9GshZ0E7Oh2vbnn
        UN47LWz/5xAEUFxrkAlSz/h4sFKbiOdBmoxgTJ/MOw==
X-Google-Smtp-Source: APXvYqyzSNw5fgPuqOXuZ9E0S5P8ZcGvg1VGM3Px3r+Q/r5kCzQT3Wp40YDjWm6uY0oKjJg6KIfkez35AvU4AV+OdBk=
X-Received: by 2002:adf:cd04:: with SMTP id w4mr30157912wrm.219.1580902453005;
 Wed, 05 Feb 2020 03:34:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <pull.539.v3.git.1580848060.gitgitgadget@gmail.com> <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
 <xmqqeeva6nyw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeeva6nyw.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 5 Feb 2020 12:34:01 +0100
Message-ID: <CAFQ2z_P3HU3mVvDXs6NXdZrfy0ELdzHFj1-9ibO5NuZdTA2nAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] create .git/refs in files-backend.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 10:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> > +     files_ref_path(refs, &sb, "refs");
>
> Have you run "git diff --check" before committing?

let me install the clang-format pre-commit hook.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
