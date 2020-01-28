Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D15C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4346C24681
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCQFCYDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgA1QHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:07:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1QHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 11:07:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so16694451wru.4
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abBvY/mgjoxb/8n25zOaiDP5qT50RmI/Bla7NHsIqJA=;
        b=OCQFCYDQHMlScO+HHXEl9R1iz5HhXp7cGU5uWaK0og8Xw0TD90m8p9imp74cNXm6F8
         J2+kIooYhr++TuYxqgBgYhxjT3m4YzwhpvdHd2hUvoJqigUQjslSbph8E7TZqaSGtmvW
         B4NtqwG1ZGVc5yLvpvh97jgA7Yy5kXEP1nkwu1cesB7IM91b0ZL0SC4qnTJqQzoKBESO
         wdSEwqTivJ4u3utHQlvpSvE0C9JRTwlvWRUT89WEwo2yWBHfFATE9Ai2zZQaXwfF4wlK
         ozud44Bhuz5ZIh8Ku+h3QgcxQYbWbQZaxLy2gW8f3uTWeXf5v0KkETpx5UehFKxRDGzI
         7r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abBvY/mgjoxb/8n25zOaiDP5qT50RmI/Bla7NHsIqJA=;
        b=RbTg6MISPeN0kpXDfRRWAj/f8ou7Fn8jpToMZE84mz1MrUBiljMFFMK0U2wIuwS3NV
         t5guUP3L83yJO0c6xjPNpItBY3U5vfrt0isFXRUwCdeDN0bYGlno5ipVhw8e9YPmX5+i
         CC6ZcM5WS5VIf+e/d7bEk27ITmdmqZcXLCFKybynSy/u9s10Xne8OaVZgPe6t7sMF0+o
         ATWZfFO0+k7uGAQ21mavBnpZVAFU6AbsnXYk1glmCc7iQpAXAyBW1SdKNTRp0HOHJhbL
         RtmcSQxc88ACgzrQPjcmu233ebrt6prNP4R9ofe96ZyYmp29CfgpYrD3kNNlcKRb8n76
         kMqQ==
X-Gm-Message-State: APjAAAVHfGZoL5TlRJ9XLr01X5y8R5+30Z/+RmjUkR0FQn/C+JfQ1mBY
        NRaPEIbZmbxusJk2lkPYz7wBFtALoHfrRCCANLmG8SvR
X-Google-Smtp-Source: APXvYqyHt/SR4kVbZE0MehBcxdTLRskXoB0bFrnoJGO9XQa4Z/T8y2Cakwwiuu5coNM1ChzaFT8bN9oq14QS5KF0N7A=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr28856432wro.310.1580227657659;
 Tue, 28 Jan 2020 08:07:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <9cf185b51f45f2df0016d7b69351ec2a7656dac2.1580134944.git.gitgitgadget@gmail.com>
 <xmqqmua8a4vg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmua8a4vg.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Jan 2020 17:07:25 +0100
Message-ID: <CAFQ2z_Oht5yCKXCP4rb+yA+u1gnK++Uy-jmyFdN5+Q6eBi5_8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Document how ref iterators and symrefs interact
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> > Subject: Re: [PATCH v2 3/5] Document how ref iterators and symrefs inte=
ract
>
> "Subject: refs: document how ...", perhaps?
>
> Also isn't it more like iterators and symrefs do not interact in any
> unexpected way, is it?  iterators while enumerating refs when they
> see a symref, they do not dereference and give the underlying ref
> the symref is pointing at---the underlying ref will be listed when
> it comes its turn to be shown as an ordinary ref.  I am not sure
> what is there to single out and document...

I mean, you can't return a zero OID and set REF_ISSYMLINK. Instead,
the ref backend has to follow the symlink recursively until it finds a
ref pointing to a OID.

> > Change-Id: Ie3ee63c52254c000ef712986246ca28f312b4301
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  refs/refs-internal.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index ff2436c0fb..fc18b12340 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -269,6 +269,9 @@ int refs_rename_ref_available(struct ref_store *ref=
s,
> >   * to the next entry, ref_iterator_advance() aborts the iteration,
> >   * frees the ref_iterator, and returns ITER_ERROR.
> >   *
> > + * Ref iterators cannot return symref targets, so symbolic refs must b=
e
> > + * dereferenced during the iteration.
>
> What this says is not techincally incorrect.  Iterators do not give
> each_ref_fn what underlying ref a symref is pointing at.  But it
> also is misleading.  If your callback wants to know what object each
> ref is pointing at do not need to do anything extra when it sees a
> symref, as name of the object pointed at by the underlying ref is
> given to it.  Only callbacks that wants to know the other ref, not
> the value of the other ref, needs to dereference when called with a
> symref.
>
> But I wonder if we need to even say this.  Isn't it obvious from the
> each_ref_fn API that nothing other than the refname, object id, and
> what kind of ref it is, will be given to the user of the API, so it
> would be natural for a caller that wants to do extra things it needs
> to do for symrefs must act when it learns a ref is a symref?  After
> all, that is why the flags word is one of the parameters given to an
> each_ref_fn.

Maybe it is obvious to you, but it was not obvious to me, coming from
JGit working on the RefDatabase. One could imagine that the caller
needs to do something special to handle a symref, and returning a zero
object ID is OK, and this is a natural assumption if you implement a
ref backend, as dereferencing the symref to find out the final OID may
do more work than the caller needs.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
