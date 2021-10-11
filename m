Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E8C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E82260C41
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 22:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJKWqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJKWqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 18:46:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D48C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 15:44:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id n65so42370902ybb.7
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tF5/6AdBIriAgUn1uxIjabWLWhP32a/X7ct65539LU=;
        b=WEadiOnwyDbJWH60wrSqvfq8Hg3DQCXAH1laBPs+HY0KSWUE744UZ5McPLteeKSBN8
         aKhZAnh6vUrquDCWS46cnJrq1TD6HG2eihhjTEkoNHW06NtC8K9hYdP1iZcwdtf61aOO
         VxB9fmomsfd0DIY6eZJ8CNkmiciqLKy8CBhQroPOHDZomXhQi2B5LgIFev0nf+/v6vBW
         MVbcJYiVvJYJVgWN9f6nRZjPG1zjNOvMoNgeC9ePo78yDLPqPXCAiEfT4tVp5FRXqWZd
         lJPSbv97tYcFYTQrmez61P9ru+LhgLJFAdccqZ4k4QRNbej/8beFy1TJkLNWtsSooek/
         dgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tF5/6AdBIriAgUn1uxIjabWLWhP32a/X7ct65539LU=;
        b=ZNxAIhp/NNuQLhHHQnIavXxLS8OD+ZEKi8vFrMmwMP6k1V284W5RwTJUejm8Wy28TH
         2z9OoUmVbKB6lxNtC5CQHyxi3Au90TsGSTxBfs144OWolakA5VD3t+0kQXPbXJ+IO4hZ
         nLklGjZ5jngcDpPdkLz/yb8sFw7ZyAbWk8It2ir1J+iU/p+48H0j7VvNWdQ5eIfvjnah
         oi41V/l1aqR0o4KJ/VE7YsJefjy0pX8ivMnxW6j/euGBU+io2lfmSaQkI3KTgEC2cgCT
         hfis8v1ra2opHxVwF4VxxjUJefu2vpsh3XFL1x2QimHxf1TCSHMwF5I/2BmArqi1B4+D
         onQw==
X-Gm-Message-State: AOAM532TGz1+ml3ywMsjD534e6yJCpCewnxGm7R4RxdiKhbJNeV1rRoS
        /LPmY7TxGE6cPsbnGPlNpqvLlyf9o9HhWAVtAaMpivXLWl4=
X-Google-Smtp-Source: ABdhPJxwU5T6hFhlHsv+IIJx+Tp0YHIDAqeL7GJvNpetxywfCptR+GTNdVakzS2HD+n5ydGPofbd+FYMV7AZx4TEdwI=
X-Received: by 2002:a25:d856:: with SMTP id p83mr26207939ybg.269.1633992250252;
 Mon, 11 Oct 2021 15:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
 <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com> <afd8890e-0042-8fc6-523d-f69aa6ed7af3@zoho.com>
 <CAP8UFD0TBOkNU2g_OqpMiQyopBfae95nBwJQJ8F04+C1FcBRYQ@mail.gmail.com> <64c7dd07-495d-7efe-f4aa-7ea91830c783@zoho.com>
In-Reply-To: <64c7dd07-495d-7efe-f4aa-7ea91830c783@zoho.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Oct 2021 00:43:59 +0200
Message-ID: <CAP8UFD3Qbvz3Gj1M2VqtsdAK=ucZ_FgC5RV284yX=7Y6xh_E6g@mail.gmail.com>
Subject: Re: I just want the revision
To:     ToddAndMargo <ToddAndMargo@zoho.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 11:52 PM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>
> On 10/11/21 06:13, Christian Couder wrote:

> > If I needed more information than just the commit ID, I would use the
> > GitLab API, especially:
> >
> > https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit
> >
> > So you might want to customize this example command:
> >
> > $ curl --header "PRIVATE-TOKEN: <your_access_token>"
> > "https://gitlab.example.com/api/v4/projects/5/repository/commits/master"
> >
>
> no idea what the " <your_access_token>" is.

This is a mailing list about Git, not GitLab or other service
providers, so I don't want to go into too many details here. As I
already explained you should look at the docs for more details.
Alternatively you can google it or ask in a GitLab forum or to GitLab
support if you have paid for that.
