Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF2C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 03:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjEIDup (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 23:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEIDun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 23:50:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4049CC
        for <git@vger.kernel.org>; Mon,  8 May 2023 20:50:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38ea3f8e413so2767400b6e.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 20:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683604242; x=1686196242;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNtgV4OeATwyxexpQYSy7Z+XhPPAtKpBNQVKNvS2bIM=;
        b=bbE/tA0qmLcTNCXkNFCfCDwwJwfGpr+X1SQPD4sL4LLsmmCCzA1X3eF7FmHGXFlZ4/
         5jSkNxZI/Bn9n70mp+5mGuGlPIDeJj/g11AHkIWI/AJoGR91L1miaQhBuaCe8lNYqitm
         oHeKjlHx9n1LWyyP+hzg5mq0RsL+/u77Sa5/ITbtuqjtBX01DG9aB6EgGjs2xNF3F8tU
         O6d+Tdpf1NMN68VN07SS30/KnYyPwiOt0xhxBtOaSbwsayjyFDxmN4jpnHk7yvMXTrHB
         H5jIt2VdNl7Pty5oGa/c4QgFZmvsmUj8quVg5hPwrv9wC0RdVLXotQQAizz+31YycGb4
         9sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683604242; x=1686196242;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNtgV4OeATwyxexpQYSy7Z+XhPPAtKpBNQVKNvS2bIM=;
        b=BmGhEFqfAizDSuDj0zXhu6rWNYxT/WE1JTev58bhUqOQwVT4i5Ql/Wp7+t1DEQ4xNr
         6+Av7gEnN4wWQTGPLqMnrgaOXWbbpG753YjJmQ/TLil4L87S6rHpSpW/+P7sCnhLkISy
         2VXBrr1zKv1h0MDYMO/+VusAOcdCvqKrGygb5CUjPZVu4+3fzsUB0gnpOGrdi6clsP14
         UChfHuWERORFLm2B7rKnKUhnFI0DxIPKkN4piSgWxqztfjw+EOkdTn0OjxrvfEFRbppI
         zuCnbCMmg3jJQDCB/yvsJkI4FUV7sAB7KLuHo2IyfFoPlZVOILFB4H5SqCJqklorYBDr
         WC9w==
X-Gm-Message-State: AC+VfDxU/wLqrmtGSgDHsAssAzetMzu61C2n37F4Yi5/eKji3mo1uriC
        RvxJfGPjaLAXLl6aWxEwZu6HNutH4iM=
X-Google-Smtp-Source: ACHHUZ6XCFSPqiumsMoJvHvdSla8gZp8cZHuZxy9H6atENaPSVUwiK2Sah2E5w7e7pTY2xQeDrcAig==
X-Received: by 2002:a05:6808:2a8a:b0:38d:ef8f:11cb with SMTP id fc10-20020a0568082a8a00b0038def8f11cbmr558568oib.9.1683604241756;
        Mon, 08 May 2023 20:50:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u14-20020a4ad0ce000000b0054f9f229bddsm1051216oor.15.2023.05.08.20.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 20:50:41 -0700 (PDT)
Date:   Mon, 08 May 2023 21:50:40 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <6459c31038e81_7c68294ee@chronos.notmuch>
In-Reply-To: <xmqqsfc62t8y.fsf@gitster.g>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
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
> >> Let's fix the interactions of these bits to first make "-s" work as
> >> intended.
> >
> > Is it though?
> 
> Yes.
> 
> If the proposed log message says "as intended", the author thinks it
> is.

The question is not if the author of the patch thinks this is the way
`-s` is intended to work, the question is if this is the way `-s` is
intended to work.

The way `-s` is intended to work is completely independent of what the
author of the patch thinks, as `-s` existed well before this patch.

A cursory search for `-s` in diff-tree.c shows:

  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
  Date:   Fri May 6 10:56:35 2005 -0700

      git-diff-tree: clean up output
      
      This only shows the tree headers when something actually changed. Also,
      add a "silent" mode, which doesn't actually show the changes at all,
      just the commit information.

So presumably the original author of `-s` intended for it to not show
any changes at all, but that was before any of the non-patch options
were introduced.

So, 18 years later: what is the intention behind `-s`?

> Throwing a rhetorical question and stopping at that is not
> useful;

Who says this is a rhetorical question?

`-s` was introduced 18 years ago, before any of the non-patch options
were introduced.

I do not think the intention behind `-s` in 2023 is clear at all, and
the patch does not attempt to answer that.

> Unless the only effect you want is to be argumentative and annoy
> others, that is.

Assume good faith:
https://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith

> I've dug the history and as I explained elsewhere in the earlier
> discussion, I know that the "--no-patch" originally was added as a
> synonym for "-s" that makes the output from the diff machinery
> silent---I have a good reason to believe that it is making "-s" and
> "--no-patch" both work as intended.

I don't think so.

`-s` might have been added to make all the diff machinery silent, but
`--no-patch` is a different question, as the commit message of d09cd15d
makes abundantly clear:

  diff: allow --no-patch as synonym for -s
  
  This follows the usual convention of having a --no-foo option to negate
  --foo.

Now we know `-s` is not an antonym of `--patch`, so the commit message
of d09cd15d cannot possibly be correct.

There's only three options now:

 1. `-s` doesn't turn all the diff machinery silent, only --patch
 2. `--no-patch` is decoupled from `--patch`
 3. `--no-patch` is decoupled from `-s`

I don't think think there's any other reasonable option, including the
status quo.

> I would not say that we should *not* move further with a follow up
> topic, but I think we should consider doing so only after the dust
> settles from this round.

But what is that dust?

Do you agree with the following?

 1. No reasonable user would consider the status quo to be expected.
 2. Any change to the status quo would incur in backwards-incompatible
    changes for end-users.

If so, the only question remaining is what backwards-incompatible
changes shall be implemented.

-- 
Felipe Contreras
