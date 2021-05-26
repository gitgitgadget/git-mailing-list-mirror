Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13559C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AFB613CC
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhEZPEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhEZPEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 11:04:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4273C06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 08:02:58 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id g11so1175148ilq.3
        for <git@vger.kernel.org>; Wed, 26 May 2021 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WLRx9E+ESlmchWuAoqAKqwAcnt5S0Fjbw5KSHl9TnPQ=;
        b=qeZQqPU7zdaNq48q1O7o3d0eb2kdi2O31Bv2UH3ILqhUGnVJVCQDeuWdiarnzrvboy
         wXtGBlTMp8Tb5mySHZ26PH+TgcJwFrJEKPOR80POY/j2yQmQ6w5d6W0sF7Xu30oXGAPn
         hWQ35lF7c98F3YFwxCK2Nqg98ABGoDwf4jQyPBK/4qE7iHhV7kwx+XM001tjxVme5ziJ
         czFw9YYN2ODRpnAx2KiISb0TN+OdyinlL935tl3Sbb64fxajzqSyjpAyIKoWz/2F6s06
         avmVaDq7MZBk6e5Bn33Amt4leM6VkXEpbeOSNinriXky8yo9MR+FYV6/OhDQ9IpGcjHZ
         SAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WLRx9E+ESlmchWuAoqAKqwAcnt5S0Fjbw5KSHl9TnPQ=;
        b=QTNyznP8us48u9vofIsLCUIRdEfpMH/vbO6sKdzYly9gokQ6Zk5zZgUD/7K2p2Uq3q
         55KeT8fEKNlCZ+IkbecwLRlYiaTzkByI9HNNqj0kVNrzfzSor0OpB5UuzD1LfYSrmnjH
         MTZd/RVQS6/pL7KcOxPyY9Qo3kD6LiOz82TY2IQnI19lDF7GEo+qjoWcuUIipJ96zH+I
         m7Y5aQOKvBdl1kyHDLoGDcH7uqqYfy6kQo2oPvzmeUZ1OAw2v5VgfvAloHfIf8gUjsmt
         qIEaSOLV/XX9BHJlNWBg9Ax8ibEabhr5I+wVHBqxnixvYiqmU5HbZW855cRaxjvTgiR1
         zjag==
X-Gm-Message-State: AOAM532JCSWWc0T7Y3hTht4DnFnSOAZrYW3FPbfIuxNULQy5ssO2vaPC
        vhIMuYBvndRuw4hn3efWPvJX+P/nutXMeV8YsSc=
X-Google-Smtp-Source: ABdhPJyFSVED8A7x6BXpNmCewt7Ghtxp64sDsqRe2EZynSKWcRo9meXruWR2JlbS6BD97rrR5k6gaZEqVPzPvYGDVEY=
X-Received: by 2002:a92:2004:: with SMTP id j4mr27699958ile.53.1622041378187;
 Wed, 26 May 2021 08:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqcztecuy7.fsf@gitster.g>
In-Reply-To: <xmqqcztecuy7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 23:02:45 +0800
Message-ID: <CAOLTT8SEmb6AXQPie7oYK8FruC2-9_yytojYYKxkVWLpks246A@mail.gmail.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?Avar_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=886:25=E5=86=99=E9=81=93=EF=BC=9A
>
> It is sad that the tip of 'seen' rarely passes all tests these days.
>
> I excluded a few topics (chosen primarily by prejudice after looking
> at which tests failed earlier, without locating exactly where and
> why they fail) from 'seen' and the exclusion of them seems to have
> made 'seen' finally pass the tests, eh, almost [*1*].
>
> 82b1e47 is such a "reduced" 'seen' branch, and the CI run for it can
> be found here:
>
>   https://github.com/git/git/actions/runs/876448385
>
> Excluded are:
>
>   ab/fsck-unexpected-type
>   hn/reftable
>   hn/refs-errno-cleanup
>   zh/ref-filter-raw-data
>

Hi, Junio,
I find my patch may cause some bug:
I ignored those blobs with no content (objectsize =3D=3D 0) before,
Some things about "--sort=3Dcontents:raw" need to be changed.
so please remove my patch from `seen`.

--
ZheNing Hu
