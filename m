Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C453CC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E17601FF
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCUDab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUD37 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 23:29:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D07C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 20:29:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so12197956otb.7
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UsG76foYInuHiAuWmDQg586mI7NNBtKWw5RKB+cR7JY=;
        b=S+1Itu4eHQS6ODvoqjB2BzKB2k0GcHSqgiB1s7l7s0VIHpB9nVH/9SUnKfK07682P6
         5B2WKWbV2y/QNUSLlN9OB7ayStXRW/AUJlie1MFhqkufLgdfWBlEYSP8oRcYVWR2FfXt
         tLbtcjNE2KQ04ge8cd0oqImCIiRqo03x9Igvp8hfx+Yjic5Niic48MTDVBWufvrOXQeY
         RjvoAjHMk8LsXCa2W1TUSuFzMCKb3Y/v0W6B1exEBVRVTLvSf3njwQefyOajPqKBZR2m
         FmZjExE3mofhY/N9wfO2ibH4WSclq8+UYUoOPD4kBKCoOkt7q28LLrbWxyudHxhC9HrN
         4D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UsG76foYInuHiAuWmDQg586mI7NNBtKWw5RKB+cR7JY=;
        b=UAzICZmGptlb31M6M5Jl2tLfCW1TgHp4XE228XAnQrHRnWjKVjdLO+5qoVTvgoXO6l
         lz3ug2U1CUK0Id814hUQYaN2uCKOH5RUlcJBTrrv8jGtRDEsUndCd3uTQh/Cb+8G1VsK
         N7K5Zk4+fgIQyz48iPeS5mVw5DacUz0R9gfPcWGGO/VxPBejfGSfeT/uFdDuJKO/D0h6
         vI2kulisikcdDHkZs3Tcb4gXkJ/Rdsp22vmwuQPxsqq1iz3474DLq2DWuyokarvfcUF8
         8iQ5FHvPqFFBbHvGaluS6cepzLXfLBseuRU4z1e/5wrcTizBFRR8sTES2wBNDtrI7Cba
         pL9Q==
X-Gm-Message-State: AOAM530wY1650u1Zy3li3nvr09FcL6sdIKXYqDdOhhwvukIE7R/1Yfzn
        i1CGdfNW2QeVxBZKm+wgoRoFxfl8NV8Iqll+V2M=
X-Google-Smtp-Source: ABdhPJzPN5YpMWFLzpSYgyKcYoWwNz/QsUgUbyN3OIeTVGjrKTQ2W6R8VUEwLXmNw2vyvH0EN6Huh1NyOZ0TBtUfP8A=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr6456483otq.160.1616297398003;
 Sat, 20 Mar 2021 20:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <ca521d3c01d652e09e716fb447b0b26da1a014e8.1616251299.git.gitgitgadget@gmail.com>
 <xmqqft0pk018.fsf@gitster.g>
In-Reply-To: <xmqqft0pk018.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 11:29:46 +0800
Message-ID: <CAOLTT8Q7yNscYrYHWJQcsGn67MjWe15nd7SnCEd5QVUG0A6dRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8821=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:06=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/commit.h b/commit.h
> > index 49c0f503964e..970a73ccd5be 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -371,4 +371,6 @@ int parse_buffer_signed_by_header(const char *buffe=
r,
> >                                 struct strbuf *signature,
> >                                 const struct git_hash_algo *algop);
> >
> > +const char *find_author_by_nickname(const char *name);
> > +
> >  #endif /* COMMIT_H */
>
> As I already said, we do not want to pretend that this is a
> generally reusable helper function.  We should at least have a
> comment to tell people to never add new callers to this function,
> with explanation of the reason.

Do you think this is appropriate?

@@ -370,5 +370,15 @@ int parse_buffer_signed_by_header(const char *buffer,
                                  struct strbuf *payload,
                                  struct strbuf *signature,
                                  const struct git_hash_algo *algop);
+/*
+ * Calling `find_author_by_nickname` to find the "author <email>" pair
+ * in the most recent commit which matches "--author=3Dname".
+ *
+ * Note that `find_author_by_nickname` is not reusable, because it haven't
+ * reset flags for parsed objects. The only safe way to use
`find_author_by_nickname`
+ * (without rewriting the revision traversal machinery) is to spawn a
+ * subprocess and do find_author_by_nickname() in it.
+ */
+const char *find_author_by_nickname(const char *name);

Thanks.
