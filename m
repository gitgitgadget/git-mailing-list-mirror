Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF0EEC8738
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjIGQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbjIGQP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:15:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A712139
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:14:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so18856421fa.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103189; x=1694707989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb5fIn6hNdaaPNusBbM3OUFj2WMtO25Kj6ZYNow0E2I=;
        b=jQrnVdUVCB5mnFNinaMZW/WDJv4PrzRrNCUtqsAz5EAc+tZumL9UAbtols5flE7SDP
         US0hcoAiReM80qUph2ENKJZdFXy5VO7HebOgjsty5OJqV988+E176A9A05trbjJzxFPr
         Zy6fSJ/yaXOSeBiFcXNVSokdRsl3B7CyQLhHexX9TbIO8ICatCWJbN7RVebIwxY6L/qV
         NvlK8cdvOhudhOJEG1Dlchxakj2nDlkJiaUwgSuHMk1X2tDDd/qoGYPWcD/9bF7ETt/j
         fLX6hLU00z2j98AlHdhvKEkgTpAuXJSqACkCcf3n8tZzJ3hDEWdvHRPzSyH6uj1puhVB
         aKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103189; x=1694707989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb5fIn6hNdaaPNusBbM3OUFj2WMtO25Kj6ZYNow0E2I=;
        b=NqUn6N5iQHhRWJBLnFuZjeu37yJ0uL+wASqBrTpsZJRDSPBdnqMfGDQVezen1syol7
         uPRk6ucUZUVOn2h5WdCF8T2rqirvJmV+F3yQlthkX8VSz3wjIYxhtpv7l8lLQob26fQA
         EL+MoX/UDqrfUkeEy3HB0uo1oM3Rmj4NyN8eBr2mFIghvRNcnnqrpsg2daCTWW3zjTw2
         VqTE22pOFkhjU8FVxWn1ZE+uyIDQACuYsxbt13fh+DI/lvu4JqYqCGOcZwB/C37IOmle
         vVUN4/oBQ4vMBxSHILRhb5OQ0xTEyb9BS6qNgFbYqyg8SjfYsGXtPuRdhuG4bILgdOwk
         bxoA==
X-Gm-Message-State: AOJu0YwQSIJshiljnVxOFFF5rzwcjQQ2mY8mYewMki8htl6aVdByUB7i
        H9gCLzsLjx8Kygy1hCrTVc4rgyRNnLl0TBDXU5w9cxPY
X-Google-Smtp-Source: AGHT+IF+M/E+430r1OhfGZcwBjf2Ad4S1TN8eFJH9QcMUeQVZdbq53g47Sj3z90uHurl+8Ett1cOIoIOcHNYzMB1Yug=
X-Received: by 2002:a17:906:cc12:b0:969:93f2:259a with SMTP id
 ml18-20020a170906cc1200b0096993f2259amr3902143ejb.73.1694075577589; Thu, 07
 Sep 2023 01:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-12-christian.couder@gmail.com>
 <87legbsths.fsf@iotcl.com>
In-Reply-To: <87legbsths.fsf@iotcl.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:32:45 +0200
Message-ID: <CAP8UFD1_67rNke1y-GV7qX46GXQkNJzw7fXfK=kkUjc-jb5S_g@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] replay: use standard revision ranges
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 12:03=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +DESCRIPTION
> > +-----------
> > +
> > +Takes a range of commits, and replays them onto a new location.  Does
> > +not touch the working tree or index, and does not update any
> > +references.  However, the output of this command is meant to be used
>
> Small suggestion here:
>
> Takes a range of commits, and replays them onto a new location.  Does
> neither touch the working tree nor index, and does not update any
> references.

I am not a native speaker, so I am not sure what's best here. I find
your suggestion a bit less clear though, so until a native speaker
agrees with it or maybe finds something even better, I prefer to leave
it as-is.
