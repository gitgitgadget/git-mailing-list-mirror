Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABAC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869A020659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHqgGYgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390640AbgEMTsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTsd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:48:33 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE5C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:48:31 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s85so150384vks.11
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHNMhwptvNzSZBuXX8x/wcTssZX6fmJ4K1dLg0I/Jow=;
        b=BHqgGYgja8IWEY80tp7JKDYhgRuyKgS23is74blQNb5LNCLwTJJjOuqDHEbe0WFTOu
         mg76WsK98q2+S4YKFc756k1g21c8DH24TH13kqfYf6q8J8Ws/lcH6WeLsBUb2FHJTBsk
         hzqaE5bSGL6PyVnCWZVbK7Uwx3kDQvPDWSJ6dOdT4FfQZqgH9xMxj0NbEDrBcvH0KglD
         oWkWYARq9KmIZvGXXhBD9rD62pphtKFVshd9ryBNfVvg7UazINY78OGUdt8WwdnEmDNZ
         h2C1PkKQB0fQb0nXkmIHlqOjp4dkd3KvsaLxXDpnhp2ogVW+MsOOqNxqW2IHOso0p66j
         kwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHNMhwptvNzSZBuXX8x/wcTssZX6fmJ4K1dLg0I/Jow=;
        b=bIr4ZwxKk36pyZFNeReZLyl97BbDHS4duQQV0d32O02xFaD4fzP+bLoulH9cZko7xs
         wdP6eFWCJU/kBUnrngk+q/Oai8p/X6duK+05scXf9co5FudUpnNwG14N10YYobkGQWAK
         7CKrpXCDOO3TjOMYk8HC9ONa7ApMlcFeQkMoksMOhVgLh+go3Af/wMu4PzaGnUtbRnzP
         RkXaHW74uVQHO+ha1PCjfpAlGrZXa7OkSF1RS4J1wYQfkpdJ8KsM9rUTE2Nun3ljTm6t
         um5HU230S0uqZExOCsn0rfm1HkjLPbbR7JmCcg0GWjY+6fDg7cj7FRIXGRm9uRVwvCIV
         ssKQ==
X-Gm-Message-State: AOAM531izAaiSfvTHAio+ggYRO5sEj/169dSqA+XQNlOwK49tPp12BgH
        ANzdLiE54UG2wOeqKWFWpYGf/PtbOIQQMn8eOKk=
X-Google-Smtp-Source: ABdhPJyC/7b3eEps7FqQC+pkGRmBzu70CqRdMpOc0DzkILCLcwWybxgzdEtQs3RIeYGZL0ch1NCWJc8ZkeLlaTz12qI=
X-Received: by 2002:a1f:9e17:: with SMTP id h23mr785572vke.57.1589399310951;
 Wed, 13 May 2020 12:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-13-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-13-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:48:20 +0200
Message-ID: <CAN0heSrS+xMqhcUTZjhzq_EX0Zwm-PO9Yu6ue3q9dc_Z1VF3tQ@mail.gmail.com>
Subject: Re: [PATCH 12/44] connect: make parse_feature_value extern
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We're going to be using this function in other files, so no longer mark
> this function static.
>
>  static char *server_capabilities_v1;
>  static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
> -static const char *parse_feature_value(const char *, const char *, int *, int *);
>  static const char *next_server_feature_value(const char *feature, int *len, int *offset);

> -static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
> +const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
>  {

> --- a/connect.h
> +++ b/connect.h
> +const char *parse_feature_value(const char *, const char *, int *, int *);

This "char *, int *" comes from the forward-declaration above, which is
now dropped. Now that this is a header file for everyone to use, I think
these parameters should be named, at least, but even better would be
some documentation. ;-)

I'll stop reading here. I'm not familiar with the technical details here
(i.e., where you'd be most interested in review), so I've just left some
more or less superficial comments.

One thing I've noticed is that there are relatively few tests so far. I
suppose it could be hard to trigger things before everything is properly
plugged through. But maybe at least various error paths could be
exercised already at this point, such as in the previous patch I
commented on.

So far I feel like I'm following along ok and I have a feeling I know
where this is leading up to. Nicely done so far.


Martin
