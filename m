Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A491F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936623AbeF2Vwd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:52:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42664 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeF2Vwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:52:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so10092965wrs.9
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jLEx4+hpUq7NsrxVUoIX4o/h2G6mdpM3rqVBk/MZL/I=;
        b=dJXZfzspKB+Pn0T2RK/Wy3Tau7lcpDkro9mJN64CIs8Lm8OQf17brRc2uS2lPVrT3i
         GXGZbRzgIL0wOP2n2vRjOGVep3XJhpSvm5GB0a10QdpkzjE+WhUiPVPFLD6PFSSG8yNS
         XJIQIRIu1hPFq4kwpvRQcbeQ2y+DhD26in/+vj5FEhrWBXAbP/Gub8eLXuoajboFPMEF
         qPXWxe/ZAKHOKXF0yeDad1MFYLBQ48NvElbXGJkMOxgE27qLNdUDOE77X9QO+95DGOPf
         3nls03Tqlo9eACnz4H3uY1P6KZ24aEWMrVnHvdDsIYCAxQHx1+DvFN796oUbEilumuhq
         Ef+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jLEx4+hpUq7NsrxVUoIX4o/h2G6mdpM3rqVBk/MZL/I=;
        b=mniFSxlYIc1RHmWtMrn03j3YkMEZp0sPzWCtFdmmX+tGZpliLOucnuI+s9OJKonX3J
         0GZk9vw6I9wkwvHXsLYkEwq0h8CFtAOzG9h0AUtdQN+BVFLf25jfOqfsUYn6N/mVvCa6
         vvW+J+xbNY/4IoRTleinNFYjdSyOp4i2DaUA9stLYCYEo2lQENLlp3yKDhf5dSKJ8gM3
         ivalwmmGT4XOLOJBqPM5Gy0DfCxhVVWeV/H98j8lo+LulZPi4XpNSHAgw0YV4Z5rKUuQ
         TUvE5iWxiugKTceQ4GOsNI/aY03iWmo9FbCEmDRkKeZbQ7mzmn8oHRnyQFEzjiMwNKu2
         S0/A==
X-Gm-Message-State: APt69E3ShVKQQJ70PRCyIcWRrnqPWtkr+m34BFYoigc4UOeuzOpJcAHj
        fcdT9OTUXan0aG42CmUOhoE=
X-Google-Smtp-Source: AAOMgperX5ZyeS4jltvXzFzE4cE3v3Yb2gzMWBiGgWBrwoJyJYAQXEv4q9ZKqMkMWzRk7N1Vb2ElUw==
X-Received: by 2002:adf:abf7:: with SMTP id s110-v6mr14066321wrc.101.1530309150754;
        Fri, 29 Jun 2018 14:52:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y18-v6sm12869778wrn.68.2018.06.29.14.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 14:52:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>
Subject: Re: [RFC PATCH 01/13] commit-reach: move walk methods from commit.c
References: <20180629161223.229661-1-dstolee@microsoft.com>
        <20180629161223.229661-2-dstolee@microsoft.com>
Date:   Fri, 29 Jun 2018 14:52:29 -0700
In-Reply-To: <20180629161223.229661-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 29 Jun 2018 16:12:37 +0000")
Message-ID: <xmqqbmbttg4i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile       |   1 +
>  commit-reach.c | 359 +++++++++++++++++++++++++++++++++++++++++++++++++
>  commit-reach.h |  41 ++++++
>  commit.c       | 358 ------------------------------------------------
>  4 files changed, 401 insertions(+), 358 deletions(-)
>  create mode 100644 commit-reach.c

"blame -bs -C HEAD^.." tells us that all lines except for the
initial #include of this file came from commit.c verbatim, which is
good for a "move lines" patch like this one.

>  create mode 100644 commit-reach.h

"blame -bs -C -C HEAD^.." tells us, but "blame -bs -C HEAD^.." does
not tell us, that most of the lines are from commit.h, which is a
very bad sign.  reduce_heads(), for example, have two duplicated
decl and depending on which header file is included, the source
files will risk getting inconsistent definition once the headers
start to deviate from each other.

