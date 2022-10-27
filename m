Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C3ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 21:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiJ0Vsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 17:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ0Vsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 17:48:35 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE085A83
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 14:48:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h2so2957821pgp.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dHciKxZHu8VZ7yZrnNDo15mD36IMbsUzu2YLka7inY=;
        b=F7y2eWnfIpX1YYfKXMbcsvIzKHBjh7ZjHoG1umH86fiWXc2aJoD+QK+zjoo3vDQDKy
         5B38pBxvVfcIF0lSjLadL/Vzh8tnuLIxNC5U401x80iVkC/Ml/C+nYpNm7VoULZHZ44g
         mFHhZ3oIKV9VECK9/tZfqZ4FW6disjn8PhBYT+v6EZC8SoAiZxRd0XKA5iVAhySHhWdp
         v+VnvoAdnoAgwqx/6YbKE6dQHWp2cJ/3uAYQlzohzdAugY6A8FTZGdEhstJrtQPfFihQ
         EGYl3s153+mpNwf86RaVMbafJv2V+Y6b2/naRV09rIz9IpfcOD8l1a7+MA2G+oYLVRT6
         ZgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1dHciKxZHu8VZ7yZrnNDo15mD36IMbsUzu2YLka7inY=;
        b=YltGlV7VrI9czkgknEiaf2EH89B0/OYDEQBzBdi9RnpsLehtGmBe2Vy/4RevBy20ss
         QZaMwJvSKqn+m7Yww+zQZhFbjqKAN6O+T5h9WAlsUHBLzgk7xwMH1GnO33U5iwJa6oyC
         6jFmdx/jBNa9GRRnuVFnI5NpCc+GsohwDoYxHSoCKS9AtltAYSs/lOMDW1pLwWlvN4Jd
         cl+XlfDmxsn0ZSs78OIeqm8AcXyXzyIur3BbEJ6ip0q77WQ8g1VAA3hxgIhkiUFzFlf4
         Ptmheic3w2LiEHgBxrj/U2Ofs31c4VzjWeF5Mzk6NZdU4RCCB5qtJed0FMeuLv8aB3FW
         1cug==
X-Gm-Message-State: ACrzQf0Fmq/KovrERvNiQX5WEjBk1KX6LlEyPO0Ke0Srpv5FA3k9Lt6D
        +dNWLQbk0/6xCK1m5bXeFQc=
X-Google-Smtp-Source: AMsMyM6fZHmlyMhPNNs5zK6yUCtsoiNvpEC5kLZhElxTGHI8zKzxlrxmYi3sUShL39fuQGl9EU8TwA==
X-Received: by 2002:a05:6a00:891:b0:565:85a7:a6e with SMTP id q17-20020a056a00089100b0056585a70a6emr50350572pfj.21.1666907314258;
        Thu, 27 Oct 2022 14:48:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b00172951ddb12sm1704511plx.42.2022.10.27.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:48:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Mention that password could be a personal access token.
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
        <xmqqk04lmagy.fsf@gitster.g>
        <Y1roZeM6EsPgpHqu@coredump.intra.peff.net>
Date:   Thu, 27 Oct 2022 14:48:33 -0700
In-Reply-To: <Y1roZeM6EsPgpHqu@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 27 Oct 2022 16:21:57 -0400")
Message-ID: <xmqqo7txj5u6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, I had the same reaction. From the client perspective for https,
> this is going over basic-auth, and it might be nice to just say so. But
> of course the whole credential system is abstract, so it gets awkward.
> We could probably say something like:
>
>   The credential's password, if we are asking it to be stored. Note that
>   this may not strictly be a traditional password, but rather any secret
>   string which is used for authentication. For instance, Git's HTTP
>   protocol will generally pass this using an Authorization header;
>   depending on what the server is expecting this may be a password typed
>   by the user, a personal access token, or some other opaque value.

Thanks.  I have no problem with this replacement text.

> Maybe that is getting too into the weeds. OTOH, anybody reading this far
> into git-credential(1) is probably pretty technical.

True, too.
