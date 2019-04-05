Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB98320248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfDESmf (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:42:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50455 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfDESme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:42:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so7796128wmi.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xfyjImC35WfwYVh8IMsnExnsNZ03alZmJASch5QZ600=;
        b=svCqxhosFVnfhE7d1BE55XYKQlLexSBK5muA39hcWQPKECiRgBhKW2nFP5TWlMwge1
         8DvsCoQuVNATW4cGMJ1JSjO1mbXSA5Vh/pUH1F0hSQxx6AFdZL7mRD3/S44vYpiIqysx
         LSDv+sbnvhk958P8ntNMmesPq7Ot7m6pbF4MuLV/bb0eqSIblylWZgNEuXt8pkRHBEgO
         E18kLL23pCA0DahS3och1y+ZKaW4aN4gPFpWQIEAFUSoaiJy+A1gm8NBNC5aTKeVZLvm
         /0VwpksL8mTGfvXnrRjPRkrvR1OhkYSZpVZu1mvJgnHU0QpkB20+oUyDpOF5qMRM36W/
         gR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xfyjImC35WfwYVh8IMsnExnsNZ03alZmJASch5QZ600=;
        b=VWHg01gb5nWcs/NkOar6DHmwWoJql5OQPhfMFgu+w80suHjiOR8covbX/eeb6+CMeP
         6DTZW14V0uaINvlEzMqqEKZfar+97ppfTm9OFU7T3uoq7yKM6WSMRCrLB/IvGrYQOHZY
         p+ZtUWWdG3V09AQmu4pxxnkdC1rySbUMEqOEkBXG3T22Qs1HwDXGKk8U2voso9Zt+4NU
         8c/i8vDdEIf3LFQJ4y6rzMRkJMOjTsrMlLGxXV9OORC51v8IJBzPh1I9bQhxhWfBJBRI
         wimL4Qa/GE5BMQcg3fGHgKRhXliGqcPbkML/bzux9kPQ4E5dQdla/o/Ivo22MULsvQ2B
         CqLQ==
X-Gm-Message-State: APjAAAUxYLE5aTqXW6CQw34fc5ZM1g74V43ueqW1szscjWbmNcP3xj6k
        CcZKXztdBJmn87S7wh4jQVw=
X-Google-Smtp-Source: APXvYqxmAC60mpqVhtxlue/W5mNKIvloKAwBGeEPnNminl4ZmQUa9vHD3zHKE/YWsFg7Kar+QRd9xQ==
X-Received: by 2002:a7b:c76c:: with SMTP id x12mr9038613wmk.97.1554489753006;
        Fri, 05 Apr 2019 11:42:33 -0700 (PDT)
Received: from szeder.dev (x4d0c3c70.dyn.telefonica.de. [77.12.60.112])
        by smtp.gmail.com with ESMTPSA id x5sm3077638wmi.37.2019.04.05.11.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:42:32 -0700 (PDT)
Date:   Fri, 5 Apr 2019 20:42:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405184229.GB8796@szeder.dev>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405182412.GC2284@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:24:12PM -0400, Jeff King wrote:
> On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
> 
> > > +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
> > > +	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
> > 
> > This test saves standard output and error, but doesn't look at them.
> 
> I think we want to be checking for "not a tree" here, which is later
> added with the fix. But either we should have the test_i18ngrep here
> initially, or we should add both the redirect and the grep with the fix.
> 
> > > +test_expect_success 'setup unexpected non-commit parent' '
> > > +	git cat-file commit $commit |
> > > +		perl -lpe "/^author/ && print q(parent $blob)" \
> > > +		>broken-commit &&
> > 
> > Don't run git commands upstream of a pipe, because the pipe hides
> > their exit code.  This applies to several other tests below as well.
> 
> I disagree with that rule here. We're not testing "cat-file" in any
> meaningful way, but just getting some stock output from a known-good
> commit.

It makes auditing harder and sets bad example.
 
> > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > dependency?
> 
> Heh, this was actually the subject of much discussion before the patches
> hit the list. If you can write such a one-liner that is both readable
> and portable, please share it. I got disgusted with sed and suggested
> this perl.

Hm, so the trivial s/// with '\n' in the replacement part is not
portable, then?  Oh, well.

