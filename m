Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D6C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C85207D8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbQo+xYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgESJoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 05:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESJoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 05:44:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9693C061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 02:44:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s3so11216497eji.6
        for <git@vger.kernel.org>; Tue, 19 May 2020 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psbIrsAYcjZLAqAvaZy6/G/0BWZRyut4Ws1X/1kAD4g=;
        b=cbQo+xYZdk/fjumSgDjW3dZQnbh5+YjxVvC+ZxsPEMnJz8amwpF2NrR8bleurGs4kr
         uwbhZZxPBH2CPuUFRZ13QCHfgz2gi3N0gS3bZCLBBA8ZGHqrL/B8wrljZJjqHi46vx/s
         0UjjWSZ7+G1BSodGeWx+PvsHbIEXLMmLQENMR6xOsGmj8707pd9JvVQN4J10oLa4bv8C
         2wHXTRMknsdMDKb1rD5Ccq5qO+GLhVYcHMObb+ykfQnh56Ou6oFiQ+nL9lFuy9rkgEvn
         3NQTUVqCzYXOPmb8zQ0qcCIWiSe1Z9RJ4pB6Q7RgF12fa8F2zyyeZdN7JRypKNXwYCar
         N9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psbIrsAYcjZLAqAvaZy6/G/0BWZRyut4Ws1X/1kAD4g=;
        b=gm8G/WxxqbhnniKAhIab3gt5qrwoWUOcalft3DKYP28ow59Lznbgg+E7jSCp4PwJwm
         Vy7KRezkNXDqAAwGbsYoJmdfxvkzpga3PlJSwnbr5zmiDAX0U/X9+hiBWPwFpJQdorzq
         R1NAcElULNKC6u1++OwBc8fgqMDt1MIi8Y0/QuMmm5rg9ok1OJvQbjkRw6NT41onklEs
         TvJJV2enSvPK7+BZjst8woOI5gaBYBcLEp0EpAHBxfgFORHwkeDXoxaT50Df3zZlKMEo
         XaNg1c44jUXvYHwS90ByEQNEHBfY0cxQlr2mxMsJMfnDbWiXrw+ef8kWtvXchMXZT/21
         ezKw==
X-Gm-Message-State: AOAM532gQ/hB6JG6ecrWIuxMvLzl5hJyHeZjVYVuSEjEtC9TiepaEfw6
        lgaehpuNrPk/Z/NxAdn8oIGucaaGnU0iQEtAnVo=
X-Google-Smtp-Source: ABdhPJzOLqrxtY+aOWp6YPl/HqrkcGw6Y9ljEvNBG62eLVY7Cebx/4D3jJe6J9CGxw3dvJKEpr8xryxDbXDBIkKXE1o=
X-Received: by 2002:a17:906:a856:: with SMTP id dx22mr18997258ejb.255.1589881454431;
 Tue, 19 May 2020 02:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515184716.GM3692649@coredump.intra.peff.net> <20200515185534.GN3692649@coredump.intra.peff.net>
In-Reply-To: <20200515185534.GN3692649@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 May 2020 11:44:03 +0200
Message-ID: <CAP8UFD1JndLk=cxguLuwv+hV5-TdNrr+oT4wJ4bBhhCHe9JM4w@mail.gmail.com>
Subject: Re: [PATCH 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 1
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 8:55 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 15, 2020 at 02:47:16PM -0400, Jeff King wrote:
>
> > > While there are still a lot of static variables at the top of
> > > 'upload-pack.c' after this patch series, it does a lot of ground work
> > > and a number of cleanups.
> >
> > Yeah, I think all of use_thin_pack, use_ofs_delta, etc, should be easy
> > conversions on top (and will really give us the payoff).
>
> Hmm, none of those fields in upload_pack_data are used, even for v2!
> I.e., if I apply this patch:

[...]

> it still compiles. So starting to use those would be a behavior change,
> as we accidentally let use_ofs_delta, etc, propagate from one v2 "fetch"
> command to another for ssh/git/file connections (but not for http). I
> think that's fixing a bug (but one nobody is likely to see, because it
> would imply the client sending different capabilities for each request).

I agree.

> I think we'd want something like the patch below.

Thanks for your patch! I have included it as the first patch in the
"part 2" patch series I am planning to send once this "part 1" will be
merged to pu or next:

- the commit with your patch:
https://gitlab.com/gitlab-org/gitlab-git/-/commit/458b79f0f563226bf50924553fc3889cb0942864
- the whole branch with "part 1" and "part 2":
https://gitlab.com/gitlab-org/gitlab-git/-/commits/fix-upload-pack-variable-scope5/

> Some of the other globals, like multi_ack, are really v0 only (since v2
> assumes certain baseline capabilities). We could either leave them
> as-is, or roll them into upload_pack_data and just let v2 code ignore
> them as it does now.

I am in favor of rolling them into upload_pack_data. That's what I
started doing in "part 1" and continued doing in "part 2". I think it
makes the code more coherent and cleaner.

Thanks for your review,
Christian.
