Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE7C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjD1SVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjD1SVv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:21:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655701722
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:21:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a80d827179so2167685ad.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682706110; x=1685298110;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y1WOeRao3QPHRfqls7KiCzBAKDQfxlGSd1XgrPYG18=;
        b=WJmHRR7cImGHfwbx7B52iYnjQzSaBc6xqpG1c6jD3puEZEWD6+7wKt5rT+NwZCTyTD
         fOM0FRPktikwLnof+5c59MWTbYsQoaFG2i987CBUJnYgGO2eiBsGXMIebeKSRDUMNDrO
         Nl43vbMfNxznK5uucOwm2m46OmANhpZpK6Llnd37wu2HOCgUmucYDmCsqDF0/la8rwYk
         UZoO6GmdQ/0Bl53ZpiD/hviCD99UkRfmla9dcr8pTeStGgKdl+RyUNVSCpZTa4tQmuwO
         TVaLazMkRXR6rA1UySczajb78wgvw1Fbsv5rFwIx214lQRp55+Y+rUwfwnBlr6BL/jff
         PBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706110; x=1685298110;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5y1WOeRao3QPHRfqls7KiCzBAKDQfxlGSd1XgrPYG18=;
        b=TwmLPvjjbQPvEOocxu1BOLDf6LIwRDrHNX3zb7y2vkQz8S+MixoIzKyub94RN7BCcv
         frKa5WsErSSUlbKJbVNnDoYmx/ZwKrpmJUIuvaOjOB59VwFWVzr9ySyY3lR+GO9cS+lR
         8czVfnDhilhziCiuZL9PR5HccKQ3k/DyNnbqbS5w2HBVZHw+3N4LItaKk05dvI3j2vT8
         8KKTfGKrXxzfMyjWoKgguWqCKIVHdCgyqQenwUJAipcHG5U1iL8JBHgshp85zV5m4wae
         TUW9xH3aUArXHslg4hQmZlu9IOblxVrhTBoqg6FnECUpowr0jYWpwouRtOvNeH77snqn
         VFfQ==
X-Gm-Message-State: AC+VfDysv0TDw9Cdb5chbSDat/KVULxmUjQ49gu1Kwydq/DTJbKrdAiR
        0sZ3YTrCLUEeH7bxeyWhqLtD72SLdaQ=
X-Google-Smtp-Source: ACHHUZ5DJwSWHkTTUE3m41zfv3PEn1ReERqUhGP77ok2fqbCrhQqMayxXgAmHr+nbBtpwg8ut5Xifw==
X-Received: by 2002:a17:902:ed44:b0:1a8:1cbb:4f76 with SMTP id y4-20020a170902ed4400b001a81cbb4f76mr6164075plb.28.1682706109702;
        Fri, 28 Apr 2023 11:21:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b001a6370bb33csm13607489plb.41.2023.04.28.11.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:21:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 6/6] notes.c: introduce "--[no-]stripspace" option
References: <xmqq4jp326oj.fsf@gitster.g>
        <20230428074013.22998-1-tenglong.tl@alibaba-inc.com>
Date:   Fri, 28 Apr 2023 11:21:48 -0700
In-Reply-To: <20230428074013.22998-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Fri, 28 Apr 2023 15:40:13 +0800")
Message-ID: <xmqqo7n7eukj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>>Teng Long <dyroneteng@gmail.com> writes:
>>
>>> From: Teng Long <dyroneteng@gmail.com>
>>>
>>> This commit introduces a new option "--[no-]stripspace" to git notes
>>> append, git notes edit, and git notes add. This option allows users to
>>> control whether the note message need to stripped out.
>>
>>Makes sense.
>>
>>>     ... One more thing need to note is "the order of
>>>     the options matter", that is, if you specify "-C" before "-m" or
>>>     "-F", the reused message by "-C" will be stripped out together,
>>>     because everytime concat "-m" or "-F" message, the concated message
>>>     will be stripped together. Oppositely, if you specify "-m" or "-F"
>>>     before "-C", the reused message by "-C" will not be stripped out.
>>
>>This sounds more like a design/implementation mistake that we may
>>want to fix.
>
> I doubted this either, but for compatibility, implementations of
> this patchset have been made, such as "note_msg" recording the
> "stripspace" field, to implement these two new options without
> breaking the old behavior.

Thanks, that is a sensible stance to take.
