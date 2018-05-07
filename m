Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A0C200B9
	for <e@80x24.org>; Mon,  7 May 2018 04:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeEGEIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 00:08:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40831 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeEGEIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 00:08:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so27042760wrc.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XMPo8SdKD0hpLPjylCjpm7mMz18CcPTKk9ypHjXsQKc=;
        b=dRPe1CGkfIiajKM6bwHPFbHEYy6gd4wxGSxO46BMdDOeAAcMstWk1wOCBtbmAsV27R
         UNWp/4pKlah9KP2W34O4RalL/DB3yui/wxDM6sg3um3NPzDaRRkQ3wuyWCWjwQLb7kTu
         9ezSl2TJhGosls3xjo/2n0wmkDvUf31XD7l7mQwirLULVKN7ujxQtKl3m8yOiUI7SOLA
         vBFfQj5e/5qSuaSxEAgZyx+uwrkMItsBkJQ5MN9stzPqZZrGD4ZZEsLDvKYwEE4CgsEp
         n1IhlRjC27t2V4O/0T7CypHfAZ1vHjhBQi6WNtXnmkqry0verxDRYsupzst8yf4z7/YN
         eN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XMPo8SdKD0hpLPjylCjpm7mMz18CcPTKk9ypHjXsQKc=;
        b=Vz9wefLfs/O4LJXDydKt+aZEdWS3hJ0/KtJx0FGvQtUl5nqYjTiS5LU9ynPsuSQiFT
         Sn6AV3PILG8qc4FFrHuT9VBgjgXaoihUAaWC4jCTo5P8GerlBlzLSueZKjD9mAwxlFe0
         HThtG2yKKtmrQdgTGBTivlkD/Gi9b15LbdMuySiQcW6Pocz+1qQBQS21qrXU/Or2Cok+
         cexHwTWJcoeSpinUd3VTxY8aICmGvWT0gadQGyYHY2876a/1aMBS3Riz7lk2goI7sL7s
         dfK6jPL/HFI9vEwmhBxC04OOnfLkiVZ8tSNsKUmjadZfrfu2IAyBWzxsxoLZyycz3wiF
         sLvw==
X-Gm-Message-State: ALQs6tDb0aLh4G00VFiga+YLPCbo497sskOG7TQAvd7sdwLCLtpkiH1n
        CCoPz5EPzbEIHo5GQUXd3PQ=
X-Google-Smtp-Source: AB8JxZr9qNxtVFLL4LRzXtBf4+YzXpnyaqrIYwIycmF3/uF+yEAi9MCXDhAcBFSrXVweUVz8ngt2+g==
X-Received: by 2002:adf:a194:: with SMTP id u20-v6mr24619092wru.262.1525666128290;
        Sun, 06 May 2018 21:08:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b85sm7251660wme.46.2018.05.06.21.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 21:08:46 -0700 (PDT)
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
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
        <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
        <87lgczyfq6.fsf@evledraar.gmail.com>
Date:   Mon, 07 May 2018 13:08:46 +0900
In-Reply-To: <87lgczyfq6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 04 May 2018 10:42:09 +0200")
Message-ID: <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Right, and I'm with you so far, this makes sense to me for all existing
> uses of the peel syntax, otherwise v2.17.0^{tree} wouldn't be the same
> as rev-parse v2.17.0^{tree}^{tree}...

More importantly, you could spell v2.17.0 part of the above with a
short hexadecimal string.  And that string should be naming some
tree-ish, the most important thing being that it is *NOT* required
to be a tree (and practically, it is likely that the user has a
tree-ish that is *NOT* a tree).

I guess I have a reaction to the title

    "get_short_oid/peel_onion: ^{tree} should be tree"

"X^{tree}" should *RESULT* in a tree, but it should *REQUIRE* X to
be a tree-ish.  It is unclear "should be tree" is about the former
and I read (perhaps mis-read) it as saying "it should require X to
be a tree"---that statement is utterly incorrect as we agreed above.

> case-by-case[1]:
>
>     ^{tag}:
>     7452b4b5786778d5d87f5c90a94fab8936502e20

I take it as "git rev-parse 7452^{tag}" output (similarly ^{$type}
for the rest)?  That probably is desirable, as blobs, trees and
commits cannot be peeled down to a tag.

>     ^{commit}:
>     hint:   74521eee4c commit 2007-12-01 - git-gui: install-sh from automake does not like -m755
>     hint:   745224e04a commit 2014-06-18 - refs.c: SSE2 optimizations for check_refname_component

If 7452 points at a commit, that tag itself should also be given as
a possible object the user may have meant in the "hint" thing.  I
agree it is a good idea to exclude trees and blobs from the hint,
for the same reason why I think it makes sense to exclude blobs,
trees and commits from hints for a X in "X^{tag}" above.

>     ^{tree}:
>     hint:   7452336aa3 tree
>     hint:   74524f384d tree
>     hint:   7452813bcd tree
>     hint:   7452b1a701 tree
>     hint:   7452b73c42 tree
>     hint:   7452ca1557 tree

Again, if there is a commit or a tag (that points at a commit or a
tree) whose name begins with 7452, it should be included in the hint
above.  Not having blobs in the hint of course makes sense, as a
blob cannot be X in "X^{tree}".

> And[2]:
>
>     core.disambiguate=tag:
>     [same as ^{tag]
>     core.disambiguate=commit:
>     [same as ^{commit}]

When core.disambiguate tells us to "interprete hexadecimal literals
to name commit objects only", giving only commits in hints: section
makes sense, because we are explicitly saying that "when I say 7452,
I do not mean any tag whose name begins with 7452", so "sorry, your
request is not explicit enough---there are two commits and a tag
that begin with that prefix" is not helpful---it should stop at "you
may have meant one of these two commits" and not mention any tag.
