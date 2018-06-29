Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43BC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeF2VRV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:17:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37013 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeF2VRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:17:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so10027728wrp.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7FCbg++Q6mkbWQkAq4SbSGdnO3lsj1XY4TUkolwtR3U=;
        b=q6BsCSSs4nxk1xUIuCHx9tZuov1OXGaiSXZx4w/89L6fcUFxQN8Y9k3guRY76z+MuT
         Iq5et0lWoPPgLmNY8rs8oq7embBVoaGd3SPqV9rlMlhwpKiP4RXhzQHMSbKiYzXLVt3k
         zeewnRHM1NmZ4DA/r4lXza31uHXS1eyK1Lrcu/PM/MON2/yQ/DON0LZWcJMmkqxWnyhZ
         Pw4hP5eZyogmW/2eS9qnRWsaveNdKtuHPSxJJo4gopSIn9HSK4qlV38bCpDd2Yl/N1a1
         3MFMkowKHCikvrR8ckGjHNpOdEgLNlazh6XeXTRWHnt1ZaRylOGE24jJ6qksBJxLW8bu
         LSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7FCbg++Q6mkbWQkAq4SbSGdnO3lsj1XY4TUkolwtR3U=;
        b=FymRgmopqnYTlGrEYb9B+Fv9ZA1rYFSniT+9qIylzXj/wxBcb1gGIk2Gapm6ilDQGr
         p4MYP1J5/YR8HmdQ8iLZRTacRoHnb3PnR7g1kDiTVnZWxFxRXcxGTm7uK1Eck1fb+aiB
         lDOPpKgjCPpoEgF099z0D4B5WMCAUiYQQVo/j6PlyXg0BTt3VptqMvW5onZHvcEkUlp0
         UiLXDlpcR3H9p/Eo0sa3OKvxAld77EGJMpK6f6PWsUzOcYPwDbx2/FAvir3zVB9WxGIe
         nwzKpdXK10AGOWbwRBL3syEafCMUKP0Hc1ZziK/7lbNykg1ihKJfrMsmOlZpKhA4ST5X
         fcJw==
X-Gm-Message-State: APt69E3dOYaTF7jnP/qcAJDOGp6Qymmc6k02P9UK+kD2GOYSvtJeXLn5
        69b2SSW+4x77VXlkqe2MyLg=
X-Google-Smtp-Source: AAOMgpdfmW7GwYgjHJtFS9pbGpFYdBC9fdSb0MkMWtIUeygvvPxVIR0XfpRSDtD4yyu0eZWP1LXFVg==
X-Received: by 2002:adf:b587:: with SMTP id c7-v6mr13246328wre.141.1530307037732;
        Fri, 29 Jun 2018 14:17:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v4-v6sm5543352wrd.41.2018.06.29.14.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 14:17:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     mhagger@alum.mit.edu, git@vger.kernel.org, jamill@microsoft.com,
        mh@glandium.org
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
        <20180629202811.131265-1-sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:17:15 -0700
In-Reply-To: <20180629202811.131265-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 29 Jun 2018 13:28:11 -0700")
Message-ID: <xmqqfu15thr8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This patch was written originally for mercurial at
> https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5
>
>     changeset:   36674:c420792217c8
>     user:        Jun Wu <quark@fb.com>
>     date:        Sat Mar 03 12:39:11 2018 -0800
>     files:       mercurial/thirdparty/xdiff/xdiffi.c
>     description:
>     xdiff: reduce indent heuristic overhead

... This should come with in-body header to credit the original
author as the author, I think.

