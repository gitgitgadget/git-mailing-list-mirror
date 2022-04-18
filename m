Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261CC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 07:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiDRHH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiDRHH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 03:07:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B7CDC2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 00:04:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o127so8238577iof.12
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kapr040vmaKdpfCbTtD69N5qYkAGxoePakxueS0DZts=;
        b=XaDiXIY54XFTDTOEoywrJF+nTRMm+iA4Txepa8hoy4HBB8biyIiVMNGSB62ovcVhJz
         sWY09n45N6gsKkco0SxQCyoCdeSYuKttsNEa5QsxL2U9tviT27HAsyqm3mju3PVOe7SI
         x0ye4kV20duu/z4H1P12kyUJXO1V/v8csDQzkU/BFjglPVJ1sXnisamCoKFaYYw0Wc+J
         UGFNz4MbIBczSLQj/B9LE5u0X5CyV0zV4nUvLu/68JLFQtQlr6VnM6YzzHc1Ue5z4R6s
         rV5mxoKEJS4EqE+Nt6MW7iosNLbCy93a+UWp+8mRJz2U/IIfN0VVUzQc7W99kvR6JeUa
         mW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kapr040vmaKdpfCbTtD69N5qYkAGxoePakxueS0DZts=;
        b=BwP+zqMZnpy87W8TD3RJD0Li2KaDXggmcN/bAv/GiwUfOPJEghDUqJWL18iC3XTZay
         HW+m2bS3rvJONMy4jsTgopQOhTaA1Vun8guq42Znjfj1c6++jAk7+/cG7acrccMKDdAi
         8sFd3AultDlCPDHQCIo7ZOpvd+YQvdEwvRujVbQ+n1JeGT/GRLNno1uPCadIPijpMcl6
         i1r1P7B3ZZeee+8un2LSXKoAtWyhxBGgg46J//2WCFG4EHv1PcFd/ryKXoKWmGhxpA33
         k4GuwMOnDLjMCPodcKfx4+cSMUHrdlIizUKU1WgMeAW/ZcY+voRJIOM3KIQrPXiDOeuT
         Zhhw==
X-Gm-Message-State: AOAM531vucykxjBRyMdLpAiVwjqR51SKoKzEfb8mZiZnC1x2psdUdNlR
        7TZpIAHigGv5KLa6A4AUq1nudptflp9Zjno5+hv1QGCIGxPXtQ==
X-Google-Smtp-Source: ABdhPJytJ4hZlzFqrSGU62y16e0pVsVUnFgB7GBB6O/W3C01k79PlrCD4Cdk5fcQwlE2q6pFh/fmNDgS6pZOIcu6H78=
X-Received: by 2002:a05:6638:1450:b0:323:b114:c831 with SMTP id
 l16-20020a056638145000b00323b114c831mr4589438jad.285.1650265487418; Mon, 18
 Apr 2022 00:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
 <CAOc6etb7fmO2FAv09+wHsDBwnLsBi+B-CwRarm2tfYS-aUWcfg@mail.gmail.com> <CANiSa6g7ShxTXNEyJEyb==qCYNAMrNf30VkDPaydvOo0Bm+Onw@mail.gmail.com>
In-Reply-To: <CANiSa6g7ShxTXNEyJEyb==qCYNAMrNf30VkDPaydvOo0Bm+Onw@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 18 Apr 2022 09:04:36 +0200
Message-ID: <CAOc6etZmLusw4fxTx=9Gm6W2L4cSdOKQP_eX+23HGpdd=r1omA@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2022 at 7:23 PM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>

>
> My (Git-compatible) VCS [1] is very relevant to this thread. It always
> treats the contents of a merge commit as the diff compared to the
> re-merge (auto-merged) parents. That applies to diffs (like
> --remerge-diff) and rebases (what Elijah suggested in that link above)
> . An important part of the solution I went with is to store
> information about conflicts in the commits. Note that it's a more
> high-level representation of the conflicts - not conflict *markers* -
> that's stored in the commits [2]. Adding a new kind of object type is
> obviously a huge step to take for Git, but perhaps you can consider it
> as long as these objects are not exchanged. Also, as you have probably
> noticed with your `git replay` command, this kind of rebasing without
> touching the working copy or trees can get pretty fast. I didn't see
> any performance numbers in your original message, but you are probably
> able to rebase >1k commits per second in the git.git repo [3].
>

Thanks for all your input (I mean, everybody who has jumped into the
conversation). In my last experiment to get this into rebase (and
still without moving the working tree), the 900+ commits that make up
the segment v2.35.0..v2.36.0-rc1 are converted in some 143 ms in my
computer, which is an aging dinosaur.
