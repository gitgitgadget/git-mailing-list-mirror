Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0576EC33CB7
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B198720722
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdpOCCkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaX6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:58:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33724 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgAaX6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 18:58:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so6868799qto.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 15:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2TPvNujwEoj7IihHT9IQ1V7kHB4rDc3zzc+at9RjXA=;
        b=SdpOCCkzdbOkwia57EA4ZID4zqbwUs8+lRMKqz6SSn87FK3E839T8ucb88EmXPN21z
         btzCfHERNPjIsvISK0mI6Oj+EdarclIQSbFWJt5wGjXWpn6j2sRkl7IY7gmP8vdMkz4/
         IsiwrmgQ4wfKVp+KRlc3eWV2nr9xnCZhHh5dNio8vTPV3T33d7ljJ3YhmMGIKDdmsmgl
         +1DC56ipSBmyX5hzg7zZr5gMiptENIhj9FFxxOfVOizc6z5I2fjG3sPFYMw+PZyDRI09
         UOb/oXlD9IHGWezjSf7ynHMVY6sFmJ6y4j0wL5w2S6beNGkg+IEPXQpHhOEZV0m17FvK
         MSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2TPvNujwEoj7IihHT9IQ1V7kHB4rDc3zzc+at9RjXA=;
        b=ePrK5UVFZryZOvs/2T64o324XTpiRHEqQHmhveZh9a+CKNoZMpDtQyWVC3NKOiag63
         X1HZ6jkGzr6H0c2eghkLpZplPjyjfVOUsRdN86BEqKSnX7qCwAo1QI6VJCsgcyZcpKQV
         s+umPpTQB0ZgBw+CLpym3C/m8aoeGOFjg21c5eDDkCXuWCIHh2MBQaqoHJj0bmrKlV7X
         py8PhXTWkehwMLmF+dpNmMoMN3FzwXw25Z0cERMVwYm37EKlqkbZ8qfIYnpAnoWEkYH1
         7+DqRC4ypv5rgqAngpTg0Fwn8oMJ5Z1NfwIUoR6FcOx3XPSzT5KSTKUxx3xfL/wDyRKp
         UYhQ==
X-Gm-Message-State: APjAAAWqJfwxRLd9U2q4HVQD7i7nHU1W4xxOC6EKkzbkcgW8OYXosgN9
        NC77X6VIZgau0pKy43OzYsDZUo/YC/19Qn10vkT2Tw==
X-Google-Smtp-Source: APXvYqw57oeJlELe3v2AIv9txmygdWH0iuKGaIy9305E51lSXqSXJAfoO/ba5jaIpQnhTwCSYFYhMQ85SB0Hv3w3Qko=
X-Received: by 2002:aed:2344:: with SMTP id i4mr13352888qtc.136.1580515087283;
 Fri, 31 Jan 2020 15:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20200130225818.193825-1-masayasuzuki@google.com>
 <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com> <CAJB1erXnNe0yGvL+wgU9RXAA6Vyx7T2dwM9NgCmUChOtL102NQ@mail.gmail.com>
 <xmqqy2tn8c3w.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2tn8c3w.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 31 Jan 2020 15:57:55 -0800
