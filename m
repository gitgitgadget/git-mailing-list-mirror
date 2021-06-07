Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A2C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4174160FEF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFGRFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:05:21 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40859 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFGRFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:05:21 -0400
Received: by mail-oi1-f180.google.com with SMTP id r17so8507721oic.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6m94Xxlf5ze4eI0CSsjI55cUvAS8CMY9aA0LHxp9+Ko=;
        b=QNwDECxwaO7s3/ZxSSpXX5AnOHXkiRegDeMOHHN3n9olyavjC2pDeX1aVx8ejvRXdP
         AdZMJ0PyCchBc5Z8XfHHhdmA3ft/QWFPdGZ4hxbEl4tBXhCCHmZguqNKrGnC9k0istII
         uK7XZlRzwojmEvuCLevp+Ax+XexJmlcjj8jZMbThBG22l1IjWUtNBxtivnnRKxSwJM0x
         9mHmmCmAmwC9BV9kYJD3MQtGM90UF2uawjUJXSX4z+llDZVKeZBhQ88biJAsX1cYdLdj
         SXZfFbXb5/CtwXU+wg+wOZOnhr+Gs7xcpLIwdrmVWKPwToP5158IfSImBnvOQsw1W3TV
         6ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6m94Xxlf5ze4eI0CSsjI55cUvAS8CMY9aA0LHxp9+Ko=;
        b=PFMVWnjHxIjn2xQuS1j5ughb1uZhxEg+/72lqEEW+h46EYdH4iM+Su/9KNsp5B82yG
         BWsV7YV+gI9rFW5wBw5dmlzspgU45NOWhDoKHVBNb3e71H/WUvvneXswWdpLJSw/iXaa
         uFwtYnmd8Y62w/hOYrnPlpwID1TJUcSYXGPdU9aCvdsmt2QVGTYRvulrRBpXhJEJL1MS
         2l8m8gZxYUjFI3LijbI3fYrH/lBwB1SqOB+PD8LkYOHNgh3bah4B8Cqq0qVHiZPStVI9
         PFtuNBnhGG7m7pPznzSX96hU7azfaEm+SZJdNATvamCbSOzS7gVXQQaRRkF+1wg2aj22
         Ockw==
X-Gm-Message-State: AOAM5327o12U8eL4rm5sYu9cfkRn9GKIWc7rKVLVD7fPrblNZ5ifAM3Y
        d8UqTQ34k9kTJ735jshKNq0=
X-Google-Smtp-Source: ABdhPJzkp0gSJ/j7xqBhARVLHumla46N/9LNUxJtWPRtQG+b0pZGTzOSbqPkmPy16ln+91PJUnvxog==
X-Received: by 2002:a05:6808:6c8:: with SMTP id m8mr71295oih.11.1623085333505;
        Mon, 07 Jun 2021 10:02:13 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y66sm1899625ooa.48.2021.06.07.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:02:13 -0700 (PDT)
Date:   Mon, 07 Jun 2021 12:02:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60be5113c50a1_39c0a208e1@natae.notmuch>
In-Reply-To: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
Subject: RE: [PATCH] builtins + test helpers: use return instead of exit() in
 cmd_*
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Change various cmd_* functions to use "return" instead of exit() to
> indicate an exit code. On Solaris with SunCC the compiler legitimately
> complains about these, since we'll e.g. skip the cleanup (e.g. closing
> fd's, erroring if we can't) in git.c's run_builtin() when we exit()
> directly like this.
> =

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

Makes sense to me and it's obviously correct.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- =

Felipe Contreras=
