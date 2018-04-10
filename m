Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673871F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeDJWSB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:18:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52389 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeDJWSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:18:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id g8so296119wmd.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kGmfoKz8P3JzOtJ+uHgQnTL5Xyhqt4zWcZnxseqpsqQ=;
        b=avBzKyBbwLct4nP7Kq7RUrVoKUf1j4mC51igdNv6D1mQw1n6tDOejfu+3IyIhh6RhU
         ttgvvQCeg4t7vTqjrC0Uxu2euM6c/LSjWgj9Nip61CRNWSvP8+/04if/FgVRIQpET4YF
         BxcCf99QuYA66WTAFyEjtqJjgnDjUchcTVc6nkEWL2JJBuCwX4goxxRimNPhSaMBWhXn
         TvxFiP6BlUPpkyelyhNX+eOxkJ5qZbs5DRqeYKiKmMesrlUFjj4LBWHO4/OHC2H9Hbps
         HiGixfDsdjgCoXl1yj48H+yQEKupwQ0mAgHurkxPcKMGOMFKeUYCiq8nDA6utwnpNoC7
         VfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kGmfoKz8P3JzOtJ+uHgQnTL5Xyhqt4zWcZnxseqpsqQ=;
        b=FuMeiX65GXWq0fu6+oSjFcZJmbhk5zb/tqNz007wQya6fBRycKjjZe7NOiD0i01BcY
         2IznezHSW/g/b1V/7UK2p41+Ukg5Rfcc5C89y/5Hd+Fs+Imi/NKMe480aOWctuTv++NJ
         uCM6Uvkpm7GN8c0KTS/mz8W3ShQnyg0FhBdwtgOWP8akJAoMSkrX1pUAOp3ZqgRFxepK
         5wlBq49lgcTsp1ViAkbysjI5zd/gxL/shMDUNJIsXcDSPcf1fKhalnhs/eDZIvCHcbmx
         FqG4oKuIS9ADZv7C8hNavpyWN/igiNSCoF97DnrPGkjpU5H7vFkpLrTFJHyMbhOMuAIX
         TmYA==
X-Gm-Message-State: ALQs6tC7pxC+z306w0P9vsx11kPCmn89jO0EiuhMPt6RABRlN2kyi9II
        LCPqfGEQKWle9+f9wk8Gfjo=
X-Google-Smtp-Source: AIpwx4/jE1Us+euKYKG9ckfKJ7ERmLMxT4JJRYxiKddeNLtSdcHfAt4DLtTZjYu7zgBGZe/KnQWc/g==
X-Received: by 10.28.85.137 with SMTP id j131mr851432wmb.94.1523398678850;
        Tue, 10 Apr 2018 15:17:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l73sm6089237wma.10.2018.04.10.15.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 15:17:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-7-mastahyeti@gmail.com>
        <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com>
        <CAE=pOyFj+WZBB6Zp35d=mYNsxcJK-LwOxseWXSmY_hs+Lwugpg@mail.gmail.com>
        <xmqqbmeq3h8o.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Apr 2018 07:17:57 +0900
In-Reply-To: <xmqqbmeq3h8o.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 11 Apr 2018 06:04:55 +0900")
Message-ID: <xmqqh8oi1zai.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> That test was fixed a week ago:
>> https://github.com/git/git/commit/a99d903f21d102a5768f19157085a9733aeb68dd
>
> Well, you cannot expect any reviewer to know about a change that has
> never been sent to the list and has never been part of even 'pu'
> branch, no matter how old such a private "fix" is.  
>
> What other unpublished things that are not even on 'pu' do these
> patches depend on?

Answering my own question after digging a bit more, now I know that
a99d903 comes from the 'private' branch in peff/git/ repository
hosted at GitHub [*1*].  The branch builds on 'next' by merging many
private branches, and 'jk/non-pgp-signatures' branch has that commit.

    peff.git/private$ git log --oneline --boundary 0c8726318..7a526834e^2
    c9ce7c5b7 gpg-interface: handle multiple signing tools
    914951682 gpg-interface: handle bool user.signingkey
    1f2ea84b3 gpg-interface: return signature type from parse_signature()
    6d2ce6547 gpg-interface: prepare for parsing arbitrary PEM blocks
    fb1d173db gpg-interface: find the last gpg signature line
    6bc4e7e17 gpg-interface: extract gpg line matching helper
    4f883ac49 gpg-interface: fix const-correctness of "eol" pointer
    ae6529fdb gpg-interface: use size_t for signature buffer size
    1bca4296b gpg-interface: modernize function declarations
    a99d903f2 t7004: fix mistaken tag name
    - 468165c1d Git 2.17

It seems to me that Peff did the t7004 change as the earliest
preliminary step of the series, but it caused confusion when it was
not sent as part of the series by mistake.  Judging from the shape
of the topic, I do not think this topic has any other hidden
dependencies as it builds directly on top of v2.17.0.

For those who are reading and reviewing from the sideline, I've
attached that missing 0.9/8 patch at the end of this message.

[Footnote]

*1* I do not know if it deserves to be called a bug, but it
    certainly is an anomaly GitHub exhibits that a99d903f can be
    viewed at https://github.com/git/git/commit/a99d903f..., as if
    it is part of the official git/git history, when it only exists
    in a fork of that repository.  I can understand why it happens
    but it certainly is unexpected.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 3 Apr 2018 17:10:30 -0400
Subject: [PATCH 0.9/8] t7004: fix mistaken tag name

We have a series of tests which create signed tags with
various properties, but one test accidentally verifies a tag
from much earlier in the series.
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2aac77af7..ee093b393 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1056,7 +1056,7 @@ test_expect_success GPG \
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git tag -v signed-tag
+	git tag -v blanknonlfile-signed-tag
 '
 
 # messages with commented lines for signed tags:
-- 
2.17.0-140-g0b0cc9f867

