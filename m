Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EAEB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 06:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFUGbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFUGbE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 02:31:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C41A3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:31:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a4088c4ebso5397281a12.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687329061; x=1689921061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xIjZ2181M/0eMiOgzHKTE46BHvkfM3aZ4cXW9g1NMfg=;
        b=YAb9txI9i8HO6kE+qnaEmcLb15ebtWYDRbE8mzXUgSd5Lh7Dy/c0AFVbGuJFzaqwCM
         zT10uNp71X3emdXOqzyamRqkQVaB9bWgQEhG2HQygWTUO2HE+U6lz33QstwAIc8pu08C
         ZjbdYDFIVQhmCwHROzWNFXsy6xJa12nVpuiUe9daam0YNsT/3//ZjayCkwMsktNQXETU
         EsATD9liplvVWKJSAUKOFu4tlMeOVM6DUp1bWdi4iTkbcYlU7am1LuO4caqSI+KTjJkI
         7JVIx4CUAvVIgs4hBRGjtcUzkKYjPIvKImTJsLcKTrJPNVukBP3bTct4g3a1uFwUYzm8
         J98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329061; x=1689921061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIjZ2181M/0eMiOgzHKTE46BHvkfM3aZ4cXW9g1NMfg=;
        b=ioIqoeKwI63ifLYwtQu0x9m6HYvN9bwsBExjpaAuT3YI974XPzULaytIlj993r8xJK
         R5N2tm3yC/O6U+a/RNsibvwNonWpzfpqXsC7deQ/kORg/apNOUQ0OXpiN5LPaBPRP1vU
         SylzYgukvV7JxjvKZS0QMJ7tyLvIFjPJH1YW1GuxuA0ajqIeNbPHGJPSAbXDUTG546q0
         3Xg82iA6Ia8MmoAhsJJLMQ46okFeZwb8c29ZNyPFtozsQTRBLWB0bfy/zUYcqIVGEFyJ
         DHohrbetqQHeWzc+3CfLLfSsj93ToaPIqpDXgqjITBjQbO/2Y6g1O6PQFaZmPR1au+HJ
         TXQA==
X-Gm-Message-State: AC+VfDz8GrvytHl316vM07LYVOYGcbDNwi0cTjuyeikUk8kdZp6fkEA0
        xYR2g/LZyMMdfvTdkPCH02nPviw1PApmThSozB4=
X-Google-Smtp-Source: ACHHUZ7Mj6nda6o+IEpjPlRF9tFYHCHouK5aC7Nh5Mj/xP3yef9a3Ouo+tVBJxfjGd4qd4GArFVzB3uofStp1UhhI5o=
X-Received: by 2002:a05:6402:783:b0:51a:3df4:569a with SMTP id
 d3-20020a056402078300b0051a3df4569amr8990344edy.26.1687329060776; Tue, 20 Jun
 2023 23:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
 <xmqqh6rc72k8.fsf@gitster.g>
In-Reply-To: <xmqqh6rc72k8.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 21 Jun 2023 07:30:24 +0100
Message-ID: <CAGJzqsnU9HOCWOOaMdUcNzSDWg6wUqK0bhNvtNAv82yeCkHwgQ@mail.gmail.com>
Subject: Re: Remembering which http remotes require authentication
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Jun 2023 at 23:12, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Could Git remember which remotes require authentication for which
> > operations?
>
> Interesting idea.
>
> Credential helpers may know which URL needed authentication before,
> but that is not per operation.  I wonder if it is sufficient as the
> zeroth approximation to always try authenticated access if helpers
> have any auth material to the URL regardless of the operation?

The simplicity appeals. A challenge is that `helper get` may be slow
or even block requiring user interaction (to unlock a keyring or
complete OAuth). A solution could be to introduce a new action
`get-existing` or `fast-get` to the helper protocol. Storage helpers
would handle this similarly to `get` (unless a keyring is locked).
Credential-generating helpers would refrain from generating fresh
credentials.

However as Brian pointed out, Git doesn't know which authentication
scheme to use until it sees the WWW-Authenticate header in the
response from the initial unauthenticated request, so I think
config or state would be necessary.



>
> There needs a way to force unautheticated access if we were to do
> anything of that sort, of course.
>
>
>
