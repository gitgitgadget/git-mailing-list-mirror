Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CF71F462
	for <e@80x24.org>; Thu, 30 May 2019 00:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfE3AT6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 20:19:58 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39167 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE3AT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 20:19:57 -0400
Received: by mail-vs1-f45.google.com with SMTP id m1so3249829vsr.6
        for <git@vger.kernel.org>; Wed, 29 May 2019 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Wld854k+1BVoLJnO81AcEFv2kJ+hVyVE1tFX/qfFUNI=;
        b=X2KdH6kbuzdKrqgXa1YY99vL5UAon+D1fA81yoj8KAahJRuz3nCb/a6E2id8XJsgBw
         b8nkDqI9GXpt/0ISq/TNtP1PyJTLQXl1oKsuIX4W8kZpWq2Hl0stEE5M8v8JNs4GtF78
         tAYwrLuqjoDjToQrVZGP3/iHdrbfK1ozAAGlNSGBGay6M0zfcNIfD3T4m8mZv/vGG4zb
         3fC7J7bN546Mb8gFWsIOrAyVj3zkJtxrxTktDc93bkkquTMH3R62L659UQS5hcSrR9iA
         NNxkYkwgm9WHKfQglRUtCIYmMALjy1NqHIjGPfc68josS4FMIKvQw8Lk/aYOGL+NxC2t
         NZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Wld854k+1BVoLJnO81AcEFv2kJ+hVyVE1tFX/qfFUNI=;
        b=Hm6iEOR5njZTVhEgARWqPa0QaAUgXi4LJBuzWtHEzYPfB0gde93TysJCn6aD6KTg6V
         fP1FppJU/2uln9Lq5WM9XigrgLzkyDle3zqMy7h/JqBkFGLjGVMkNcZkfnTmLDe6EwAp
         gHtVypGRTqj+xn0bonDL6EdJDFCdEzaOuZG7izGc7sUbJmaVYH8WROFf90+v1TTcw3FI
         rab91Tm/55I+SnQ5yFUi5O7jkyhKXv1VKI8B7G1MJDZfOYSPaYFQxpwQsDKPzWknFHvi
         KaDFauypsx+kTfEp7KfdADew8aVg1uSBVUy0qxGQGG2LZ0zosVGhllVikKwoEpgHR/lr
         X7VQ==
X-Gm-Message-State: APjAAAWSwUUJkh50TX/LhGEMycMynEobnXcYUUpQxhVZ/njwTyheSy2X
        QvdDr8fMa58S5pgIPwfEzDZDQLQ14MM0sHNNFW5IaTO+
X-Google-Smtp-Source: APXvYqwKnM0gq4CF6L/bcpTa9UPbeTY62NsOmlKhXHzd6gE1ReDIdotv6d304lf9qU0ruXgsDrTbsVoqlGDnP5Rp+zY=
X-Received: by 2002:a67:ce96:: with SMTP id c22mr366189vse.204.1559175596893;
 Wed, 29 May 2019 17:19:56 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Wed, 29 May 2019 20:19:45 -0400
Message-ID: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com>
Subject: Request: git add --interactive: split hunk: When can't split further,
 split on empty lines
To:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding interactively, 's' can be used to split the current hunk.
Once it gets down to where 's' reports "Sorry, cannot split this
hunk", it could be useful if it would then start splitting based on
empty lines, probably leaving empty lines at the top of the split
hunks.  It certainly wouldn't be perfect, and might create many hunks,
but it would be a nice alternative to manually editing the hunk.
Certainly someone could still manually edit the hunk if they didn't
want to use it in a particular situation.

Example:

----------
int a() {
}

int b() {
}
----------

becomes

---------
int a() {
}
---------

int b() {
}
---------
