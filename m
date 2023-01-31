Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96829C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAaWBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAaWBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 17:01:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC2518C9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 14:01:07 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a184so11238849pfa.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yW6oEc4470t7QgO78oDOqAPAeUQKeh20lqNvT4rreWY=;
        b=Jn66xJl4sd90Gah4Y6hZlLqZi2IhJFmbJW6o8n1rxAuOYRj2Z77NqZdNNzYe/uZ6PJ
         LSScbrWc+qmMpW4lSwcRfigNVCsGHnIuGN1Jchx3o+QhFh+Ec6h6eS4xpf93ucVfkHQN
         87ekack/UkmF+9t8fffDeuBOKo3dG0mDSiADy2UiqmT35IbgwtukpV5qpcn+Mq+UvUk2
         QiU13TkQuuIT4hWcSjkVCAe3AgemwR7wdIi3bFqTndkHtb2JMPzjRziuMznU7TUPZcHj
         gD4FePjnxtDKO/IYbwH5MkS5U7xlNM1Gg0e+oZvFjiFQj77FNh/mpShCeP6c6zRcZat0
         3qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yW6oEc4470t7QgO78oDOqAPAeUQKeh20lqNvT4rreWY=;
        b=ohpWgSjk0Fs1kjm5WDlTttEwV48foN/2QIAMqMxBnXfFaB1gezvDQgLQdAnySE2xWA
         nUmo6DvPUapKukMC0+1K+jCQ6UV2oEkJSnjtO3mAv5IPxNDqz3xYzwNuIEx+vNYszW4P
         WUXYv/5LAhHtpgnk5pPFICv6clxpGpPgXKntnPyZmbq7stPYOHF29DIWV4lXql5dMukq
         2knh+iDaDR8qb9cphjgNBWUJrelSFKqORWdWw4R5TAOXd09QeqyaUW6wQ1tWqkqmQe1m
         eL4GOJkP496QdZqI63jUJsLqkN/ueN46j+lt7AInlJUxyj2UBm67wtz8KPUCeXcF18n/
         ti7w==
X-Gm-Message-State: AO0yUKW0nYJmND9xxFfL8jrnpyEl5zLqUZs0xFbVnwhCQN44dbtKPnsl
        S5Ivd1wAnfIyb9juvS3diIo=
X-Google-Smtp-Source: AK7set+pM+WbCzpaP6jHZjU/5uHe/6ajln7gIm9Ev2roNdJPuUmM6E9vV5p9JVXSN6n/WYtNjWKh5w==
X-Received: by 2002:a05:6a00:26cf:b0:580:ea08:5277 with SMTP id p15-20020a056a0026cf00b00580ea085277mr10629652pfw.16.1675202467151;
        Tue, 31 Jan 2023 14:01:07 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y6-20020a056a00180600b00593b06e0493sm5417031pfa.81.2023.01.31.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:01:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/11] Bundle URIs V: creationToken heuristic for
 incremental fetches
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 14:01:06 -0800
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 31 Jan 2023 13:29:08
        +0000")
Message-ID: <xmqqzg9ywehp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This fifth part to the bundle URIs feature follows part IV (advertising via
> protocol v2) which recently merged to 'master', so this series is based on
> 'master'.

Thanks for a pleasant read.  Will queue.
