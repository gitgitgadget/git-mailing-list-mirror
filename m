Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A99C33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 07:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FEA24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 07:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJUlyHAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAUHFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:05:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42449 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 02:05:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so1924863edv.9
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7KJeaTzz593Hfmt4Dn7P8uaXI8jGjQDDwXB8s9INjM=;
        b=KJUlyHAeIzQVgve8tukWafj0LVaJoixPQ3fs+LDyR7VoMS50fDFaUd8693HKeeH9Nf
         Zi9T/XH7IheLPMix7uj3NiEP1ibXb8srBNfO495dR4Y2xww/YWc5mSCe29KRSHEEP6zD
         i9Ij9JaeryRxe9Nz9cP1IM606uaSyKHlfFphSTCMgV3rKgc1QAq/YxS5VcMtHteAjfKW
         qJjaBMxAoNyWt/i5iz1+l2w5k4CeAcIYlxomTS7eG7tsVxsYqcFnvTcASRCcWAM9KbUN
         Ua/CXMLvSBU+KI3TzhH4QCE9G9QsMkgRLVkHcz0AC7HzdA3YtZCVoTRVypIUXTM8wzNf
         lWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7KJeaTzz593Hfmt4Dn7P8uaXI8jGjQDDwXB8s9INjM=;
        b=ctLp1p3d6OSO7KwgIFBjT0gZTAjveRjDXkuF3LGAUh+Sr3zJyfDEQOKu0A0pzOUIzA
         DqF5kthh0Sw19FdyndMNZBAWgQ8qgArdrPcm2TcXnMio/sqVrZb7nRQvYEruRPAhLENT
         VX4Pjxig2ypfs/Z7uZe2sTcTDei5li5JogptTWj4Tzg3LXLqSoiRCIn+sNw7RS+02TxP
         CogdsAW9aFbxO723DxvhJ3VWlRmPGRkUk8E8AfMaa4MdsW4dmOleyI8pTl6W5G+kUTeK
         cEVpbwVWU6o1R759rFq13nWWp4VY1w77SP2CiB29kMMPDszC5jcnWBYtlaq1u+SL5crO
         6Iqw==
X-Gm-Message-State: APjAAAWFeAUbraxJuLw2GB0YzMRLDAc3vvCuFKE7OJXjZVjAhJwJRbqC
        /uTbKy0GjvyixsY4rx/ebAKmIEJiYo5+9/YUuh4=
X-Google-Smtp-Source: APXvYqwiSKUniq0gLrf/kxl0e3UZuvcxq5jQmFufKE3FTIH6R+KbnqNA56ehdxMSUDtDk7bk0DPJ8zdyHPlGHs2aWZk=
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr3030608ejb.320.1579590345762;
 Mon, 20 Jan 2020 23:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-11-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202321210.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202321210.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Jan 2020 08:05:34 +0100
Message-ID: <CAP8UFD0TU9FQQfk6SgDtOi+_eDni0ZJf+Bw-uN_LzAdeVh3HvQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] bisect: libify `handle_bad_merge_base` and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 11:23 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> > @@ -777,14 +777,14 @@ static void handle_bad_merge_base(void)
> >                               "between %s and [%s].\n"),
> >                               bad_hex, term_bad, term_good, bad_hex, good_hex);
> >               }
> > -             exit(3);
> > +             return -3;
>
> ... which is: what does `3` stand for?

Maybe the question should have been answered by adding a comment to
the previous patch that added the `exit(3)` statement.

So yeah we could here add a separate patch that just adds such a comment.

Or maybe we can add such a comment in this patch and say something
like "while at it let's explain a bit the '3' error code" in the
commit message.
