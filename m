Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60035C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiK3TFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiK3TEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 14:04:38 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76842197
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:04:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i131so22749615ybc.9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbnxdDqDyHXVy219HUWq2YSjq3seL5I2LgGPLAqdL9E=;
        b=ArYtUVRDKqcVEZh+aWT42QIewY0wtwrckXNuzaS4lBtR+jeMfzVxPzZT7TEEpybGiD
         Zxjym2/zZ7f/SgSiXLjavlccRy2WTJWdfgcufbvCknEoVTPkVL7QQY+mvorz1L0oZgiI
         VubbIwvc0tIluf5ECKaeWefDkdWydeCzfFXUUCZbR1ZlWt2qofL8H5pNPKBqNb7boBRA
         4+rlUyPV55RYCT0HFl54b41t7FkmnrmDnn0iUEm6mR+AXRForFn+xQ32Pg6rVdmRijMT
         MF6cx9JCHi6YVTMX+8gxiv/PJw3OMMSAf2lUrS9hsZqleSuH2zW4QUub0LSY4w7bTttS
         ItrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbnxdDqDyHXVy219HUWq2YSjq3seL5I2LgGPLAqdL9E=;
        b=7jFInMndwz5JvsE+mKtTLBxKIt8pKE1r9IWyG3SjcUWRVzYXNxXsfOq/smgudrHKua
         NvXwgC9B2j5EsSZE6OJ1IqBQW7AlH33JtRwUryBHxtO5YM0aqT4AHoxEIjZonGxFeSN2
         +awvfniLmTnhnpdMacWQELhu4XxNW6FkyiWvuduZ2nBhItxGfCCRmu+THkiYEvZaQSDa
         To67CL4L0zRT6IDKlyDnqRTAwBNahIvaOPmfrqeBZoxuFkdxK55lZAQtjDjAahjFWfZC
         HCg7UM1Co83tosXwn9wj7fUE6y+RgEmh2xGlNQylNSeu6n9bZGEMPa/uvr4vATwBliQ5
         JCJQ==
X-Gm-Message-State: ANoB5plFrJCA0mF9IPUG+UWKLNAmZiZs1R/HD+umV+IqHdvR00K1Gyip
        kBh41lLIkq0Pn2ZkYLTYSzzvb4SXJY1e8ozXuKVaIW9203t6sw==
X-Google-Smtp-Source: AA0mqf6/UlKbqSDG3m5o8QPbEIE9uZu/haV8hl6Ur9tik8U2M8ek2V8N9MpStOdKYsrSTilQ8k9ueZgTmsMbepMSbIk=
X-Received: by 2002:a25:b08b:0:b0:6f8:b539:5c7f with SMTP id
 f11-20020a25b08b000000b006f8b5395c7fmr9819004ybj.510.1669834937733; Wed, 30
 Nov 2022 11:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-2-calvinwan@google.com>
 <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221130.86lensiwy0.gmgdl@evledraar.gmail.com> <778b25b4-8eb2-6d02-3ba5-a21724ff2f2f@dunelm.org.uk>
In-Reply-To: <778b25b4-8eb2-6d02-3ba5-a21724ff2f2f@dunelm.org.uk>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 11:02:06 -0800
Message-ID: <CAFySSZDfueOverb0TrYd_BZAgjVpS2pzqaN+=jHXUOrH6-eU+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, phillip.wood123@gmail.com,
        myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 2:26 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 30/11/2022 09:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Tue, Nov 29 2022, Glen Choo wrote:
> >
> >> Calvin Wan <calvinwan@google.com> writes:
> >>
> >>> @@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_p=
rocesses *pp,
> >>>     for (size_t i =3D 0; i < opts->processes; i++) {
> >>>             if (pp->children[i].state =3D=3D GIT_CP_WORKING &&
> >>>                 pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> >>> -                   int n =3D strbuf_read_once(&pp->children[i].err,
> >>> -                                            pp->children[i].process.=
err, 0);
> >>> +                   struct strbuf buf =3D STRBUF_INIT;
> >>> +                   int n =3D strbuf_read_once(&buf, pp->children[i].=
process.err, 0);
> >>> +                   strbuf_addbuf(&pp->children[i].err, &buf);
> >>> +                   if (opts->duplicate_output)
>
> Shouldn't we be checking if n < 0 before we do this?

Yes we should.
>
> >>> +                           opts->duplicate_output(&buf, &pp->childre=
n[i].err,
> >>> +                                     opts->data,
> >>> +                                     pp->children[i].data);
> >>> +                   strbuf_release(&buf);
> >>>                     if (n =3D=3D 0) {
> >>>                             close(pp->children[i].process.err);
> >>>                             pp->children[i].state =3D GIT_CP_WAIT_CLE=
ANUP;
> >>
> >> A common pattern is that optional behavior does not impose additional
> >> costs on the non-optional part. Here, we unconditionally do a
> >> strbuf_addbuf() even though we don't use the result in the "else" case=
.
> >>
> >> So this might be more idiomatically written as:
> >>
> >>          int n =3D strbuf_read_once(&pp->children[i].err,
> >>                               pp->children[i].process.err, 0);
> >>   +      if (opts->duplicate_output) {
> >>   +          struct strbuf buf =3D STRBUF_INIT;
> >>   +          strbuf_addbuf(&buf, &pp->children[i].err);
> >>   +          opts->duplicate_output(&buf, &pp->children[i].err,
> >>   +                    opts->data,
> >>   +                    pp->children[i].data);
> >>   +          strbuf_release(&buf);
> >>   +      }
> >>
> > [...]
> > And why does "&buf" exist at all?
>
> I was wondering that as too
>
> >Why can't we just pass
> > &pp->children[i].err, and if this callback cares about the last thing w=
e
> > read let's pass it an offset, so it can know what came from the
> > strbuf_read_once() (I don't know if it actually cares about that
> > either...).
>
> Or we could just pass a `const char*`, `size_t` pair.

Both you and Avar are correct that &buf isn't necessary. I think the
offset idea works better so the function calls stay similar.

>
> > That would avoid the copy entirely.
>
> Is the copying quadratic at the moment? - it looks like each call to
> strbuf_read_once() appends to the buffer and we copy the whole buffer
> each time.
>

Depends on how you're defining it, but doesn't really matter since it's
going away anyways ;)
