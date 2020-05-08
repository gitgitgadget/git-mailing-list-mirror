Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF16C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3742184D
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/HHHa/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHSAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726746AbgEHSAk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 14:00:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24FC061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 11:00:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f12so1927067edn.12
        for <git@vger.kernel.org>; Fri, 08 May 2020 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i9aS+9qTf0x4dyCBJ0aq5UrweZ/GxN25YEVcIdDSwU=;
        b=J/HHHa/2gHf7ngx6jeSFILvVO8cedBjQ+5YiKXxzms/abfPugpu8EHhert9ipNPNpc
         mV67OoJ/rxMEfLgtjQyWMJsCzqz2IsdxeYbfOkoM4pv9WVpHS2FvbQNeNMcT6MqQt//h
         hX+TRSaz+9eqsGPyUmci/7zaBeA2TmgToNZ5Y5wDfQaxI8oZmykj8P7lwTFh1KBduJQR
         CPN07V4P1JBoHcm1zAHPAGzb2kMqXtq2nd0dcvzQhSzGUEkQrSCiFEl7vU+s3L79TC0e
         GW0wYcBsH6tDL2LiHt7rH7VsF2B/OCfszW8m1J3ZN4OR0eCqXk8QKvB9OJjU+LTRemdF
         zHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i9aS+9qTf0x4dyCBJ0aq5UrweZ/GxN25YEVcIdDSwU=;
        b=tNnI9c0SlbnOX7+euk5gxxNZ/s29Kq5qpGUHougIEe7z7jCaBfdzZzhP/IPAKduL8n
         i5bQAfRK+zJ6/2e9WD+mAwKqkffUnl/xJZUgQEBC4gBdxiUiQiO/tRnTgEfTtI88fh9P
         ie8JqMtSIY3rE3TTiKIKD2kXVu+WnjewDZXy1GL9QZBe0nRjuDx2vh1nKYevXiHMlVmb
         dh3dk0iurje3w8vm0XoJYdnMIob8I+0PwCCHfHpumuYfnNREntmAuYBD7Bx4ForacxSI
         eVmErBmiZfuUsWdE34Gw02v0ML5VEJCio4yKubmVoTxXwVNS+V14crd68GWoSYe8J4wD
         BQ1g==
X-Gm-Message-State: AGi0PuZjvj4Rf5yWDFaId3dXEBrQm/qr5NgBFfLBwFLZPPiNKePMxmZ8
        jQetJd/99SBnvkrWijg5YjGhIATAs3BVb0a3GxA=
X-Google-Smtp-Source: APiQypJMrYqKXoTwV3AMMTdcIDBXDd1CnjGd1dCvgR4JaSMJopqy4XHSE7akjTjBmQxWML3lzFzK4sMc3syMpB1f0I8=
X-Received: by 2002:aa7:cc88:: with SMTP id p8mr3237257edt.387.1588960839309;
 Fri, 08 May 2020 11:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
 <20200508080115.15616-1-chriscool@tuxfamily.org> <20200508130616.GA631018@coredump.intra.peff.net>
 <xmqqtv0qzax9.fsf@gitster.c.googlers.com> <20200508171635.GB637136@coredump.intra.peff.net>
In-Reply-To: <20200508171635.GB637136@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 May 2020 20:00:27 +0200
Message-ID: <CAP8UFD2-8FwEjyHromp-=MSSeFo=mn9GhkPvtFnF9MRx-4cjPQ@mail.gmail.com>
Subject: Re: [PATCH v2] upload-pack: fix filter options scope
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 7:16 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 08, 2020 at 08:46:58AM -0700, Junio C Hamano wrote:

> > Is it that the server side was incapable of serving a follow-up
> > fetch request in the same process when protocol v2 was in use?
> > Perhaps
> >
> >     upload-pack: allow follow-up fetch in protocol v2
> >
> > or something?
>
> Yeah, I agree that's better. Maybe even:
>
>   upload-pack: clear filter_options for each v2 fetch command

Ok, I will resend soon with the above title.

> which is more direct (we already allow follow-up fetches; they just
> don't work sometimes) and makes it clear that this is about fixing the
> filter feature with v2.

Thanks,
Christian.
