Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D8C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355923AbiBCXGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347868AbiBCXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:06:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F5C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:06:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso4438912pjm.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tUnYy86Y2qj2stQ3Z+tZiYyfeW2zX8aMPQdkYjqUH6A=;
        b=MCfXlla5F9XCDkurWJ9tQN9XRuszCo+/H0X6FEZ/MtkcRzuCk374Rv6U/VBKn+NG1o
         KDrH/tDRR10Bn8yFFrcM7QYLZ5l4bzWYqJbVJk0EpRyzHffxtwHMoNdwxDh2SUjgASHp
         O2lifstlsivKMuyRk+3ef7jyubSuKc0954ObUo1UTGdplyizo1l5/oWOPDr1BuvJnrPM
         6ZcvrTdg33s1TDfD8+zJCFp/bGTQSp29YpEpn0LdgIZDRSJOp91CKFI2swR3kmotFbgF
         JeXam+cQ8DvlSnoXfSW/uo/ewTa5+FE/TCeyihh1mCxtdUyZmppa2yssLH2heAnSxJDP
         u1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tUnYy86Y2qj2stQ3Z+tZiYyfeW2zX8aMPQdkYjqUH6A=;
        b=Q5MnckSjTdyaE0rV9b7mQXLlHYpYPXcHlREvMk688uZsX90GXAsoAYfO+lp2YSfz96
         vqB0YS4OXOpj+on9JKgQ3fTAsRuLVXa2n4vNMLRF7+rDmDtAUgD+f18bxLxzMKLonWPj
         xcZ8hSAScIlu7OiMCU3VT6y6zyzcE9YrtPC4cmQifbcSYcUFRUjyHjJ/aYkVQjTtE0qR
         mJsl5+wqm0zksLtboEs7DK0EbuWXhUSD4C61RJ1Mrug0QK4f7uwlbMylD0Fj8Mzz9cDm
         j74LM8z/1p11zD2obll9X55q5q2YN2tHzAxz0ZEUnoElpUy9n2ECg5+ULpNqxxYTyiH3
         BuDQ==
X-Gm-Message-State: AOAM532fLbCGuFwZla2uCAft/q+qkK9463gu8jC6d0sSCZ6a2PF5aOxt
        SKxITUoajh8gLajg8IwZdxY=
X-Google-Smtp-Source: ABdhPJyPxf5l1PQbutU0AIbLC23BpOpfgSmjBJqE4QAfGcHUX7ldNWxdq3DwXcmRYYg2q6GBhNsv6w==
X-Received: by 2002:a17:902:c406:: with SMTP id k6mr355687plk.96.1643929607491;
        Thu, 03 Feb 2022 15:06:47 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id ga21sm4014572pjb.2.2022.02.03.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 15:06:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        <xmqqa6facn9i.fsf@gitster.g>
        <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
        <xmqqsft2b5jl.fsf@gitster.g>
        <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
Date:   Thu, 03 Feb 2022 15:06:46 -0800
In-Reply-To: <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 3 Feb 2022 17:02:47 +0100")
Message-ID: <xmqq4k5fr1mh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Technically, the only obstacle I see is that we'd need to treat an
> existence entry especially for the purpose of compaction/gc: we can
> discard older entries, but we shouldn't discard the existence bit, no
> matter how old it is.

I was hoping that we already have a type of block that can be used
to record an attribute on the ref (other than its value) and it
would be just the matter of stealing one unused bit from such a
record per ref to say "when answering 'does this ref have reflog?'
say yes even when there is no log record for that refname".  Or the
table format is extensible enough that we can add such a block
without breaking existing clients.

If we have to implement the "this ref has (enabled) reflog, even
though there may not be any log record for it right now" bit as a
fake log record, then yes, we'd have to teach the log iterator to
skip such an entry and we'd have to teach the expiry logic that they
are not to be expired.  It certainly is a sad design than being able
to express the bit in a more direct way (like file backend does,
which is "presence of the reflog file gives the precense of the log,
contents of the reflog file are the actual logs).

