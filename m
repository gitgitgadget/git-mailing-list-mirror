Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148ABEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjFNVyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFNVyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:54:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E672689
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:54:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6668208bd4eso537374b3a.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686779691; x=1689371691;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioeP8zJal9BTV1VHX2eN+zhsRdASyXyLvj6q6ZKkcSo=;
        b=PfxhhW5QOQuRYPUCvaD0Qu9EvFtqTcxnmUJjAPpcq202xjfassQlhnUJgYBCDciGPI
         7sXNhAX8UxNqZYHneg/vY8NxR1+H0F/oh7ID7pqxWqBmu6zU8zDvLbGaAA2aLYtjZrJ3
         qdrjBvJlVblAfOLpieJ9wMg7E8z1BzkE7ijfczC5xBkwmK3nsUO+L7l9oyD5uBClZP5g
         rjU1ODGjt8HGq3y+TkGfiLBL7eA1zsYxFCHPhEsAO5xQScEGjh59jksF/7QYv0zTcb2n
         ara7pr1H/xqTuEyFFjiekiOhW8A5fce+mMtj0YEeOqOr3pj9nZWajoaBpEOR2TCGv1sc
         kLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686779691; x=1689371691;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ioeP8zJal9BTV1VHX2eN+zhsRdASyXyLvj6q6ZKkcSo=;
        b=Z/Ye9/KC7PIj8MOR26aR8n24XefRk5fyeGn+GA8cWKQSkgJ3zeSZY8fEFfCjM2iKNe
         9wuzXqbhdBiju8rDTRg8BcrHLxsyprDlG5x1F70+RIqjnmwlIOGNCrleETWOWpN8Mj1F
         89qxLN/wPPK9cf9fxDbtWRuV8HEVesgtHynDnuaExy1MZ2pFTXb1OLPUTxVLHLmC6+Qi
         yjoah0qTUityUL4CVCHutjtWDK0T+i8dOovq6U3UK/MLMbUOnuaPFHa/1SAeUl6uxpQ9
         1vVmUs6WUM/BDlCdO6THsMXXhor2orW5N5u8ANUOSEiDeGnBshZrO3ORtRsT++/VobTa
         18Bw==
X-Gm-Message-State: AC+VfDwLQC5sMTrN/XIbIK4Vr4/eQwYUwE33rWV+glu6Q/2GDOYJtUU5
        gQVWzhERzz5JOuY/wObzwwQ=
X-Google-Smtp-Source: ACHHUZ7DZ7Ro/fWoRN/SqNSel3LXDyFD8iYWgYK/oek4st6sm7VwHLbswnFv7MIW5+AuXFA50FwHNA==
X-Received: by 2002:a05:6a20:7fa3:b0:112:1e0d:14ae with SMTP id d35-20020a056a207fa300b001121e0d14aemr3208832pzj.7.1686779691433;
        Wed, 14 Jun 2023 14:54:51 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0063d2d9990ecsm10765080pfa.87.2023.06.14.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:54:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] CodingGuidelines: use octal escapes, not hex
References: <20230614001558.277755-1-jonathantanmy@google.com>
        <20230614213145.475607-1-jonathantanmy@google.com>
Date:   Wed, 14 Jun 2023 14:54:50 -0700
In-Reply-To: <20230614213145.475607-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 14 Jun 2023 14:31:45 -0700")
Message-ID: <xmqqo7lhwvyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Extend the shell-scripting section of CodingGuidelines to suggest octal
> escape sequences (e.g. "\302\242") over hexadecimal (e.g. "\xc2\xa2")
> since the latter can be a source of portability problems.

Sounds good.  On a typical GNU system, /usr/bin/printf as well as
printf built into bash groks "\x<hex>" escapes in its format string,
but we cannot depend on it because POSIX does not require support
for "\x<hex>", and printf built into dash indeed does not.  It is a
good idea to stress that this is specifically about the format
string (in other words, nothing magical happens when using octal or
hex escapes in say "printf '%s\n' '\302\242'").

> + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> +   "\xc2\xa2") in printf format strings, since hexadecimal escape
> +   sequences are not portable.

Will queue.  Thanks.
