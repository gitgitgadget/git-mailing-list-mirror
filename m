Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2951C4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFFD613BC
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFGAtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:49:47 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44819 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFGAtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 20:49:46 -0400
Received: by mail-io1-f44.google.com with SMTP id v9so16529763ion.11
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yducw9Karg6ibIgniRWjM0E6GoNPDDEOW0IXGHi3qUI=;
        b=MWP1Bqv3lRFoIdbxyGHhZSVgFnqcgY6W6MsNJLgNkFPLfszncuLW4M5oYD4EU3ZYOv
         QlAvlVeyHZhVQoWdR52BhQFHT1mdpaxkQPZhhOAUQJj/N8X97g791wbtJNm4yRN6jwWK
         ziVRDrnqNiu1Xtp2OiPHKjKBNqpcBHTx3AVMphJtxWhBN8/R/KhNJYTq1AtKgMtyxWAX
         f0WuGh3J+azjjO9SMVCndoG6LsIrI+Zauo0/cg0BptjIuoeSmh617i4XTqYOK1WFFuxy
         syHe53owF5GbqXv0jAYfsfDLe2MC0GoCeLlqxvyimnw6C/l7SmqqDRkzDm4IS69/IwJj
         Ie8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yducw9Karg6ibIgniRWjM0E6GoNPDDEOW0IXGHi3qUI=;
        b=qZ4n08egLGTCP7BRoC8SGOSuWd3D8yfwk9S6uTUCy8uvzi0My8/ays/9hNZ9XL6tT8
         /UFuLEsLI/Zzs92/x1banMJbIMz5BFSOTJ2pZuHGpArspXNQtiVhQMcTeHTYcSSLXTMb
         3777/RmHqpuJJsVfAvpiG5aUyPlhtY0BjyRt8igSu64Rx3aMdn72yaRSFjhdNRRjW4SR
         RSW5YbW5aHfeprMfsyk/WfWbhj6Y7ayG2u8qpb7rgkZjeH1eWzJ+ySIdDrEACLag/Puo
         GtbnboFFfRcqX86LE4miVPRAH3goBEMTH/GRzCLFUgZwjl5ZACagtmRa7kTkPsJCbbI2
         s1/w==
X-Gm-Message-State: AOAM531pcx8Dnlco2Pig2QjiO0tZk+zk1dWi+DcnS4Smcf9zBvQm7aZE
        bUpsiv8i+9436BaMP/yzRSp54VDrWxWR+5WuPGk=
X-Google-Smtp-Source: ABdhPJwqM6Aqsc1tyoZ/4GLqcPLn/oTxegHkJd40RslVfENpIfi5SEPmNIlvx/ZiT8lCx13KNY4VYRHsItuHvNRNLxg=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr12504174iog.24.1623026802652;
 Sun, 06 Jun 2021 17:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 6 Jun 2021 17:46:06 -0700
Message-ID: <CAJDDKr4Wm2FQ-kq8k8EU6wE20V6ghuKDrzC5PcsZ6We0bMz3uQ@mail.gmail.com>
Subject: Re: [PATCH v2 try2 0/4] completion: bash: a bunch of fixes
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 6, 2021 at 11:51 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> These should be pretty obvious and straightforward.
>
> This is the second time I'm sending this exact series, and the seventh ti=
me in almost
> exactly the same form.
>
> The previous version was still applying without conflicts to master, and =
so does this one.
>
>  * https://lore.kernel.org/git/xmqqv9cavcc5.fsf@gitster.c.googlers.com/
>  * https://lore.kernel.org/git/6094a335c22dc_8ee520860@natae.notmuch/
>
> Felipe Contreras (4):
>   completion: bash: fix prefix detection in branch.*
>   completion: bash: fix for suboptions with value
>   completion: bash: fix for multiple dash commands
>   completion: bash: add correct suffix in variables
>
>  contrib/completion/git-completion.bash | 14 +++++++-------
>  t/t9902-completion.sh                  | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> Range-diff:
> 1:  dd49b0e680 ! 1:  52de92cb06 completion: bash: fix prefix detection in=
 branch.*
>     @@ Commit message
>
>            git clone --config=3Dbranch.<tab>
>
>     +    Reviewed-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>          Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
>       ## contrib/completion/git-completion.bash ##
> 2:  6ac184b9a4 =3D 2:  af2f17364d completion: bash: fix for suboptions wi=
th value
> 3:  960a692fda =3D 3:  a3bcb70594 completion: bash: fix for multiple dash=
 commands
> 4:  a95c3edaf9 =3D 4:  6b3ef41c92 completion: bash: add correct suffix in=
 variables
> --
> 2.31.1.2.g0532ba4bf6
>

I tested this series on:
- GNU bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
- GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)
- zsh 5.0.2 (x86_64-redhat-linux-gnu)
- zsh 5.7.1 (x86_64-apple-darwin19.0)
and can confirm that it is an improvement.

FWIW,
Tested-by: David Aguilar <davvid@gmail.com>

cheers,
--=20
David
