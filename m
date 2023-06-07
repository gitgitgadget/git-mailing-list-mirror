Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B66C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjFGQbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFGQbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 12:31:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7FA1BF5
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 09:31:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so12471424276.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686155461; x=1688747461;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JMZnoY4XqTcDt48VDkYT5pC/JnPK+jLurDYhV/yZUSs=;
        b=7NeonI1n5/Sie6iiAQn121YG0RuVW+7uTb5RTx7MhVtxNJosZwAj4lJlUnNdIao0Fy
         owCJBGYBKMxTwxC5wH9oJbVBcr83IShIwcr5iN5sU0A/pLAq0PecKDC2uccuiUtfiDzu
         u6ivnAKkU9bkp6CqVqWYbRyZNadoit5Z7zRwaredpGkTdI010MQlXtJnm6hlZZdEX8G8
         gIUKdCuMHZFw37mOOMCkg5aI1xcLBRRgL9v9eNjrLLqYEHNzGFkoYYL6SoDYuik6NfFp
         jeHvIRbU2sOKlNrrnCZ5377qCpCxcZxLHBud6N4TDR+ZX4/yT34PHvy1uVv0Hu16Yaa1
         8HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155461; x=1688747461;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMZnoY4XqTcDt48VDkYT5pC/JnPK+jLurDYhV/yZUSs=;
        b=CnXl68siR1iA43BmEhYHeY34GB/6nksrMM96lUbjmjtYh9/Mi3PvdByJU7d9FiFigf
         Qq7YPfWTibIFsyEPrLF8XYi+m7NetQxXte/y9AZWzSe6EhCGCJxCz3bGLoA6oZUGXiI8
         +fXWwGsMVKAMshRvAbiz43pp3UESyC9a4c9sFDUSxnOrSpIqraJX5vbJqCY3WDUwa9V7
         NlsQAjmnqrAOf+RvqTna+hqbpUTlvyD35SD7B7zMoS+0c79RgUnL/O+Ev+DsdZEikfsp
         SBEnYqIwgeqrfKJExGVag4gp85R7Pp76esc7dHorsu04D7/LDMw89fEsq1t2xByCofGu
         EhUw==
X-Gm-Message-State: AC+VfDytU0CwlFWJqv0TefPGX04n6HkYOJVFjzXIuGn13gTbl4oLpdtL
        fvICu28WC9vwY6mdNIltBVD5Q6/4DnVCIsZQv6XM
X-Google-Smtp-Source: ACHHUZ4NyqeWJTTKgdhKhqxj5cblajTQgAH15WAKN6l8540z8TnU6dCDdIcH0cBcDcxLk1pO6MXUfbzgNTQ7hj2dAG2+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:83cf:b5ee:dde8:2648])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:72a:b0:bab:cc56:76c2 with
 SMTP id l10-20020a056902072a00b00babcc5676c2mr3553507ybt.8.1686155461281;
 Wed, 07 Jun 2023 09:31:01 -0700 (PDT)
Date:   Wed,  7 Jun 2023 09:30:56 -0700
In-Reply-To: <xmqqa5xh705s.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230607163056.1602219-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/3] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >> Here's a new version. With this, Git can function with both version
> >> 1 (incorrect murmur3) and version 2 (correct murmur3) changed path
> >> filters, but not at the same time: the user can set a config variable to
> >> choose which one, and Git will ignore existing changed path filters of
> >> the wrong version (and always write the version that the config variable
> >> says).
> 
> Seems to break t4216 when merged to 'seen' to replace the previous
> round.  Could you take a look?

OK - I see that it fails CI when I upload the merge to GitHub (although
it passes locally). I'll take a look.
