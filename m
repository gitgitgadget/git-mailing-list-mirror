Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830CBC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D97604AC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhHMQjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhHMQja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:39:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9EC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:39:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w23-20020a170902d71700b0012d8286e44bso611100ply.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rNtSjyHIzwxBMEUyihPqdCcJlGXi3eMnG2l7FKkYZ5k=;
        b=h3rNo6x/NQ2JjAFttvvsMmof5+35hPoXZHOR1jVsoQTcrBzn6S+zHvflgXEAe4q+SA
         EQzoXfZEHHJKzfuIJRBxcRLBPI67McLMmiU8KXH9y3gR3j8wmTGlqsqBH0rs74fYtq5y
         ReuKwl2I69OnkPaPBbK+VysVaxfiuPakYKYmVUE6Y/JeKqo3QBJl1usqETjuS23i5PeE
         2fw0fIB7BhlwMomMl5kd9nBYvl6AO8qjjB6a+tPgpAltAKH0zpwWog+FN0dtVg/gL36O
         MwpMom7y2anqMJ63pVdEgZc73RPE0cfIRSV9rxyK8J+dI081lF2fWmyMWv8J7IfffeAZ
         QRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rNtSjyHIzwxBMEUyihPqdCcJlGXi3eMnG2l7FKkYZ5k=;
        b=YCbm2Wdo5+g47tsG/Q9/dT/Y6PQKg5vk4IfY8Iz9dJrLKpO8uvyKqdVvWCqld3Rv1k
         FOFfpm9tC1b7jXNZwUbbgfI7xe28MXp9xyn9+3REZASJMX1lIxWbPxdXdfWWJ8+r+uPp
         RRXlAFJ1WNegS4O+6FMA6rPF9rqVBxmGfuEBi41LB8PI2nVZpC7NsSPh4z+zbfiH7zWD
         5uUj2N916beNgVpjm1+YOw9aNJhBKpBbjQkN/sfS2ikafipVkc2ZQ9uoj4jaLxm3UWlj
         ol0+cevpCf/e5qfsV0GGhAauSmufYukiIv0mEuUqEPiM92LUk/PUlxGv3/Qw6MFgUiBT
         4MMw==
X-Gm-Message-State: AOAM533mjgHWvIZgPzssAIpGVx1GZGLJ9qvZHusZfAenlSju+wF0MME6
        t8LucLr2+b4t4O//fnU1eeGO9lP7dkcbbX596ZcX
X-Google-Smtp-Source: ABdhPJz7sF2sasrOpM+pT1G0w3MK0mR6KwzfyqED3voG1BiH5pQCkVFlnaLNin9keN5W94IRJTfoCiHrFxCEBDijwPfr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:150d:b029:3c8:e86e:79ec
 with SMTP id q13-20020a056a00150db02903c8e86e79ecmr3339936pfu.62.1628872743195;
 Fri, 13 Aug 2021 09:39:03 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:39:01 -0700
In-Reply-To: <YRREyrAXBmxVoxRr@google.com>
Message-Id: <20210813163901.3214789-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRREyrAXBmxVoxRr@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 4/7] grep: read submodule entry with explicit repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -		object = parse_object_or_die(oid, NULL);
> > +		object_type = oid_object_info(&subrepo, oid, NULL);
> 
> One thing I wonder is whether we are missing out on some error
> conditions we used to get with parse_object_or_die() by using
> oid_object_info() instead. Do we need to be more defensive in
> investigating 'oid' before calling that helper, now?

For the purposes of grep, I don't think that this matters - we just want
to find the ultimate tree that this object represents.
