Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1553C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhLUV5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUV5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 16:57:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A37C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:57:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so644498edc.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AxZZ0+b1jHlvIPz6k97dAsR//+P2tpmmHrskASac2TI=;
        b=EmEU6RjTrKNWICqGP7OWipQj4TBhwoZut5EpAbFPOSnU2VRXOxRWLnw3S9iFBlCDrv
         LJEd3kObX7MLHtmxn+QwNWpCYcaoNk4cK1+ldgNdvv/m9va1BjtznM+V3/nwXyY0T+f6
         cWkCOmvbWVfftjYKVLaIW3uc+vYlvF7hr65jy5bOl2CeRe5tT6Y/dbD8lKpB8c6/IfFB
         DtoDTsXcnqPEZEopv/kEPgQRQ8YOH8PKLB+EkawUTLY7VNIjugbfFNmFXesnY1dsylsw
         0t1vxf4AZ1xYW2BvOMqWA+1KqwJjAesBCg3KU0nhaCp2SOUkcUOcwsBwj5CV0RY+qINI
         8acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AxZZ0+b1jHlvIPz6k97dAsR//+P2tpmmHrskASac2TI=;
        b=WewoLtD7ZR/x0+It5Y3I6jeNTBtb7He9UGOP+YpgcNfYM7hr79AK5T4QvtJVQT1dH6
         NRq/5wW44rP6ngDWyESJ3LmE04Q0mHLl119OKOlH14wHumtmrgQ0GoQD99uM3GfipEIp
         H/HfhqGHQ5d1S0q14A1K5Co4FeE7YMItsf+PSEmRWaKC5yyR6YoJaLfvLaW+30Wtii97
         kcSXjJLjDnPSXhH+uUVBq+1kAp/lQm2k7mk2FtS+q0u3zQNhhtIvlOg/LSLOz586/vZy
         eioISQlMh9q/s+9g4vLGreSGl9AcNnNpbWfYy0jfJXebkK39LbFJufMdChIdrWkA36N3
         Av8w==
X-Gm-Message-State: AOAM533Ci9x8h3luWrGNEmGgu6vHPcHM9Jx4nKaEs+UfuWjThLX2Rl5Y
        JOfyedVyyl7mND1TGWEc1j5wRG6TUH5AtfZHmYw=
X-Google-Smtp-Source: ABdhPJx1UJLtaEOfdr+NcbfO9Sesb6/0vkKg5F8Icg7pjgw0nLwAXzYaP1WEITvIwKmgjnsHp+AEpFW3gWTDk/fBN3o=
X-Received: by 2002:aa7:c550:: with SMTP id s16mr252324edr.320.1640123861830;
 Tue, 21 Dec 2021 13:57:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
 <211221.868rwdr6wc.gmgdl@evledraar.gmail.com>
In-Reply-To: <211221.868rwdr6wc.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 13:57:30 -0800
Message-ID: <CABPp-BHZH=hdEZ=iYQK_Gg+3aXmJj4uv4SZcJB=J4_K=TTKwHQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] ll-merge: make callers responsible for showing warnings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 1:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +     if (status =3D=3D LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     "base", "ours", "theirs");
>
> This & other messages in the series have warning/BUG etc. starting with
> upper-case.

Yes, but I'm not introducing a new message here; I'm merely moving an
existing one.  It's important to me that readers of this patch be able
to verify that I have made no functional changes in this patch, so
fixing the case should definitely be a different patch from this one.
I kind of think that fixing the case distracts a bit from the point of
the series, and the series is already kind of long, but do you feel
strongly that I should fix the case with a new patch inserted into the
series?
