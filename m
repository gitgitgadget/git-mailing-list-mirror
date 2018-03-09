Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C807F1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeCIWSY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 17:18:24 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45978 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeCIWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 17:18:23 -0500
Received: by mail-wr0-f195.google.com with SMTP id h2so3084516wre.12
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oLlUVij6S520oQSkR8LwDo3GFditZEEAsL2UYIpsWZE=;
        b=fGv85MUSecoYEqWRSB+xfKEDOzMtGzqlLsinxIRg310nVtZKveMAH0Enn4W48/BeCd
         ywWp18tu+LRQkTXx6DPGzgcESATASXhUjwuFl90C5qvPYZijbZzT4sCyb1J2ObUuUF2X
         7hP/7jfvxaSq20tzDz2IHYSy8D52pUb3P9MvNxK0hBXCMF5DDrG1Jam++3mQ694+Jo6e
         JlTABmZdKdwuX8YJT2jwZKGQl4wjc03t4WiSA1SrkuReLqWZrK8DeH1Dx2FbdglRZTQs
         1c3ToGnqB3qhZ/CAGFOztjtojL8WSIqCTQ2s5S3if9YUf1UDq8pgxwH8drrnLMxfpN83
         aDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oLlUVij6S520oQSkR8LwDo3GFditZEEAsL2UYIpsWZE=;
        b=X2fPHz8+6WuYAEDAowg5Uj5r0U606FYgb3L7a8cXeTizKipGgTXpVSBUBs2hS/WqPp
         2ZvXCyJmKMs10uMzsiWNZCCQBQG6mpX5wtgD/c7OrCs4xql3kSuFY5O9ylCkGiF8BkJ+
         r2b08bNCbS7hOFYEC6tU7XsIbyouc4cY2n7NqLDoC10+uXOCWn4jC6eYhfwWeaaD4IIv
         Yk1XSXlcJu6wPSyugI4DmLUKFW3dDP3rsF6G8bgH0i5N3G13w8SW8d17Z9Ws0txC5UIa
         h+w/HRneuhhEOwoTQeBcuAwCB0r1SBv+D5LUQ0GiDGHcZZUc04KDxTZnu26M78HuGL+O
         raxg==
X-Gm-Message-State: AElRT7GhuZYMilH3s39/hBjh1TmjYZiZQ6hdVox68rWRODgjKG21d1ew
        ktNsIPh+gCDhgpvxMPZnuXOtAI7f
X-Google-Smtp-Source: AG47ELvFO8bJly7LHumWsfg/tqGt8JLDYV+n607QJaEx3fVH3npAVJr+0oB/Wg8dcgYj+Zi/6m8zow==
X-Received: by 10.223.139.88 with SMTP id v24mr33009wra.44.1520633901691;
        Fri, 09 Mar 2018 14:18:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u127sm2608429wmd.30.2018.03.09.14.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 14:18:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: git stash push -u always warns "pathspec '...' did not match any files"
References: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
        <20180303154654.GH2130@hank>
        <08d765ec-b2d7-7087-fca5-2eecefcef9cf@syntevo.com>
Date:   Fri, 09 Mar 2018 14:18:19 -0800
In-Reply-To: <08d765ec-b2d7-7087-fca5-2eecefcef9cf@syntevo.com> (Marc
        Strapetz's message of "Sun, 4 Mar 2018 11:44:30 +0100")
Message-ID: <xmqqwoyk51w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> Thanks, I can confirm that the misleading warning message is fixed.
>
> What I've noticed now is that when using -u option, Git won't warn if
> the pathspec is actually not matching a file. Also, an empty stash may
> be created.

Soooo..., does it mean that the patch Thomas posted and you
confirmed trades one issue with another issue with a similar
graveness?  Is this something we want to "fix" without adding
another breakage?

