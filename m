Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF1EC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbiC3R4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349456AbiC3R4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:56:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBB22B09
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:54:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so37148804lfg.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usOAbz7ApQUntyCOQ53uudexIQkSDK5PL2pjU9JKEBk=;
        b=DXWE/tWU1owquCUHugA9BKtFNeivx27Ike6uTZKYyPZ5xIYrA1o1RBY4SGrEZrGd8n
         T5hGzt42FFJbcj3Y+E7S638pGdXxUKS9Y7vV8VV1+qJtHR4TlaUNsJq+1WhFEogBt0uH
         OnTXvoQRveFsNKfCXL+09xJs8FhEX4mv8KnKQAgaxcILGSR7EhOooR7JmL8MAoELVOT/
         eInc7hdZoJq2uhabqNyFX+0x7mXVX0rhdd5lNZ2jF0QTXoYXmhsJtXWv+RGbz2rUG2uG
         avJiu/70r6jLyzUp+iq4m2JU8xMLpgNhTQAKP+o+58EWwbk8Ql948VrRy7AyMW1ptogX
         TIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usOAbz7ApQUntyCOQ53uudexIQkSDK5PL2pjU9JKEBk=;
        b=k8c0K+7wLmFoRE0EzTQ+zLjV2tfz0eq9duS4v4I8lODkrET69H7QCDH+Totn1zsHPk
         VqB68ytDasb/WAVQPr0Ou9vrpcgklvLHjuc9mZDrIKZVPX8NDSS/dHx0cIkI0dnWExM0
         +GTIndeH9Yi+sVC1c2Y7R1mk/J0P9wxM2+/h0gUdzHmcBsqAGv+TFZMsYPEx1qEBjpFX
         B/VFAkl+RNsRyRj6VRubX7PUnxVjQ62eQH35dmtnMNZItCA1wwlZ8xgixgKEk+3j6B8z
         8mL0ucV1XRPZE+7ak/vylLy8pY790HrTp0TCMp6q8trGypdEjH+800dKn9H22ZIYI+ox
         DOfg==
X-Gm-Message-State: AOAM5339VEpR19tcMj2BisZaqKNFE/DkWmBIuT9urQStOJ9y4Pa5SBPp
        XRL2ErdlCMoXK6/VRK/AWQGvXdM1Mrly9Avd0SE=
X-Google-Smtp-Source: ABdhPJxvZ6kr3apYN94uAzV2ivab2wTgwHwlzO3eqhk8k2Mhj09q903oU54H44rs4vK8n94FMYo7Hv1bK8W6KTdN4e8=
X-Received: by 2002:a05:6512:1151:b0:44a:6d05:8d2d with SMTP id
 m17-20020a056512115100b0044a6d058d2dmr7779842lfg.442.1648662858206; Wed, 30
 Mar 2022 10:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <2d1bc4568ac744f11c886a5f964dbe563c04ce8b.1648616734.git.gitgitgadget@gmail.com>
 <xmqqfsmz9x4u.fsf@gitster.g>
In-Reply-To: <xmqqfsmz9x4u.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 10:54:06 -0700
Message-ID: <CANQDOdeFbMreRh_5w5fwfJzRfrhk+A9HBoqpkACx1PrNOpyq0Q@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] object-file: pass filename to fsync_or_die
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > If we die while trying to fsync a loose object file, pass the actual
> > filename we're trying to sync. This is likely to be more helpful for a
> > user trying to diagnose the cause of the failure than the former
> > 'loose object file' string. It also sidesteps any concerns about
> > translating the die message differently for loose objects versus
> > something else that has a real path.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  object-file.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Looks good and obviously can be done totally outside the series.
> Perhaps while the rest of the topic is still cooking, extract this
> (we may find others) and have them graduate sooner?
>
> > diff --git a/object-file.c b/object-file.c
> > index b254bc50d70..5ffbf3d4fd4 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
> >  }
> >
> >  /* Finalize a file on disk, and close it. */
> > -static void close_loose_object(int fd)
> > +static void close_loose_object(int fd, const char *filename)
> >  {
> >       if (the_repository->objects->odb->will_destroy)
> >               goto out;
> >
> >       if (fsync_object_files > 0)
> > -             fsync_or_die(fd, "loose object file");
> > +             fsync_or_die(fd, filename);
> >       else
> >               fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
> > -                                    "loose object file");
> > +                                    filename);
> >
> >  out:
> >       if (close(fd) != 0)
> > @@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
> >               die(_("confused by unstable object source data for %s"),
> >                   oid_to_hex(oid));
> >
> > -     close_loose_object(fd);
> > +     close_loose_object(fd, tmp_file.buf);
> >
> >       if (mtime) {
> >               struct utimbuf utb;


Ok. I'll create two new single-patch series with changes that are independent.
