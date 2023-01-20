Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2375C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjATPkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjATPku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:40:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35C819B7
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:40:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b10so5987933pjo.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Df+7viPl/x5SmJabZtGjdKuHGjvuEtixuz0gzlq7aww=;
        b=ntue4PDhn8BwVIkVcRV0lgxozOMBNQ+oMZh9A6rao7Ow6F9xGXZ2GB86JKFCa0wKUq
         Hb1dsoeUWuGYgDE2h8C9puLrGq+yqzK8elTxiHQDc81rHPovbQsJjBQiuwXMTwajZsg4
         svAsVWiUoq48Lagax06r2iQeK+o6uRDE+9218gctYkRmflqqZ0VArTHFW7ru5Ci4B+PZ
         JwcEQ7K4mBv72aAfK8F7Quksc0v6o4l/JD31ovXmDap+BbW8512jvkynssHeNE+lw2gN
         uJicXoJrFnYsie4zNAyoqvyPgbn6YcCvjpO8wN43hrccvrjiDJuClTaIM5ka70ma7Iux
         peBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Df+7viPl/x5SmJabZtGjdKuHGjvuEtixuz0gzlq7aww=;
        b=p5y3Ukh6QPTX8dQ8U4i0icR6XYjbZ/uD2gYASU40AZYdyQKlA0JTHIc/EJVsT69VyF
         TBJ6ii20qD+IaqazEog6uTmLSc+taT9Jrct1aqi+cX4zL+MRp3qrBOpappONXNWrFxJq
         ornSuaVSsSPZ6aqlM9kprBm1b/urEQvdOi3JOuL/btDUKXcVVfUctfFN69Ec5dzdlhIU
         +H/IKXo04SiBG6E8TdQr0CexQNZ0tnWdxFOTLSH2Gnvz6gF60LBUK5oVsDDO9jghhkOD
         JzhlpwNXdezNdPVaTBQjMnBcYiSigAgV0XkSYfNa3i+WCu06UyhFfUz1R9+EShLyLlk3
         /tYA==
X-Gm-Message-State: AFqh2kop7quzQn48AyEZOXQl4XMpO83APClA68hJvRphOYMxsFMXcq08
        BNNQmv/H+TzvzFfXlnzVcfVePNgveko=
X-Google-Smtp-Source: AMrXdXtyUJsQoGuEQLmUYLtzCPGLSGikajZd8QV5biTqpJulfB/kCWOK/rADfwaoJciaF1ji3vsBEg==
X-Received: by 2002:a17:902:eb89:b0:194:997d:7735 with SMTP id q9-20020a170902eb8900b00194997d7735mr14224962plg.48.1674229229630;
        Fri, 20 Jan 2023 07:40:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b00194c1281ca9sm4507971plg.166.2023.01.20.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:40:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler <jeffhostetler@github.com>, edecosta@mathworks.com,
        git@vger.kernel.org
Subject: Re: [CI]: Is t7527 known to be flakey?
References: <xmqqtu0lzzn2.fsf@gitster.g>
        <d5e2cd60-49f7-91bf-0678-70e3671b1cad@jeffhostetler.com>
Date:   Fri, 20 Jan 2023 07:40:28 -0800
In-Reply-To: <d5e2cd60-49f7-91bf-0678-70e3671b1cad@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 20 Jan 2023 10:23:29 -0500")
Message-ID: <xmqqmt6dxlhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> This is on Linux, so it would be using the linux inotify backend.
> Let me add Eric to the "To:" line for visibility.

Thanks for redirection.
