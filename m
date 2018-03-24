Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34861F404
	for <e@80x24.org>; Sat, 24 Mar 2018 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeCXTd5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 15:33:57 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:46362 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeCXTd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 15:33:57 -0400
Received: by mail-pl0-f46.google.com with SMTP id f5-v6so9432628plj.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject:references;
        bh=mYbMWakGX6dRzAxZgntCP9G6b+vtQgfU8f8TcI9K1lY=;
        b=q1/K8tcEeKub3IyuUIz068EAoPBy1hr9s3fQ+Pubn+lvkiDiAR5I0YZdrrZIqEJUnM
         7fBs6znGhj5KMakgwI42wIPY5uwf5HAY6zJFegcHIXGLDyYUOoqLkWj84+jOwDANdjMJ
         FxeWXXKgj7gG31qKKcV1AKA8vqmWLWk/vNlWY2l3W2UD4C1wu+EFNECZr3STEJQ/B9aA
         foZc4Z34OTSYGb7xgsIqaPN8S5S7hgQZydYiZwB2xVEntjFCG59LafXTU8nu1XfARDcO
         jQxV5GtcHXAilnzrqcprokaxfkIdEWg7/Hi8eOy6RaKo5oGIk6TqhHW/CLuWccCsTUvv
         psqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject
         :references;
        bh=mYbMWakGX6dRzAxZgntCP9G6b+vtQgfU8f8TcI9K1lY=;
        b=qxWtk05gWNCRumXoTA/CX3IraAIzeaEC9OKXh9bdC4Fw10CuvisXUvOcvd0pSlhy6l
         g4Ag6LVMRhX9PqGnFVBoJzqzF6cnncpyOw60hq8CWWBhiW4Vr79spK05xfBlhDtzuh9l
         hnS7L/BSoogDvIpd9/cgc85WmVIZ8wJRcMrVItvowqMklaxCKSNx0KwlLT7e3PuI13gc
         3b0DyjPavm2TPXHYyQxMv+D1wBrwzd59icfb+xtRL2Ff/MkdzIXezWQ5nnx/uTxsiTPH
         5JQYGIuHQMfRdlFUBTA1Sc+MRiN8HBRbdr2KGOiSnSnJWImh8hRQsP31RedyjXM+edof
         RFUA==
X-Gm-Message-State: AElRT7HYZ1uAsbqek8wFSmb7bJ67JO3/Evlwfuxz+n+lAzn+WGxw5KGg
        tMsPv/FiTiuH+vNLbUSop0E=
X-Google-Smtp-Source: AG47ELvWDK8mxsIc4g5LrizbGvk7t00tWW6RPw4U6Ql11lLdDVhGlovHD7p9KxF38mfTLk+VAgrH5g==
X-Received: by 2002:a17:902:1e5:: with SMTP id b92-v6mr22861994plb.78.1521920036449;
        Sat, 24 Mar 2018 12:33:56 -0700 (PDT)
Received: from localhost (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id e125sm21693674pgc.76.2018.03.24.12.33.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Mar 2018 12:33:55 -0700 (PDT)
Message-ID: <5ab6a823.8369630a.f525.c93a@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Sat, 24 Mar 2018 19:29:53 +0000
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
        <5ab46520.0352650a.cc02b.a177@mx.google.com>
        <20180323050913.5188-1-orga.chem.job@gmail.com> 
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> "git filter-branch -- --all" print unwanted error messages when refs that
>> cannot be used with ^0 exist.
>
> It is not incorrect per-se, but if I were writing this, I'd say
> "... when refs that point at objects that are not committish" or
> something like that, as that is much closer to people (both end
> users and Git developers) than the "^0" implementation detail.

I agree that readability to users is important than the implementation detail.
So, I'm gonna change the commit message.

>> Such refs can be created by "git replace" with
>> trees or blobs. Also, "git tag" with trees or blobs can create such refs.
> 
> Taking two paragraphs above together, you wrote an excellent
> description of the problem to be solved (i.e. what would be seen by
> users and under what condition the symptom would trigger).  If there
> is a single obvious solution that would trivially follow from the
> problem description, it is perfectly fine to stop here.  Otherwise,
> it would help to describe how it is solved next.  Something as brief
> like
> 
> 	Filter these problematic refs out early, and warn that these
> 	refs are left unwritten while doing so.
> 
> would suffice in this case, I think.  We _could_ insert
> 
> 	before they are seen by the logic to see which refs have
> 	been modified and which have been left intact (which is
> 	where the unwanted error messages come from),
> 
> between "early," and "and warn", if we wanted to.

I think the detailed description is better than the shorter one in this case.
So I'm gonna follow to detailed one.
