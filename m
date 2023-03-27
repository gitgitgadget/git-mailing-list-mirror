Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C69C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjC0KRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjC0KRc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 06:17:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE512F
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 03:17:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r187so9823962ybr.6
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K//sqDqP7G6c8NjXRFFXx0YYvUsTGlXDpD/id+odkA4=;
        b=EtzdLGQWHqWBTrAPUOjeyM+c0RZtYBU5R0JtiQMSVFzGYTil2CYgSfXP0DQYhGL6S0
         Yc189itMjc/qIQu8PMKO5XJcidSCIceOxssMm/I6DFoBmiJXjgwijwQeG36c2bw6Odlw
         /1mWBfJmwQjXtVeFUiY4/BryKu0dNumXokHuYRxD1cRTwa8vpUhToSMMs0ROgO3I9jlB
         fux1YgtWWiRk/6KJx7p/DIZTp4GVLn1zFjuEgy6oW8NG8j9Nb7EeFBBExWvPaWDlqw1E
         zxqY/EcF/bxaugjG5trV39kXl1U38kS9udMYQVBGcQmg0/FE3yhTeId8fRoXHGURPCTy
         TJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K//sqDqP7G6c8NjXRFFXx0YYvUsTGlXDpD/id+odkA4=;
        b=57UXuWoMWmZUTqDQX9bHwPRusnsvXc5Id4FF7oKVkeo5219Zbt5FnErvBrDl9nmHqO
         EIhLivZ3D1fmkujgHd1dhNs9e145890JY8VtK7eol0Bsz/mUNZy5Ri/yig9yOhu6Xccq
         seuxdgowzUq2MNu0UNe8fpq50egzy8x5hsTESiivkhJBZ3iUCi7mo7aZgCdBwXOtRFlw
         BBt7XbnaO60CyaREbjnjj+uTbTE6yM4ZMJoVx0L+07c79aYZ6I4nXAJDIk7/GWpvg1Tq
         pvzC1G3a8cQ3AJDDGGTA8KtZuUgWT4OsSHZiUHhHMkvU/Sv5YLpgNiUYU5I+B+5gCeMo
         gnfg==
X-Gm-Message-State: AAQBX9ccsMlF+ngd712UfXq8ywubOfo06tSHNRMVCSJWdP+qfA2OQzs2
        kD6RN+Sb4Oyj6yIw2ePfs9XkY8diarltvhaq5Zg=
X-Google-Smtp-Source: AKy350Zh2eL+Bv729+V2ASRQqaBMvgwTUgQqumgGt6SpyIGInvaP/bJcY04jYa3YrWt71vhXef7datT2HCmHCjSlHUA=
X-Received: by 2002:a05:6902:10c2:b0:b21:a3b8:45cd with SMTP id
 w2-20020a05690210c200b00b21a3b845cdmr7345599ybu.0.1679912251333; Mon, 27 Mar
 2023 03:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com> <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
In-Reply-To: <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 27 Mar 2023 04:17:20 -0600
Message-ID: <CAMP44s0jG1CQMygMASjEe8Uzu7rOrNuxUbjS05FAA=zBwMV72Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] gitk: handle long command-lines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 3:41=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> this patch series saw a positive review from Junio (thank you! I know tha=
t
> you try to stay away from Tcl code, so I appreciate the effort very much)=
,
> but apart from that it simply languished on the mailing list for more tha=
n
> two months now.

Two months? My patch which contains an obvious fix [1] has been
waiting almost two years.

> Paul, is there anything I can do to help you integrate this into `gitk`?
> Or is it time to pass over `gitk` maintenance to the Git project?

Or just remove it from the Git codebase and maintain it elsewhere.

[1] https://lore.kernel.org/git/20210505211846.1842824-1-felipe.contreras@g=
mail.com/

--=20
Felipe Contreras
