Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF13C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9360722C7E
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAXHLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 02:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXHLm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 02:11:42 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17356C061573
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 23:11:01 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id g69so10444623oib.12
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 23:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eDTl0gkP4rjhtqvJ9S3Q6+YzfZ1i5vbhnx8/cY0Buk=;
        b=Uxwqf1S0lEUDyAkCpPw+yvuY512qUO4E/5d+DSb4oWhoRtNhYTPOmBT6h8bm9h9d3M
         suRDfV1SnIF7Xd+zSTaCtdHY5dUS9kASTQ5dt5JL517iGGT9VKVE5jDqgmvb6XWsAgSv
         nj0dsgx3pn/0U3ucsAIfuXJIz1yB6Jo5BYRKBi6T0AkTZf51VGKlKky6fl9Sv5PC/MNT
         CtPsmG723G7ohR6jO36MIGvAQgP1NPdwETkX3I/GtRLyEEQvV1D7Xd3f36XdK5pyEbBj
         Ta6bXiethApOnWpdtGZojrHrBE3umlaf9hO1hMrzessMkULJIopug0GxukbXPGyqiSbB
         8x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eDTl0gkP4rjhtqvJ9S3Q6+YzfZ1i5vbhnx8/cY0Buk=;
        b=lm6pPQ6mnxDBTbuUidIyiLm43mridEFyBg0RRsZeJXjIq+JTsqRNk9RG8TpLj+HhH7
         AaYf9EMBlHm75cxzyZTAYPGwG5QiVa/ZaqcDBw5bLc8RfwmuzmfntVAkRXYjN4PcQvA4
         AICSqhT9Up+zLw2A1OA5qWYNx5RO/KMfJnC80GoJJX4+gYBP2OyB+5kTC6/oy7oFTT+q
         YKZ8B90lGBliJT6/vDBrsFKP1iTbrfXMdI28IrMmSZ7uyqWxzNRBGtFLOfnVxl8YIPDd
         V7VDWE76TKIDmjzBqXCCTzElj/LQmDmoKhWeNp4aoBaaBSAzwYMPha0mMC0O+84nnc5g
         QdRQ==
X-Gm-Message-State: AOAM533z6jbL4/LkT3g7Qo7V3UGJclTenilQGE4ZX9QDJkKVlFEs8DPt
        m39yztjbWNaF8bTeYHvrMxtRRlHQXWYTqeaPoe9wChVCeCk=
X-Google-Smtp-Source: ABdhPJy7uQMJtUrTELnEdRQTo1ueQGDLxn4jSTjdbStE48ua+f5XAeGPcrTVZuuZzOdIdXsinjJ96ALTVoz7svw5+nc=
X-Received: by 2002:aca:a816:: with SMTP id r22mr2998972oie.31.1611472260320;
 Sat, 23 Jan 2021 23:11:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com> <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
 <xmqqft2ucf4p.fsf@gitster.c.googlers.com> <CABPp-BHMmi1A2fzkVsgEUeeMQywtU6YaCU93nq1K7301YhtpjQ@mail.gmail.com>
 <xmqq35yq24ve.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35yq24ve.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jan 2021 23:10:49 -0800
Message-ID: <CABPp-BHu75TLe8Behkf59Ke-acxzmRmr-AaziQX1ewg_J9BNgQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 11:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jan 21, 2021 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> ...
> >> Even though I wanted to merge the en/ort-directory-rename down to
> >> 'next' yesterday, it has just got updated and I had to rebase the
> >> ort-perf branch using the material from the old thread, so neither
> >> is in 'next' as of now.
> > ...
> > reports, it's kinda important to get it right.  So...
> >
> > * I'm not touching en/ort-directory-rename; I still think it is ready
> > for merging to next.
>
> By "not touching", do you mean you now want me to discard the latest
> round that is on en/ort-directory-rename and revert the topic to the
> previous version?

No!  Sorry, I meant that en/ort-directory-rename is fine as-is.  Do
not revert it.  I think it is good to merge down to next and master.
(The memory leak I found was not from that series, but from another
series that pre-dated it; in particular, one of the ones that has
already merged to master.)

The only thing changing here is en/merge-ort-perf; I'm modifying the
existing patch slightly (mostly the commit message) but also adding
two new patches, one of which fixes the big memory leak.
