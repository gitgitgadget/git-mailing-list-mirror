Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE83C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 03:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbjDZDyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 23:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDZDyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 23:54:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D510FE
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 20:54:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec817735a7so6803634e87.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 20:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682481270; x=1685073270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRjQhMRZl3uteCw65gH5zuzOr9ImlCxqoG2vU6XKntE=;
        b=oFMSrEUMjaQV9GQm0y1xF/0FdxkiU+6zphBDg54DgW2YocbHVIiStjkHh8SLGPv5G2
         fROtyPZKz+3H/kogMV6E72QCM0TVBgIJvRgR9fNsGL6zE0sUofDe4YNpwxdN7soUWZz7
         YX++lcj5eTp0PxbU8q0Ce3RXrqOSOAkE4NxnHIYe7E3CGkycH5uuF/UsdaSuoO4e1HWr
         fRDAWb3WJ4QrTqHuznoCIh11qmRDyQjdLAy4NeKO0wDjul0C39za2pXYILKW+LoUcKXx
         oXO9jW2iWhQnowOmwbjoecJU+Nw3iFW7kD7XGcay7pq0UrrCr2pV9zO1e4/LSspEebRb
         LuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682481270; x=1685073270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRjQhMRZl3uteCw65gH5zuzOr9ImlCxqoG2vU6XKntE=;
        b=dA16TA4EO+aEVLSkvzBy90uK2O9tXYdjTan9U+yfoQ6c19G7fYbExtYfZABlkxsoZC
         f1Tan7k6QbSevaUafFRq+4/L1rzwZD7jMlcMosk6VSUQeOEIFl2L79vwVONEh4EstcZW
         iOuU28L9DJQmdNxOQePP8gke11nRYtAtEgh9GECpdlQtsgsskDwUcfYjjDwD1xZkdqJD
         M4zems5RMsGKf4A6Bqo/Xvu53sECT7dfBz57kfIbuIvXqHSV1zSHxHlO878VlRksh7o0
         xw0t2Kca6S1QErTNi+orKb9nnU1BHQUlcIXExVtUlpe2nNvFxYxS/tAyr3S8kenQC/k5
         Mdqg==
X-Gm-Message-State: AAQBX9fX0i3hSV1WzDpcE4vXZc9aeW26CyVZtrpKGDP21wNLF4WFNgqn
        8kVOfXVA+NpmQbS7KL2IZ6ZIzZt4Mayq+a0iksiA9fAR
X-Google-Smtp-Source: AKy350YDKA4kvX3T1ysZ7R9oLivAE1XCzBWh9guogxz/PYYOCsysNYG5ujbB7DvzFOqSdA3nYS7q6pnSUuEIa97t4rU=
X-Received: by 2002:a19:ae0a:0:b0:4ea:fabb:4db1 with SMTP id
 f10-20020a19ae0a000000b004eafabb4db1mr5007441lfc.1.1682481269715; Tue, 25 Apr
 2023 20:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
 <kl6ly1mh865x.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6ly1mh865x.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Apr 2023 20:54:17 -0700
Message-ID: <CABPp-BEWS75TrsfUQUP9t4_2B4FTDbM2FamqTgvVj8WpxUgSYA@mail.gmail.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 11:51=E2=80=AFAM Glen Choo <chooglen@google.com> wr=
ote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >                                 Move the parts of hash.h that do not
> > depend upon repository.h into a new file hash-ll.h (the "low level"
> > parts of hash.h), and adjust other files to use this new header where
> > the convenience inline functions aren't needed.
>
> Suggestion: To maintain this property, it might be helpful to capture
> the rules of hash-ll.h vs hash.h in a top-level comment.
>
> > diff --git a/hash-ll.h b/hash-ll.h
> > new file mode 100644
> > index 00000000000..80509251370
> > --- /dev/null
> > +++ b/hash-ll.h
> > +const struct object_id *null_oid(void);
> > [...]
> > +const char *empty_tree_oid_hex(void);
> > +const char *empty_blob_oid_hex(void);
>
> hash-ll.h doesn't depend on repository.h, but these functions' bodies
> use the_hash_algo. Does it matter?

That's a good point.  I think eventually moving these functions from
hash-ll.h to hash.h on this basis makes sense.  But I kind of view
this series (and its predecessors) as focusing on cleaning up header
dependencies, with the idea that hopefully we'd go through and do
further cleanup of dependencies of C files that would likely result in
further changes to some of the headers.  I suspect this isn't the only
change we'd need to make for that kind of consistency, which might
lengthen this already sizable series, and I've probably missed a few
similar cases in my previous series as well.

> Moving the functions to hash.h requires changing 8 files to #include
> "hash.h", all of which seem to be because they were getting hash-ll.h
> indirectly via object-name.h.

Yeah, seems like a reasonable further change.  Are you okay with that
being in a future series, or do you think it should be included in
this one?
