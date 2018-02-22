Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801861F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbeBVSxh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:53:37 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35831 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVSxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:53:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id l43so11653495wrc.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l1UbQynCzQN+pFOGxqfzezakrJoXy5YRI8Emo70iEyA=;
        b=adURR3zHJ47F4Hsin1yGRruvA5ogdURGGaNq7T2NdK4mn26VALO3e+oU95LLXKXs9G
         AMlwZhc6k33HQRFMSl8MWtWk0q+taH6m6xPLaRorPBpBK0uicleCv6yP1woqGVs8YVd8
         2oJTAkckwTSE77RlX64bc9XUQbl0QymF/rZQYY/gAHh/3IHnA26heWTIUh1UWJWUxfCy
         nv1mUdAcb9Ikc11GvY/sgwU+LDbnA55srPoLgjuQ3/k96LIonbmm74ZVeZVKksAw6IZT
         ylZpmfu5Zo2mQnXOlJvJA/tD+Us5uMd38PmzQPB7zbZPsQ0a5HUv0JcoDEhtjt6Zrml/
         t80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l1UbQynCzQN+pFOGxqfzezakrJoXy5YRI8Emo70iEyA=;
        b=iZgxf22OWUpO5/3zufKhZm4f5r/KdbCqfI5z7QIjIfwLnSvxG7qb5h4bRdLCvt+apn
         GIldCcgVqwJPKlxs4wnRIJKpo1ck8IpQeQigUVPyeN+7MvwICeqyG5V6K1tXa0FP4C9K
         AkCTie6lSzlf16BGoHYjYQrGWTvogxJjdGz9FczS0c+Nn64LrkVDofuMdeP87BRaayIp
         +Wh8cR1SzAqznAXukWDFVfmO+G7xlpR0TdywALptk1HRU+HjKF3z6c3UisQFwFf9Cnr6
         0dRrqxQuvyB/grOpZdrgOj0ULFauLKeLdNgZ+XQrXCCusKl7QXHCkfKkXs4O4yNaXWcG
         G3VA==
X-Gm-Message-State: APf1xPCGCsCTypKzM+VRZaZpNclM/p2yUIq3HvffxgMZBZMYwZg6V1RS
        llGGnBCjlIBTzVcKF4DjFiY=
X-Google-Smtp-Source: AH8x224io2zg/23056Lpq3E1s5LfX8Uo7C1YTDaaTOqFdVVknK6YPQGKZLX0kcS+8xGvYLHadhki0w==
X-Received: by 10.223.166.103 with SMTP id k94mr6756814wrc.237.1519325291896;
        Thu, 22 Feb 2018 10:48:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v23sm108394wmv.8.2018.02.22.10.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:48:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
Date:   Thu, 22 Feb 2018 10:48:10 -0800
In-Reply-To: <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:21 -0500")
Message-ID: <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Teach git-commit-graph to delete the .graph files that are siblings of a
> newly-written graph file, except for the file referenced by 'graph-latest'
> at the beginning of the process and the newly-written file. If we fail to
> delete a graph file, only report a warning because another git process may
> be using that file. In a multi-process environment, we expect the previoius
> graph file to be used by a concurrent process, so we do not delete it to
> avoid race conditions.

I do not understand the later part of the above.  On some operating
systems, you actually can remove a file that is open by another
process without any ill effect.  There are systems that do not allow
removing a file that is in use, and an attempt to unlink it may
fail.  The need to handle such a failure gracefully is not limited
to the case of removing a commit graph file---we need to deal with
it when removing file of _any_ type.

Especially the last sentence "we do not delete it to avoid race
conditions" I find problematic.  If a system does not allow removing
a file in use and we detect a failure after an attempt to do so, it
is not "we do not delete it" --- even if you do, you won't succeed
anyway, so there is no point saying that.  And on systems that do
allow safe removal of a file in use (i.e. they allow an open file to
be used by processes that have open filehandles to it after its
removal), there is no point refraining to delete it "to avoid race
conditions", either---in fact it is unlikely that you would even know
somebody else had it open and was using it.

In any case, I do not think '--delete-expired' option that can be
given only when you are writing makes much sense as an API.  An
'expire' command, just like 'set-latest' command, that is a separate
command from 'write',  may make sense, though.
