Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473DC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjEKVmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjEKVms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:42:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84855BA1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:42:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aae46e62e9so66408935ad.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683841355; x=1686433355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Lnh2sRBijWVZk7yqoJY2BLeohj/uIXFGZaUULtkb7s=;
        b=fDusFCrrJqrPOHGw/wjcOKQCfKFkLR4g2u8f7xJFN9hsrYKnd/kHFQPhSUpu+l8KM0
         JrIa2Um00RFxocI3tzeMK71WEJkFLQDe/I+IhUb6rTU1xIIj+rLIv6p2dfeXgjJWhQI+
         pGq6LWmFkwATztNZENFJcTZOR76WUICTPDd9S/34oJrerFH3j9yaYuO5tlS/02Y1gFun
         xOZ/x4A5bu2GSeO6hF4AGJpF3L+SkwzcR5PM/9IynFLKpeCc44z0Di8Mj49mFWiTeSw0
         rnShH8+jGCoA5SDzXSgtO0LyOqu7B2GSa3ypPKt0uS0Usr3mMt5Zk8vBcDBnUxEE9Trx
         msng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683841355; x=1686433355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Lnh2sRBijWVZk7yqoJY2BLeohj/uIXFGZaUULtkb7s=;
        b=Pr/kXbsfDJmzarX2fAcgkVHpT0i481wQGTErNmSDkdFG+gAxGwzsOOeIV/haJMmwY3
         +r61reqZl/UK1+OkVrelDka2iFGpUXz5YLcl020RQc2OYojtBfUh7RE1Sj9MdMUVXyyT
         HVn7BThKf/pH5ODNDMQTsa25TN4kUu6kzmQGK487esxHVQWKIcKtHPIcxAgs9vkGZ0oa
         wSpL1nrVj/DM00JOn153aUtK9gNVf7W5UsJZeARvG3Tq4EkS+ktX8FuzDWcu4sqZYgH1
         mgOTA3RI+3l0Ne7N0Ue8a19+mp7iNLRDwt2tfb13Gkcijd7j+IlrMRvJkcADfbWi+KDb
         YMsQ==
X-Gm-Message-State: AC+VfDzQ8lmUR2N/dA2T6lPPJUaNLceHsal4vFfx/22aJC3G+IFo3jdr
        2FMvEZs2twkTxGnsZbzsvS0=
X-Google-Smtp-Source: ACHHUZ7ciCx/PiHOWeAEck2HcJVjLgFDuxo+xO67vy1DAPRxe1cs76j0o7z7+i+YDQC+/8MS7zFsHw==
X-Received: by 2002:a17:902:e852:b0:1a9:433e:41e7 with SMTP id t18-20020a170902e85200b001a9433e41e7mr20693562plg.43.1683841355217;
        Thu, 11 May 2023 14:42:35 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902a60b00b001ab1a737c8dsm6339104plq.285.2023.05.11.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:42:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v5 7/7] strbuf: remove global variable
References: <20230511194446.1492907-1-calvinwan@google.com>
        <20230511194822.1493798-7-calvinwan@google.com>
Date:   Thu, 11 May 2023 14:42:34 -0700
In-Reply-To: <20230511194822.1493798-7-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 11 May 2023 19:48:22 +0000")
Message-ID: <xmqqr0rmtuid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> strbuf_stripspace() removes the skip_comments boolean and checks if
> comment_line_char is a non-NULL character to determine whether to skip
> comments or not.

Hmph, that is certainly cute.  Taking it as granted that NUL can
never serve any useful purpose in a text file (where stripspace
makes any sense), passing NUL as the comment_line_char can certainly
be used as a sign that no stripping is desired.

And those existing callers that do not want comment stripping are
already passing 0 at the position because the original parameter is
an integer (used as a Boolean); they now ought to be passing '\0'
instead, but passing 0 is acceptable.

It is not trivial to catch existing callers that pass 1 to mean
"please strip" as they are not supposed to pass comment_line_char
(usually "#", but there is a global variable for that visible to
them).  If left unconverted, they end up asking that lines that
begin with SOH ('\001') to be considered comments and get stripped.
In order to catch such a mistake, however, you cannot say "ah, the
skip_comments parameter is '1'; is that because the end user really
wanted SOH as the comment leader?  Let's warn if the value of the
comment_line_char global is not 1" for obvious reasons X-<.

So this step, while it makes sense in a vacuum, is a cute idea, and
is nicer in the longer term (because we certainly do not want to
have to pass an extra parameter to the function), raises the risk of
semantic mismerge higher for topics in flight that do want to use
stripspace to remove lines that are commented out.  My quick "git
log -S" seems to tell me there is no such topic I happened to have
picked up in 'seen' right now, though, so it may be OK.

Thanks.


