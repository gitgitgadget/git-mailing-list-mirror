Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6924FC6FA99
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCGVGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCGVGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 16:06:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F56ABB33
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 13:06:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oj5so14509004pjb.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678223175;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnTLr7N5iaswVP7vQYRI6F4bj9Eoz4gDY1GkaPkd1Qk=;
        b=AtbEgkXcmumxQmF+eXnd1ReRmqExsVxzq+rFt/CWYkRmZ1ucU+NHUC38iARIpZBlKJ
         CaQw4JKDDIqB/uSLf6sgQ9Zq0fATpq+vjm2dtUErPB/tK8ay3Tw/daimPiTh9SQoEs0f
         to03xKHlG7AeUbLYv9hMGfjfN/U6xXePKIkATwzGFBcJczr0YniD7fQcm6iVhD9F2P9w
         zGWOFrPD40vtreZISFuF+4/B+xEa+SJw6sDEtHjnsXQBhuRIWpJV4YlQ+bMG9cQU+pWC
         vKJbdncGgq4HjK3IBc8ctIuPlXgbS+Zj6sf3kW7U7dNMA83EPBu0LOwWYiojXloBDENI
         PKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223175;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qnTLr7N5iaswVP7vQYRI6F4bj9Eoz4gDY1GkaPkd1Qk=;
        b=E49+LdSHzUkzfnCQXO+SAdLwtXnWGxBX6A0vRE9rv8844bYB3fZErzwULN2klQNjsb
         F63qimngWvQkTKuWjF4hlLhRQrCjlJjsL4Q8iGpe4hSjeaikjh0ej6/fNmoSvFDXCEQv
         iDfWg/faS9S/M00+Yak8owbGr5gBMWfBISWLvwXNy84ytlRfYZ5fP5xVxyeyRaQzTKjG
         FnXznssghg5nNeJufohrUe0CCyYIzbgZEURolG/JP7oAqaLdbPpy3RCjX2YPxuXBGJJz
         nmQmacvItAx9Vb856ejj/qC+NLAB5fXwMJGKO8TxXULlp6wV0+T57fIA1lclFkwodk1v
         tCkw==
X-Gm-Message-State: AO0yUKVvEWc7lEkh2Y1Cx6bB0ZO0QAajlYLq70kCLgibiC434S5fspVN
        MyHKXhbDO1ssYvvM0euz3zo=
X-Google-Smtp-Source: AK7set9TKi//ETaq54+SYLCzZATz6y0bjpenN7cdKQLoK+4HSo+YvgJ/4vNtdHR6RR6af+Yd7dc6xw==
X-Received: by 2002:a17:90b:3812:b0:23a:4875:6e1a with SMTP id mq18-20020a17090b381200b0023a48756e1amr17490661pjb.25.1678223175593;
        Tue, 07 Mar 2023 13:06:15 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a4e8800b002372106a5casm7594556pjh.44.2023.03.07.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:06:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: fz/rebase-msg-update (2023-02-27)
References: <xmqqcz5snyxz.fsf@gitster.g>
        <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
Date:   Tue, 07 Mar 2023 13:06:14 -0800
In-Reply-To: <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
        (Fangyi Zhou's message of "Tue, 07 Mar 2023 21:04:16 +0000")
Message-ID: <xmqqttyww9tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fangyi Zhou <me@fangyi.io> writes:

> This patch is actually a hotfix for a topic added in v2.40.0 RC
> 2c6e5b32aa (Merge branch 'en/rebase-incompatible-opts', 2023-02-03),
> could it be reviewed and included in the release?

Is it?  

If a message used to say autoSquash 2.39 series and 2.40-rc2
has it autosquash, then it may be a hotfix, but otherwise no.
