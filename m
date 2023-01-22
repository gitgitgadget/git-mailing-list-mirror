Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90212C38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAVQgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:36:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401BFF1C
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:36:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9so9300513pll.9
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YtmOUro/qrcvbA0VRy29idOED2OvILmJSAvA4fydnI=;
        b=PxPWHH6dN4sLkBc23G1MW7i9+7yHJhgZs2buTIaVBGPEIkZFCnYS2A81p3hZyZOlha
         TTlKw1UTRDz5hbeByTNKwBNm/1fIMz2c5RoPM1X7bwIlc977LCD1k5t0VJlRcnXinBS2
         qOXi1vsYvPW3+AuRoy1ozzuzDxa2kdUAal1TvExCCoiS28t6OsnvwwDmiKVLcwMLFnTB
         c766saGKJnfNga5uAJ46UDyVFi6L8Kv/irWepf7w7nYNopSotwSwbV380arrRv8UVoMk
         +lZxlRNAOiCY7S2KNEFu/hzhH036dUxxCs3xxt3X1k881lWgkzX8rxa6BmF/QA77KBrU
         5i2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YtmOUro/qrcvbA0VRy29idOED2OvILmJSAvA4fydnI=;
        b=QQ8eSytZUMLcupiJhXchbcoRYIcK+ax6acR0LXcXdaraoyESZ70CBhgNOIU+TRHA53
         yGx+ckMCfOBl5JHZcuBRQ2LIiSmCGlCKj50TGVMmr1uOWpcWiHLMSGVMIwSWsNxFxUJc
         bIAz1h2yEx4Fcr8jyapEMt3XtKxktKomtrJJty8+7Zblc4EwREA+Nm/3VXAmXrKdZBbb
         VdEoEyoTWoW35GD4qanVswlxyEDOYUtt0fkePvOxXbd4qVFsjpMXRyo+WPGcHyR5InP9
         NxI4BukezdiI5SXZohtNlB4SyzResFwRaIQZxsZiTcghNWpTOdLaOkOijBjoVuZFU6XJ
         6KvQ==
X-Gm-Message-State: AFqh2kpU927wXQOVyn01nY3szbWRbj72IxHTjKTR9tTrsorWsFDngbGF
        cYJYBC6qhA0Srta+BTf7+MYAfuVYVH8=
X-Google-Smtp-Source: AMrXdXv3F/J0t7GnfIRuaJVxlVzpiQZ7oB0jW9ADKNayulJvykpfYM2VvYHQ5FBVfWAqNrcm+gnt6w==
X-Received: by 2002:a05:6a20:7d98:b0:ad:3ada:c712 with SMTP id v24-20020a056a207d9800b000ad3adac712mr27946652pzj.14.1674405373446;
        Sun, 22 Jan 2023 08:36:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k133-20020a636f8b000000b00478c48cf73csm1170374pgc.82.2023.01.22.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:36:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
        <Y8zquGar3rLyRdTp@coredump.intra.peff.net>
        <044bdc8f-fdc9-dfd2-6cbb-941513467524@web.de>
Date:   Sun, 22 Jan 2023 08:36:12 -0800
In-Reply-To: <044bdc8f-fdc9-dfd2-6cbb-941513467524@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 22 Jan 2023 11:03:38 +0100")
Message-ID: <xmqqk01esf0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> We could be more strict and reject everything that oversteps
> S_IFMT|ALLPERMS, but the latter is not defined everywhere.  But
> permission bits are well-known, so the magic number 07777 should be
> recognizable enough.  Like this?

I do not quite see the reason why we want to be more strict than we
already are at this point in the code path.  Stricter mode check in
reports FSCK_MSG_ZERO_PADDED_FILEMODE and FSCK_MSG_BAD_FILEMODE from
"fsck", which I think is probably sufficient.

Avoiding integer wraparound is a good idea, even if it were
impossible to induce misparsing of the tree data to lead to any
security issues, for the same reason why we check for zero padded
filemode, i.e. such a tree mode will allow the same tree object to
be given different object names.

Thanks.
