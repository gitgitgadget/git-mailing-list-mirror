Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10778C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjC1OCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjC1OBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0213DBEE
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:00:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id fb38so8048647pfb.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012042;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AWNXURa67oVBh1KFs2WMF5ZhfSuCPmJPY5Q12WJiGc=;
        b=URs0tMcEHzVQGoy0JQp9oBtMhe+oMO1H+94k/DZmKDSELaiT8egg6T0IZpRvwXYYCA
         TmHXAyvfJkAQ25tjThkDwh0fWD4zss8HSgzfLoghz41DZ4yFAYgNKJPP7FUir+c69uPL
         k6vSSqxwDj1zuFVfj5gYoxsDNhTLbiEKe+L/F1Q81TzFPEQdCzSSjwW/Tu9Am0SvdiaX
         +BypTWOR4bmwBPZDBr+c6SaOdYJCcU6qix9JiDxSQwjwh7AOacV+y07v48ESqCWdMhNg
         ADzudy6VEiWbu8MsMZsy9Dn2cvu7S61aV5QGN01k9aUD+dGlNAEfNJqYwSMnC2799Hd3
         X65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012042;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AWNXURa67oVBh1KFs2WMF5ZhfSuCPmJPY5Q12WJiGc=;
        b=Ta3AJDJZrhfHRIxF4mtSOv3P+GWztdCFKqooIzGz7XOipaBI59LGGjjuIz30sRE04R
         9woFWbEXM3YyUGh4r5R6RxK72+ihM9nPIm+ZDTQvw0Eb4+RAU9QSV15UQbXYR8l2fWuk
         XkwgCrUdJO+tlL1QEMTKH4/PQbRlbH2R3Iast/oy4UlDhgyk/nec3NTgi033KoFTxR1R
         mfhz35EOgCJ8mcCC0OPRLIBBUI1jTozoGSg98UhJ0Aa/x0PfuTE9+xImqf1SVA4QHWyj
         seB/ydl5iixzDYVRrQ4Y8+aJthqy+uEoH5I4+IFlJ93NyAyhzXrzdvyn9niSZ7RhrOEk
         dXcw==
X-Gm-Message-State: AAQBX9cg51EVVjUM8OyzrabxdTKY0K9atlif9yRTc2zxMbuiL2PnysQV
        TubbBrFInlOHbmSqsRKaCEo/MgAeqcY=
X-Google-Smtp-Source: AKy350YvAEc0DDubOxCRD+uidsfdE64R0XwnXCGshlPrb+Flftut3Hu+Yj5SAAvPWHTuF9kwIAdMuQ==
X-Received: by 2002:aa7:96b0:0:b0:626:24b2:cd6c with SMTP id g16-20020aa796b0000000b0062624b2cd6cmr16840043pfk.7.1680012041891;
        Tue, 28 Mar 2023 07:00:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm18728242pff.189.2023.03.28.07.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:00:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
        <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
        <xmqqa5zxn85r.fsf@gitster.g>
        <4f570b05-036d-45a1-8caa-cebfce3026c9@app.fastmail.com>
        <ZCLqbmWsN/7Ihjg+@ugly>
Date:   Tue, 28 Mar 2023 07:00:41 -0700
Message-ID: <xmqq5yalj7qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>That looks good. And the transformations are just:
>>
>>    Revert " → Reapply "
>>    Reapply " → Revert^3 "
>>    Revert^<n> " → Revert^<n+1> "
>>
> i thought about that already, and concluded that it's getting a bit
> "too nerdy" and over-engineered.

I agree that Revert^<n> looks too nerdy, and suspect that it was
also one of the reasons why the old discussion thread died out, even
though nobody in the thread explicitly mentioned it as the reason
to reject it.

> ...
> but i don't mind, as long as `Revert "Revert "Revert "foo"""` cannot
> be argued to be canon any more.

At least, that form can be mechanically understood what it means
with a single rule (i.e. "count the leading Revert"), instead of
requiring a set of rules (i.e. "if it begins with Reapply, then that
is reverted twice, count Reapply, multiply by two, and then add the
number of Revert").

I personally prefer a format that conveys how things happened in a
way that can be easily understood, over a format that looks pretty
on surface but needs more special cases to understand what led to
the outcome it represents.  But because reverting a commit ought to
be a rare event, and reverting a revert (or doing so recursively for
more levels) ought to be even rarer, it shouldn't matter all that
much either way how we phrase the reversion of a revert, or reversion
of such a reversion.

There will be folks who will complain no matter how we change the
way we phrase the reversion of a revert, while there may also be
other folks who like the change we make, and I feel that it would
not be worth my time to deal with the complaints for _this_
particular change that was proposed.  As long as proponents for this
change promise to handle all such complaints on and off list, I am
fine with the change, though.

Having said all that, I think this change, if we were to apply,
should be described in the documentation.  Perhaps something along
this line?

diff --git c/Documentation/git-revert.txt w/Documentation/git-revert.txt
index d2e10d3dce..d09311dd8a 100644
--- c/Documentation/git-revert.txt
+++ w/Documentation/git-revert.txt
@@ -31,6 +31,13 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+The command by default gives "Revert '<title>'" as the title to the
+resulting commit when reverting the original commit whose title is
+'<title>'.  A commit that reverts such a reversion commit is given
+"Reapply '<title>' as its title.  These can of course be edited in
+the editor when the reason for reverting is described.
+
+
 OPTIONS
 -------
 <commit>...::


