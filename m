Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C19DC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDETUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjDETUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:20:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983945FFB
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:20:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso38310359pjb.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680722438;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+mVjKhxsIKdcUO3unH4X9IdS9QnAEq2XSvuEDZtuGI=;
        b=Htg9hE9ErBT/94gXFjmg/fNP6MKrN9akXYH6QVLcPARbktt2+32M8FJ8oMF7zFSXW0
         RRpHVhAuzg7ojbHRnX5YD9Hm4vSAYeZr90HBSUuZaICkotOpgIQPCphsjXgtiESsNTUw
         BRAiUXzSfPIwGRUVPy3xn2seky1pHPnZsNcVRc0gN3mQkRMZgyAcCqB1Hv1Hp7A5iTqe
         mJOoZU8MUCVwNHkrtaMB0dkcG7XDaS+nvUsE9GaMCmVGyYOV6iXYlksZPFRFgr5fSnsL
         WUlF7hjDfpp2KHzozqGF+RNMxb1jXvrtjBcK5PvnAoGPSjJ/8bahTlKhJymVBF2HJn/i
         rzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722438;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+mVjKhxsIKdcUO3unH4X9IdS9QnAEq2XSvuEDZtuGI=;
        b=bqxSCW5lvgFoYfNeSU85m0kHGfiP2sdcrk9vWtByUQWhG7PPK9UUjdUu7x6zzOOSEO
         ooUErCGQDkMtrAHtToNAa9VCl358HWGuz0YqjwFUQFMt4W1u60j8XIxUIRRT8e/hepOn
         aS18zeVHQsnxVKPJ1t+PGExFBiWfKIo1sjs8zMZGvsyrfe2kdhEPbo1KoOlyw6zW6wtG
         /ZB1LJQ4x5klPryhN+Es8hiI04O3Q/waHQKioHfNQgxrSV+CwrwjQPTHa5MuAwvPbX1X
         N1y6XNhU3rlfHvu4fQPo2TlnA60j8kxLiEx2wDA9Lt2eO5o1f79deOSiuGv/fJtWq4u2
         QibQ==
X-Gm-Message-State: AAQBX9cwC55ldgra1G80acDYDcD+pJwvKZB+tO+tf6w9ij4tIa0806/L
        hNdDPw/uj91gPM6cBJjVGNI=
X-Google-Smtp-Source: AKy350anX+Wnj/x3ppu9DEsWkraAX5EmEDgYqsH4nQdEZUvahxKAgnC17tf+9/QAj0ZAYm4xB0U1OQ==
X-Received: by 2002:a05:6a20:3148:b0:d9:7424:341b with SMTP id 8-20020a056a20314800b000d97424341bmr374335pzk.9.1680722437894;
        Wed, 05 Apr 2023 12:20:37 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0062dd8809d67sm11315408pfk.141.2023.04.05.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:20:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] clone: error specifically with --local and symlinked
 objects
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
        <xmqq7curxk22.fsf@gitster.g>
        <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 05 Apr 2023 12:20:36 -0700
In-Reply-To: <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 05 Apr 2023 09:48:22 -0700")
Message-ID: <xmqq4jpuw2yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Since this is an error code path, I think the extra lstat() is probably
> worth it since it lets us be really specific about the error.

OK.  Sounds good.  Thanks.


