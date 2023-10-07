Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F94E95A61
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 10:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbjJGK0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbjJGK0t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 06:26:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0E92
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 03:26:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-58916df84c8so2004380a12.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696674407; x=1697279207; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9hFDfgTjitVqTpRhG8PdlQKG0+R5J3rswyD07oLWoQ=;
        b=YMDnZDm/20ox3TTOg7F+ytxELKIBymXfdL1cL/OBZrI0ebasCmPQtklV5C1PWpIv4b
         mJV3FXXM/NVBZz9RaWfsG7H6BSmb/ndytv7qnaTXyECaAChxI9w26KMxj9rrhwy6qeW6
         uns1FN37AHED35OL1gGbhYnPlF0k3TGk7RSf8DBOLxnuckqb/Y60n+he/+rgLVosB2pF
         W8sgjb0JbSz2z4PPLk5Y2JWFkf4++IAAl/rd3v6D2gMvCvjakv1VSuVhlO7Td5GB+hWQ
         jyZEdjJRO2pnSmIOAuy/BfOuUXXIxQqG+RuZTkCZg1s2nnMna+QMasXV3G/AHzfS1XTu
         2/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674407; x=1697279207;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9hFDfgTjitVqTpRhG8PdlQKG0+R5J3rswyD07oLWoQ=;
        b=azDxZYu02shps92PkKygFk06eWhQ4MkY5fhxjzISgIAOuJx7MtIP15z1gcMEzf1miv
         F6VvoaPKCNujVNz8dnZ8XlbgpBz5jB2P7GJPqVM8pdlTEG3pkPOXIsbWb8icQVU2Z7bB
         VDP/RYysAvX2/pxjH5MBOi9YoU02PgkFpWBTiy6cQiefvb/O4eCgA1+8ZG/OFo88ehoc
         p8ibarwq3R00eDMpatd4sIiDEzSydw35zRtD0W9CamvbQGhav3MEsuLa9hO4nPpU0qh8
         8NIvj4hmRvk1CDWUVv2kb+UTGveqOhQcl99mD4liWMxO4nKxZQznaVJ82pFTUfyydHlO
         NZ2Q==
X-Gm-Message-State: AOJu0YzIsq+1DOZn0OxP41YxPm1YNzrbOCwR5BQjDYLFKoq5CCoqPpZ0
        1ZWh8gFD8ULPDdsHrCLuvRDWNXY/zAYYMngBxTmcOFsPtHeyd6uC
X-Google-Smtp-Source: AGHT+IGj/BRf7n15ONuxfcbe3EAeuZkQjQ/gLhAEKJhHcVK8t85pZBihVqY335o3YbDoRKdStlo81UiA4SCBHbBZbog=
X-Received: by 2002:a17:90b:4a0c:b0:26b:4e40:7be8 with SMTP id
 kk12-20020a17090b4a0c00b0026b4e407be8mr10183499pjb.12.1696674406744; Sat, 07
 Oct 2023 03:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
In-Reply-To: <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Sat, 7 Oct 2023 11:25:21 +0100
Message-ID: <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,
I am interested in working on this issue
https://github.com/gitgitgadget/git/issues/1555 as a micro project. Is
it worth doing and appropriate for a micro project?

On Wed, Oct 4, 2023 at 11:21=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Isoken,
>
> On Tue, Oct 3, 2023 at 12:21=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail=
.com> wrote:
> >
> > Dear Git Community,
> >
> > I hope this email finds you well. My name is Isoken Ibizugbe, and I am
> > writing to express my strong interest in joining the Git community as
> > a contributor to the FOSS project. I recently came across the project
> > description regarding "Moving existing tests to a unit testing
> > framework" and was particularly intrigued by the opportunity to be
> > part of this exciting endeavor.
>
> Great, welcome to the Git community!
>
> > As an aspiring software engineer, I have always admired the incredible
> > work done by the Git community in developing and maintaining this
> > widely-used version control system. The project's commitment to
> > fostering collaboration and innovation aligns perfectly with my values
> > and aspirations as a developer.
> >
> > I understand that Christian Couder is the mentor for this project, and
> > I would be honored to have the opportunity to work under his guidance
> > and expertise. I would greatly appreciate any advice or direction he
> > can provide to help me get started on this journey.
> >
> > I am eager to learn, collaborate with the community, and contribute
> > meaningfully to this project. Please let me know how I can formally
> > start my journey as a Git contributor and if there are any specific
> > guidelines or resources that you recommend for newcomers, as it was a
> > bit confusing process for me to join this mailing list.
>
> Sure, please take a look at the documentation we have on
> https://git.github.io/, especially the pages and sections I mention
> below.
>
> First, we require that applicants make a small code contribution (we
> call that a micro-project) to the Git project. This is explained here:
>
> https://git.github.io/General-Microproject-Information/
>
> If I have time, I will perhaps prepare a small list of possible
> micro-project. For example we prepared this one for the Outreachy
> Winter 2021-2022 round:
>
> https://git.github.io/Outreachy-23-Microprojects/
>
> but no promise. The "General-Microproject-Information" page has
> information about how to find micro-project ideas anyway.
>
> Now we have recently added a "Thoroughly check your eligibility in the
> program" sub-section to that page. Please read it, check your
> eligibility and confirm that you meet all the requirements soon.
>
> Then there are links to tutorials and a number of other useful link
> for Git developers on this page:
>
> https://git.github.io/Hacking-Git/
>
> Also the following page is useful as it contains more general
> information about how to apply:
>
> https://git.github.io/General-Application-Information/
>
> > Once again, thank you for your time and for providing an opportunity
> > for individuals like me to contribute to this remarkable project. I am
> > enthusiastic about the potential of this project and the journey
> > ahead.
>
> Thanks for your enthusiasm,
> Christian.
