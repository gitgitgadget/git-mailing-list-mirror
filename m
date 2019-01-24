Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8B41F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfAXUSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:18:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45131 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfAXUSo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:18:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so7872153wrr.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bpN1KFGQJUre+tKnyAWTnA3Ep583EfRIY3XpNyqOoYY=;
        b=hv6urvMjzizyGUUgj8GocIR6AXaAIl5o+XFe+wszibdfW7ytbDROrxw9MUH/QdpYwc
         cLb58zXbjw8L8syjNhbhiHHgs9z2eomXF3DDPNA5dNYkNbCb0d/TLqMBqHgEUNW7IS4I
         2gQny2j/BFnyCHd+kRgXrk10pMv4EUzy6PhrywdZ+0hRvpeP91RYJ8FClsMvEUG42GoS
         UPkifrurz7u0tzSRWDokMAFe7nYjvxspN6XRX9zZqp9YkSTzw95rqTs9c3QpXhqG/AN9
         kJDeL5GcJUt2+7BKysokv9enlknYHT9Rc3msqGmeqnPS86Tv4pnugfdoITtaFeY6QnRY
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bpN1KFGQJUre+tKnyAWTnA3Ep583EfRIY3XpNyqOoYY=;
        b=SL+k0zwAKpX6r8Py8ibrwKfNBApdSYOhm02H3cBhe8Oa/v/i8QbmHtTfH4ujTf6WTO
         YbN7KqGtHom3mSL/PlY6XohvnPu0lAJS8ZTck3arQxo2SCpWi9Rd8qDFhP/dYCwvirDu
         RwIBSdOoRKclGsQSb6V3pw2tyHEhZbhYcbOnPihT8XgR3TtPBkPDYYSvK0s1gvPfxcid
         1yKApV7yNajslI6ikeUcZoMMNK7EHlVhLpN98jiNVWL+kQRLiF+I9ZMcRErQZd6q4Iup
         doxl921SHKjXDdEgOLy6oxYYH3QdmNOp6k7CTfQg5bAtFYHutjvsXS9gDEK7UxUHIW5j
         I84g==
X-Gm-Message-State: AJcUukdagNVQVgoNx8mSQxuCw3sMn6AZpuHwJAeJfHk1XTsaxBeMtrEs
        X5ZrS58e7WNaB1fJWtJ09DY=
X-Google-Smtp-Source: ALg8bN4Etd2SnykDXhVBiCeHRUJUXAeeuyzvY+mwYaGLUQTmh0s0EVa2ts8UO7AiOWEO4v9KM12xgQ==
X-Received: by 2002:adf:9591:: with SMTP id p17mr8951863wrp.224.1548361122161;
        Thu, 24 Jan 2019 12:18:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c202sm62929579wmd.40.2019.01.24.12.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:18:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
References: <20190124122603.GA10415@sigill.intra.peff.net>
        <20190124123240.GB11354@sigill.intra.peff.net>
Date:   Thu, 24 Jan 2019 12:18:41 -0800
In-Reply-To: <20190124123240.GB11354@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 07:32:41 -0500")
Message-ID: <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we run "git log --cc --stat -p --color-moved" starting at D, we get
> this sequence of events:
>
>   1. The diff for D is using -p, so diff_flush() calls into
>      diff_flush_patch_all_file_pairs(). There we see that o->color_moved
>      is in effect, so we point o->emitted_symbols to a static local
>      struct, causing diff_flush_patch() to queue the symbols instead of
>      actually writing them out.
>
>      We then do our move detection, emit the symbols, and clear the
>      struct. But we leave o->emitted_symbols pointing to our struct.

Wow, that was nasty.  

I did not like the complexity of that "emitted symbols" conversion
we had to do recently and never trusted the code.  There still is
something funny in diff_flush_patch_all_file_pairs() even after this
patch, though.

 - We first check o->color_moved and unconditionally point
   o->emitted_symbols to &esm.

 - In an if() block we enter when o->emitted_symbols is set, there
   is a check to see if o->color_moved is set.  This makes sense
   only if we are trying to be prepared to handle a case where we
   are not the one that assigned a non-NULL to o->emitted_symbols
   due to o->color_moved.  So it certainly is possible that
   o->emitted_symbols is set before we enter this function.

 - But then, it means that o->emitted_symbols we may have had
   non-NULL when the function is called may be overwritten if
   o->color_moved is set.

The above observation does not necessarily indicate any bug; it just
shows that the code structure is messier than necessary.

> To fix it, we can simply restore o->emitted_symbols to NULL after
> flushing it, so that it does not affect anything outside of
> diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
> nobody outside of that function is going to bother flushing it, so we
> would not want them to write to it either.

Perhaps.  I see word-diff codepath gives an allocated buffer to
o->emitted_symbols, so assigning NULL without freeing would mean a
leak, but I guess this helper function is not designed to be called
