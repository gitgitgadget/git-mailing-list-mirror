Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E3FC7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 06:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDHG1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 02:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDHG1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 02:27:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937DB740
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 23:27:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54c061acbc9so151738677b3.11
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680935270; x=1683527270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPqgpgTbvsvkO+2lgRZGSBUPMRTsL376+9kbuAwq0No=;
        b=IOsCy5JzS79KXlnBxDzU5oxCEC8YCuWNm9rfUtjHxhBUB2KAJfqJd5ZecyAdV0zbH2
         VQS/8V7piE69TeNlptwH0BoQ2+MV4Zj8K+miTI5DjL59UEDTUExqfPeb0DIZnC9OJP8W
         dwnOPeiWOuwqjBYiSIW4Az601n5UoKXogjhfrJxmdGOl1OppPCoXWZWeiH4LBnRSP/Ac
         Zxcg95X2cDXlBVtd4D/QaSshpNN9Zz5AbSLAxifUp46C+qRr5dc5RXX82UqUFf1teC3F
         3r/XTf4TD8oaVc+N/BXkcD251vIxrJHV5SEKKQTUjgyATdjxC0zEbe2nzpMoRzJ+EvEU
         3wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680935270; x=1683527270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPqgpgTbvsvkO+2lgRZGSBUPMRTsL376+9kbuAwq0No=;
        b=MTujTYcCiVP/lgb7+S7GXke73SgA4PWWJcaRKvYer+YECmu037MCi81Ro6QYeodBhV
         8JkOYqdYfSs/BGJIcGfV6UT2omo4EUix3NrXL5SywpcLKdb9lyoE61m+RK0dZGSVAUw1
         UZSJB0rs0HAS7PmCIysbOAJxjvyVdwp3WcXrlMFNL3LxIEpxKm9KupCanOPwHpm32iKc
         +oL+HIOKKtyda2v6DNrHm+l6+mn0akDI2B7G+p0kz8LLkqmKi2ojjI91NCSQ8WKumhqg
         R5aL8xsmi9LQWsU4ndW+KhuWGzz9TmiPh+rNlFCRwjruDG0Go5pu2YlNXcVYopbuGJkc
         74aA==
X-Gm-Message-State: AAQBX9cLbYsNSTpX6UepwrWNU1zkwycrkfUtoyG98k0wDFIrW3K/NNxq
        5nEz+zkBwlz1zm9S1dHq4ArKB38/sSIRq3MpGBU=
X-Google-Smtp-Source: AKy350ZyKq2lzsQqzcX4mwgnXHmT0YjIvgkeUtD9InUax+6hpFnf2nsu1rAWRwnT0cearTWEvYyHDORQCstuTIBsuWA=
X-Received: by 2002:a81:a907:0:b0:53c:6fda:835f with SMTP id
 g7-20020a81a907000000b0053c6fda835fmr610091ywh.0.1680935270198; Fri, 07 Apr
 2023 23:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
In-Reply-To: <xmqqy1n3k63p.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 8 Apr 2023 14:27:53 +0800
Message-ID: <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=85=AD 00:30=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > all blobs, and then use `git cat-file --batch` to retrieve them. This
> > is not very elegant, or in other words, it might be better to have an
> > internal implementation of filtering within `git cat-file
> > --batch-all-objects`.
>
> It does sound prominently elegant to have each tool does one task
> and does it well, and being able to flexibly combine them to achieve
> a larger task.
>

Okay, you're right. It's not "ungraceful" to have each task do its own thin=
g.
I should clarify that for a command like `git cat-file --batch-all-objects`=
,
which traverses all objects, it would be better to have a filter. It might =
be
more performant than using `git rev-list --filter | git cat-file --batch`?


> Once that approach is working well, it may still make sense to give
> a special case codepath that bundles a specific combination of these
> primitive features, if use cases for the specific combination appear
> often.  But I do not know if the particular one, "we do not want to
> feed specific list of objects to check to 'cat-file --batch'",
> qualifies as one.
>
> > For example, `--type-filter`?
>
> Is the object type the only thing that people often would want to
> base their filtering decision on?  Will we then see somebody else
> request a "--size-filter", and then somebody else realizes that the
> filtering criteria based on size need to be different between blobs
> (most likely counted in bytes) and trees (it may be more convenient
> to count the tree entries, not byes)?  It sounds rather messy and
> we may be better off having such an extensible logic in one place.
>

Yes, having a generic filter for `git cat-file` would be better.

> Like rev-list's object list filtering, that is.
>
> Is the logic that implements rev-list's object list filtering
> something that is easily called from the side, as if it were a
> library routine?  Refactoring that and teaching cat-file an option
> to activate that logic might be more palatable.
>

I don't think so. While `git rev-list` traverses objects and performs
filtering within a revision, `git cat-file --batch-all-objects` traverses
all loose and packed objects. It might be difficult to perfectly
extract the filtering from `git rev-list` and apply it to `git cat-file`.

> Thanks.
