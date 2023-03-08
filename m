Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38239C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCHUoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCHUoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:44:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057A6A2EA
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:43:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso107566pju.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678308226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVLNmpOvyF6Zw9HYeO0RigKID3ZrhKss8cS0wQtcAjA=;
        b=T0OW7oannlDgGL7I0oWeni3WojKvRRYxqcXJMvt1V1UaCJahNFfMIm7yDx4Codx0uk
         mR5gNwqvWfxr80X2o0nMfdBLp0m5CYrvb5FcBrkzd5Nn9OCjdMaw5mMHvuG1gtEXm0Tw
         6kLzRrcTA24RJyg/CfO6FPCoqZX1BFVBd0/fmgLdF5KobtVrdOFZcWuE73UcNoH2guBZ
         Dfhs33yQ0bmJPx98Bk6V9qurJM1myHNAALgFbBHDdG1nufEYNzZq7CB46KYgxmAJ669j
         aiqgBB4PW5p3SU6pB4AU2dNGbqV9vRR6V0KINCiCtyeDewK6ay1tKMamcMHPjxvJnbxn
         0/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DVLNmpOvyF6Zw9HYeO0RigKID3ZrhKss8cS0wQtcAjA=;
        b=0Eo3e78XDJllme+8EvItxoFMKYFYPu+J2hKu6APksaRsDXxvtfw4xjEFgLuNsdWunP
         N89AHDZl2PPV28pw16TnyDXEPBx8DaRRQEPMfAbNK4XM0Vdo0UVIgzHAtp8syrl9rqli
         AkA3jMMVbwM80QH4lcMUwYx9a7Y1iVQztVcn6AbxMCAGU2qLo3q8ewFVaym3uL4XG66t
         ZdhBA4dxN1qIE3jv/gLGjEv87f2bLb9LUot0S13vt1GtWQXEviDb3+VLakUw0yv1Afpd
         iLKj5na+SARDBdO8IOkRDru/9j34EaUDMxBKwrHzEtNuZCb9CulfYJTboWQT806sqvag
         ppKg==
X-Gm-Message-State: AO0yUKUEmTrH21q8OClxCOwLxLGIkJI6/V2L7Z33g+r22/G8NTZS3Mor
        bAN8NJ7eELG8J7+3htXvG7hplJ9mY00=
X-Google-Smtp-Source: AK7set9QOD0X9HXB1i07QFRLsUdEUAwHm7etXurftPk6dIABIA/2Xz2QcdOgfN7cwVVlaVslgjD3PQ==
X-Received: by 2002:a05:6a21:6da6:b0:cb:e8c6:26a0 with SMTP id wl38-20020a056a216da600b000cbe8c626a0mr26766136pzb.11.1678308225916;
        Wed, 08 Mar 2023 12:43:45 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b005cdf83e4513sm10058758pfn.145.2023.03.08.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:43:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Keeping <john@keeping.me.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: output header for empty commits
References: <20230303160301.3659328-1-john@keeping.me.uk>
        <xmqqwn3xg3m0.fsf@gitster.g> <ZAMhOehmuIov/KM8@keeping.me.uk>
        <xmqqlek9byeb.fsf@gitster.g> <ZAjxL2MIXCNZgYj/@keeping.me.uk>
Date:   Wed, 08 Mar 2023 12:43:45 -0800
In-Reply-To: <ZAjxL2MIXCNZgYj/@keeping.me.uk> (John Keeping's message of "Wed,
        8 Mar 2023 20:33:51 +0000")
Message-ID: <xmqqo7p3rn26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

>> Overall, if we were designing format-patch/send-email/am today with
>> today's use cases in mind without any existing users of these three
>> commands, I think these three would be designed to pass an empty
>> commit through the chain unconditionally.  But we do not live in
>> such a world, so perhaps some sort of opting in may be appropriate.
>
> Does that mean you want to see format-patch die on empty commits unless
> --allow-empty is specified?

No, what I (with Devil's advocate hat on) suggested was to hide the
"instead of leaving an empty file, fill the file with the log message"
feature this patch adds behind --allow-empty option, and when the
option is not given, keep the current behaviour.
