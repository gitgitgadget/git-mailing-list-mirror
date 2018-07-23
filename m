Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760A01F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbeGWTQc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:16:32 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35111 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWTQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:16:32 -0400
Received: by mail-it0-f51.google.com with SMTP id q20-v6so109282ith.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XT5GIjLDjJk/mYMV/mbYVEbH5Z9SUxtJpJ49XC+i8GY=;
        b=To+7Oe2H9MJwpaFOY4GFi00kwVMayF99AbHDQmwC/vj6Ydo/AuQc/OHf6kdNxk3iVz
         lcu1dAF1Qyqdg1xVhss0i56rYNmeT8qoIJbpq7ZkKciR4CoxmSdE4EeZVFPUhSXl+Xzv
         wJjN2tQXOO0xT2AQkZjzDop76kGAootFU8VcQ7pbWBJG8O4v/BZIm3sJMBZAOzu8K9UM
         Qt1tX58ezR+ubikBnHg40W/DLHVgZ+opB7eau+a/6W3KIA28PbGkuEwOGZt8uMvWqldy
         M6F+TIeCprFUBxSafI4/zZnXr3BSRoWqGLT7jUSqDggYjdfhzW0akmgBhwFjCMWR+Ygi
         9seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XT5GIjLDjJk/mYMV/mbYVEbH5Z9SUxtJpJ49XC+i8GY=;
        b=SB138YumPUouEo9BAqGcyg45BTUFzdLqCIpL3NYcuFPQASL/2r+ZZlVNt24YNtnBB8
         HlAqfqsur14AH4blZSGr9BtlPCnNeJMj/qlCJ8303coYF0a0Hog2B8FmIB8CDfp0bIQX
         3aTRq/ViuwQ5xKQSXDQbrlu9YMhx/pOFCglaThM5lmIRnRSnn1ulaQp5UUxedXkm9QOf
         3xfFoSh7FhDhgKq/4WTSKOL63T7Yal0H97PWMOZhWTzc/aaOg9Ip7Yjvxplvh1lNZcz+
         WPEUDIfv0tMxTIYffIC4Njw5xfnK3T2NxRiNsc0uNuzZHodMz9MWe5yGPvyFgVqz/dZh
         E16g==
X-Gm-Message-State: AOUpUlGF3JntNJA6hAaM2eGPlxCRMDRGEO/cfUqImzVQ+im9ACeNipli
        qgAAreifggExy3lr64PIIsD1xHOqWxleXaHgqvn9OA==
X-Google-Smtp-Source: AAOMgpdJuF/gqkllTVIb232eTE/zP/ft0+qy4yLabA/DMKA1KmpmtgQLRdtyMyv2X845WAyeuS/5Rc1X/o05A6IRVbc=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr92940itf.78.1532369646020;
 Mon, 23 Jul 2018 11:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
 <20180627223023.49659-9-bmwill@google.com> <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
 <20180723175318.GB25435@google.com>
In-Reply-To: <20180723175318.GB25435@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 20:13:39 +0200
Message-ID: <CACsJy8COu2zmWWuodww=ZdURZBw6CVx9ibbfeAJ0Q4pQ-ng_uA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] fetch-pack: implement ref-in-want
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 7:53 PM Brandon Williams <bmwill@google.com> wrote:
>
> On 07/22, Duy Nguyen wrote:
> > On Thu, Jun 28, 2018 at 12:33 AM Brandon Williams <bmwill@google.com> wrote:
> > > +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> > > +{
> > > +       process_section_header(reader, "wanted-refs", 0);
> > > +       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> > > +               struct object_id oid;
> > > +               const char *end;
> > > +               struct ref *r = NULL;
> > > +
> > > +               if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> > > +                       die("expected wanted-ref, got '%s'", reader->line);
> >
> > Could you do a follow and wrap all these strings in _() since this one
> > is already in 'next'?
>
> What criteria is used to determine if something should be translated?
> To me, this looks like a wire-protocol error which would benefit from
> not being translated because it would be easier to grep for if it
> occurs.  That and if a user sees this sort of error I don't think that
> they could really do anything about it anyway.

Devs are users too and for me, even if I can read English just fine, I
prefer fully translated interface, not a mix of non-English and
English. Users can still google around and find out about wanted-ref
(at least linux users 10 years ago did). If they show up here asking
for support, we can ask them to translate back if needed (or look into
.po files). We have the same problem anyway if their bug reports
contain other non-English strings.

Besides drawing the line "benefit from (not) being translated" varies
from one developer to another. I think it's just easier and more
consistent to stick to "if it's not machine-readable (or really meant
for devs, like BUG()), translate it" and leave it to translators to
decide.
-- 
Duy
