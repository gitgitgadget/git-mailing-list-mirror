Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A9C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiLSOWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiLSOW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:22:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EBEFAFB
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:22:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so13823504lfa.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ucFxZEvaJ6UJYjSd5eijJPi8wRZoDK+Eg2+C9i/ENc=;
        b=hF9Cx6kZuB5fSUHE9KsXew5pLKW3QzkLFC9ypJ6dpUGWvZNopOsKxRzLS6wiFXp1uq
         a6NXW1q+CGxp12kgPnKEq6k4IiZMUSFmrsipXkXliyU9+IdI6oaq4A/OLCC0FCWx6p/j
         mt8K0WwfSZ9YoSFgfR4Ia9B0toKjsAES3EotWgc+zpwAD6YSUw3l2Isb/ShU1hY8SbDD
         FfTR33MIIg0KiIa8U3Lp53dwBW/4tlPk2dGQt/rTmsagXOacnePM16lEwBRstoziHVTu
         gxdmbSXFhww0v2TmRHBVD13fOE3PTB2q6kE+YqJeAKZDbA+u8xUNWe2Kr7z6oY0oBEW3
         wx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ucFxZEvaJ6UJYjSd5eijJPi8wRZoDK+Eg2+C9i/ENc=;
        b=X0jIxtnqv8X5xIgfRQP78hFUSyZgOUsAnKK7HbB82gK9lrg8nk6ljlQzV0WoGNcjNr
         68JsQRaIafQy1v1JvD4AKesm6FRoq2Kwj4ZLdj6Jrryqnoa9HPORSwUgYjA6t8EEksmy
         RtAYNxIpmuNWg+GFupcJCEHrLZJ3kJGgTbh0Tbie0nN2uVXPAkFTQ9c28RJSYhHMzfft
         KeRn7tS6o6kON8gpd+d+jG4FLlSthAdEjnuJUQQYA2eTByxVAOYdtJTqgKCjF/QYaeLp
         Dz0GLG0p6giBhf3xUvCjli00/bP8tpnZLQD1HaqrTweegir80Ln6+hTzWT/DZKfUqpXd
         TYFA==
X-Gm-Message-State: ANoB5pld+X5ZT1gUFg+HZy15HpcxegY0OOSU2U5hF2MiYMInKCHdZTYg
        Pgbhe9E6nM8vjKSNo1PuffdZ0o3upXQ=
X-Google-Smtp-Source: AA0mqf6wlenFM70g3AWibjPdbC9yFZbKEJxHGALGS7Ue/mLoLRnJ5QNnlualYhyscxg5+Qd/kbs+Zw==
X-Received: by 2002:a19:5f0d:0:b0:4a4:68b9:608c with SMTP id t13-20020a195f0d000000b004a468b9608cmr12683677lfb.23.1671459743688;
        Mon, 19 Dec 2022 06:22:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512200500b00492b494c4e8sm1113901lfb.298.2022.12.19.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 06:22:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] diff-merges: more features to fix '-m'
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20221217132955.108542-1-sorganov@gmail.com>
        <xmqqbko1xv86.fsf@gitster.g>
Date:   Mon, 19 Dec 2022 17:22:21 +0300
In-Reply-To: <xmqqbko1xv86.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Dec 2022 12:10:33 +0900")
Message-ID: <87cz8ffp7m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> The last attempt to fix '-m' option for "git log" to imply '-p', to
>> make it consistent with similar options (-c/--cc), was called by the
>> request on the mailing list, here:
>
> In retrospect, this old attempt may probably shouldn't have been
> done, as there wasn't really a compelling need to change the
> behaviour of "-m".  The "combined diff" options were "if specified,
> give output" from day one, unlike "-m" which was "modify the
> behaviour of '-p' if given" for a long time.

No, I think your memory played trick on you, at least for --cc:

https://lore.kernel.org/git/1440110591-12941-3-git-send-email-gitster@pobox.com/

Please also see the history of -m, -c, --cc that I've tried to reproduce
from the repo and mailing list, here:

https://lore.kernel.org/git/87ilijt2c3.fsf@osv.gnss.ru/

Thanks,
-- Sergey Organov
