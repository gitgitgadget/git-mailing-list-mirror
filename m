Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A19C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0319920738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S47KbKIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgHURQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgHURQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:16:52 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C9C061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:16:52 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id g11so743677ual.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WmRBMACRDMTNZHCrvmAVH7wY5vipw+K1z8VG04SPVs=;
        b=S47KbKIjRBNCr6LdoaZlw6FbyJLMPqT5n0Kjg1zJ8cSNpmcqm3CiIyBmmn2b8VMS1g
         u6Pl/zsN02oFvXbk4NHVP4YFZb4kJ+rdwQpMVWvuJAfYjj97QWNj19+298brIifoTWkR
         H7xUhlPUNebBD6iGjJQBhgWCs/L+5D9dzotRra7hVZpW1n3iRaGBxLHcN9MGMiK/ta2O
         W2ThE7UJSALAcF2xSLjgjPGT1B5UEIpZ1AE7EiADTf75Wy5rjvMQ1wBUQornEDC04U5w
         oBrLDv1/lH615xoGydiZjf7wNJckJOhfxlWCqd+Q7OLpkfZsIPGf6w0KJI3Xec/EipMw
         m9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WmRBMACRDMTNZHCrvmAVH7wY5vipw+K1z8VG04SPVs=;
        b=XQlhzY9GGxvRrfVPCInDjByd3T7Z1pEjlo7hKIcKghQdGLi6bPWjc3dIN/w4R11rgW
         U9GzoJSoEG3x34b2n7mnnlOcA18LScXLLmAoEcocz2tCAGSImHzx1CcfZWfTrtKAGVd8
         eKDx+iGrZHfJ39P5Ms3tPHx9YJHVFcOmyU82VzlK73zG9OvVOZPK1nkRmf7F4wJgVByS
         P6h3p5YrFRrvTugd8gSAnakWyuT1+8U3Mclg+zesrkViEFAnh7yh2JfuEvdhpaIXBUrl
         1R4+1MMkM0w2lF1LGCj0pxzxZkkP+RcT5mmNMNe0Q8Jfcu6p1odDjkZzPIZpWeAlPYrD
         f77Q==
X-Gm-Message-State: AOAM530k1V0tJSJ91oPJAS5ZXUoeHdCh4UURyVGqsTryp8hEhuuhcct2
        7/Wuxn4WV/YnIaMmFih22HGP9fAS3G2Sl40QKVgT6x0hwPA=
X-Google-Smtp-Source: ABdhPJyzxhn55NJbHGJBp9+Ri/M3H2wUTa7W1N/O3uLRGed1Oqdv+LCokxpp+gkBl3ofQu6GEcLbxHq8R7SzWZbftqk=
X-Received: by 2002:ab0:3762:: with SMTP id o2mr2271610uat.140.1598030208238;
 Fri, 21 Aug 2020 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com> <20200818174116.GA2473110@coredump.intra.peff.net>
In-Reply-To: <20200818174116.GA2473110@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Aug 2020 10:16:36 -0700
Message-ID: <CA+P7+xrPep7caJm2uN+hAqOqZU3b2njpW95JQCzYJdKgbakp8A@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 10:41 AM Jeff King <peff@peff.net> wrote:
> Hmm. I think the behavior we'd want is something like:
>
>   # make sure the other side has three refs
>   git branch prune/one HEAD
>   git branch prune/two HEAD
>   git branch prune/three HEAD
>   git push dst.git refs/heads/prune/*
>
>   # now drop two of ours, which are eligible for pruning
>   git branch -d prune/one
>   git branch -d prune/two
>
>   # push with pruning, omitting "two"
>   git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
>
>   # we should leave "two" but still deleted "one"
>   test_write_lines one three >expect
>   git -C dst.git for-each-ref --format='%(refname:lstrip=3)' refs/heads/prune/ >actual
>   test_cmp expect actual
>
> I.e., the negative refspec shrinks the space we're considering pruning.
> And we'd probably want a similar test for "fetch --prune".
>
> I just tried that, though, and got an interesting result. The push
> actually complains:
>
>   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
>   error: src refspec refs/heads/prune/two does not match any
>   error: failed to push some refs to 'dst.git'
>
> For negative refspecs, would we want to loosen the "must-exist" check?
> Or really, is this getting into the "are we negative on the src or dst"
> thing you brought up earlier? Especially with --prune, what I really
> want to say is "do not touch the remote refs/heads/two".
>
> We can get work around it by using a wildcard:
>
>   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two*
>   To dst.git
>    - [deleted]         prune/one
>
> So it works as I'd expect already with your patch. But I do wonder if
> there are corner cases around the src/dst thing that might not behave
> sensibly.
>

Hmm. So this raises a good point. I added a variation of this test
where I used separate names for the source and destination. It looks
like with the current implementation, negative refspecs always apply
to the destination.
