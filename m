Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F7C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 18:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDCScQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjDCScN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F293
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 11:32:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw3so28945776plb.6
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680546726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiR3kkOSKmHCI89v4a80vJZ0Bnf7jZ/m5Wx9JnTH2/s=;
        b=X+FaDGGzLMySgg0ulECRbBKQk7bsT4YjBXjq31t8+/QGyZN4vGETL/tNWCKpLptmMZ
         k3wa/Ieq3pJhqKZeFFHo8QuOT2l1Ca6bu1fKzpdzXbLR+ZBrZpvdvz68KbPqDlgBogN0
         NiHAu4MOPLFINTe6NYC/Jb1LwLSchcPzWugLOU3y6WRYPdt/HiHp0XJ6sl62qQoeQ6Sq
         zA7ja5KntUmvJw7Pm+1Ae3vmyONNTip/iuEdDGiDwffC8HOoB9H1xTyZBR8C1JQWSE6r
         rde/3rfvFmaafC7h++CRgqDPiWXsZDKKcx0oBEUYMGjxot8czBTkkbC69A2dzGoRNlM8
         K5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eiR3kkOSKmHCI89v4a80vJZ0Bnf7jZ/m5Wx9JnTH2/s=;
        b=uD8NxVUZBXe/tJI3jH84FaQz6ybv4UPKEQRz1R+M3G8SfNMtA8qOvc1GeUml/2RYIZ
         1mff/5u3c9DQEDaAaTPuxgIBkQJHAaoNl1fq6f+0rK+JVrZBh2yTr/wxsNBMY6XySEAn
         +irLauEYYuou6B7vlWrE4TRXRH1eezI8ge10g1HzuxyR7Y/NJBL1p1EUU3syj0Jz0szF
         pNqoSQZi0jQ8VAsDt/n5sREvfqK5XIalSk8JtP1RCZAsoWYFmZmDk0CXgH715PMJUef6
         H8CABXu7MTQ5KGLCLp/lEShwtMuwYgm5Iqt81lz8av4wRnh6MQA2LhDbM/tC5jZAJSHO
         DuDQ==
X-Gm-Message-State: AAQBX9fBAY2IWG26YGC2PAgFAfjMHcHiGAJac5d7nNNA1Xcrj8smboZN
        Lop47nCiq5yf2wYJcaZRZLI=
X-Google-Smtp-Source: AKy350bTMUHbXMtK07kCOnB66oeOKsOV5a+uGUlePQ8AtBD/NgR7VKo7RCnxL1XrHohpRUp0gcTVnA==
X-Received: by 2002:a17:903:5c3:b0:1a2:9051:f09e with SMTP id kf3-20020a17090305c300b001a29051f09emr17400plb.21.1680546726558;
        Mon, 03 Apr 2023 11:32:06 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b0019ac23cb6edsm6929544pls.181.2023.04.03.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:32:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] fetch: download bundles once, even with --all
References: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
        <20230401082233.GA3503828@coredump.intra.peff.net>
Date:   Mon, 03 Apr 2023 11:32:06 -0700
In-Reply-To: <20230401082233.GA3503828@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 1 Apr 2023 04:22:33 -0400")
Message-ID: <xmqqy1n84y1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	if (!uri || !*uri) {
>> +		result = 0;
>> +		goto cleanup;
>> +	}
>
> Coverity flagged this "!uri"; it can never be true since we
> unconditionally xstrdup(uri) at the top of the function, and we'd
> segfault in that case.
>
> I think the existing code that assumes a non-NULL uri is reasonable.
> Even before the xstrdup() we'd have segfaulted when it was handed to
> fetch_bundle_uri_internal().
>
> It's not a huge deal, in the sense that you're just being overly
> defensive, but the comment and conditional here are a little misleading.

Nice.  Thanks for commenting on what you spotted.
