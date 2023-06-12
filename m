Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4686C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjFLVbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjFLVbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:31:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA2C5
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:31:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25bf9dadfe8so841652a91.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686605501; x=1689197501;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lk5oKvZCeciUmtk0AT3CpRpWY2jsFidhNrYBF/+tGc=;
        b=YmKC05s9ZtpkhoaPQK89NXCofC+KpWzkz4hxAXBew2sLH9e/gXyGhE6GoI1K/xTfnz
         gwuTu9tDsiMx51hhn95oXc2AxGaEMNhHQHaWi+4qUTxwECs3Us/JoZxzQZyVNOgCaCsf
         Zg7u791W5YkkQjpn10XrZMKLvY43zNcq+oh+pKj33eIBiu7gBWHLqn14t5v4bKQOwdRS
         jP/YNBXsVpgB8YF8ciWswOv4BmSmqrtpmzT4nViHdP8eDb3C3bWE+412Vt0l0ytr1MHy
         Vj5MCSVtgyNQ8N4XC2ONp2ZMc6G18qtGkAlrLgPQNQvy/OtkQ3WtwOxh5iNkUU6G+GeK
         94BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686605501; x=1689197501;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lk5oKvZCeciUmtk0AT3CpRpWY2jsFidhNrYBF/+tGc=;
        b=aC9XufoCAx5D4LWz7DcupHtYFGl8i+aaP5ME//w9R5LLRAstpobyB1XtfF0z6qmiFB
         UiO8oLxCurjtkS1T3NUrSj5MBJHfVKxJh1IZB3eg+wr2K0XJiI5uvmGI+TQ0wuKPy2IE
         bQngghUU0T8K/2TBwAL0Pg4QzOoPbsuyo+nW8fR7NvosVlG9/heioVoLrsR0xwdUUvQH
         kogTDazRoXRZY80WP7bAvnWsnCxVAzHNujHuz/tGkYTFfKYX9dp0UunGfYYGxJUcMhtm
         2+BGjdQ7Wjm+RjDkIxcfplA2kxSYE9m3rVeDmC5TwPnvNcClrbSEmBBALfmbMlTz3Vfa
         9j5A==
X-Gm-Message-State: AC+VfDyZiaQjmiVDUghonmJXDJQifCclu3MA01HxRgasKn9+3cTYy6z8
        zscK65AjYEo6qbp+VHNvTUZaxR6B1y4=
X-Google-Smtp-Source: ACHHUZ4W4R5C56zY9b9f6r6QpCMVOyV9BmL/Hh5Xwhuw21aOeJjmQTNjYIaYE6/2gJRNEhVXEHP8xA==
X-Received: by 2002:a17:90b:364c:b0:25b:e311:14b9 with SMTP id nh12-20020a17090b364c00b0025be31114b9mr3793320pjb.29.1686605501349;
        Mon, 12 Jun 2023 14:31:41 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id f3-20020a656283000000b005308b255502sm7212405pgv.68.2023.06.12.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:31:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1686251688.git.jonathantanmy@google.com>
        <3ff7acfc-0fd2-88a8-3e31-2c6405a03f59@ramsayjones.plus.com>
Date:   Mon, 12 Jun 2023 14:31:40 -0700
In-Reply-To: <3ff7acfc-0fd2-88a8-3e31-2c6405a03f59@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 8 Jun 2023 20:50:56 +0100")
Message-ID: <xmqqa5x48j0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I think the only change you need to make here (because /usr/bin/sh
> on Ubuntu is usually 'dash' not 'bash') is to use octal rather than
> hexadecimal. ie: CENT=$(printf "\302\242")

Perhaps an addition to Documentation/CodingGuidelines is in order?

 Documentation/CodingGuidelines | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 9d5c27807a..78bc60665d 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -188,6 +188,15 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
 
+ - In 'printf' format string, do not use hexadecimals, as they are not
+   portable.  Write 
+
+     CENT=$(printf "\302\242")
+
+   not
+
+     CENT=$(printf "\xc2\xa2")
+
 
 For C programs:
 


