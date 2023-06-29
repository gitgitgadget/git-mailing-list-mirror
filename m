Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A89EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 09:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF2JMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjF2JMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 05:12:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F202132
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 02:12:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7fb02edfaso3722675ad.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688029957; x=1690621957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqcDUSlortmbZZyexLgcUCc4iMvMx0DEfi2QUeWCacA=;
        b=TBipEyowuEFaVUWvioRsI1YgwT0B4EgEBwxcjtW7GuWbtAJAZKCEOQd7skrZAIfhbK
         aZlA4I5tDmWkipfyMwOthVr3wX1mFKDGl3paV0366pWrvzUhuycPw2ktL5JhJpiGtOs1
         1U7CG7FmA1ErnDE8+07D5B0VQeY0jiggiGhtE70OO2GeoakCGpWqDGlWjTWYweBlF5QD
         EtsZFN23VcY9g7EEnytit/6RenxncixZIwNRmSevOtFngg+6jxxEUvMfPZ1rVgxFKvhY
         hVYyZYQUv8aaQrtt+1VhAw94GtAbVq5FdM3S4/ar74VmjkyDkS7ylU7UGxfgBMkYAH2b
         Rznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688029957; x=1690621957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqcDUSlortmbZZyexLgcUCc4iMvMx0DEfi2QUeWCacA=;
        b=Dbr0QwQL1ushNJ3Oow4+iRX7kAM1piYJJ+DN4uAEQOkd/zYuSwKGKTWk/lf8paQ8tW
         8vHB/n0tCqCOihAaZVrA04CvmYsHLoFp5U66oa7rxOPKKauT8qYKDfQn2aX/U+S+OiVC
         oZ/+TAwABoiQmOvEdRUWiUZTiRZfOwTYL8nseQKv6AfKs5cYo9el2tvC6QOuE9qcOfYK
         3iZBTwsbip4GmuovnexrQjo3WgN4qCJnnHJyTq1d5O0m6j8OgVyYuh+x/18lTs9Yajif
         OfdrMx30GGAEZslJr21Q8MEDjy0beFhDHO31HSHvsdvlUx9nZBt0ucFfZfstT1m0j1Z1
         XC8w==
X-Gm-Message-State: ABy/qLYMB+iZmx9/6NsYbtMAg6ejpSMYk7YLv/SURuSISiq6h12shj0V
        2idRP1w94ZpLwxN0vQ2qd0QUiugz7jbpGQ==
X-Google-Smtp-Source: APBJJlF5pHmum4QTKscjyhn+qP+4W1fkHWttcQEnNkTKbXYSZX6oUCjLJwcusjM+h3em1v8gA8F+Rg==
X-Received: by 2002:a17:902:704c:b0:1b8:4baa:52ff with SMTP id h12-20020a170902704c00b001b84baa52ffmr2594942plt.47.1688029956894;
        Thu, 29 Jun 2023 02:12:36 -0700 (PDT)
Received: from five231003 ([49.37.158.45])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709029b8800b001b23eb0b4bbsm8788777plp.147.2023.06.29.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:12:36 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:42:27 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] t4205: correctly test %(describe:abbrev=...)
Message-ID: <ZJ1K-3ZFtmMJtW3r@five231003>
References: <20230628181753.10384-1-five231003@gmail.com>
 <xmqqv8f7b7h1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8f7b7h1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2023 at 02:30:18PM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
>
> > The pretty format %(describe:abbrev=<number>) tells describe to use only
> > <number> characters of the oid to generate the human-readable format of
> > the commit-ish.
>
> Is that *only* correct?  I thought it was "at least <number> hexdigits"
> to allow for future growth of the project.

Yeah, this is wrong. It should be "at least" for being more precise as
we may need more than <number> in some cases. Will change that. Thanks
for catching it.

> > This is not apparent in the test for %(describe:abbrev=...) because we
> > directly tag HEAD and use that, in which case the human-readable format
> > is just the tag name. So, create a new commit and use that instead.
>
> Nice.  How was this found, I have to wonder, and more importantly,

I was working on duplicating "%(describe)" from pretty, in ref-filter
and was writing tests for it. While going through the trash directory
for some other breakage, I found this. So it was kind of a chance.

> how would we have written this test in the first place to avoid
> testing "the wrong thing", to learn from this experience?

I don't have a clue :).

In this particular test, this is not "the wrong thing" anyways, as you
explain below. We just fail to test it wholly (we missed some cases).

> >  test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
> > -   test_when_finished "git tag -d tagname" &&
> > -   git tag -a -m tagged tagname &&
> > +   test_commit --no-tag file &&
> >     git describe --abbrev=15 >expect &&
> >     git log -1 --format="%(describe:abbrev=15)" >actual &&
> >     test_cmp expect actual
>
> The current test checks that the output in the case where the number
> of commits since the tag is 0, and "describe --abbrev=15" and "log
> --format='%(describe:abbrev=15)'" give exactly the same result.
> Which is a good thing to test.
>
> But we *also* want to test a more typical case where there are
> commits between HEAD and the tag that is used to describe it.
>
> And we *also* want to make sure that the hexadecimal object name
> suffix used in the description is at least 15 hexdigits long, if not
> more.
>
> The updated test drops test #1 (which is questionable), adds test #2
> (which is good), and still omits test #3 (which is not so good).
>
> So, perhaps
>
>     test_when_finished "git tag -d tagname" &&
> -   git tag -a -m tagged tagname &&
>     test_commit --no-tag file &&
>     git describe --abbrev=15 >expect &&
>     git log -1 --format="%(describe:abbrev=15)" >actual &&
>     test_cmp expect actual &&
> +   sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
> +   test 16 -le $(wc -c <hexpart) &&
> +
> +   git tag -a -m tagged tagname &&
> +   git describe --abbrev=15 >expect &&
> +   git log -1 --format="%(describe:abbrev=15)" >actual &&
> +   test_cmp expect actual &&
> +   test tagname = $(cat actual)
>
> or something along the line?  First we test with a commit that is
> not tagged at all to have some commits between the tag and HEAD with
> the original comparison (this is for #2), then we make sure the
> length of the hexpart (new---this is for #3), and then we add the
> tag to see the "exact" case also works (this is for #1).

Yeah, makes sense. Thanks for such a nice explanation.

I have applied this and it works. I'll reroll with this change and
also the change in the log message (and also maybe add some comments
about these cases).

I'll make sure to do this in the tests for ref-filter too, about which I
mentioned above.

Thanks
