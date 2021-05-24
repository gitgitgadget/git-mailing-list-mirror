Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DA8C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE80661414
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhEXTZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhEXTZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 15:25:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C47C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 12:23:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z3so28030971oib.5
        for <git@vger.kernel.org>; Mon, 24 May 2021 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aF8loM1HIag6L+cev2sS+sjNWjXWWakAB6SQF7XTico=;
        b=ofF0mMsdr0k5+klrj3ZkrE6cq/iA380j0oD0AGTjqEEZw8bh0T3TB5kK+yCpBjNNHR
         1Lve2kNRmtLg0CAtkHHZFzupFCsgU/9KzHj5Bu72JXGF7PfFTfDUd6VtUbLPVnKQ8ZQH
         H50EkTbMUQwOiiO99rUf+xD53kJ21bS6TincJIUhsYPHk+OCnf5MZkKjitc6Hr8XPoxp
         bulnEjkSf8shAIlJOeq5hEKttVRSVtpy+BQJrzpeoCJDkMcKS16FsfyTUjNW1xU/+PMF
         rH/gCrHUGjGk1Bzd4IIbk2/czX/Lur9JWZ7W28ekbflPy6YAdNwr8xZ5KfxcC71o2hUJ
         NCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aF8loM1HIag6L+cev2sS+sjNWjXWWakAB6SQF7XTico=;
        b=slxI9GsVnf5fYWYpcd4QePcWal5Pvszwdm9k80ODKZh5cxVH0Cxokw8W/B6hNSuttm
         jisKlHObMgiGxkzBOY/2sz+ZEnUPxWx4FWLX3SfqRuoit4hfftcujD0h+AyfdmLyuopm
         TqJdr4QO1XVWV8p6Bb/0pU8VAc87m1Ep+R/QUun90XpG87wvpr1p3eo4qLe3c9n3vOGn
         Jd/UZcdzgf3BjVnPLwtHKrOfIhyKryfICHfHzpQA1ylf4tevAez6fCG24lF+sOAgCMWM
         MFCuHqGMsxNmxa1oNGfBw6G6GkcvMN0CG7D6X9aP0kAdm5F/RSYRwU/DEpsXwYdalKjb
         Q3gA==
X-Gm-Message-State: AOAM530a0mdrbLBlTx7mBCmiUhg9EW4cluZrXWy4ETK4cNj/wyUqq5xr
        1JwbZXgTKY+7ECCGq7vkn3c=
X-Google-Smtp-Source: ABdhPJwTCJ0/rZziPmVGFRdYqaa7Dcq/S2ZBcP8oqrPXp2I/RAnid5ffd+NAnSigNtAuakXZN8regg==
X-Received: by 2002:aca:4d01:: with SMTP id a1mr11756615oib.158.1621884232491;
        Mon, 24 May 2021 12:23:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e21sm2853987oie.32.2021.05.24.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:23:52 -0700 (PDT)
Date:   Mon, 24 May 2021 14:23:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <60abfd46a8ca3_1b20920823@natae.notmuch>
In-Reply-To: <xmqq1r9wj9im.fsf@gitster.g>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
 <xmqq1r9wj9im.fsf@gitster.g>
Subject: Re: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > This patch series gets rid of old unnecessary workarounds and convoluted solutions.
> >
> > Additionally it cleanups the asciidoctor-specific code so it ends up much more simpler.
> >
> > This goes on top of my other cleanup patches [1].
> >
> > Since v2 there's only one small fix that introduced an extra space after linkgit.
> 
> Since v1, I presume?

Yes.

> It seems that the previous round did not interest anybody (or am I
> looking at the archive incorrectly???)

None the cared to reply, correct.

> In any case, after applying the 5-patch series on 2.32-rc1, an
> attempt ot apply these 12 patches seems to fail at the very first
> step.
> 
>     $ git am -s ./+fc12-doc-build-cleanup-more
>     error: removal patch leaves file contents
>     error: Documentation/manpage-quote-apos.xsl: patch does not apply
>     hint: Use 'git am --show-current-patch=diff' to see the failed patch
>     Applying: doc: remove GNU troff workaround
>     Patch failed at 0001 doc: remove GNU troff workaround

Apparently my scripts call `git format-patch` with -D, which doesn't
generate appliable patches when files are deleted.

If you remove the files manually the series applies cleanly.

Do you want me to send it again without -D?

Cheers.

-- 
Felipe Contreras
