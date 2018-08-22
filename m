Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135E71F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeHWAdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 20:33:46 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51499 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeHWAdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 20:33:46 -0400
Received: by mail-wm0-f42.google.com with SMTP id y2-v6so3222778wma.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xgtfSYg02wbEDPOKXn62W1+4T4q6GFbU9+1HEDf+HFA=;
        b=E7pPbpBrXTpQuGyRABS+EnDnJGhokrC8dxbsDv+Bg0YrkHIMa6D0p1nrkTZHLbbYr7
         2dJhIHdt0a49INjGKlSvLe+7Mn6dofAcypxHrfzmX7iWHHXUUwwPFgWAsmUSlMR2b5Cj
         b7PQs3DXHK4ulPompC0SNeE4IwXy/kBBuQUO8ovMTFZiTV4Un4mUsu0cJbmGRjEO/Yai
         yTPr7gewu4umrXLexHHn1ks6/CGnek2aKP3FlH+zUgpLsV0g4TeFe4ZYkEEu50Ij4kfV
         ruewaQxjIUmuIFfIdu1pNr/PAZjSbqWObM+AZVBLyc2bbHdfuVv5YM2Y42WaZ88CP8zj
         ICpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xgtfSYg02wbEDPOKXn62W1+4T4q6GFbU9+1HEDf+HFA=;
        b=TIolIKfVYPhBzXUVWJNXMsNqlR6hEEiNn2t9ihfFsAFhm2so7oioCntxKszta0gUyC
         JqcZsg+PukXLKAAkz2hxccjbTHfPHMZsrDobAOSemH6KbKAOMRQR7nHYEFAI6ZE5V3TD
         q0tkarPJb2uFUBTUIcHxCtLExwcWJbnnWtvy1BGAGxMiM4lrKcYijeEepVKRrB+sGNkQ
         EYw89VujbMJwk80s3Kp64UBzGwN5jlP5Tql6kqenk5SV0Vsd76a24pPetmXK1nNX1ytg
         fftMRVe9bDE5SjixxVWVw1+n0dkIcJasTDtX59jFw5H0lLiyptZAI8tjWn0vBkv8zf4I
         NC/A==
X-Gm-Message-State: APzg51CQynck77usj1zSVTkdPYPbJN8WG5SvZI231UGFhZd5xCMLUngK
        cXFqtxbvoqG8LUTU8iV4qd8=
X-Google-Smtp-Source: ANB0VdbI6xkzrYLqy7ds4/fAki95jduTIXKDOaKxmrsi/wuZM7bFOmPVO+l0teqtVo3K0zsjXhKiqA==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr3139318wma.43.1534972034159;
        Wed, 22 Aug 2018 14:07:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j133-v6sm4529059wmd.12.2018.08.22.14.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 14:07:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
References: <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180805172037.12530-1-t.gummerer@gmail.com>
        <20180805172037.12530-11-t.gummerer@gmail.com>
        <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
        <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
        <20180822203451.GG13316@hank.intra.tgummerer.com>
Date:   Wed, 22 Aug 2018 14:07:12 -0700
In-Reply-To: <20180822203451.GG13316@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 22 Aug 2018 21:34:51 +0100")
Message-ID: <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Hmm, it does describe what happens in the code, which is what this
> patch implements.  Maybe we should rephrase the title here?
>
> Or are you suggesting dropping this patch (and the next one)
> completely, as we don't want to try and handle the case where this
> kind of garbage is thrown at 'rerere'?

I consider these two patches as merely attempting to punt a bit
better.  Once users start committing conflict-marker-looking lines
in the contents, and getting them involved in actual conflicts, I do
not think any approach (including what the original rerere uses
before this patch) that assumes the markers will neatly form set of
blocks of text enclosed in << == >> will reliably step around such
broken contents.  E.g. it is entirely conceivable both branches have
the <<< beginning of conflict marker plus contents from the HEAD
before they recorded the marker that are identical, that diverge as
you scan the text down and get closer to ===, something like:

        side A                  side B
        --------------------    --------------------

        shared                  shared
        <<<<<<<                 <<<<<<<
        version before          version before
        these guys merged       these guys merged
        their ancestor          their ancestor
        versions                versions.
        but some                now some
        lines are different     lines are different
        =======                 ========
        and other               totally different
        contents                contents
        ...                     ...

And a merge of these may make <<< part shared (i.e. outside the
conflicted region) while lines near and below ==== part of conflict,
which would give us something like

        merge of side A & B
        -------------------

        shared                  
        <<<<<<<                 (this is part of contents)
        version before          
        these guys merged       
        their ancestor          
        <<<<<<< HEAD            (conflict marker)
        versions
        but some
        lines are different
        =======                 (this is part of contents)
        and other
        contents
        ...
        =======                 (conflict marker)
        versions.
        now some
        lines are different
        =======                 (this is part of contents)
        totally different
        contents
        ...
        >>>>>>> theirs          (conflict marker)

Depending on the shape of the original conflict that was committed,
we may have two versions of <<<, together with the real conflict
marker, but shared closing >>> marker.  With contents like that,
there is no way for us to split these lines into two groups at a
line '=====' (which one?) and swap to come up with the normalized
shape.

The original rerere algorithm would punt when such an unmatched
markers are found, and deals with "nested conflict" situation by
avoiding to create such a thing altogether.  I am sure your two
patches may make the code punt less, but I suspect that is not a
foolproof "solution" but more of a workaround, as I do not think it
is solvable, once you allow users to commit conflict-marker looking
strings in contents.  As the heuristics used in such a workaround
are very likely to change, and something the end-users should not
even rely on, I'd rather not document and promise the exact
behaviour---perhaps we should stress "don't do that" even stronger
instead.
