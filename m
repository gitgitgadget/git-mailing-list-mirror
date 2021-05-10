Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB84C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BCB61483
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhEJSop (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:44:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52709C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:43:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so10886956pjb.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8ea3nwEl9R9eZ1lzm57tyHPiUKd0s2rbZl10a3i2u0=;
        b=SDKBOJUZl0RVckuE/7S9G9Ca93nz9I6J2t2/fx4l7UUjnQKT0Dq6ACqrZviepWx+gA
         mjIN+iR3pj/ugu4Kws9zbJv51SZWk+qgsjL2Ma7qVZ/D15GkfZnmk5tLXba4AfVkw3Hh
         D0fx4L9nw5J746cPqX8D6PTzXWvPPeOLURrKu1Vr3ciVUYpGPLLd9J/HohRd5UltvL5C
         RGKhsclh7IOVuItNmf99mZV5w2B+bjfg81nrCA+27J6Gxt15C11vWjZefVFdMeX1IbJp
         OH7XKLmy4kEhXPI4TNbBbcOpxKjrNkSrh8m3kouo0W95nhfd+DHzmswjlqDPUb828TPq
         UkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8ea3nwEl9R9eZ1lzm57tyHPiUKd0s2rbZl10a3i2u0=;
        b=bQpfS+wlQfZFBNld/kyKR0kTcuYslgSdC32GQJu9ES0cNy4uY40h9UT77FveN2zDkl
         7nPzbReMiqezHRjYkG7m+mEcjgy3zAJVAtBP5dvwVW4uWF1LLoUoMbKA+i8sXy9CTHR9
         /Csu7dlv1eDrvYIw5gOfWPlkqy0UdXVufaLlT5Gb4Cm+QSarntpsVcWy6P/RLMSxlREv
         O3GIY6fy1vm8lJpU4zpp4vK2zJfTaRa3MzvXB645YvOohZPWg/vwI8siXB0komPs989F
         2zNAZPyElsJ7qqaYYaU+ddrMR0OB0GZD5c0MBo2/DPqC2hqlNPmCOjrjwCBQNM+ZoqCA
         eZvQ==
X-Gm-Message-State: AOAM530hYrcoYpRpqD60/BCIxv7p0aBbMoROQ8JlsJiudg0ny0S0Dh9e
        cFhzq6NZwU8tmf/X+cq4d8lPZs+MeFJBVODA3TA=
X-Google-Smtp-Source: ABdhPJy4U4NZuHZTK6ZgLoTDGejbui5Wfm/pk5zzeJriAsVwfnt+kyDbgKxmF9K5WrCtM2lvYR97P1e7riFqRcJMzWM=
X-Received: by 2002:a17:902:d104:b029:ee:ac12:4b31 with SMTP id
 w4-20020a170902d104b02900eeac124b31mr25972389plw.56.1620672219911; Mon, 10
 May 2021 11:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com> <CAMP44s3wagd6pk-YfnYV3QoRbZ5cRA0MBU4=Mdxerbdx80J7hw@mail.gmail.com>
In-Reply-To: <CAMP44s3wagd6pk-YfnYV3QoRbZ5cRA0MBU4=Mdxerbdx80J7hw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 10 May 2021 20:43:26 +0200
Message-ID: <CAN0heSrcZrfD60SJW9pJADwF8=SQ3Zw0KW1ZZvF4EPh82cNtPw@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 9 May 2021 at 20:46, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Are there some minimal requirements to say; this documentation was
> built correctly (as far as we know)? If so, maybe we can add a
> checker, or perhaps add a test under t/.

There's `make check-doc` which does some linting. But that's about
checking that there's a manpage at all for each builtin, that the doc
sources list sections in the right order, and such things. It doesn't
actually build the docs.

ci/test-documentation.sh runs `make check-doc` (see above), then goes on
to actually build the docs using both asciidoc and asciidoctor.  It
checks the exit status, but also that stderr is empty after filtering
out some expected, harmless output.

I think that's about the right balance. We could perhaps do something
under t/, but it probably shouldn't be to actually build the stuff. More
like, "oh, you've built the documentation -- let me sanity-check it for
you".  One way to detect that it makes sense to check it might be to see
if the Git version in the manpage footer(s) matches the version under
test. But I don't know what to check next.  (Actually, if we do find the
version number there, we have verified a fairly tricky piece of content
injection. At least "tricky" as in "we have more than one way of doing
it, because we support more than one toolchain" [1]. And if that stuff
broke, the test wouldn't notice, if we relied on detecting a version
match to even start testing...)

[1] See 7a30134358 ("asciidoctor-extensions: provide `<refmiscinfo/>`",
2019-09-16) and its parent commit.

Martin
