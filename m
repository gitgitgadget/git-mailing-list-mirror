Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DD61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeGQSc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:32:28 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34423 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbeGQSc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:32:28 -0400
Received: by mail-yw0-f196.google.com with SMTP id j68-v6so711084ywg.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PDxu3lQwhQA+wvoG6chmozBIbpkDzraaAViit0JxIek=;
        b=JSPFMq7hrQhYUKyIYSrDqwsnikVOLrB4vUf2kGUdvI/qt+WcwpND01rugU8GzLtD4C
         zx/R/oMEqF6qbvN6h8qx+qgrNlLMW1QN1CBKaWrB3iujMWWl1E8uRMbl0/JBLZCTupkF
         8iz54nRblu1ic2wM1enx/HalaI5nYHP9D3kmMqlwcWhHSPSNB0Xrf3XPYp2YufLh2mK5
         wkgK/G4v1DE24LhlGAzP+5PTYcK8NWzCURFgne/drWWB0XJ8CBn4YFZk0wXHSsTUaPab
         s7hoOhk1+BQollPL981XvI3MCaXjSA/KR4x7bud5tyzOg7YCYOJMi29Ovuo+KJy+8z+f
         sSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PDxu3lQwhQA+wvoG6chmozBIbpkDzraaAViit0JxIek=;
        b=ITDf+j6ktok2Hm57Rj1GtE7JRtknJTWlzeG06kJuBEVRmR3a07X4dsVjaml9UATHLo
         dsAlbQzFs0OnBxgxGbhrYUGdCpFfe6YCCUc8vHQgJ41m0wwm+iaXB4XyPJDBr9LbH0EV
         9mfsz4iDo2nTM3WuqqVPJ525hrhjI9a+/1oh8cbkTGKVePPYslDu5gHLGIudykYyFnvY
         8QHuia51P0MUDe8X6OeDzBaK0qiltkosZu3eOPH+hPVu9nvXO1KlmC8ibNmFJFjCVvyS
         d86yUZ42xKgCZuCqdcAiJg8sOElyXmWASX18z9M2gXsIB+zFB/M+U8g82swJLVnBb0C8
         wRuQ==
X-Gm-Message-State: AOUpUlHzJPwFlWCa0Vk/2ekSH49GTw5pxLIYEhT3ZuP13V60sgEEAdbe
        7YV9N9xos5JyOmSij6h6qJGidxcvhLBQQul9D//2kQ==
X-Google-Smtp-Source: AAOMgpcSwlJxS8r5+wuylcLUCDHDOxqAAirqUvZG+Tev7q0BkaDY3HTp8t9wTB74YD1K/S044lOWtw8x23lx3ablP0Q=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr1428599ywd.421.1531850321143;
 Tue, 17 Jul 2018 10:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180717091429.GA31043@sigkill.com> <87bmb6chvm.fsf@evledraar.gmail.com>
In-Reply-To: <87bmb6chvm.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jul 2018 10:58:30 -0700
Message-ID: <CAGZ79kbJkocY0oe2_efEA3s0dGgR4tnvwpvUTNuJuSSYY=MazQ@mail.gmail.com>
Subject: Re: Are clone/checkout operations deterministic?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <peartben@gmail.com>
Cc:     preed@sigkill.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 2:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jul 17 2018, J. Paul Reed wrote:
>
> > Hey Git Devs,
> >
> > I have a bit of an odd question: do git clone/checkout operations have =
a
> > deterministic ordering?
> >
> > That is: are files guaranteed to be laid down onto disk in any specific
> > (and deterministic) order as a clone and/or checkout operations occurs?
> > (And if so, is it alphabetical order? Depth-first? Something else?)
> >
> > In case the answer is different (and I'd guess that it might be?), I'm
> > mostly interested in the initial clone case... but it would be great to
> > know if, indeed, the answer is different for just-checkouts too.
> >
> > I did some cursory googling, but nothing hopped out at me as an answer =
to
> > this question.
>
> In practice I think clone, checkout, reset etc. always work in the same
> order you see with `git ls-tree -r --name-only HEAD`, but as far as I
> know this has never been guaranteed or documented, and shouldn't be
> relied on.

The transmission of packfiles is non-deterministic, as the packfiles
(which are packed for each clone separately when using core git as
a server) are not packed in a deterministic fashion, but in a threaded
environment which allows different packing orders.

If you clone from a server that gives you exactly the same pack at
all times (assuming the remote repo doesn't change refs), then
checkout is currently deterministic in unpacking files to the working tree.

>
> E.g. there's probably cases where writing files in parallel is going to
> be faster than writing them sequentially. We don't have such a mode just
> because nobody's written a patch for it, but having that patch would
> break any assumptions of our current order.

+cc Ben who is looking into that, but hasn't spoken up on the mailing list =
yet.
