Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEDAE7B5E6
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 10:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbjJDKVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjJDKVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 06:21:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31790AC
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 03:21:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso349740866b.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696414860; x=1697019660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgv/agVlXtelxUW3bKE86MzC6ciB8yWeaBgc4I7PkH4=;
        b=EvSaNXq/JfVL55JA7OYqqJoad7NEaBNIsTTJN67lWh5HtfKh9hKSvGcWcrUBo3K/XE
         Fbx5qwamBWL+A9reXbau2/GlNpZZ7Sd1FtbH2qTZ/JpSDlme9YyQJj9a5C1vh+e4mOLJ
         u6B9Ygb+Hdq+yCGKXL9uH67lFPxrKAz4QZrWuiIjD4o7znWhUChWKbcr0M7WVsqGffdZ
         UYxA3Rzu8QEvVbvLbu1+UutVvIWZS2oW512geqVVJzxM9vA57HcGO4d3cpn5YJ8dyYPw
         gDS2L9c/3m8QelVO6sJxxUcYINIcu5UJnKEgg65ifQ+prb5Pcmhv4URR0bOL7xmtnUdi
         uflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696414860; x=1697019660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgv/agVlXtelxUW3bKE86MzC6ciB8yWeaBgc4I7PkH4=;
        b=gUu3uv74ypbJVPCBeY6tTk/IGnr4hDbpCak6ZPB9lHi1w4u4ZJFE1gqlD3xJZddD/o
         hX69bYWh4CpQ2EczYOOGiBYmBzcMv7exTLa/EyhbLQdSxNenk267YlVS0/DgDVrkdVIb
         PfIb4Uiqb0W4SDyhSVO3UlzK1Z/h1uzjeejP+WLncmfBzvYAzwlAbrt0j3X0a7gN0XAb
         aY+Rh2TyQ5FIDMHl+h/lQ2BscbeQJIHyIojZWcREasQ96W7ENM7eVq0GsV/r0CJVasGA
         q6j4VHLLR5MBBSl17JVFf/5KLPq58SV+EPApr6YcOZ9ODe4MsGkAHrPVKj798Hs6C98P
         3rWw==
X-Gm-Message-State: AOJu0YzkRA7ry8H/R2kxE4MXEkmrpRMpAcTPiBlLjNE2Ya8DnhoK0pz3
        R40ygyyx48Thm5q9ViUlhvcReQizSN5A9ruAvocEFaEArD75kg==
X-Google-Smtp-Source: AGHT+IHUJswooQuxyc6fMnh+abPEYyuGj0QPKUDU7dNU114PWYoWlULWQjoL3kM4QheFGe74Y5MTPzQ9hxC206wuCfM=
X-Received: by 2002:a17:906:74db:b0:9ad:e0e0:d6ab with SMTP id
 z27-20020a17090674db00b009ade0e0d6abmr2001984ejl.12.1696414860425; Wed, 04
 Oct 2023 03:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
In-Reply-To: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 4 Oct 2023 12:20:48 +0200
Message-ID: <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Isoken Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isoken,

On Tue, Oct 3, 2023 at 12:21=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.c=
om> wrote:
>
> Dear Git Community,
>
> I hope this email finds you well. My name is Isoken Ibizugbe, and I am
> writing to express my strong interest in joining the Git community as
> a contributor to the FOSS project. I recently came across the project
> description regarding "Moving existing tests to a unit testing
> framework" and was particularly intrigued by the opportunity to be
> part of this exciting endeavor.

Great, welcome to the Git community!

> As an aspiring software engineer, I have always admired the incredible
> work done by the Git community in developing and maintaining this
> widely-used version control system. The project's commitment to
> fostering collaboration and innovation aligns perfectly with my values
> and aspirations as a developer.
>
> I understand that Christian Couder is the mentor for this project, and
> I would be honored to have the opportunity to work under his guidance
> and expertise. I would greatly appreciate any advice or direction he
> can provide to help me get started on this journey.
>
> I am eager to learn, collaborate with the community, and contribute
> meaningfully to this project. Please let me know how I can formally
> start my journey as a Git contributor and if there are any specific
> guidelines or resources that you recommend for newcomers, as it was a
> bit confusing process for me to join this mailing list.

Sure, please take a look at the documentation we have on
https://git.github.io/, especially the pages and sections I mention
below.

First, we require that applicants make a small code contribution (we
call that a micro-project) to the Git project. This is explained here:

https://git.github.io/General-Microproject-Information/

If I have time, I will perhaps prepare a small list of possible
micro-project. For example we prepared this one for the Outreachy
Winter 2021-2022 round:

https://git.github.io/Outreachy-23-Microprojects/

but no promise. The "General-Microproject-Information" page has
information about how to find micro-project ideas anyway.

Now we have recently added a "Thoroughly check your eligibility in the
program" sub-section to that page. Please read it, check your
eligibility and confirm that you meet all the requirements soon.

Then there are links to tutorials and a number of other useful link
for Git developers on this page:

https://git.github.io/Hacking-Git/

Also the following page is useful as it contains more general
information about how to apply:

https://git.github.io/General-Application-Information/

> Once again, thank you for your time and for providing an opportunity
> for individuals like me to contribute to this remarkable project. I am
> enthusiastic about the potential of this project and the journey
> ahead.

Thanks for your enthusiasm,
Christian.
