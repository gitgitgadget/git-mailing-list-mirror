Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA32C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjECTpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjECTp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:45:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251824C2E
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:45:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517bb01bac9so3794480a12.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143124; x=1685735124;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Fgn6zh3gvrMab2LBRqhNeiLS3Yu538Qfty6kmXbT9A=;
        b=oKJ9adTgWlOabzJU1cyB7TEv3cmBvxcy0IRB7dPB3g6mHjau50M73VTU5mNANgaobD
         XDnv2NzPF5ixO9NSE6xFInfa4rjbs2O3y8O2jGHUCILhcnVBnqyOowCjYwrPYmPYTeBg
         9h9bK+TQzNfB2THNSG6ksgHnbtMxZvonWLAqXWK08Xr/vfGCVcFTrJQZxVcylfvP1T3P
         DBjVQyY1toUYl/6b4Vbo7KMpee7JGmRLIyD7hqo68B4AFpW29aTz7ziElznskdcf930G
         4/F1wRin2awmnj/6JRwjZaODy6pJKX7E2QC+LwYeIUoC2PULvKr0h5+GFu/wzsX8ZxkU
         u7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143124; x=1685735124;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Fgn6zh3gvrMab2LBRqhNeiLS3Yu538Qfty6kmXbT9A=;
        b=Q+72MSkp6rqNATaAj3TxkZ6pFeJuW0K7nEajW9oKwdWGYk12IVAJtvrdYZEwPPdw7s
         rbgpGscTBw6dC+O4H/YN5flbA9iGUt+Q717WmDee2T5vQ48iRS3czwsMhivW4zPDaYkI
         JvsV62eDFSLWLfIT1PL4Dwh+FRMmSU8rzhZZ4VGoqjeKKB3wVnaND8XE6foBZVOYm+GK
         c6ouss9IkShAL1Q66bbaS8/pohL300GgJdH9Wboz7Hw3pBZDgqfr901blwXN7GY0HVzM
         WbdYY4ZDvyoK9sRmjzCVpll7QyypCA/LAASBOmFayJODhvh0Ddt42GHM+jCZDjQcq0+g
         vEMw==
X-Gm-Message-State: AC+VfDyhVgKbe86tFbM9crreu/vrMxfghWVsS+KYrgvoS3tp71DgrbfZ
        UWWI+DjCjYTtBtRgnlrgx5s=
X-Google-Smtp-Source: ACHHUZ50VbXqnxZOzC6HPEaJQEQfT/k55pAtuF8wqqVnGac1b8eTD0NfVn9WBoDGioGFeDggI/77fA==
X-Received: by 2002:a05:6a20:12d2:b0:f0:4dbf:5f9f with SMTP id v18-20020a056a2012d200b000f04dbf5f9fmr28610267pzg.29.1683143124493;
        Wed, 03 May 2023 12:45:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00170400b00640f01e130fsm15565067pfc.124.2023.05.03.12.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:45:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 7/7] strbuf: remove environment variables
References: <20230503184849.1809304-1-calvinwan@google.com>
        <20230503185031.1810078-7-calvinwan@google.com>
        <xmqqednxqkun.fsf@gitster.g>
        <CAFySSZDiQe+VRgc3wRk4gTwNxWiF_VmKjOu-UEop+D34+5JUXg@mail.gmail.com>
Date:   Wed, 03 May 2023 12:45:23 -0700
In-Reply-To: <CAFySSZDiQe+VRgc3wRk4gTwNxWiF_VmKjOu-UEop+D34+5JUXg@mail.gmail.com>
        (Calvin Wan's message of "Wed, 3 May 2023 12:41:12 -0700")
Message-ID: <xmqqwn1pp5bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> I'll reword and reroll just this patch real quick.

No need to be "real quick".  Other patches looked like they were
reasonably well proofread before they were sent, but I somehow got
an impression that this one (and possibly your v3---I saw its
presence but haven't read it yet) was rushed.

Thanks.
