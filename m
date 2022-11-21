Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B7C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKUAfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiKUAe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:34:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452C5FD3
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:34:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so9192655plb.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8+ZMZ8etNIgE6lVt65SLxgXX8cytOlU7G+SN9l7PEA=;
        b=cuIcd4iP24MUQKplreI3h1b1OtCvKYeo/b2bXtoq+ry9HDqbJofkhb7oLP0AAR2enD
         vnNullzwDYDslloMQCQbvk3lTr6DE8ytx0eIBZXRejRLRO0l+c63l8WZPcXGuu19wcL3
         rAEFx59DmclA0WVbzvm8frwY2pUXYGKiTY26FIW6L5+9EgPimbfeUjaxFTF9VIyiAtWC
         scL4ouzdC/AnEljs4oRtbpw9Ru3uD6//noO3u3gGzXN0G5Z2LO14xK/a3pHJshK3OvwT
         kOr0I16PM3X4OIgc+hiK0BRNMOw0s+0WmYsIkbwsEjITU3Reau2DKH16oI+JchqmdvXa
         RhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d8+ZMZ8etNIgE6lVt65SLxgXX8cytOlU7G+SN9l7PEA=;
        b=R7vnhBKPs9Tm0ZOH45u3y3tNcJ3uUDlSTJuvx7m3Vt2NiUOQWrkGeKgTNOM/KoIbTY
         UvLS3KtkfnW6vhET1O8bc4vrYAyc4FXvYlU9czhzA85LGyCUKU+RFBMNMmgynDSoPQA9
         xGq+WU7+qRadQvm+20CvVtPLN6x+WJYef1UTplhbgoe2xD7tFYEtoPkj/QQpIKQF8WEY
         1tNsghDDdWa36Ms2QiLMq7hVqf+qebfNOmT7ro8FH5TRqxysbbCS/d2qgkeUieounGtz
         n4pLgaLa/PSKBAY1B1W0mOgHRFfqWOicD8/ixHM/Al9NqcmYTHI4iZgY5Bz7mroqmt8c
         MXyw==
X-Gm-Message-State: ANoB5pnQFDxoTNuJEoEhkK2yovmDLj0QHtCaRueWfpwWCtEULCGR3Zvf
        ZgwMWL4exmo+t+aMQW1V0rboX/Dr3iRcFQ==
X-Google-Smtp-Source: AA0mqf4uJUM28cTV7XZycv6ezLm8cCFhD25flcAjjzzidUiOMUXGSZGS+eSmSMGBP59Ir55JJAp8Xw==
X-Received: by 2002:a17:90a:bd11:b0:206:64cd:4797 with SMTP id y17-20020a17090abd1100b0020664cd4797mr17996211pjr.103.1668990842788;
        Sun, 20 Nov 2022 16:34:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c65-20020a621c44000000b0056bcd7e1e04sm7212800pfc.124.2022.11.20.16.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:34:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
Date:   Mon, 21 Nov 2022 09:34:01 +0900
In-Reply-To: <20221112143616.1429-1-philipoakley@iee.email> (Philip Oakley's
        message of "Sat, 12 Nov 2022 14:36:16 +0000")
Message-ID: <xmqqfsedywli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Instead of replacing with "..", replace with the empty string,
> implied by passing NULL, and adjust the padding length calculation.

What's the point of saying "implied by passing NULL" here?  Is it an
excuse for passing NULL when passing "" would have sufficed and been
more natural, or something?  Also, it is unclear to whom you are
passing the NULL.  I think that it is sufficient that you said
"replace with the empty string" there.

> Extend the existing tests for these pretty formats to include
> `Trunc` and Ltrunc` options matching the `trunc` and `ltrunc`
> tests.

A more important thing to say is that we add Trunc and Ltrunc, than
we test for these new features ;-)

You may also want to explain why there is no matching Mtrunc added.

I also have another comment on the design.

Imagine there are series of wide characters, each occupying two
display columns, and you give 6 display columns to truncate such a
string into.  "trunc" would give you "[][].." (where [] denotes one
such wide letter that occupies two display columns), and "Trunc"
would give you "[][][]".  Now if you give only 5 display columns,
to fill instead of 6, what should happen?

I do not recall how ".."-stuffed truncation works in this case but
it should notice that it cannot stuff 3 wide letters and give you
"[][].".  The current code may be already buggy, but at least at the
design level, it is fairly clear what the feature _should_ do.

As a design question, what should "Trunc" do in such a case now?  I
do not think we can still call it "hard truncate" if the feature
gives "[][]" (i.e. fill only 4 display columns, resulting in a
string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
that are given), but of course chomping a letter in the middle is
not acceptable behaviour, so ...
