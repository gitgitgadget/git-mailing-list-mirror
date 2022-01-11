Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0089C433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiAKRGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343779AbiAKRGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:06:41 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1FC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:06:41 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id x33so29711996uad.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FL49/j923vQ5kXFlgIyou1k50VotBG7HQ3uKfp2yXDY=;
        b=Dg7NsV+vASjRDOq9sLhlJUDIsNGAXYPn0HZyay7xlmKDfcvL+hK3HRDNAPkn/ntS+t
         b/uAguBtLpOR6sW7FEvtLm5yOWq6ROKXcfK5jM/n9MTTW1nfGAqGDLNILuFX3xg+bg1f
         0LP/Qvf6hAMfyAIOH5fDRjsQxqTc4FSURKgGKM/DUuAK1z6fPM7vsSR7cL8niExzBR24
         2fmrnP8wbO40O2UWvazcBnfzSM4KVu4cQaX1gEGda1Qfug1ZYrbNA/QPcnVdjRi2KEHP
         vzZpztlDM2/gViMFbcNCXMNdOHU20Cu+LB3l+F84sk5v4PwjAhNUrIEVrExC4Afgq4nh
         tOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FL49/j923vQ5kXFlgIyou1k50VotBG7HQ3uKfp2yXDY=;
        b=tpuNU44w9fHBUAaI+x2xWBR4IP/sYF7LGWYU5t3mB23Rdi5jUkr9GxVKYapSBZsWIZ
         M7ODtbmrIhPGbnVE6dmvWFQzcqrKkTozG8Q5tdEPsIUoYZAKDrsuWzOwRKMeiOI+hQz8
         IFfBapEXbv3VPvCGf5i+/fZ7hU9RrxtNhWw0rTCn4SkvhW8zAU0j7Be2wAhhsOrdGZUW
         lsnAeO0DkcoYGZmPE9dPH7Rakglh0kn41TPEQxGaSVm5pUc6oUi5z3Fe1W1vnTm5CFm1
         6TZfuXoqKpkZCCfdf9Q9AGI9mtX613ikpWdH9yvIW2wfqvvpihFdVqcIMdy4F1hJhphZ
         e2Yw==
X-Gm-Message-State: AOAM5329j+st6N+8y+9bmtoec8hbua8xXlLDO1nKCUNsSlmDKDYsTMdU
        2ByslvYgyOrPIn4fiUfUAa5l43Lrf8M6K/Zg6bGxEw==
X-Google-Smtp-Source: ABdhPJwBdE+uEILCoikzQxocPu+H7KBdY6B0jZhWzu27ADoUP299moEhJJLSF7M4iyar6cwvzDT+DgLDnHKco2nJ4zg=
X-Received: by 2002:a67:f404:: with SMTP id p4mr2548715vsn.16.1641920800343;
 Tue, 11 Jan 2022 09:06:40 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
In-Reply-To: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Jan 2022 18:06:28 +0100
Message-ID: <CAFQ2z_M1skVCFYQ-kM5dMVXcUxV-uR+Zf89dKxgc2v1c1tre=A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix SunCC compiler complaints new in v2.35.0-rc0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 5:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This trivial set of patches fixes compiler complaints from SunCC on
> Solaris that are new in v2.35.0-rc0.

Thanks, looks fine in principle.

For the switch, maybe the block types should be an enum. Is there
tooling that would detect a missing case in that case, so we could
drop the abort() ?

For the 0xffffffff constant, there is probably a better symbolic
constant somewhere. Or could we say (1<<64) -1 without causing
overflow?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
