Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7F9C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E00610A1
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHZG3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbhHZG3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 02:29:39 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A54C0613CF
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:28:52 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 75so1053376uav.8
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G46WU4wruuDNdR/0GvTOBYJzy1xmy7zHWOFFIcWULTE=;
        b=nxBpWEhYXYL7Y17FJq9M6Lx0vCLd1apk0rFBbzzBW3eTmhNkH4gieDJPbKioehyJvL
         0kVnCWZb39ct4jQEqqzPaZxp+zEvedIncbYP/ZHo5qZvD0wmWF8RZ9apdvmYIcTWylNS
         x3ToFTlPAjyKbClgmnSeuglfaXMaXhQyMaYnY6MeMzboPsmU6k02spBmmoe+kz4WH+l8
         h8Q9DYDyFbk0Ivf3mS1E96Y833lFucYWprKd+rVu8aZPepkNhVm/UhUynO4/hrrCoSIL
         ll1X3UseFkPzsY3XJ8TzAY40nU51p1AjuT8Qq5VXc6iX71aByNAPHAmIVRJPpx6RR8jQ
         Y2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G46WU4wruuDNdR/0GvTOBYJzy1xmy7zHWOFFIcWULTE=;
        b=KmlDi3MBnXnYpTul26RQlKfkFUhvNKc/2UXSdkDueRiEsRj47g0mLzgCDc5WN6xw23
         euItVNpRdOM3Kh3WVlVYQ3Xl7ltTgwfm304nYdu4u5TlFiC8WmFDZK/0OtNW7Ug9pB7m
         74sLEvGCA8ZGcv/5H1k5PtVI+Q7F4o1V0npDV+wZCKoeVxXhf3/MqnC3OtBtM+B6g3ET
         kHE8drdlm0NjYUjUQviPvv/osS2Hjckht+qpjjy8Y6hHu0ITtaqS35I7RLbwQtSJ6LX0
         ZxKYTivhw9h5QNtmE+KH5ZtcumZsOQZk8yhocIEvF9RxHKp74BLdDqQgGOdcRAPhI76A
         +/iQ==
X-Gm-Message-State: AOAM530pFZg+1fXkSvDgCSE3lYvrt77CGsh3Y9BeSKEJ8pWDUSB8rYgS
        CMmBSGmgLrvbCcZNpC1C0vxqd+gEa+hutksHIbkz3aVp5xo=
X-Google-Smtp-Source: ABdhPJwwr0yyb7ooIR3zvNbPB8z2R6yAMXhgrLd2s8XiaPcdPIc/ss3rN81Ke/DKnOH1gAqWfyHDH7W+7vDD7LltmIk=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr1064309uap.96.1629959331397;
 Wed, 25 Aug 2021 23:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210826031710.32980-1-carenas@gmail.com> <YScXboC0M1IPNFon@nand.local>
In-Reply-To: <YScXboC0M1IPNFon@nand.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 25 Aug 2021 23:28:40 -0700
Message-ID: <CAPUEspjGkHhFNgTe3HnnUvkzwHfKqb9dYO3aCXDh_fRyFMRN6A@mail.gmail.com>
Subject: Re: [PATCH] test-lib-functions: avoid non POSIX ERE in test_dir_is_empty()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 9:24 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Aug 25, 2021 at 08:17:10PM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index e28411bb75..2803c97df3 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -790,7 +790,7 @@ test_path_exists () {
> >  test_dir_is_empty () {
> >       test "$#" -ne 1 && BUG "1 param"
> >       test_path_is_dir "$1" &&
> > -     if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> > +     if test -n "$(ls -a1 "$1" | grep -v '^\.$' | grep -v '^\.\.$')"
>
> This replacement is correct, but I'm not sure that I necessarily find it
> simpler. If we really are concerned about egrep usage, then
>
>     if test -n "$(find "$1" | grep -v '^\.$')"

Interesting idea; if having a much simpler expression is so important
then we could do instead [^.], since all use cases will be covered
(nobody is going to create a three dotted file to workaround a test
IMHO)

> But it looks like we are fairly OK with egrep in t (`git
> grep 'egrep' -- t | wc -l` turns up 19 matches), so I'm not sure the
> change is necessary in the first place.

egrep (and also fgrep, which we intentionally support because it is
missing from some ancient AIX system[1]) will be removed in the
next[2] release of GNU grep.

Carlo

[1] 87539416fd (tests: grep portability fixes, 2008-09-30)
[2] https://git.savannah.gnu.org/cgit/grep.git/commit/?id=3Da9515624709865d=
480e3142fd959bccd1c9372d1
