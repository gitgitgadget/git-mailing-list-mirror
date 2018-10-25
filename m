Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4961F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJZD3B (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:29:01 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:50974 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:29:01 -0400
Received: by mail-io1-f73.google.com with SMTP id q127-v6so7706344iod.17
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FbfWO9z734LtXWHPZZujuN/lBRkgPuBBwXEANqM4+Ng=;
        b=P2nI/FOGu4x+gm/FjnLlFdBWl3I/nwvX1c93d+IBktHB695Q5uRkm9WBm2PCbEQ6pF
         H5iRXPyg71fea61O5HffRxN9jILbuWBR/nPO5B1CZkrITMM3vUiNo8Ibo1o6xOkwiIBp
         mff9C2gkTbCom9MrEYiFlk79zgUy93sdwS2eMSb430fhc7tmYDkHxOYxmoykkwfP0+Nd
         xIZZX2WjrSRHbi4wLpk6LZaok08BRZBlQXAPlrE0vPX/hdza/a/M05BaT8OLr61NGlLI
         B2YcqboK3JMrwUV2n5eA0XRDtOAiNJQrZ+fcVzh9+yXFfFfzufA4CF17tng5In1hCYVT
         dQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FbfWO9z734LtXWHPZZujuN/lBRkgPuBBwXEANqM4+Ng=;
        b=O6sgFxyMr4yL2O/+oJtv8khZUx+H94BvtrX2VCWtNSsFt9q8YETiKYkKt+EYjnD6Ow
         ov7G5nIRt2xzWXnoTiz+ainU3p9SECpmJ8Z5I8UHNiq94sqBFM5TFa/T8ziO7oQDpn+/
         qSEWXvs0lDsH4h6Qo5V3dI76z8GX2iqHe4z8lASg7FdSvUBzkqbyyLZHhhOdnGksIVpt
         TluLKAND1ex21FL316Nn1Or/ZLGGvE0UdYdtik/3QDzIYqZt4ddg3MDnEU5qKJiiuxAP
         Uvr7jvwsexotnjDw7AzMHsnZmwW88AVtpDN1CjEKAUpreEPagYygqcU3QZZAyjDMfNqx
         HzvA==
X-Gm-Message-State: AGRZ1gJSlgVgcokg/0IbX6tDXZqqbEw6GPp/4a4E+PmP94Wq8Jg4vTMs
        uPUbDEskHkrwcKnmQa7uakd6nz49DIvsvv0N1VCk
X-Google-Smtp-Source: AJdET5efoXirOMx+oB5yyNB/RHRaEcxd7V2od+R4ytcbIWAuqgTQziAI3vggfVjWtjKgCS9fK2TGIx6gHSqssw70y6OA
X-Received: by 2002:a24:9085:: with SMTP id x127-v6mr315380itd.17.1540493702518;
 Thu, 25 Oct 2018 11:55:02 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:54:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1810241756390.4546@tvgsbejvaqbjf.bet>
Message-Id: <20181025185459.206127-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1810241756390.4546@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing entries
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@vger.kernel.org, pclouds@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, 24 Oct 2018, Johannes Schindelin wrote:
> 
> > On Wed, 24 Oct 2018, Junio C Hamano wrote:
> > 
> > > Jonathan, do you see any issues with the use of lookup_commit() in
> > > this change wrt lazy clone?  I am wondering what happens when the
> > > commit in question is at, an immediate parent of, or an immediate
> > > child of a promisor object.  I _think_ this change won't make it
> > > worse for two features in playing together, but thought that it
> > > would be better to double check.
> > 
> > Good point.
> > 
> > Instinctively, I would say that no promised object can be a shallow
> > commit. The entire idea of a shallow commit is that it *is* present, but
> > none of its parents.

I'm envisioning a client repo with a single branch, cloned both with
--depth=1 and with --filter=<foo>, that has just fetched to the same
branch also with --depth=1 resulting in a fast-forward from A to B.

If A is B's parent, then A would be known to be promised. (Incidentally,
the problem is greater in current Git, because for performance reasons,
we do not check promisor status when lazily fetching - so it doesn't
matter here whether an object is known to be promised or not.)

When pruning shallow and checking the existence of A, this would trigger
a fetch for A, which would download all commits and trees reachable from
it.

It sounds safer to me to use the fast approach in this patch when the
repository is not partial, and stick to the slow approach when it is.

> > However, I am curious whether there is a better way to check for the
> > presence of a local commit? Do we have an API function for that, that I
> > missed? (I do not really want to parse the commit, after all, just verify
> > that it is not pruned.)
> 
> Okay, I looked around a bit. It seems that there is an
> `is_promisor_object(oid)` function in `pu` to see whether an object was
> promised. If need be (and I am still not convinced that there is a need),
> then we can always add a call to that function to the condition.

I don't think there is a need for is_promisor_object() either - as
described above, it doesn't completely solve the problem.

> Coming back to my question whether there is a better way to check for the
> presence of a local commit, I figured that I can use `has_object_file()`
> instead of looking up and parsing the commit, as this code does not really
> need to verify that the shallow entry refers to a commit, but only that it
> refers to a local object.

Note that has_object_file() also triggers the lazy fetch if needed, but
I agree that it's better because you don't really need to parse the
commit.

There is the possibility of just checking for loose objects (which does
not trigger any lazy fetches), which works for builtin/prune since it
only prunes loose objects, but doesn't work in the general case, I
guess.
