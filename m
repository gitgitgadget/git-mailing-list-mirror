Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B3C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 01:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGIBCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIBCF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 21:02:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA17538B
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 18:02:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3472357pjc.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CvgmGnA86M2a/QYPtW7guF9+riWtHeaVSV+fS/JjBLI=;
        b=N5RuWJX5JGY7HP8AWhP5kcUPzkNhQ4tyPVOCkuAe1wWeOh/zEPDAbGarA7uBAwoCxN
         Jgk+1NO2qGd8z0llMa2ZA6zazZEotaB/Vxu7xIg0xybHS9dytWhd6mK4Py5oyL2GFHcV
         DsXG5IH9gv3wnQ4yV/ljwPT8QZXXTVIuWFQqcc/mzU7rYoMVSuZapLJYyUe6adotlqtM
         mWBjwjMKpngfmSvxt9FGZKurYGJ3HZOfs+4eBqFrX7Yo/CCek+g8XNvznBaGG7dtMZuz
         IF79mbVbBHWeQw6h3/NPSKeggg6KBMhK1Bozo3cv/SZu20G7Kb64g5cczx/q4w/UlWGe
         aIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CvgmGnA86M2a/QYPtW7guF9+riWtHeaVSV+fS/JjBLI=;
        b=ZotMVSwtgUbBXDUZZY0LtbuMjCr+lW8zjKctjzbYUXVhEgdH8/Ria8hqzlCAwOCuyv
         X5cqMHyzoY46aGuY5xKG3evpVDQcKePlG5ZNt3RsxuW8ioXTW6gumuDIXg41UvTy8DDl
         tuYNGU6VVg6YyhFLbXTVG2oQqX3ud6NNbFqUSUYYWkr/TM7ZDvIl98MOTgttfGGPO5oE
         SF3oxo5nAAsfBa51/TOatHlCWydKILYirDxJ+uLPknbkPH4hmN6sASiZnDApjNtAlCzY
         YJzBXmz9vgF5JR3qVNYpr2URk1OUe/+dZL9GAZugwAWvDuDFNsPfmcTrAZowXYOMDzqS
         tuXQ==
X-Gm-Message-State: AJIora9Ihp8JTacyQCgkBWpjCvjkB6w2+vE7H5779fnCFEiUXK5SFFSc
        aSI34VY5pEp/1qMXCZAiO3E=
X-Google-Smtp-Source: AGRyM1t2GgTXRObltMQldlK5Te/0ji+Mda0dUQUvbcHPAG1ByneQSUav3oJeR4KXP0TXmcs86ZIR7A==
X-Received: by 2002:a17:902:7618:b0:16a:23ec:75f6 with SMTP id k24-20020a170902761800b0016a23ec75f6mr6437301pll.158.1657328524030;
        Fri, 08 Jul 2022 18:02:04 -0700 (PDT)
Received: from localhost ([2001:ee0:4fc8:e0b0:4ee7:6ef1:618c:a53f])
        by smtp.gmail.com with ESMTPSA id i7-20020a635847000000b00413d592af6asm74305pgm.50.2022.07.08.18.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 18:02:03 -0700 (PDT)
Date:   Sat, 9 Jul 2022 08:02:01 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        siddharthasthana31@gmail.com
Cc:     siddharthasthana31@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] revision: improve commit_rewrite_person()
Message-ID: <YsjTif0TjYBzBXfh@danh.dev>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-2-siddharthasthana31@gmail.com>
 <YshESKSHfpcQf/dI@danh.dev>
 <CAP8UFD116xMnp27pxW8WNDf6PRJxnnwWtcy2TNHU_KyV2ZVA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD116xMnp27pxW8WNDf6PRJxnnwWtcy2TNHU_KyV2ZVA1g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add list back to cc

On 2022-07-08 23:23:07+0200, Christian Couder <christian.couder@gmail.com> wrote:
> On Fri, Jul 8, 2022 at 4:50 PM Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> >
> > On 2022-07-07 21:45:51+0530, Siddharth Asthana <siddharthasthana31@gmail.com> wrote:
>
> > > By simplyfying the interface of the commit_rewrite_person(), we also
> >
> > s/simplyfying/simplifying/
>
> Thanks for noticing the typos!
>
> > > +static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
> > > +{
> > > +     size_t buf_offset = 0;
> > > +
> > > +     if (!mailmap)
> > > +             return;
> > > +
> > > +     for (;;) {
> > > +             const char *person, *line = buf->buf + buf_offset;
> > > +             int i, linelen = strchrnul(line, '\n') - line + 1;
> >
> > Would you mind to change those lines to avoid mixed of declaration and
> > expression.
>
> I am not sure we have some clear guidelines on this.

Yes, we don't have a clear guidelines on this, but this would sure
matches into mixed declaration and expression. And some variables are
initialized and some aren't in the same line. I was confused in my
first glance.

>
> > Also, I think i and linelen should be ssize_t instead.
>
> Could you explain why?
>
> I think 'i' is changed only in:
>
> for (i = 0; headers[i]; i++)
>
> and therefore cannot be négative.
>
> While linelen is set only in:
>
> linelen = strchrnul(line, '\n') - line + 1;
>
> and therefore cannot be négative either.


Yes, both of them can't be negative. As I explained in the part you
removed.  However, I choose ssize_t in my reply because it's
a ptrdiff_t.

So, size_t is an obviously a better choice.
Either size_t and ssize_t could be used in this case, but not int.


>>> +
>>> +             if (!linelen || linelen == 1)
>>> +                     /* End of header */
>>> +                     return;
>>
>>And I think linelen will never be 0 or negative,
>>even if linelen could be 0, I think we want "linelen != 0"
>>for integer comparision.


-- 
Danh
