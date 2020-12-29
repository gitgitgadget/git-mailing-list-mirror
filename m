Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED911C4332B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34992065E
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgL2CCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 21:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2CCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 21:02:19 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0036C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 18:01:38 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r9so10723396otk.11
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 18:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ahiTnfrmPQlMY23CTEy5a3Wz4PCGo6IMVqhQzk0/JRk=;
        b=RA8Zg+uI/h88pf7jc4wld4sQVPAVnADY/8NOCmaUsJTzt/3MwOBiVq9S5rEw7xKCoY
         CGSRvwMKG0MlxY7m8SLISRfj96B1m+wkA18uvYxR+/fTuDHzabphd5pT3rnACs5A8TiO
         Q79kyQvHn43S2em8EeZyfuS+pjZcaJm+/0etuLYFHeRxd5HVWM9KbhMIoggbqRJ7laf/
         jIdpXiAK89V9Xm/jvDLuVliUtbrIDciYISjgwYc4yfeJYAJsdaEAGs7MNXRHceyvMQxN
         A+lownHcBKB/DoBhbifoS2/v7dtOd1B146h7MCIPBGV4lI0kkPKmMZEdybTQvOH8CNa7
         uElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ahiTnfrmPQlMY23CTEy5a3Wz4PCGo6IMVqhQzk0/JRk=;
        b=FAhCywthc1QTKgubTT5FLuHYJExY9+bdireufl+D2lDVW6q6eX5BXvQaBo+SCbCdhp
         KH68P9Hs/HQlCcwWbt6SxAL35QKpnNQChLtAl/B3WBJCDTnNP1fiErC5KDXU+g62t3o/
         li3KipFN7rrRRPvCjJydHqBVzqcovXLrAG/Rgevf7z6oyd0VptaZI9xtuxuazQKZR3Uv
         EPY2X13wapzpOGzdykImSc2x+3zyQjLreJc9X0d5n4mO8rNTgM2lLRXGhonkoXHpYyaD
         NSqZWX3Z4M0TyYMb+9qL+goQ3Oz8DALVlbeGb4jpXGB2et+3bnTuS/RzDrsjB4ISTeB6
         CYAA==
X-Gm-Message-State: AOAM531zFLrpY1EexTmV/NyomgbzyfFfnNBayWU84Jit645bdYUZfKfW
        Rq4JXov97lLdFANTOf1TLVM+v48NeAzVjQ==
X-Google-Smtp-Source: ABdhPJxaUBFX9+tKjeQcgbMynWbJsV2k9xfDJflcmI/rSEeQoegoriAmdRpLjRCEMpmvEDhddYFx+w==
X-Received: by 2002:a9d:5909:: with SMTP id t9mr33270971oth.263.1609207298085;
        Mon, 28 Dec 2020 18:01:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y65sm9059671oie.39.2020.12.28.18.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 18:01:37 -0800 (PST)
Date:   Mon, 28 Dec 2020 20:01:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Message-ID: <5fea8e001e8a2_27555208fd@natae.notmuch>
In-Reply-To: <20201228192919.1195211-6-seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
 <20201228192919.1195211-6-seth@eseth.com>
Subject: RE: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> Disabling may be desirable if the mergetool wants or needs access to the
> original, unmodified 'LOCAL', 'REMOTE', and 'BASE' versions of the
> conflicted file. For example:
> 
> - A tool may use a custom conflict resolution algorithm and prefer to
>   ignore the results of Git's conflict resolution.

If git's conflict resolution decides there are no conflicts, how would
such tool "ignore" that?

> - A tool may want to visually compare/constrast the version of the file
>   from before the merge (saved to 'LOCAL', 'REMOTE', and 'BASE') with
>   Git's conflict resolution results (saved to 'MERGED').

Can't such tool use "git checkout-index" for that?

> - A student or researcher working on a new algorithm may want to
>   directly compare the result of that algorithm with the result of Git's
>   algorithm.

 1. If git's algorithm decides there are no conflicts, and the new
    algorithm decides there are conflicts, how would such researcher
    find that out?

 2. Can't such researcher simply do:
    git -c mergetool.automerge=false mergetool?

Cheers.

-- 
Felipe Contreras
