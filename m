Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F3C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A96A610C8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEaLca (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaLc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 07:32:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928DC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:30:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k16so11570795ios.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NctcFs2gvfbesyusPII/GVNvNgByip7SR7b+0PFxSlM=;
        b=AvOPP/TfitlxfwklzrE+nebVhgakT6yUEv/08WmADKrmDBb5dOjFjpJyBxfOTBoURn
         doF4YjJEWIQncMZLO1eclHWlvz6t0NwTgFU67mCMgJDfWllorFJ7adaS43JHVG06SJSr
         Ji0jh37ihxFUhcGSHxvLQVXy4VIgkYDsH/T5FMuJTgoPS5jfGUGgs1vxykvqvXAggw5o
         tasckqRXCid33kV/nIEKshZSFeBel5qxxFAmf8HPiKVXtFf7hBajfBGySk1Vka4Nomsc
         L3TA6f71jMBMBeCAQu1H8lZu4kqvnA4AXjDACEJA/GA8soVfJwA6/wqSiXCi+29V2w6/
         t4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NctcFs2gvfbesyusPII/GVNvNgByip7SR7b+0PFxSlM=;
        b=s1M8kfzfYhS4lGFg4zQEWECnITU4mRS8tEQ74dL7uZ+xco4YYGMpkbDInyhj5PCCWP
         9GsoKrlafKRK5oxWbetm+VWmBwhWP//VtsDCsaRwGgHeRv5HRWiEOjOFw7CP6Zhg7FUW
         HjUb6vrxbJ6aJBnqUh3s9cXaughdnZiQmUBlV+t/zKD+eiwdRBj40zuTXIxREYIk6vak
         nvbK+m3QpdNhYllHkZ1pbwTAaCJyh+QRs1voF3xeq3qNYEYi+NCiQ3XOn8cxNYGxuvl3
         idl7j1ZzOPmp4Vi+iuqn75CUUThi5YfJ9xDzn7Nvu6HCw1Y7vEZMtphIo8Y8sEM8xPt1
         5C6w==
X-Gm-Message-State: AOAM5326WBURogNE9yDDzAyd33kIssR83UkfzyhWtKNA/Paw/jIrFZLf
        VoKfOPFmmNecauVrVXzQaCYM+D5/wakg9tUleY8=
X-Google-Smtp-Source: ABdhPJx3lHOFoYW+RlML4wVHJxnh0jtZ2e3cQm2CtzTGN4lnvoajuOkpuTEgCRqvU4UmozbdPrUlD/QyJYOhJEOlXjg=
X-Received: by 2002:a02:9a17:: with SMTP id b23mr764395jal.10.1622460648376;
 Mon, 31 May 2021 04:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SS8Wypho7eCCGH7LtOLwM6tWCzp8mGGEVASBC80MwJ5A@mail.gmail.com>
 <YLP7kuFNfVZK+xCK@coredump.intra.peff.net>
In-Reply-To: <YLP7kuFNfVZK+xCK@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 19:30:35 +0800
Message-ID: <CAOLTT8Rsy-XRys6fv3EbUJSUbHFCG4=w9uR7Bz8N8u8PWHgPhw@mail.gmail.com>
Subject: Re: [QUESTION] how to quickly find an oid in the git repository
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8A=E5=8D=884:54=E5=86=99=E9=81=93=EF=BC=9A

> > On the other hand, oid_object_info_extended() will parse an object
> > in depth, using it will seriously affect performance. So I want to know
> > if there is a function that can quickly find the oid? I searched in
> > `object-name.c`, `object-file.c`, and there seems to be no clue...
>
> You should be able to use oid_object_info_extended() here. It will try
> to do as little work as possible to fulfill the items requested in the
> object_info struct. So a blank one (or even passing NULL) will return an
> error if the object doesn't exist, but not otherwise.
>
> There's also has_object_file(), which is essentially a wrapper for this.
>

This is exactly what I want. It seems that the real performance problem
is not because of the use of oid_object_info_extended(), but the possible
copy of the object data in it.

> -Peff

Thanks!
--
ZheNing Hu
