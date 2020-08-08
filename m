Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A16AC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1393B206B6
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMzlCSFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHUZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHUZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 16:25:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA0C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 13:25:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so5546523ejb.11
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xaf3G/bmzA1fSn+VteV961eRvK0BMMKJ5w9dbLalZ4w=;
        b=HMzlCSFja85wR1MKIpHcUKE3MQKNSo+ABFgMjVEcPcOtxtstp8mpE5DH721MWOP4Eb
         +uhcjXHwiO2qEJefW18oGfoBtKGlP1rbdtAPRbfFK6zOjMUm3suiGR0MrEiw8spqYskm
         P+HNgfzZ8AZGR9Bp7bUIOpeeWZVoszPNVkCqB4R+h/S7s9nnHXcdAo95aSCEWDlLYAJd
         a8PkTijLQfpGN6pU98sXbSHKhul2n0QYILBcyUYOIEkA0pQFcsIFCjZ6yUhfx7A30qEP
         7crfhtCEwEPTBo1O2HSQq5GHldalMRmR/hv1cxDATqT88RmzID7cvQrXVIi2SmzvMVix
         8x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xaf3G/bmzA1fSn+VteV961eRvK0BMMKJ5w9dbLalZ4w=;
        b=BdQyg/hl+4wNR0WxxqC9nU46xcxPMaOFICls2V0kTXbWhcLJXPGeDaH5mM5lY6DJ5n
         d26Lrac/VZNC3IBbjSOefzBITvLKGbjS/IcCDc0AbOjNIv05RCxSJX/EUTMlJweH3JTF
         8mpgQSrr9vv5nzX9Q/IENtcANzi01wefDyPVoFnUNUvQcCqPOxCy8GF5VGglsosTGqJF
         60DbevSY37LF43EiuE6+kNzwpk7sqGSwiCCuQ4YIlQNDFEdQoJS3lS6ViERLRliVLI+H
         BARBy4aZkWzT59eay22eP5r4QyyI9ZDm5v0jMJc4f9JVpZ0W9ingNrgg+8KRh84MGQmm
         9JXw==
X-Gm-Message-State: AOAM531lN8FUISteEzAaD0YphwJza3XZ/Qow3wt8kNSxzOPClzGU4xun
        Kv7j6onstE0jCgy4qKBK+d5ay6WQLd69k9W524zCLFPetwM=
X-Google-Smtp-Source: ABdhPJwUnu1vN/INbx2vUpVqOAb6N7johNF48oW/SIDp8HZljTYbYeiuQ5QHP92pUUjXxQeQcXSjm5dgg2A3XgUCTOo=
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr15536373ejj.197.1596918323356;
 Sat, 08 Aug 2020 13:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200806164102.6707-2-shouryashukla.oo@gmail.com> <831df9f2-0663-0dfc-0871-d34864d1ecde@gmail.com>
In-Reply-To: <831df9f2-0663-0dfc-0871-d34864d1ecde@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 8 Aug 2020 22:25:10 +0200
Message-ID: <CAP8UFD20ORozywSAV+Qayuf_vwve9A21ySAtTZVphwhv5nYWXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] submodule: expose the '--for-status' option of summary
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le sam. 8 ao=C3=BBt 2020 =C3=A0 16:40, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> a =C3=A9crit :
>
> On 06-08-2020 22:10, Shourya Shukla wrote:
> > The 'for-status' option is used to compute the summary of submodule(s)
> > in a superproject by skipping the ignored submdules i.e., those with
> > 'submodule.<name>.ignore' set to 'all' in the '.gitmodules' or
> > '.git/config', with the latter taking precedence over the former.

The above seems to suggest that a name like --skip-ignored could fit,
if we wanted to rename --for-status.

> > The option was introduced in d0f64dd44d (git-submodule summary:
> > --for-status option, 2008-04-12), refined in 3ba7407b8b (submodule
> > summary: ignore --for-status option, 2013-09-06) and finally perfected
> > in 927b26f87a (submodule: don't print status output with ignore=3Dall,
> > 2013-09-01). But, it was not mentioned in the 'git submodule'
> > Documentation.

After this we would need to tell why it's a good idea to actually
document this option (and perhaps rename it if we are going to do
that). It could be a good idea, if it could help users to see a
summary without the ignored submodules.

So for example a possibly good justification could be that in a repo
with many ignored submodules it might be interesting for users to get
a summary that contains information only about the non-ignored
submodules.

An example output of `git submodule summary` both with and without
--for-status (or --skip-ignored) in an interesting case (where there
are many ignored submodule) could help convince people that it's a
possibly useful option, and that it's worth documenting.

> > Expose the '--for-status' option accepted by the command 'git submodule
> > summary'.
> >
>
> I've had one concern about exposing '--for-status'. As of now, the name
> of the option has no relation with the behaviour that we get as a
> consequence. So long, the option has been internal and this wasn't a
> problem. Now that we're considering to expose it in the docs, usage and
> autocomplete, I would say it should be done after renaming it
> appropriately given that it's easy to do now than later. As to name
> suggestions, I really don't have any.

Yeah, I agree that finding a good name and a good use case for the
option would surely help.

> Also, as to whether exposing this would be useful at all, I really don't
> know.
