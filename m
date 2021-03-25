Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82485C433E3
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5124D619FE
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 07:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCYHxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCYHxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 03:53:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C0C061760
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:53:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so1313241edc.9
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFRD7SAbKAbUNyNdW73s4EjMLMqrQMF2EC/4u1Mq4IA=;
        b=MDq+SUCrSwEK7+jOJG0YvB0U8JJgsOwCcsFAyI4nDFtygs9vrO8yI/X1TZEp02ERpP
         VSEjQHPSCz+ila6U2C7ZtM3pLLuVjlidj9X5C4awx9WlEEZ7fNYGXOaO2OqC0yeFblPy
         YHhaiAroIhjP1r2vVgy+kzU9TjYjTYT4FAOwklh/Fd0Mp+qAav0DCquEHTdMurYfwpPd
         bHB3mZa3g17dm2DdfO7unAACN5FZq2j3m0hoJFN9ezqHvKqEIy2798GXgaZuJ2bcXqdQ
         02fOy4NR5a3qe41taWLKs0Lh5V2WgnWYqtDL0amSQfidMNt1GkepcGDpa9y11QGPSYoP
         5pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFRD7SAbKAbUNyNdW73s4EjMLMqrQMF2EC/4u1Mq4IA=;
        b=UQE0bcvBiW/yYtFdcguTKL0iD4qKGhmfcrbBwDwN2XL0hf4PEYDry+t8Qett0NrVFE
         Pm9uv7Fc/WqKEMj0UETyQoktgsIKleSKGSA8+rlw0gNdbvR1SgAlSqkgxTG1VCe2KSZn
         OcHr++Lkpe01WsLsg8crwu7IzyQhxRTnX/IlNa5YxT85L0G1vcPJEzHNWlcg1arLqGWa
         y8f2SNUmrLcroAk+w9PpUPUN3b8y1VUpNbLhr7SYWemKZoI3KydyuRBh1XyPp4HpK+h+
         8sMxE1+xQQcE4l6zJ/cGfrnF7DcbBlTTSg5a+O/j55l+nBxTmCaCBvtHJ8ym5rS05RG2
         B+6Q==
X-Gm-Message-State: AOAM530EBSLwNSi4Qde/cLRAKhHLvH1UG+j8BYk50elNbE714SF4j7Yl
        F6j9DmRwn6rA/lZEmfXXrTbiGVU4bGmcXCjrkk4=
X-Google-Smtp-Source: ABdhPJzYnFS/vKM09squFRsLZ/YHM2tVnB3I+Gy6YjH6tM29zEtf9HYpZ4OFb5nizm/Rgpzebtr2IfGdgg6WC9N6w8E=
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr7628810edv.237.1616658795704;
 Thu, 25 Mar 2021 00:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com> <YCwJ8tORQg2Air4r@nand.local>
 <xmqqmtw3pzu3.fsf@gitster.c.googlers.com> <YCwhPG6RaAhU9ljg@nand.local>
 <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com> <xmqqsg4l3h32.fsf@gitster.g>
In-Reply-To: <xmqqsg4l3h32.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Mar 2021 08:53:04 +0100
Message-ID: <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > So I thought that blank lines should not appear in the trailers. And
> > if any appears, it means that the trailers should start after the last
> > blank line.
>
> I think that is a good principle to stick to.
>
> >> >  - if the second "multi:" trailer did not have the funny blank line
> >> >    before "_two", the expected output would still be "multi:"
> >> >    followed by "one two three", iow, the line after the second
> >> >    "multi: one" is a total no-op?  If we added many more " \n" lines
> >> >    there, they are all absorbed and ignored?  It somehow feels wrong
> >>
> >> That's definitely the outcome of this patch, but I agree it feels wrong.
> >> I'm not sure that we define the behavior that strictly in
> >> git-interpret-trailers(1), so we have some wiggle room, I guess.
> >
> > Any patch to relax how blank lines and other aspects of trailers
> > parsing in my opinion should come with some documentation change to
> > explain what we now accept and what we don't accept, and also tests to
> > enforce that.
>
> OK.  But do we document clearly what we accept and we don't before
> any change?

Maybe it's not enough, but the doc already has the following:

------
Existing trailers are extracted from the input message by looking for
a group of one or more lines that (i) is all trailers, or (ii) contains at
least one Git-generated or user-configured trailer and consists of at
least 25% trailers.
The group must be preceded by one or more empty (or whitespace-only) lines.
The group must either be at the end of the message or be the last
non-whitespace lines before a line that starts with '---' (followed by a
space or the end of the line). Such three minus signs start the patch
part of the message. See also `--no-divider` below.

When reading trailers, there can be whitespaces after the
token, the separator and the value. There can also be whitespaces
inside the token and the value. The value may be split over multiple lines with
each subsequent line starting with whitespace, like the "folding" in RFC 822.
------
