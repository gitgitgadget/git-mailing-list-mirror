Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98486C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjFLVXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjFLVXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:23:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D15B99
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:19:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-665a18f5643so780152b3a.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686604742; x=1689196742;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8XS6XghBqpWW0uNRgw7CefY6SnXH37Ye4SMgORfkjc=;
        b=Ht4KTczxX+3SrOk9LdqHs8gqeKj/BCUNV+QU5CH+k0lMoSH9Vra0BG42Z+oZVvUnhB
         RKOoE0DUDp02F+a7q0Tk6R6vj4P1vWGt3DLsFonmBQ7odw4JWdpxodXe8GdpjX+fV4PP
         q5Q5h4sU2sIk7MbGHO1sfFsz244Bqa8NFHK934stBtSUiqat7OYEaMSsNW91wbxfpJ7Z
         C7OZgXCYSdUfJDzLbQBtlboupaCMVsIyggjg+r34YSuPAT8gtmy5K8aOQA50IkFuLCuH
         6rj4mQ7+GzeKvrBbyzyRToNY8yK9UkQmSDnPfwhrTPWuK9CsL0C6eEdrzLrWEQ4UxNjV
         PC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686604742; x=1689196742;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8XS6XghBqpWW0uNRgw7CefY6SnXH37Ye4SMgORfkjc=;
        b=T3uHynqClOHWMl7+JAp+3vmF4/rG0/ayAv3Dfl0HVgNR+eSYn+mdLj7kCaRbGTg9gQ
         EQpXxXzhadeF/FqeOAtVwOmw/gndQiuwXZR+nB3Fhmu3Hps/s1h+bj3nx+U2t/LH4r0w
         VAOHUBk/xI1ntTjoik2cTAmC3YZtYLgFqzTbnP6u79FyWf/FNgqYLytMm3CKlpc9Du9a
         ESsxhNsyn0ghZwg/qIbyiJHgaUICNizph2r7WUJcB1QehldN41/T/vZpnzSZ5pdMRreo
         NW3IQpugJoHRqD9skiq6uupo9X5n07IxUhMgHBAZ48XpoEpesujaESvsC4fo/VdADMxp
         TCFA==
X-Gm-Message-State: AC+VfDzPqP4b0wfwrvhyArE/Ng3Q6kwhsLXlprOHKBAkd5hAyrBZLpXz
        8JoyZmrgxNktWOy7/Iz+ZeY=
X-Google-Smtp-Source: ACHHUZ6UgyrXGo1ho/ja6gFYeFvraDL2z1+07nbdVy+fqTpaif+L3pcUg0YmdAiGC28wzmSgCisFsQ==
X-Received: by 2002:a05:6a00:1803:b0:647:157b:cb61 with SMTP id y3-20020a056a00180300b00647157bcb61mr11883886pfa.7.1686604742103;
        Mon, 12 Jun 2023 14:19:02 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00073200b0063d2cd02d69sm7335236pfm.54.2023.06.12.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:19:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] pack-bitmap.c: gracefully degrade on failure to load
 MIDX'd pack
References: <f123b68cb8a277fbf105b1789a84b9405a499b79.1686178854.git.me@ttaylorr.com>
Date:   Mon, 12 Jun 2023 14:19:01 -0700
In-Reply-To: <f123b68cb8a277fbf105b1789a84b9405a499b79.1686178854.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 19:01:00 -0400")
Message-ID: <xmqqpm608jlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When opening a MIDX bitmap, we the pack-bitmap machinery eagerly calls

I guess s/we // is needed here?

> When opening one of these packs fails, the pack-bitmap code will `die()`
> indicating that it can't open one of the packs in the MIDX. This
> indicates that the MIDX is somehow broken with respect to the current
> state of the repository. When this is the case, we indeed cannot make
> use of the MIDX bitmap to speed up reachability traversals.
>
> However, it does not mean that we can't perform reachability traversals
> at all. In other failure modes, that same function calls `warning()` and
> then returns -1, indicating to its caller (`open_bitmap()`) that we
> should either look for a pack bitmap if one is available, or perform
> normal object traversal without using bitmaps at all.

Makes sense.