Message-ID: <CAJB1erXqK-a2uDPPQDLpdLYnPC8Mcxjo2ER0qSAsD9DOVHSmGQ@mail.gmail.com>
Subject: Re: [PATCH] doc: describe Git bundle format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 3:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> >> > +prerequisite = "-" obj-id SP comment LF
> >> > +comment      = *CHAR
> >>
> >> Do readers know what CHAR consists of?  Anything other than NUL and
> >> LF?
> >
> > RFC 5234 defines core rules
> > (https://tools.ietf.org/html/rfc5234#appendix-B.1), and these CHAR etc
> > are defined there. It should be OK to use these rules.
>
> That's not what I asked.  Do readers know that?  Did you tell them
> that we expect they are familiar with the RFC convention?

The patch says "We will use ABNF notation to define the Git bundle
format. See protocol-common.txt for the details.", and
protocol-common.txt says "ABNF notation as described by RFC 5234 is
used within the protocol documents, except the following replacement
core rules are used:". In order to interpret this ABNF definition,
it's not enough to read RFC 5234, but the reader has to read
protocol-common.txt. Otherwise, they cannot understand what `obj-id`
is and what `refname` is. Those are not defined in RFC 5234. They're
defined in protocol-common.txt.

Based on the fact that (1) this document instructs the reader to see
protocol-common.txt in the beginning and (2) protocol-common.txt is
needed to interpret this definition and protocol-common.txt says RFC
5234 describes ABNF format, the readers should know ABNF is defined in
RFC 5234 and ABNF includes those LF, CHAR, and SP as a part of the
definition after reading the first sentence and referenced documents.

>
> It might be easier to make the above simple ABNF understandable to
> those without knowledge of RFC 5234 by spelling out what CHAR in the
> context of the above description means.  Or to tell them "go over
> there and learn CHAR then come back".  We need to do one of them.

As I said above, the first sentence says "See protocol-common.txt"
which includes the reference to the RFC and other non-terminals. Note
that, not only CHAR, but obj-id and refname are not defined here as
well. The readers need to reference protocol-common.txt to get the
definition of them.

>
> > I want to make sure the meaning of prerequisites.
> >
> > 1. Are they meant for a delta base? Or are they meant to represent a
> > partial/shallow state?
>
> They are meant as the "bottom boundary" of the range of the pack
> data stored in the bundle.
>
> Think of "git rev-list --objects $heads --not $prerequisites".  If
> we limit ourselves to commits, in the simplest case, "git log
> maint..master".  Imagine your repository has everything up to
> 'maint' (and nothing else) and then you are "git fetch"-ing from
> another repository that advanced the tip that now points at
> 'master'.  Imagine the data transferred over the network.  Imagine
> that data is frozen on disk somehow.  That is what a bundle is.
>
> So, 'maint' is the prerequisite---for the person who builds the
> bundle, it can safely be assumed that the bundle will be used only
> by those who already has 'maint'.
>
> There is nothing about 'partial' or 'shallow'.  And even though a
> bundle typically has deltified objects in the packfile, it does not
> have to.  Some objects are delitifed against prerequisite, and the
> logic to generate thin packs may even prefer to use the
> prerequisites as the delta base, but it is merely a side effect that
> the prerequisites are at the "bottom boundary" of the range.

OK. Then, it's better to make this clear. If you follow the analogy of
saved git-fetch response, it's possible that these prerequisites are
interpreted same as "shallow" lines of the shallow clone response.
It's more like "have" lines of git-fetch request.

> > 2. Do they need to be commits? Or can they be any object type?
> >
> > From what I can see, it seems that they should always be commits.
> >
> > 3. Does the receiver have to have all reachable objects from prerequisites?
>
> I would say that the receiver needs to have everything that is
> needed to "complete" prereqs.
>
> Bundle transfer predates shallow or incomplete repositories, but I
> think that we can (and we should if needed) update it to adjust to
> these situations by using the appropriate definition of what it
> means to "complete".  In a lazy clone, it may be sufficient to have
> promisor remote that has everything reachable from them.  In a
> shallow clone, the repository may have to be deep enough to have
> them and objects immediately reachable from them (e.g. trees and
> blobs for a commit at the "bottom boundary").

I think there are two completeness of a packfile:

* Delta complete: If an object in a packfile is deltified, the delta
base exists in the same packfile.
* Object complete: If an object in a packfile contains a reference to
another object, that object exists in the same packfile.

For example, initial shallow clone response should contain a
delta-complete object-incomplete packfile. Incremental fetch response
and bundles with prereqs would have a delta-incomplete
object-incomplete packfile. Creating delta-incomplete object-complete
packfile is possible (e.g. create a parallel history with all blobs
slightly modified and deltify against the original branch. I can
create a packfile with all objects in one history with all objects
deltified with the other history), but it's a rare case.

The reader of a bundle SHOULD have all objects reachable from prereqs.
