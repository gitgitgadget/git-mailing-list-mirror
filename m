Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF3720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 08:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKIph (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 03:45:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKIph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 03:45:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so13132270wrs.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CS+eaafF3oLOmqtHnUGjvl9vi07USxxqeTZQP68OKwI=;
        b=hhZNv45uSEn5JrDl5w7G4gPzdyMKUU61MVSlVHoc3j+cIfVq57rtEL01XpvUqk/cDg
         bcg7Ov5wxnWWjqmYgfYAyQUy12GV4bn7dp4kd2znfbWxYax7DrNwfvb672xl+OMoCEe3
         s3LARvuMzBkUlsEO+/J4MznmD8AGZV4Uk3Vuip7019W2g2fUNOZLb2ed3uzQGUpcZxZY
         /obj8PwnuEQQEiFsNLzK/6V9KKNnCAroB0tHZ0axh9xeZvbYt6wLbeW0MHV7wgr1Qd/H
         YGVMON1YagUbgCYmz6pqbK5cRUxUsewS3uhCkTGn12q2e1D0VqLZsjYy48nf6yqqHfDV
         2wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CS+eaafF3oLOmqtHnUGjvl9vi07USxxqeTZQP68OKwI=;
        b=Ny41MCL/pjTWYjOPqLS9LwiTagz50aTUGU4uegT8nmm9gYDaoYwf/sAUUvq6/41/QN
         PklToXyXQGxRDXMf83ipvTvFPDIcskI7RnOXBVX0UOwLyz5MTOQi1MpwTnjL92aMjUkz
         Cxdxt5zzOBlloV8VedSBypQtJtWWBi8/ZalmCWXchrM/QtrA1NIDtk4IYFzw1glUV/B7
         1alpK6XGqlEYtWwEqhm4A+zCMadelFTo1JNKNjsGNYJU+E8+NYysOMAhyAwlrVsttZ/r
         Vi2W0hWZPajwPg3YNxmr+6/RhVsxi5CitHwiYU4bNZ/DT4yQq1dMkC/JZyuIBxMsYb1I
         U1Sw==
X-Gm-Message-State: AA+aEWZCwHZ4J80GlM6PcubFm2syzbOkmiE4TQh1zSa++ItSuYq5oAiF
        40zFZRGHXF1ZgudGiW8iiz0=
X-Google-Smtp-Source: AFSGD/WDoHkYSA1pyISUeeFNLbKx43JjGPsfF2mf8a+6wnwmj5jIaWHfXRA5LRFB+DQMlE3GMcQYkA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr11752032wre.94.1544517935150;
        Tue, 11 Dec 2018 00:45:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t63sm669845wmt.8.2018.12.11.00.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:45:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 0/2] support for filtering trees and blobs based on depth
References: <20181210234030.176178-1-matvore@google.com>
Date:   Tue, 11 Dec 2018 17:45:32 +0900
In-Reply-To: <20181210234030.176178-1-matvore@google.com> (Matthew DeVore's
        message of "Mon, 10 Dec 2018 15:40:28 -0800")
Message-ID: <xmqq1s6oladv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> This is a follow-up to the original patchset at
> https://public-inbox.org/git/cover.1539298957.git.matvore@google.com/ -
> the purpose of that patchset and this one is to support positive integers for
> tree:<depth>. Some of the prior patchset's patches were either already queued
> (tree traversal optimization) or abandoned (documentation edit). This rendition
> of the patchset adds a commit which optimizes away tree traversal when
> collecting omits when iterating over a tree a second time.
>
> Thanks,
>
> Matthew DeVore (2):
>   list-objects-filter: teach tree:# how to handle >0
>   tree:<depth>: skip some trees even when collecting omits

This seems to require at least two topics still not in 'master';
I've bookmarked the topic by merging sb/more-repo-in-api and
nd/the-index into 'master' and then queueing these two patches on
top, to be able to merge it into 'pu' to see if there are bad
interactions with other topics and also give others easier access to
the topic in the integrated form.

Thanks.
