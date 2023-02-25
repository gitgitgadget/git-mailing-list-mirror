Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B6C7EE2D
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 22:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBYWuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 17:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBYWuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 17:50:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723B14480
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 14:50:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso6507976pjb.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lOoAZrXJNmn09ocagHe4UEW8JVrjSRrPAhkEUX/ZrlA=;
        b=p6KLCpyae2We9TtBejt98PQpYljSAZXTkABL1WAAsPQbPXg6uZRYETB5up53UVSbWt
         67RbO18NwusNxJoFqr7J14ogEUCIL8xglbh/seL+buFvdEAIyb/KAYPFJe9NMrKMCTxU
         vpaobx73orsB0FOvNRcJDuMG6bLRkrA/a6QZks7SHwjX4V28N5qO2mGolPqgtNJnJDSE
         4jO4wi+CLIE+5aokoE3Oy/t3EH9IK7iX/MeWKV4TFVry/fBdNjvSqqdHnXjqvrnXGakX
         HUlmzFOFDhWBGFWI4mJVLiVJGSqwKtw0VNUUUtJPO2wbGHd8In1AJABt/qkORvHDqUw9
         oZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOoAZrXJNmn09ocagHe4UEW8JVrjSRrPAhkEUX/ZrlA=;
        b=J0+iWXEl4b25nFmyDXvk5SDbpF+DmZ+bkBzHiZgVOQCg5Cf5pnAe66w4ybSHh8Z2wZ
         q2Xil0edDwjgAjqSBLz6qDMvim3MvVxTGrDxtqUXfZvIC0yPbbWpqy7q/AQUG3x6iZH0
         CK7pehmqRe35mPuUOFFGVXR8zM0V3Enycg8EzzaXLoobUxtgercS4pv7QRY9wz/ClokE
         yoV7ZYghtXTpTAbIx2l4h8jXX3TgTknLCbh6HHu/zEohtUxf/Y+X32Yb5tCz8NagRTue
         Q+EHDL2pwWcq4qNVjRodZSUjDNvHN5Fiv5Qmv4AVBVGHZzTZiZE3m4eH6Tz2ac5BsWql
         t9WQ==
X-Gm-Message-State: AO0yUKWmtB6z88jImKvMYKbdG1T2V43bxCvmEco4CWLHPztcuSeDS74N
        DyafiU57UeUaRK/fGRePpVM=
X-Google-Smtp-Source: AK7set+NEY2ON6ZQXrX6KwDoUL1xyQ5MA/zTXFYVKRThbYw8jNFhkYxJ20+6PYwzpBS4wEsPN4QFaw==
X-Received: by 2002:a05:6a20:a110:b0:cc:63c6:8d3a with SMTP id q16-20020a056a20a11000b000cc63c68d3amr8590701pzk.41.1677365409597;
        Sat, 25 Feb 2023 14:50:09 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t20-20020a62ea14000000b005a91d570972sm1634715pfh.41.2023.02.25.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 14:50:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2] test-lib: drop comment about test_description
References: <20230221232245.155960-1-rybak.a.v@gmail.com>
        <20230225190526.21780-1-rybak.a.v@gmail.com>
Date:   Sat, 25 Feb 2023 14:50:08 -0800
Message-ID: <xmqq5ybpuzq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> ...  The assignment
> of "test_description" and the process of writing tests in general are
> described in detail in "t/README".  So drop the obsolete comment.

Sounds sensible.

> An alternative solution is to move the comment down to the usage of
> variable "test_description".

Or at the beginning, as the comment is about "how you can use this
test-lib.sh test library in your tests".

I have no strong preference.  Just dropping it sounds easier, as a
more readable description already exists elsewhere.



>  t/test-lib.sh | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d272cca008..62136caee5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -645,12 +645,6 @@ u200c=$(printf '\342\200\214')
>  
>  export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
>  
> -# Each test should start with something like this, after copyright notices:
> -#
> -# test_description='Description of this test...
> -# This test checks if command xyzzy does the right thing...
> -# '
> -# . ./test-lib.sh
>  test "x$TERM" != "xdumb" && (
>  		test -t 1 &&
>  		tput bold >/dev/null 2>&1 &&
