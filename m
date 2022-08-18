Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5120C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbiHRTDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiHRTDX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:03:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86954C63D
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:03:22 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cr9so1826064qtb.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc;
        bh=4t+epIrC6vR8U9TrGKkEhtcvS9Ss83qTZ5qTKkzkM7U=;
        b=NA3pLwlO0bQrCVKB+7zHGzh4qy2kXdJDrY0AbmI5wCR3FUUV2A1LQFJyTO8mafgfEW
         uE7wFY9ZX1QD4+qUWdNE5uyduUb9Q01M0ADauTgRYsZD8U2/J+b15WzcPGLJL1+85Anp
         ob+4LOcQOfkZLLVeHSgu6JmwGnH1saGwGNvcMs8eewcJHsplXUXH9QnwKMjrJdn5RlmV
         urpGMx5eFL1Q4QERxfrXQtRJv5cXbyeJH8OYWPyzEjO5oLfDs+wXJ5QAqiK9rndlTc5S
         ym+s71DF6H2OWZhpiKWlP7pXCcxwXjTpeXhSfvZ9sTU1MqovEcYYi7BvSDS07Irlf24u
         F6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc;
        bh=4t+epIrC6vR8U9TrGKkEhtcvS9Ss83qTZ5qTKkzkM7U=;
        b=VvHYbJvjlFkacK+3We5cGFbRbqmXJ3i3Tb/ryNZn5ohcr6mT2vrrSMYimRKRRMD4uX
         Owr0Jy3S44M/Zo1JV7mdoL5j1X2KuetMo3UEIwtqJy2Oig5OW1LTvNbzNxof73Mksi9h
         vPWMn0VUDw9dxy+4BwKUVgIyZyN8DYjxelxtFR9+Nz14oUclXqnszB0Outj8oEmQbD8H
         vsKWSEsoh2RqI96ph/HM+C4+bgbGGChfEraKhei4A/wTm5xWzc2aZZBduah9chGXLc6U
         y4ElEa/jIBbp2QlZ80Ppe8SUMYEV0RzOYGkDG2gWRmMMLGPItdGeb5H6KNRLGmldVkk2
         JGZg==
X-Gm-Message-State: ACgBeo3NNitoAOc5JUvMQjt4ya0zW3AVl4onR69ZNjTCtzPWBOaE/0av
        Pu61KoB1WGmd3GPU76BC4dk=
X-Google-Smtp-Source: AA6agR4JkfZpnTGlUC0UluVkVI9g/kwHLqvKn15UGFBIsqR1bPs34PWEO1Irvw9Xl+JKlDFjX9apDQ==
X-Received: by 2002:ac8:5884:0:b0:344:6d9a:1e43 with SMTP id t4-20020ac85884000000b003446d9a1e43mr3962581qta.623.1660849401663;
        Thu, 18 Aug 2022 12:03:21 -0700 (PDT)
Received: from localhost (99-89-1-31.lightspeed.sntcca.sbcglobal.net. [99.89.1.31])
        by smtp.gmail.com with ESMTPSA id t20-20020a05620a451400b006bae6f73e41sm2387008qkp.5.2022.08.18.12.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 12:03:21 -0700 (PDT)
From:   Maxwell Bernstein <tekk.nolagi@gmail.com>
X-Google-Original-From: "Maxwell Bernstein" <tekknolagi@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 Aug 2022 12:03:19 -0700
Message-Id: <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "Max Bernstein" <donotemailthisaddress@bernsteinbear.com>,
        "Max Bernstein" <max@bernsteinbear.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Jonathan Tan" <jonathantanmy@google.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
X-Mailer: aerc 0.11.0
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
 <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
 <xmqqk075qyq0.fsf@gitster.g>
In-Reply-To: <xmqqk075qyq0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 18, 2022 at 9:54 AM PDT, Junio C Hamano wrote:
> So, the updated code mistook the body of the message that is not a
> sign-off, because there is a colon on the line, the line does not
> begin with the colon, and everything before the colon is an alnum or
> a whitespace, so squashed the paragraph break before the real
> trailer block and the last line of the body and made it a body-less
> commit log message?

I agree that it is not ideal, and I'm not sure how to fix it. This commit
probably shouldn't go in as-is; I modified the test in order to demonstrate
this problem.

> This might be a good demonstration of why it is a mistaken design to
> allow whitespaces, which may steer us toward fixing the documentation?
>
> I dunno.  What do others think?

I think allowing whitespace is good at least for the Phabricator project, w=
hich
despite being dead, has a number of existing users and existing commits. It
unfortunately has a "Differential revision" trailer with whitespace.
