Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B97C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB0264F62
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCLNXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 08:23:05 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA7C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 05:23:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so1374463otk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 05:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/EEkdoDn8GTI3UnUYmqFMwdtLSo5egGbeG47bguMf1Y=;
        b=ngxQ8+/H5XzM4hsveF/oNK7yAhcoKnSEjy9uoolfowBH13fR6x8iP6fAwQUSKOmJ9y
         RZjsQJuWydOqCS0fMphYJlPnv32gY5gt2YhbnDls0kB0byJj4pfncbqo0jj7jlP8sO9Z
         jq0GiaA9hswBEgHFaZGpm4u6dmlV41yd6aKalyKtH3OfRX0A3tiNwdcsEjv3ergpkM7V
         feiY5hnqtiKmKLKOp0vYZC34ccaAPOp9QnFD3aJHuvRIFxnmqHRIyvnhc+kJJXIM2eqD
         5YDvl1ZooFtTzrKdHTLMexpFbOikN0cKvkwB7+Dmn5sDXaZ2W2PnAFH88izN2B6ZGeN0
         Ujmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/EEkdoDn8GTI3UnUYmqFMwdtLSo5egGbeG47bguMf1Y=;
        b=KQhuzQsw5R9eaiSdZZZPyJLGnu88qwed2m+beHIekuOXyBD1dhh0BsHr+c5IxHtynI
         oytupsW4LXS4/88m+DtZzumLc2nLfpSksk4ioOZJ/VN0f1j08u97FnA0YERFACjTPD7C
         wLETVgrDSjbMZgOkcTBqQJBkE7raggxw7NT0PciJFDZ1OhN/X11QoalXo0zTKgjj1uY1
         HHkfwMGsrYn5FnZIA9LuqlisJB2ZPYPbIh0Sqe5kPAQxP8AwA6J9y0szmo86FMh+KHtm
         qGhjP/V+T5E02hspdr3yP3F9UrpCVFm0GUf4bKWyoDB2vSlskNli1N4kXylqHHyEjVUZ
         rwiw==
X-Gm-Message-State: AOAM533Zskqvp+RQLbuBli9hOf7JBC9Ey7YcnBGSQOqZDU1j6zdvQCmz
        6lUaPqexF6EQZggM4pZcQAdFdkjv55KECZEm7uk=
X-Google-Smtp-Source: ABdhPJxmYXazgJYQjen15PUjsitvKCH/wkchwKOfgnace8y7FujFg+9hS2wXCMTBdc8f6AKjcSw5ut+IE6Hu2iWyRLA=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr3326782ota.164.1615555384838;
 Fri, 12 Mar 2021 05:23:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com> <xmqq1rclfvl0.fsf@gitster.g>
In-Reply-To: <xmqq1rclfvl0.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 12 Mar 2021 21:22:52 +0800
Message-ID: <CAOLTT8TB3Ko7qEfDaE2xSxjB8LJ7GR1R9innBkstCxRr5QpLoQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] commit: provides multiple common signatures
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=93=EF=BC=9A
> Firm NAK.
>
> Especially, not in this form that squats on short-and-sweet single
> letter option names only to support the convention of this single
> project (namely, Git).
>
> cf. https://lore.kernel.org/git/20200824061156.1929850-1-espeer@gmail.com=
/
>
> Thanks.

Now I understand that We have a git command now:

`git interpret-trailers --in-place --where=3Dend \
./a.txt --trailer "Signed-off-by:adl <adlternative@gmail.com> " `
can add the trailers to specified file, so now maybe I only
need to provide `--trailer` for commit, right?
