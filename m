Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4652FC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DF12166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCyb1BRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBDUcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:32:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34527 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDUcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:32:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so24840632wrr.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HR+Gk4Gup1PgUySWY2K47Vv3gToit78nkF93zwrCXsU=;
        b=WCyb1BRpoGko71uCNNjxUD3w11HXLZ1Utx6e84j3uW+GvLvss0rwD+NC7GG3RL39Si
         s2eDWvPv2sltHTLpko+U5wsDrrgqo1py/bIK6ujGoFRpL6R1lD9+dDlA5RIv13UrzhIw
         Cz4ejEdPCMM7wo5OW5iu7dC6ntwsWHMjRsP3s8rDSqKjElQxBF0J8yzYXntBUJ7Ra9FF
         ppxShXGlcRAtzASj59Z8vWpIiXp/4N8bf7RPKHbh1mJ8N3hsxr7CavB4Sd1ZCUJqUoQ4
         Yp3as8RfFZ+1V1Ja9lF7dhxBKfSkyx0V+ZuhZFIXJ262GIhXWXS7xRfdCi2G22ClmQYF
         HgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HR+Gk4Gup1PgUySWY2K47Vv3gToit78nkF93zwrCXsU=;
        b=kkga/A920mN9+8TiNI2k6EAQcwvfkGjj7m2TpBHtGZzJ1KEslVFqx3t2HYTh1Tu1m2
         EsdRWXFmD0oqJ0ibRmrmtq1r7EGdBsoE3IYgPGr9CuvOb/bbmP05B06/dh/5QdadGapP
         XZyqBN9n0rqnVIIdLbwYAzweR2+udbBuTefhA7kqL01Y6J2VeoILB9XvvTOd9HtyX7SI
         1TB6mOgIyImLk/qr9krd9o5IlNxxH+fT8aoPlFfZomVnaEroYrpWzzdhSAS6cQhWIhkt
         I4LobEJvdFMKdy3/h0FcetrZvv1Hf8C4M1hkbVGrLkL17AmCP1xVmsAQ0fAhEDow0uve
         d3ng==
X-Gm-Message-State: APjAAAXNNY8qFqbQojnMqMES5/LHHv9l9ATdsdTI2CEGnAfkEAWBYqL4
        WhdC1201RDcNZJ9ptQ4IqplupLxnvZASdLLt3inMPHIj
X-Google-Smtp-Source: APXvYqxMcIJD5O8jevnBGGMFj0/LBZLOLXiJwxKjTGjLhUVIOYCTDuXU8gr09pkxWL/rMcV+dvp3CCFbQQA9F0qLc9s=
X-Received: by 2002:adf:f80b:: with SMTP id s11mr25290067wrp.12.1580848318510;
 Tue, 04 Feb 2020 12:31:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <pull.539.v3.git.1580848060.gitgitgadget@gmail.com> <57c7342319900e955ff0c14eeaa54aad9e41aa9e.1580848060.git.gitgitgadget@gmail.com>
In-Reply-To: <57c7342319900e955ff0c14eeaa54aad9e41aa9e.1580848060.git.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 4 Feb 2020 21:31:45 +0100
Message-ID: <CAFQ2z_NNNvxDtCR6bZKB7A0FehVsoYn2BMaaHRJisYjaXYrnxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] setup.c: enable repo detection for reftable
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 9:27 PM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Han-Wen Nienhuys <hanwen@google.com>
>
> * only check R_OK for .git/refs.

this patch can go now.
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
