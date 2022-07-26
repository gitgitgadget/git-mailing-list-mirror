Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49434C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 04:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiGZEEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGZEEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 00:04:04 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F22A27E
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 21:04:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 125so10376312iou.6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 21:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=coS5WhfvpD4oG3O3RNtYHMqbpcEIheTFkSwcnS97+cI=;
        b=XsPprxe58cQJrdjo5Xta+CfvQnOoay+xhNkEy/DB0eQvT+QMcfHuoxEucgHi8M0Pfo
         stPtVn6JiZSs/xgz22EddNRlxCkH7AZpk3WfczjkP5okiDr8MidbWpt/eCbmyWRDhens
         aFEbMYqjGuyWC4W818uUtWN+ZYZ7qyMemimXASiwLkcaipU4swNvA+t5FCbyE7K8jsB1
         zgcH/M3r/H89P8vPCMguweJFPwB5acYClYw7ydDrFEKzq19RebK/gYF2itFYBRlOiRFN
         jJP/gS6fq+3DgSuR83uEg/ETX+gh/CeISCPUg4zRUNaffwzGgsXTW6XLry4pnUYub4WT
         i0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=coS5WhfvpD4oG3O3RNtYHMqbpcEIheTFkSwcnS97+cI=;
        b=LrzgEtobtABGAKu5Q3Bv/Xwxc251FI98+dMM8rYJgGWcUP2OgXqSWFH4Ip2U+sstsG
         KBfm6iEMOStBCtryLMRCuAxu3ekVjG4ajJedJ9k+Ora7+SetHFgWkZWyVJh8FHFxlKOi
         fnUoXSuQrhHJpN6KVuGGlVl0LMEE2ZB49EeUJRtZQMxal+Q0HotvzztSnXttfrfbqIDp
         IZzlc19P3+dksTwx83NQke8ZcsQobF8vYJ76I457eLRQ2v2PJZLPEBRRU0WUXIVqc6d4
         YKWpNvxpOH7ZjeDF73W3FDiYPSxFTsGrsopj2c6U2pY8tfhP5Mzg+7tK3MYbK4xS4SSS
         eo1Q==
X-Gm-Message-State: AJIora+VoLMw9Kh2i0LNdiUb9x9LzMx5kJH+ezx3O64oYJv2tpJXUO6s
        iyn/NkErX1avJo0mNqa+u+szbc70D3OCq+jezs8=
X-Google-Smtp-Source: AGRyM1t2on0BAJpnTZOV9ik6YWruhbWRvuvS8lzmT4cCFBxHof4FX9y4Ah56pq7gneuHtEwevq8cMlE4a/VkeaXW3Ec=
X-Received: by 2002:a05:6638:2596:b0:33f:8e0c:6af4 with SMTP id
 s22-20020a056638259600b0033f8e0c6af4mr6049882jat.128.1658808243240; Mon, 25
 Jul 2022 21:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com> <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 26 Jul 2022 12:03:52 +0800
Message-ID: <CAOLTT8RCQtrPPcC4T8O57dN_ZxGOie7zP780xiuuyv4uwYaFqw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Fix merge restore state
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B47=E6=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD 09:53=E5=86=99=E9=81=93=EF=BC=9A
>
> This started as a simple series to fix restore_state() in builtin/merge.c=
,
> fixing an issue reported by ZheNing Hu[3]. It now fixes several bugs and =
has
> grown so much it's hard to call it simple. Anyway...
>

Thanks. This patch is good enough for me :)
