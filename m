Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90AEEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjFNP1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbjFNP1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:27:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7E2128
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:27:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so806477a12.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686756455; x=1689348455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBow89TKEsh/0WF6H1qdVHdSWdAnCPRO1eZTBfkp5O0=;
        b=NpkZa2MubiXTOKrK7CVEcsH08fIvBDCD5Wx7HAcqQcwGkj5MII8JYgF2uMktaS0s3/
         KT96uNNfHZ9Zafz1JjRb7y5xLVUSRjBS8DdowSuoCZO7yxKQLXdIDrsWS4lnJ4iWoVIj
         s2GUCNCL+IhwODR1qR2b5GeqxZ+ved3SNA2FggqliWCBq+dADQxSnJjHmR+oJSUJrA+L
         qIcthFMR0ZgIq5fMNrDMtJuq5jUoYTu6dG3Lf64F9p1K5d6v830+KsyQwD+toWlzu6UN
         u6Ui+4Tno7Do/6QgKuVkhvg5pT7Gcgu+kvhMyq8X49TiExhjFanWzPIko+Zjxs4BHT6j
         uFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756455; x=1689348455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBow89TKEsh/0WF6H1qdVHdSWdAnCPRO1eZTBfkp5O0=;
        b=cAGUOlK4HWSEmTBAqb5RN1L3Rm0cFxUZG3SIVUhCXE58Tl3r6C9e0B8UALfaYWkzTQ
         S4JZb0y1qdmsSAk1f9hKCmrfVfPK5rAFhN7waBP59tqYIA98Jmz/9LoXojswCDLHVFZQ
         xSTCpXdQEdnPQJ7HC2+NaR9rpbejwrC5uvxvyDANG8TAOO9iixqbNSlUPhA6c+ZxlEsn
         c0bs94mbirNvY/mKfybHiIkusHMUlSjchBTIWSoQrCWT3ivIGYwi8U1tKSCcx4pctW7c
         2AX8gg5VN9cnCnCdwGxJA7wuAW1bQn5cpOIqRraR4ZaZbEAtWrRQVYXWD6hieRLcgoLX
         zmEg==
X-Gm-Message-State: AC+VfDzwzsIoe4EwwJDeqptON6dsrRPgunl+dyU2FIDPh3fE7/gDVPb7
        ajsviW3ct6aWgWAdLDNRHGLCPz8HKjbnk80kQB8=
X-Google-Smtp-Source: ACHHUZ4B2SR6h4xPS2yg5rzwSWlIHLlp7HywVkY4K+ywCyaMjU6PlH+55IBnq9RqTU6AwG67TtCPElWL0L3LIRCqUyY=
X-Received: by 2002:a17:906:9c84:b0:973:c070:1b5f with SMTP id
 fj4-20020a1709069c8400b00973c0701b5fmr16270482ejc.44.1686756455133; Wed, 14
 Jun 2023 08:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <b13bd73d24885d65440e22202183bbec9deec1c5.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <b13bd73d24885d65440e22202183bbec9deec1c5.1686017304.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Jun 2023 17:27:22 +0200
Message-ID: <CAP8UFD3ikE8k7TJnX7wOt9K3JAhkh4chB3Gjp1B2tofU81xXWg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] doc: trailer: mention 'key' in DESCRIPTION
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2023 at 4:08=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> The 'key' option is used frequently in the examples at the bottom but
> there is no mention of it in the description.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git=
-interpret-trailers.txt
> index b034784e1d8..2e92640543c 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -48,7 +48,9 @@ token: value
>  ------------------------------------------------
>
>  This means that the trimmed <token> and <value> will be separated by
> -`': '` (one colon followed by one space).
> +`': '` (one colon followed by one space). If the <token> should have a d=
ifferent
> +string representation than itself, then the 'key' can be configured with
> +'trailer.<token>.key'.

I would rather say something like:

"A <token> can be a shortcut name, for example "sign", instead of the
full string, for example "Signed-off-by", which should appear before
the separator on the output. This can be configured using the
'trailer.<token>.key' configuration variable."
