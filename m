Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866EC7EE30
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjB1XfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjB1XfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:35:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40022DE2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:35:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h8so8882179plf.10
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74Bk9y7RNUPJSV3B0nB3R952jnCpSv0DSfsvLk+5Auk=;
        b=igEUY7mLMaI6Ts3Ss5ycI3ZJ/bV8wqMv5nOntOmYZXJhl0K+r6pcfZ049VypmV8qGq
         PhmeuZZY3ap2Lvn0N44oe2yJGs6eAu23lid/kGKmKUr2yiM2pwOEs1QtajosFuGxwV1/
         l+3Vh+9pSG1sCai2c3YiSTcZshVr5UUGuP5L7TuEB/ePzXvLErzAfl3/Nn/SKUUqz4B6
         gQ/Zp6KgFxIFO2gPLqpYLcH4o1P0gxat5iBVvjjECPqbn3lJlGYtj62E1f38616zguMl
         FSZzmQmLVVIkaa63IOP388eEFEEby8yGSz361A5YZ+wVMyjhFqlhKExOpNt55jgasgin
         P48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74Bk9y7RNUPJSV3B0nB3R952jnCpSv0DSfsvLk+5Auk=;
        b=5ANE6s762hlbT5qh2cdP9gPrmzIqnRgkDuGesWG+3MZIJx0OI9dn5itutGJ6Ha46ep
         v/BO5xFDmzR3W/rspzgMY5LfYNCfzFUWojwm4PtWU8ixdnPsXPkdIDGX53PptfL7T0XM
         OJVrNyXwjUpukOkfbXhTNn1YEzNFnEeRP1jz8LBinQib6iEkiGgzK2mC1oT1Kl17G6lv
         avXnFZy+EfdR2K4dyWV94GbrI786kCA59A1adNf6+YSQxzTWHP0/449OMmOd3IEmkqQu
         JL5PKLaQYg3fV2tIQKpT9c9B3I0hC/fR5RZwWzXkqUSEXC6SzcSKJLVn5+HuuZU9K5R7
         sJgA==
X-Gm-Message-State: AO0yUKXG2QaOUa2n66p9u2oP7/KdoaNduBr8mEK8XnLwMkfPcLLc8vb+
        GHIR+wHvv6U9HDgmx9mZC+hR3pXI4VI=
X-Google-Smtp-Source: AK7set9xdpZBnhX4+Dx0DtkLoruUicNj8qd7fZskitRFQqxr0gWpx8zn2DgoA2NejY9jgPhsrDpENw==
X-Received: by 2002:a17:902:d504:b0:19d:16e4:ac0f with SMTP id b4-20020a170902d50400b0019d16e4ac0fmr5787085plg.5.1677627319954;
        Tue, 28 Feb 2023 15:35:19 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b0019c92f56983sm7066275plb.120.2023.02.28.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:35:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com, peff@peff.net
Subject: Re: [PATCH v2 5/6] tests: remove duplicate .gitmodules path
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230228185642.2357806-5-calvinwan@google.com>
Date:   Tue, 28 Feb 2023 15:35:19 -0800
In-Reply-To: <20230228185642.2357806-5-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 28 Feb 2023 18:56:41 +0000")
Message-ID: <xmqqpm9tpdmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Swapping `git add <submodule>` to `git submodule add <submodule>`
> in a previous patch created a .gitmodules file with multiple
> submodules pointing to the same path in certain tests. Fix tests
> so that they are run on the original added submodule rather than
> a separate manually configured submodule.

Doesn't "git submodule add" have a way to give a specific name other
than the default taken from the path?  If "git add sub" is converted
to "git submodule add --name subname ./sub", wouldn't these changes
become unnecessary?

