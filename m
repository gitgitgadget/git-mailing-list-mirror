Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D63D1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 00:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAYAVI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 19:21:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37418 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAYAVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 19:21:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so6052985edb.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 16:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wWC3rX8K18SYuuEyqR0u5v89RN+Kn9m15wtwgHOMU4=;
        b=XDYE70A1pTlYMIBD2rhn7yxNpDl366hFEPp9JPDZbeXQHN+BTNPNCIWqlF68T18Ysk
         nZbzA0lbuXhc6nmt8Wj4lejZ+N5kRys40bRz3LTfUpjdztNQyxEI7ONrRQ+KWvFakh3g
         gUhvy1tUCDYoPBLff3IyIZb+NXOIu0FmVOT3qgY83iUyKPDP48qpK6F28IxCKaE4CDds
         iAAYOAu29D9tsG6OIJRNdcvWyAsipPW7LoS6pl9Uff2eKveVQqRAQ49NxKEkLKiCQY6J
         8LuQpNr4u4J/Il8JDX/BFqAfQDirUmYx1qRTbSuuIxKhULjv5vZLM1QKylBeuGevAuYZ
         Gssg==
X-Gm-Message-State: AJcUukeLdhKwsuX3G4OCCnj7DFpAR7pQVu1utQXsY4OiWKy8DXnok3Yq
        7F1cMXuLPhG9gFWFRFkme50jeZA69g==
X-Google-Smtp-Source: ALg8bN7TKs7F2hPKVrzTOeOW6FF7wl4PzRZhwkCzymaAnVHaKjFZXVMA4HKQ3PfZ2Bf7JYRySo+4dg==
X-Received: by 2002:a50:9226:: with SMTP id i35mr8782547eda.8.1548375666268;
        Thu, 24 Jan 2019 16:21:06 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id q50sm11194167edd.66.2019.01.24.16.21.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 16:21:05 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id p6so6088286eds.0
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 16:21:05 -0800 (PST)
X-Received: by 2002:a50:ec19:: with SMTP id g25mr8402615edr.38.1548375665312;
 Thu, 24 Jan 2019 16:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20190124010521.28452-1-phogg@novamoon.net> <20190124010521.28452-2-phogg@novamoon.net>
 <CACsJy8BDn-WBci72-DaAmc=SJsDnaiiN_rW+Yjb-1G1KFH7eCw@mail.gmail.com> <xmqq7eetj0ph.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eetj0ph.fsf@gitster-ct.c.googlers.com>
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Thu, 24 Jan 2019 19:20:27 -0500
X-Gmail-Original-Message-ID: <CAFOcBz=8gWeN7Zm346FAgwdAaMdbTk3zzRMx0LTm-OTQTkJx-Q@mail.gmail.com>
Message-ID: <CAFOcBz=8gWeN7Zm346FAgwdAaMdbTk3zzRMx0LTm-OTQTkJx-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pack-objects: merge read_lock and lock in
 packing_data struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 2:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Thu, Jan 24, 2019 at 8:06 AM Patrick Hogg <phogg@novamoon.net> wrote:
> >> diff --git a/pack-objects.h b/pack-objects.h
> >> index 0a038e3bc..dc869f26c 100644
> >> --- a/pack-objects.h
> >> +++ b/pack-objects.h
> >> @@ -146,7 +146,6 @@ struct packing_data {
> >>         struct packed_git **in_pack;
> >>
> >>         pthread_mutex_t lock;
> >> -       pthread_mutex_t read_lock;
> >
> > "lock" without any comments in this struct, to me, implies that it
> > protects access to this struct alone. But since you're using it as
> > "read lock" (aka access to object database), I think you should add a
> > comment here clarify the new role of "lock" variable.
>
> Sounds sensible.  How about squashing something like this in?
>
> Some older part of this file still tries to hide the reliance on the
> global variable "to_pack", but newer code refers to it already, and
> I think it no longer is buying us much.
>
>  [snip]

Sounds good to me, I'm going to shamelessly use exactly that
(with a Thanks-to:) as I have no better suggestions for comments.

Thanks all for the support in my first ever git.git patch!
