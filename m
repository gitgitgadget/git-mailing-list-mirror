Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AC11F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeGITdE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:33:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53342 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGITdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:33:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so22286044wme.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fPCc3FpIgjlHos1HIGSpZbN9qnGJ1qEf3MBnIGI/Mbs=;
        b=dZE+DtpSmJBk8w/LAnL9DDF3zvGq88L+3zVPyim+mzy1rtFcaw2SBbJH3q5R3H+oDU
         ArOYl+EFyD6XDOstvQL6C0iz8zJoIzXxO59UPXl3rUCD0YBwHGVPsC+ZWctO9qfBBsI0
         puBwoTaeri9S7i7xSb45RN7qcaSj1izK4ByNpdxTuc7m/mRi9GpVQX/zXyel+P7OB9Ub
         gN/4xs6BgoQlysQYh4pZAu1OOPn3T55rNfeKXe6Yn0bNprvg87Po3P37k2L9piSAgcpn
         zWGFI2KJx3SCGIRxop8GPPyFUgvL9iiDYmZvghEbIRTdtHUul7Ey5cUuCpR9xoT0Qa/o
         lOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fPCc3FpIgjlHos1HIGSpZbN9qnGJ1qEf3MBnIGI/Mbs=;
        b=spO/8BwVwEvrX6mCqM6qVaXTgwXTr2/UlKRgA2/Y4qi3yToj97IvDIqcWXESmw5JNK
         I/WFp2icYqP099dAOEBrxEyihKIyRSlX9JA+X3yH7+sXa0/VLtZEdRQhTGZBPqc826SU
         urKYCB6cyQyrL3cQh6WWmZrKe2Czhzh1wvNlQlSeL9XF5qQ/+sxiceOn1Zzkhw3nveTt
         7LqfjzCdQGyStew0Hvr1OWyQdfHYT883tYLiyr+vt7GEJ3jvXVU8pNgDKeTo/m3ghOf4
         Uo70Gvwpifj1A6E/3M4YlSvkNefkaHKZt0SvGgANPXMtRe1LegwI7ZicQ0WQ+jD6Vs7E
         WwzA==
X-Gm-Message-State: APt69E0AXXbKHx03UjWUa/woPEfmmObMZCz6nioYpftN9CEyKn8+Pry/
        HT+ClW1ZlxZVcGJJV5VLT8M=
X-Google-Smtp-Source: AAOMgpfTahQvpQC/beFIlgCW3Z12TqY4Fe8QzuTkETsRf9Iqu9SpqnbKnBOa4pWUa6xTeS63NwCtIw==
X-Received: by 2002:a1c:6d9a:: with SMTP id b26-v6mr12059345wmi.74.1531164782422;
        Mon, 09 Jul 2018 12:33:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 38-v6sm7401122wrm.15.2018.07.09.12.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 12:33:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
References: <cover.1530905323.git.jonathantanmy@google.com>
Date:   Mon, 09 Jul 2018 12:33:01 -0700
In-Reply-To: <cover.1530905323.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 6 Jul 2018 12:34:08 -0700")
Message-ID: <xmqqy3ekcihe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning a repository with a tagged blob (like the Git repository)
> with --filter=blob:none, the following message appears:
>
>         error: missing object referenced by 'refs/tags/junio-gpg-pub'
>
> and the resulting repository also fails fsck.
>
> Patch 1 fixes the protocol documentation and the server side of Git, and
> patch 2 makes clone error out when such a situation occurs.
>
> An argument could be made that we should not merge patch 2 just yet due
> to the fact that some server implementations (such as Git and JGit)
> still exhibit the old behavior, and the resulting clones (albeit failing
> fsck) are still usable, because when attempting to load the blob, Git
> will automatically fetch it. I'm on the fence about this, and have
> included patch 2 in this patch set nevertheless for completeness.

I think the latter is probably a good thing to nudge the server
implementations in the right direction by gently poking them ;-)

The patches textually apply cleanly on 'master' but apparently it
needs some fixes in jt/partial-clone-fsck-connectivity topic to
function correctly?

