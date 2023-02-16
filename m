Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BCC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBPRVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBPRVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:21:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAF53569
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:21:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y19so2699568ljq.7
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvga86SPUJ91yUP43cBdyFO4BFTR0qeTTbvh6YcpI+g=;
        b=fLZ84YLQsDNUc4yLeGkJ6Exc4l/HQh2cCIahGgq++Qo5Rw5zhgaA7GJbrP9QM36nuB
         5wbDwrVIMEixsL6XdfKH5e4yPtEdzWoipRufTTZgx0S+0uyjRRRrDqKsez/zOZVLfGaL
         8I9mnSapxCIVnvKoxdQnv1rRQR13an0JDY5wmJ/J5w8W42YDx9v/PvUOcAw3I3TBUWKH
         r/jbv/UGYUMWekWNB7+LrttEA6jY7EOXo4zcpNTJDwYfMgSp4n9w+J0ELSha7NuajDEu
         16hC2dgAtaPpDSuS2VTNplNg9s5d/kLbxlKPUHsRrc9JO6qQQU2p5j0YQtQcl24N/Ffl
         0cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvga86SPUJ91yUP43cBdyFO4BFTR0qeTTbvh6YcpI+g=;
        b=x3K7FnfjLZCaojeg3LMsDZClf6bsyqseOJHPe4wgeomfbWijEoyQ6l82UO61CehkPh
         YSqM95Shwa160PIeccaQUfikdgqZJiKitgtbzXl4ZSG3UEB4T2jHMpfb4Fn7T40lc8JF
         4WYYSCEwdp4mgeeLB/x0FXtXCTH2ufnW/tVXY/bRgMnoEAJkaNnSK5TGkaZUB50oNe+U
         SXkfmzvqQXYogNg5NdD0Tv7wH1hYxPfDIW+csazeH3vQhuIHrkFsJj41YLgetlRwa4KL
         zUVbQgyyOgA+rIw2lVxcJ5s50DFxpxvXAvswmqIKqKJMCK1uIV1iQavBIL5+m3A4MCpj
         fGpw==
X-Gm-Message-State: AO0yUKU3uFF4f6RPk4xW6RTtQr+CiX42RrhTRCna37b42tsyWm+tbSFg
        2Cw548g/VNr3KZGLdErk5N9kmUaSzzXFfNBXFSU=
X-Google-Smtp-Source: AK7set9MZ0rlaM8DpfysFTY91bcDjum05HeZpddUBBnnyDD5d8bKOAWsmR4MPNK2c4g8Rz2U/8M+UoJPWSJ7ifJiItA=
X-Received: by 2002:a2e:a37a:0:b0:293:4ba5:f632 with SMTP id
 i26-20020a2ea37a000000b002934ba5f632mr1884054ljn.10.1676568076740; Thu, 16
 Feb 2023 09:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20230215091950.2976-1-vinayakdev.sci@gmail.com>
 <xmqqmt5ezun0.fsf@gitster.g> <CADE8Nao=ZrF7_0+G=jB8=j5Aji4ndCLfMp-xjbSpc1HKmmFM7w@mail.gmail.com>
 <xmqqttzlr0wm.fsf@gitster.g>
In-Reply-To: <xmqqttzlr0wm.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Thu, 16 Feb 2023 22:51:05 +0530
Message-ID: <CADE8NaqxVZ3oA2rg6ySR6L-t+b9bM07YTKtaDZ3u=N6U_t_T2Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] apply: Change #define to enum and variable types
 from int to enum
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Feb 2023 at 22:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> Vinayak Dev <vinayakdev.sci@gmail.com> writes:
>
> >> As a faithful rewrite, forcing the same values to be given as before
> >> by saying that "_DEFLATED must be 1" is a good thing to do, but once
> >> the dust settled from the patch, it would be a good idea to go back
> >> to the code and see if the values MUST be these, or if it is fine to
> >> use any value as long as they are distinct.  If it is the latter,
> >> then it would make a good follow-up patch to remove "= 1", with an
> >> explanation why it is a safe thing to do.
> >
> > Removing the 1 _may_ be a safe thing to do, because ...
>
> I didn't mean to suggest you think about it _NOW_ in the context of
> working on this patch.  Rather the opposite.  Let's have a faithful
> rewrite first and then as a follow-on work after this patch becomes
> part of "git", a further clean-up like that can be a good idea.

I am sorry, I just got a little too excited! I will follow-up at the
right time, I assure you.

> >> > +enum diff_name {
> >> > +     DIFF_OLD_NAME = 0,
> >> > +     DIFF_NEW_NAME
> >> > +};
> >>
> >> Ditto.
> >
> > I think that since enums start with zero by default, you are right in
> > saying that the '=0' here can be removed.
>
> Not what I meant.  I was referring to the lack of trailing comma.

Ok! Understood.

> > I will do so.
>
> Please don't.

Ok! I won't. :)

Thanks a lot for your reply!
Vinayak
