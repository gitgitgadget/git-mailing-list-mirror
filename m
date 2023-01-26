Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A67C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 21:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAZVHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjAZVHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 16:07:07 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1A5D123
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 13:07:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s3so1958351pfd.12
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcpIaM8ZbOtc/nAuqpbQkJWhrpygN2kpQg4riGjYeDs=;
        b=UHSv2Z/LKRp16bGHJmwkFXhNkeKJuxpDD9iri1OfBEF1HQICs8bumbLxNLeF7Uejt4
         4a399W3DqP7ZnC9pM7PCyaQtL72rx0pfJXzB0kxvklB1tQtYdtKG6AfDO0cEts12JvKF
         MjpjzI4fElMHajqwaRpHr3IDU9eh4wFX14NfqApjBhCBmJGU5xOI8c+zWElgELC1jqaR
         rkRD6HucGpl5WbUrrkxdWCvMEjT/vTwFLEsOPeO/FCRmTm0raHVvpRdKK1KvAb6+JNn9
         +AcWB7yzZVCE/9dYyEdLIhsARawlh4sRN9Y93+qvP7cnmN5/vl6r6fLfE8ClEzRLbew6
         ejhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcpIaM8ZbOtc/nAuqpbQkJWhrpygN2kpQg4riGjYeDs=;
        b=CfIX5skCT83ZAxYmPyC7m2Vxfuiorkm+rz4NHS4d2fcESpmMP+rNBksU/p8DOb/BHb
         VDS7bxBlWrpqehYj8Ood6qHIqXmrXLtBx4K0vlsYJfBMakMx/pILfagn5Jg6SSfk0Ml3
         Kqzf1qlK1TkGV3Ep/8YmWS5HYk+ToheA3yAEoYSOnk3v8Qtjq3xQwCaqIyBndfwNKh7h
         X4f5B/Hw+M7pmOtgo0Z7MDKDCIzleYkZL4R1ht36Se27gPTjk6RdDxwt42/4PLbCPydR
         woacDgx/qMljA9nQGIctXSfx/DYkvLofo0Np1DHlPtAwj1E5xG0RAbkdZaMl0W/uVx4V
         jEww==
X-Gm-Message-State: AFqh2kobRqBiRFAl7SSq+4yAj+3ztov8zt3udhJHdzIT9wARpmD6PZty
        9M2v8Nmbm1ya8nXVoYUFhOQ=
X-Google-Smtp-Source: AMrXdXuABcAZdFF/j0hS98Q1jT2n6KSxpojybU5lon3H/N/jYkzSaZIS0pgOUAuqgRUuO1jrTNsFag==
X-Received: by 2002:a05:6a00:182a:b0:589:78:80cd with SMTP id y42-20020a056a00182a00b00589007880cdmr55010939pfa.8.1674767223482;
        Thu, 26 Jan 2023 13:07:03 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x2-20020aa793a2000000b00592591d1634sm525252pff.97.2023.01.26.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:07:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/1] ref-filter: add new "signature" atom
References: <20230110005251.10539-2-nsengiyumvawilberforce@gmail.com>
        <20230116173814.11338-1-nsengiyumvawilberforce@gmail.com>
Date:   Thu, 26 Jan 2023 13:07:02 -0800
In-Reply-To: <20230116173814.11338-1-nsengiyumvawilberforce@gmail.com>
        (Nsengiyumva Wilberforce's message of "Mon, 16 Jan 2023 12:38:13
        -0500")
Message-ID: <xmqqmt65atu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> writes:

> iv) I also moved check_commit_signature(commit, &sigc) out of the
> to avoid running GPG twice.still this change is in grab_signature()
> in ref-filter.c.

Is there some code to avoid calling check_commit_signature() or
grab_signature() itself when no %(signature) atoms is used?  When
nobody asked to use signature atom at all, calling GPG once is
already once too many.

Thanks.

