Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1608420248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDJD5F (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:57:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfDJD5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:57:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so3747697wmi.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OFbpVvn36aD2DKPX2EPK/I549f/zqnQej0qVJTlTGoE=;
        b=p1BuUYoINyTp7wWdBm5H6wJWk52JyWCLbf5iTZH4g57ZYQkXw65Kl5jQfbVEg623gT
         meKPT0Fo7dxoSFBsn6spkVskS+vynO8TL8drCYLNbziTTutflLovQxw+BBL3nibOMy/n
         jxkIMG095f4DcwF9cVwC1lDXUB6m4wQ/7OrqPG7QS7QMpFZTl0herhVEsV4XOhSNZS3m
         1YfMar18GrGThnbc/7zL1ABaiFrMAJJM0SmD8OLs5EPnCx3BvfWU1licKEnKZex4IjQB
         0OpPzFDKyS7mOXuDLN8bb+nQttID3gRqz4T1yRAXtB+rR0fm+YIapwlVStGZ5mzHK183
         iY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OFbpVvn36aD2DKPX2EPK/I549f/zqnQej0qVJTlTGoE=;
        b=rjW7jjSFeZMIWQqQmujGUU5v9tVkscPP2Yc86aQyOnXB357k17cSJdujo3JZtvwVbo
         bTGwo2qaD83faawVkHwEqD0uK0lI5pEuB1RQx5x0llpLo2HRKSDpUlSVZlUaQS/ZwjEc
         haPY6tUXv9iL/8Qs72+8Z70gmHpm6W+W4PXadzeQlA4qbBziuykzzMUBcYpjeq6EkUmw
         piDplKPf2+UDr2huXyAmVKnB+GpUvOr6i+pgjMojNKb4pIKju8JNzsT9dxYVl9crKqSa
         fSdzQ6f0AO5XcGft+PzsycMqhhmjPOL7BInd6pZT1x8Pq2pADPrQcCdulRyMaDe/fJzW
         SrbA==
X-Gm-Message-State: APjAAAWkdX5TAcTeQ8LyimQuR5yOAbHcloALTPW/49M/v1Km81IRtCpF
        +v7EAXgPLzYceJ9GugGKP2OetS8/e+0=
X-Google-Smtp-Source: APXvYqwLPJywbuZve2w/F3LoNiyg5WlIJbGmxTN8UIP7uQ8BQKCezmK4uvKmEQwEirQTlrcE0I4LMg==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr1112104wmb.110.1554868622879;
        Tue, 09 Apr 2019 20:57:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y197sm962673wmd.34.2019.04.09.20.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:57:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v3 0/3] dir: treat a repository without commits as a repository
References: <20190409230737.26809-1-kyle@kyleam.com>
Date:   Wed, 10 Apr 2019 12:57:01 +0900
In-Reply-To: <20190409230737.26809-1-kyle@kyleam.com> (Kyle Meyer's message of
        "Tue, 9 Apr 2019 19:07:34 -0400")
Message-ID: <xmqqv9zm1piq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> The series improves the handling of sub-repositories that don't have a
> commit checked out.  In particular, it addresses the following issues:
> ...
>   * Commit message tweaks.  These include replacing wording like "no
>     commits" with something like "no commit checked out" because,
>     technically, this series also concerns repositories that have
>     commit objects but are on an unborn branch.

Changes from "not have any commits" to "not have a commit checked
out" can also be seen in the code (the next bullet point), which is
a very welcome change.  It shows that the patchset was done with
nice attention to the detail.

>   * Change the "git submodule add" error message to match the wording
>     of the new error message added in add_to_index().
>
>   * Consistently use "expect" rather than "expected" as the output
>     file name for expected test output.

Thanks; will replace.  Hopefully this round is ready for 'next'.

