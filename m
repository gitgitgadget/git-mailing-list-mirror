Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA330C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 04:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjAAE1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 23:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAAE1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 23:27:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAFC624E
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:27:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso15724620pjc.2
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AhyN32wfX5gjGnfIWulLSndAepk8G92Eg7iv6Wgsac=;
        b=US8Pzq0IAIjgR7z3SwcgkwUc7LCeJ+fJ0vM+yBtE0iLi5i+rkUMTuYMqH/DS1gnu84
         XXVY9U4o1F2adqfmjo+jSswJXuoSIkDBh2jL5T9bVlarzlEziZzHEPnRF0ghQBoXLmPo
         oJwVxSrkzw1kAnqMLXFi9/Vi9MMQsL+TxB4Nmxw0A/Eww2l0nzukyAI71qijOk6zY2eR
         6I47WA8xgqQGm7GnwEEPVZqmtEGQ64orQKaqZsyFuC0vVSO5akgrJB3yYSTtxy5URQU2
         GMVOurcqEDr2cxUZSMaKzxu4WiluJiEmy/u0S65wSxxhvout3qWCa7ovGSnruTx2LIUU
         iuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AhyN32wfX5gjGnfIWulLSndAepk8G92Eg7iv6Wgsac=;
        b=FS939zTYK/DeizE7aGOeUn3jjHbzSymjh6h5mX4mNoPqE8dFiaJL92vx6ZtzcPEqnb
         hIwsbPhNUPgALlDJ/xxA29yCAs+S1WG+qKSNoIEIOZzwMygUp1KolSTjf71qnuK2S2oO
         cu0PbYj8SAUYcGZAMX6aBzczdrZ1KP1ezRrIM/DeUuEeEy03/iefSIf1EHHVtyfhX0Eq
         LjqD5DFh0ckF3CDlIvrukiKF1oFduCFj5mFg+m7Ky/31Xj7tDx04sTN7ffJjpS8NsS95
         y9uDa0npOTnr4XG8GQ/LQGmS1Vvn5ixVB0TOm2hSDX4+lbhJSUfca0g8vsUdHiv+LsBi
         3s0A==
X-Gm-Message-State: AFqh2kq3qziE3Mr0Boimc+HWxaaPBUuO9iAR8wh5S05jjYgRYKBAYHb4
        gIliMNWc9K4XxRizg0WxozcoKTnWNvxQYA==
X-Google-Smtp-Source: AMrXdXsy6iuGXgxPyrItL+RsdQgh02GdgX4a+W7T40nMVD/KsNjt59i1RSV0L1tlTCKC5NL2RQSocQ==
X-Received: by 2002:a17:902:6bca:b0:189:d8fb:152d with SMTP id m10-20020a1709026bca00b00189d8fb152dmr38502534plt.25.1672547268315;
        Sat, 31 Dec 2022 20:27:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902b71000b00180033438a0sm17576123pls.106.2022.12.31.20.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 20:27:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 00/10] sequencer API & users: fix widespread leaks
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
        <813dc31d-f36a-a4f0-ff99-2373df0eedac@dunelm.org.uk>
Date:   Sun, 01 Jan 2023 13:27:47 +0900
In-Reply-To: <813dc31d-f36a-a4f0-ff99-2373df0eedac@dunelm.org.uk> (Phillip
        Wood's message of "Sat, 31 Dec 2022 15:06:50 +0000")
Message-ID: <xmqq8rimhoak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for working on this. Separating out replay_opts_release() from
> sequencer_remove_state() enables us to free struct replay_opts
> properly. I've left some comments, the patches I haven't commented on
> all looked fine.

Ditto.  I agree with the review comments I so far saw on the list,
and this topic needs a bit more work, but it is great to aim for
allowing us freeing replay_opts properly.

Thanks, all.
