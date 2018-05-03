Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34873200B9
	for <e@80x24.org>; Thu,  3 May 2018 05:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeECF2Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 01:28:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43885 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeECF2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 01:28:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so16144864wrm.10
        for <git@vger.kernel.org>; Wed, 02 May 2018 22:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EhqccVhbAOTfx23D7/nHeRbxM18xFqBIPN+Z6pjHakk=;
        b=OII7R0qLqbyT81mn8S+nVa6W7NdMIjTjijx+MBBm2nONapRBhwlOaFZ2x53oFE8rsJ
         yfwkzhdAHRbO/vOG4aYM4LGzKtCioqaMYJYyt+ndoOGVla37dWrAWBytJjwIdnTXqxFg
         OnICr2eJS58XwFxgD2bbr9qTS7UgDCo2M8Hk7TKtPJuhZjZtxudzEx0dirmFgOtXnzaZ
         96qp4DtTdVz/RFFz0BaKy82R3xwGULd2JBmB0Tm5oA98/mzcKblp6gO7NwfNlpYdBvJu
         qXOmg+mTKRBcEyTywPrnM0BlQCRKm/HemDODIcgMX7k+9BSor2ZfAJBfBL85sFAA+cAj
         cRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EhqccVhbAOTfx23D7/nHeRbxM18xFqBIPN+Z6pjHakk=;
        b=IgTWg1ChxZGJ8USMSR1+yh9KJAawN3WHn5nQ0HuQZX4prihEe6p3Al5YWrvL/avYGw
         dRhqGukU92ZoVdcQCbGjKIsXZumbow2ARALOWyH9rQdAvBk2G7JYr+/5Y0xREO5qBoKD
         iLyc2bZaBhzU8SXHlnyRTluHuGmMgBIhcnQwYp19oMu8Xjz9gDbzCELmCQRUZrRuhgAn
         HDmuVC940c4fprG94zjB/TwEY3BNIhSDF+w2pAqtuhiRb/FMkIrLC57x9pGvDLxgoHT8
         0djkPhRFBPgfB+FezpcHN/bjf3Qfim0Gg+6KRN+7GA6UpXfP11QopX8BYhq9ld2odiSh
         /ZbQ==
X-Gm-Message-State: ALQs6tDkjC75lKb9enpT1Xui/8ZAiBaiSZL4+2TlyZOalvIVr7jneuM7
        fthNenBKAI5dzqKnl4VOPcgjN2LZ
X-Google-Smtp-Source: AB8JxZrVx2LjUUHyBbKhBx4bUZjfUZUtJ54oUDAkZzQEy3N5F4DpPNbza8IxVsxMHC3xEmEYTQP3Dg==
X-Received: by 2002:adf:bd03:: with SMTP id j3-v6mr18613517wrh.138.1525325293776;
        Wed, 02 May 2018 22:28:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h81sm16959638wmd.0.2018.05.02.22.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 22:28:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
Date:   Thu, 03 May 2018 14:28:12 +0900
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 1 May 2018 18:40:13 +0000")
Message-ID: <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> But ^{tree} shows just the trees, but would previously be equivalent
> to the above:
>
>     $ git rev-parse e8f2^{tree}
>     error: short SHA1 e8f2 is ambiguous
>     hint: The candidates are:
>     hint:   e8f2093055 tree
>     hint:   e8f25a3a50 tree
>     hint:   e8f28d537c tree
>     hint:   e8f2cf6ec0 tree
>     [...]

When a user says "git $cmd e8f2^{tree}", the user is telling Git
that s/he knows e8f2 *is* a tree-ish, but for whatever reason $cmd
wants a tree and does not accept an arbitrary tree-ish---that is the
whole piont of appending ^{tree} as a suffix.  A useful hint in such
a case would be "oh, you said e8f2 is a tree-ish, but there are more
than one tree-ish, so let me show them to you to help you decide
which one among them is the one you meant".  When $cmd is rev-parse,
I would even say that the user is saying "I know e8f2 is a tree-ish,
and I know it not a tree--it merely is a tree-ish.  I want the tree
that e8f2 thing points at".

Limiting that hint to show only real trees does not make any sense
to me.  I do not think we care _too_ deeply, because most of the
time, command line location that expects a tree-ish can be given a
tree-ish, so there is not much reason to use ^{tree} suffix these
days.  But in a case where it _does_ matter, I think this change
makes the "hint" almost useless.

Or am I misleading what you wanted to achieve with this patch?
