Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB7C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 02:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540162256F
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 02:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgLXCLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 21:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgLXCLI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 21:11:08 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247BEC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 18:10:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i6so782648otr.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QXSKJOyk5bwQ/3Kp2y4XkRBiw2icQrgtlsI5xoGiCBA=;
        b=EKktB/bPTLK/Lscpk7Gm/pKM0z8fvxlXdXfuG/SXM8NjhVpouy5UJXrKNlCTk8z5ef
         KAdZpXYDULh16RW86wxR91Ubvz/uwbt4jTNwjJbTKALwhs7npLM2rYILGCEVWiaFt63V
         lyvFcdMzL4cNUxIPVfyrRirPueVQ80YFqxNSXB8t6LqvDfnetAhJkjSHtc8IHkPl7nNq
         WR+jPpOKNEC+G5/6CcbNOo7oV1fOfmryN+MCh41L4wVx3f2ECug3HCZhxfk37aKT6H/1
         pU+olHCHmn/JaBKeDRtXVPngBvMfR3Vkvt5/vPS4Ol4fbC0jZtQX2MGmUsgmYuV8532T
         IgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QXSKJOyk5bwQ/3Kp2y4XkRBiw2icQrgtlsI5xoGiCBA=;
        b=bBRq3h1K1boIEqVLqabbpcZQBk5Vtj3GUIeDZP72m0qEY5Wns7JEDXcjUqn07tsttM
         lB9hm1NMGcNth25f8u7Lt2HHPykNPDVi0jtsWgbxUVTVhxnRVHgdJdQSgCMLlMkVjVm0
         Bibzc0xX6zVL9Xdb8SE9exfWr0Mlkbxo93PV2RZLMUWN3Dkwov+AWISXWeQCsgUaeVsX
         GblNuwgL3aAm2hyjy2jjbzBiizsxLOs3Mo9xE2+Duh/IivILsXMw1asb03alC7DJ7ww1
         KpV5DOPK0uDdbtXl6nmugCtXvOUZ1sTS6LhT5f5VbdxEW2tUsCxocQ4POadNFYSMG3ml
         GjGQ==
X-Gm-Message-State: AOAM530fpzJR6hpJK50YQu89I+yK1OUf/+O6gqSxUDz3schUkR4BSnK7
        on5WNqBqMTm5Rwuxh0qztJEO4wwVRd/fbw==
X-Google-Smtp-Source: ABdhPJwbJUk08rGswmO/pESxiVcGZQHNuH2DVR09dW9QuzKmsOpKH7Lg6xkJ0e0a2ZI6EhOb0e+kFQ==
X-Received: by 2002:a9d:37c4:: with SMTP id x62mr21891357otb.87.1608775800220;
        Wed, 23 Dec 2020 18:10:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p132sm5045659oia.41.2020.12.23.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 18:09:59 -0800 (PST)
Date:   Wed, 23 Dec 2020 20:09:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <5fe3f8763207f_7855a20860@natae.notmuch>
In-Reply-To: <X+OkOGkBrpbHhHkb@camp.crustytoothpaste.net>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
 <X+OkOGkBrpbHhHkb@camp.crustytoothpaste.net>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2020-12-23 at 14:46:56, Derrick Stolee wrote:
> > On 12/23/2020 1:17 AM, Felipe Contreras wrote:
> > > As many argued; respect cannot be manufactured at will. If you don't
> > > respect an idea (for example that the Earth is flat), then it doesn't
> > > matter how hard you try; you still will not respect it.
> > 
> > ...
> > 
> > >  * Using welcoming and inclusive language
> > > -* Being respectful of differing viewpoints and experiences
> > > +* Being tolerant of differing viewpoints and experiences
> > >  * Gracefully accepting constructive criticism
> > >  * Focusing on what is best for the community
> > >  * Showing empathy towards other community members
> > 
> > As mentioned in 5cdf230 (add a Code of Conduct document, 2019-09-24):
> > 
> >     This patch adapts the Contributor Covenant Code of Conduct. As opposed
> >     to writing our own from scratch, this uses common and well-accepted
> >     language, and strikes a good balance between illustrating expectations
> >     and avoiding a laundry list of behaviors. It's also the same document
> >     used by the Git for Windows project.
> > 
> > It is highly recommended to stick to the widely-used and carefully
> > crafted phrasing.
> 
> I am also strongly in favor of keeping the commonly used wording.

Do you care to explain why?

> If you feel that wording is inappropriate, it would be better to have
> the change adopted upstream.

What is upstream? [1]?

> > Specifically, "Being respectful" is different from "Have respect", which
> > negates your argument for changing this word. We can only enforce what
> > is evidenced by actual communication, not the internal lives of community
> > members.
> >
> > I could just as easily argue that it is possible to be tolerant without
> > being respectful.
> 
> I agree with this.
> 
> I should also point out that the situation at a university is different
> than the situation on this list.  A university is a large institution
> which is dedicated to the pursuit of learning and in which one may find
> a variety of ideas.  Sometimes those ideas (both past and present) will
> be offensive, but they are a part of learning more about the world.  We
> may tolerate those ideas as existing and being subject to critical
> analysis, but ultimately reject them and have little respect for them.

Yes. But ultimately it's about truth.

> On the other hand, many people work on Git or other open source projects
> as part of their job duties.

Nobody has ever paid me a cent to work on git.

Should the minority of open source contributors be held hostage because
the majority are corporate contributors?

> As such, this is a professional environment for many contributors.  In
> a professional environment, we need to be respectful of people who are
> different than us.

Yes, because somebody is paying you to behave in a certain way.

If a company is paying you to smile to customers, you smile to
customers.

What about the rest of us?

> We are aiming to have a common goal, which is to build a great version
> control system, and to have a coherent group of people who are willing
> to join together in that endeavor and best meet the needs of a
> diverse, multicultural base of users.

Indeed. And that's why we aim for the lowest common denominator.

We don't say; the majority of us use bash, so either you use bash, or
you are screwed.

We say; POSIX covers almost all of us, so let's try to aim for POSIX.

> The connotation I have of "tolerate" is "to suffer".

I don't think your definition is right.

Respect implies tolerance.

If you respect X, you tolerate X.

> In a healthy community, we try to minimize suffering due to others.  I
> am respectful of the fact that my colleagues may have different
> religious or cultural beliefs than I do and I try to consider those
> beliefs, such as considering their holidays when I ask someone to
> switch an on-call shift or schedule a meeting.  That can be a neutral
> or positive experience for all involved; no suffering need occur.

Therefore you are also tolerating those things.

> So I think the original Code of Conduct is more consistent with
> producing the positive, healthy environment we're looking for and best
> meeting our users' needs, and as a result, I don't agree at all that it
> should be changed.

OK. I have an opinion about this, but I cannot express it without
violating the code of conduct, so... I have three options.

  1. I pretend (i.e. lie) saying that I respect that idea.
  2. I express what I honestly think, but in theory I violate the code
     of conduct (like many people constantly do in this mailing list).
  3. I keep my mouth shut.

The reason so many intellectuals were against the word "respect" in
University of Cambridge's freedom of speech policy is not because
universities are special; it's because 1. and 3. are not conducive
towards truth.

As Stephen Fry put it: 'A demand for respect is like a demand for a
laugh, or demands for love, loyalty and allegiance. They cannot be given
if not felt' (you can only fake then).

Tolerance is the lowest common denominator everyone should be aiming
for.

Cheers.

[1] https://www.contributor-covenant.org/

-- 
Felipe Contreras
