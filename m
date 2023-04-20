Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E7C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 05:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjDTFHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDTFG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 01:06:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12102198C
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 22:06:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso293854e87.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681967216; x=1684559216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StX/KdOrOxgq8/IhYpl9d4dXY1AW3+f3C6UyrO/YfMM=;
        b=pqfuUSajski4DrjjatJbs5G+vbFnczG7e2sRABG12R3g4DI1YwmNzpOsS8+ERuWNcJ
         kBQ/eX+A9oU+wTtv5lz3wQDuioWAzWFcnqS/XYqTtLmERGvPULHKc9fjgvcm3cBFOpYE
         QnVPN9HaDuvflhclS5eHVc1TMwQt6pbWyBv3YHL+hoB6nEzNj6q8arsbDVoiEZOMcszR
         G3i/OL6OHszf3helUr1UWbH9Atj+J2+v36FYKZaGDUEsS2uuNeSjKYD5x07/OEpM0lu7
         Vq+lHsA/GFFdz/NRrSVxYWABcp6N7uT5/AMWhQVOhwAQ1pYZznAR27NikCA1ePQTBlNk
         a0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681967216; x=1684559216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StX/KdOrOxgq8/IhYpl9d4dXY1AW3+f3C6UyrO/YfMM=;
        b=gMoCfWth4pnHDueKj92FSJ/hf9Jt020oEd/NTY389/CGYUxH3eTeBOFCblUY/xLhj5
         5E1DPa8wVS2GuY2U+udQ4EHP6pTpSj+PvD19ApfxxAFtTcEeLbM37FWHOSlPTo0q2U5s
         RoVLDqclvDZjRCThI9l//BcL3RHgmhLQThSRal/vARVH61mBnvi+ZJzcuOtqKlwK/xQb
         8qDbeM8YHB3ijk7i2+pLhCJeRZf2E5iIDTmc0RPBmVas8hnatWLa0bUj124N/DtpoRGh
         vQ36nf5r2JnFNVlQkpfRY7TUpF6XbnjptkbU9PcyEDtxngJStDJXv79tGNAovwqSSmVt
         SfIw==
X-Gm-Message-State: AAQBX9dZXUsdMbtPFzfVlBXCpJAy6ktZr66HJyql+f99WkiDePnSg6ev
        QqOtCFZH+SI0U6ul2z9nW6BUAkJyuzXTb9Kero6bNl0E
X-Google-Smtp-Source: AKy350aBsZsIquGn7MbMEYxS68vPnunSMcIvyNcVmMqfzJd1i6NJ08Sb3wRR8Whykho+gLR5EuRdxDuH+lhUL+KmwPo=
X-Received: by 2002:ac2:5495:0:b0:4ed:300d:79ab with SMTP id
 t21-20020ac25495000000b004ed300d79abmr9170lfk.7.1681967216248; Wed, 19 Apr
 2023 22:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
 <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com> <xmqqedogbwh3.fsf@gitster.g>
In-Reply-To: <xmqqedogbwh3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Apr 2023 22:06:00 -0700
Message-ID: <CABPp-BELApT-6YrYJ5qwme9uwP_2gqERdiLiE7mJu_b0bXmCbg@mail.gmail.com>
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these dependencies
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 4:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > This is the first patch in the series where I don't immediately agree
> > with the patch. This is a big list of methods that don't seem like
> > they fit in repository.h:
> >
> >> diff --git a/repository.h b/repository.h
> >> +static inline int hashcmp(const unsigned char *sha1, const unsigned c=
har *sha2)
> >> +static inline int oidcmp(const struct object_id *oid1, const struct o=
bject_id *oid2)
> >> +static inline int hasheq(const unsigned char *sha1, const unsigned ch=
ar *sha2)
> >> +static inline int oideq(const struct object_id *oid1, const struct ob=
ject_id *oid2)
> >> +static inline int is_null_oid(const struct object_id *oid)
> >> +static inline void hashcpy(unsigned char *sha_dst, const unsigned cha=
r *sha_src)
> >> +static inline void oidcpy_with_padding(struct object_id *dst,
> >> +                                   const struct object_id *src)
> >> +static inline void hashclr(unsigned char *hash)
> >> +static inline void oidclr(struct object_id *oid)
> >> +static inline void oidread(struct object_id *oid, const unsigned char=
 *hash)
> >> +static inline int is_empty_blob_sha1(const unsigned char *sha1)
> >> +static inline int is_empty_blob_oid(const struct object_id *oid)
> >> +static inline int is_empty_tree_sha1(const unsigned char *sha1)
> >> +static inline int is_empty_tree_oid(const struct object_id *oid)
> >
> > The goal to remove repository.h from hash.h and object.h makes sense
> > as a goal, but is there another way to do it?
>
> Indeed.
>
> All of the above sit very well in hash simply because they are all
> about hashes.  It does not have much to do with "repository", not
> more than "well, hashes we use to identify objects, and objects are
> stored in repositories".
>
> From the point of view of somebody who needs to use these macros, it
> is utterly unnatural that they have to include "repository.h" (as
> opposed to, say, "hash.h") just to be able to compare two hash
> values.  Most of our programs interact with only one repository, and
> it is understandable to include a header "repository.h" if your
> program needs to interact with an extra repository other than the
> "current" one.  But this feels backwards and not quite satisfactory,
> even though inlines are special and I can fully sympathize with the
> author who felt that this patch was necessary.

What would you think of either of the two following alternative solutions:

  * Move these into a new header, say "hash-repository.h" that folks
could include.  People wanting to use these macros would have to
include an alternate header, but one that is perhaps more logically
named, and would allow other headers to get the basics of hash.h
without repository.h

  * Move everything else in hash.h to a new header, say
"hash-basics.h", which hash.h will #include.  That retains the ability
for people to depend on hash.h and use these inline functions, while
also giving other headers the option of including the basics of
today's hash.h without repository.h.
