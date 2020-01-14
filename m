Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BAC33CB3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0624658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwA774Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgANV5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:57:34 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35386 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANV5e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:57:34 -0500
Received: by mail-pf1-f201.google.com with SMTP id r17so9614317pfl.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 13:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s6aHBlbwYMxoHYRAcEbIeDROx6OLWvqJbp/mYWutw08=;
        b=uwA774RiUtuRCN9AbHk8NRWfjTRQFJczKaDSuDFpwCj4tO/UrLyoKJWRZG1yg9zQ5m
         uRmo/4C/2RuNqYOHow4GF2B+JKUrpTSCSftRPlAUot9QxlJhoLmD/S3MXWfg8fuZ49lI
         ss8nvx0GU6WIsTbsvDbu9Vr7PO1i6CxQLJZH48LtamMsJ6topIV4+r7OegtV5gMJJOO5
         D41TK47Ri+Q6AN1ADv7fX76RdpKGPaueaJ2/Ou4dWzB1+LX6YIQAirK+h2TGMVyA4Fb+
         8PbhAIy0ThSDIJ7SnHvzckoGCafKPf0vXIBDJ9pTpfodZY/n1kvfSy7kffgkab9gDenK
         Uw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s6aHBlbwYMxoHYRAcEbIeDROx6OLWvqJbp/mYWutw08=;
        b=TMK8CSX5JPqti6P7WC0C8ufGJ9prXEsUlG3L8xVO0tp9qaQhDejC4h+eV4ZPn0WnCP
         HBk2srmXwt3zcuGzd0hdYJEnPPi3LD+nzClqPuaFLTqBcqL2kXKTwd+MdC1HgFAB20Ve
         anY1N1U+UdX81rkKGkV7yFeYuxZNMxBP6UAIIIWV28em/2TcQy0U4+gnEvd4toMvMmAA
         mABS4uziGuQfKwr2jlMfWGVrwi2f+bnO7lbDH743xeOiRBvs4oNRifSEGHbV3DL7OqLN
         d+nC1sMXrG5TDIz07oGR6Rv9j3a6qIWUjYujNz2nQ4GRImjpKcymhk+0uKr9V5DljLVV
         9JyA==
X-Gm-Message-State: APjAAAVvzt4b/Mv9Czm8Gtt2aXDac024GwXaerzCdZ2EwpNL3c2YopL7
        knF7RJCnogMe40XxqGba8RSw4OcsLSOV+hLrITaF
X-Google-Smtp-Source: APXvYqwlzF4Yi6qi2juAyQpquHzRQwBYxB1e/ES/FEBiW1q2neb0BOYuVreq2yFC6uxwTs7YoByrwvMMhABaZ/uvB9dp
X-Received: by 2002:a63:e0f:: with SMTP id d15mr29129253pgl.255.1579039052970;
 Tue, 14 Jan 2020 13:57:32 -0800 (PST)
Date:   Tue, 14 Jan 2020 13:57:30 -0800
In-Reply-To: <CABPp-BF8OHoHo73doekKzf0CmO09_PyAfe4q__DvoftQ+BeY2w@mail.gmail.com>
Message-Id: <20200114215730.154601-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BF8OHoHo73doekKzf0CmO09_PyAfe4q__DvoftQ+BeY2w@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [RFC] Extending git-replace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, novalis@novalis.org, kaushik@twitter.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Missing promisor objects do not prevent fsck from passing - this is part
> > of the original design (any packfiles we download from the specifically
> > designated promisor remote are marked as such, and any objects that the
> > objects in the packfile refer to are considered OK to be missing).
> 
> Is there ever a risk that objects in the downloaded packfile come
> across as deltas against other objects that are missing/excluded, or
> does the partial clone machinery ensure that doesn't happen?  (Because
> this was certainly the biggest pain-point with my "fake cheap clone"
> hacks.)

The server may send thin packs during a fetch or clone, but because the
client runs index-pack (which calculates the hash of every object
downloaded, necessitating having the full object, which in turn triggers
fetches of any delta bases), this should not happen.

But if you create the packfile in some other way and then manually set a
fake promisor remote (as I perhaps too naively suggested) then the
mechanism will attempt to fetch missing delta bases, which (I think) is
not what you want.

> > Currently, when a missing object is read, it is first fetched (there are
> > some more details that I can go over if you have any specific
> > questions). What you're suggesting here is to return a fake blob with
> > wrong hash - I haven't looked at all the callers of read-object
> > functions in detail, but I don't think all of them are ready for such a
> > behavioral change.
> 
> git-replace already took care of that for you and provides that
> guarantee, modulo the --no-replace-objects & fsck & prune & fetch &
> whatnot cases that ignore replace objects as Kaushik mentioned.  I
> took advantage of this to great effect with my "fake cheap clone"
> hacks.  Based in part on your other email where you made a suggestion
> about promisors, I'm starting to think a pretty good first cut
> solution might look like the following:
> 
>   * user manually adds a bunch of replace refs to map the unwanted big
> blobs to something else (e.g. a README about how the files were
> stripped, or something similar to this)
>   * a partial clone specification that says "exclude objects that are
> referenced by replace refs"
>   * add a fake promisor to the downloaded promisor pack so that if
> anyone runs with --no-replace-objects or similar then they get an
> error saying the specified objects don't exist and can't be
> downloaded.
> 
> Anyone see any obvious problems with this?

Looking at the list of commands given in the original email (fsck,
upload-pack, pack/unpack-objects, prune and index-pack), if we use a
filter by blob size (instead of the partial clone specification
suggested), this would satisfy the purposes of fsck and prune only.

If we had a partial clone specification that excludes object referenced
by replace refs, then upload-pack from this partial repository (and
pack-objects) would work too.

But there might be non-obvious problems that I haven't thought of.
