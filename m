Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF5C10F1B
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLIH2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLIH1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 02:27:20 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969C740456
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 23:27:04 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3cbdd6c00adso41796397b3.11
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 23:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI27dDPxIHYBhQ1cCtoCAZuFO8uL2/6617sVGv0XbLQ=;
        b=FC26MjmgkopwPJaxaRhQBf8jyO5Sn1S+/BkE+wHgUOQcTkvvktPIBeQKvrrr7RMb1W
         cY/BU6JZTizVVg438s9e/i63J9zwHm3iNbc7lKdcasprgMFh9Huqr9GpeouXXfJ1aGma
         d+ASaJu+u0Xtjlv0dNaMsxIB+TSy0xNUNv0ryWlzM5hJTDRJCtmmXWxj6P7zGuSUINFd
         m4zpVrcSE7JIi6dBh9pjIvdo+uVpds4o0i+sk/nsN8OJa3g7uN0muhDFZtG5fPBUgwiE
         iLPBTg2ahBwkbDDIpcNtRsvLx0CqfWG308o1x+LXwzOE27QL2X+fTmbW+39LMuvRrJ0c
         hRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI27dDPxIHYBhQ1cCtoCAZuFO8uL2/6617sVGv0XbLQ=;
        b=nwaP/34tvKJuzQD57Oie6YZnf2gnGbaMXupGqhqk7rSd+5fqhU9LEwZ/QojaGyS6wx
         GOiugzAPMw1ne+tSswmmlymphNPsVW9Gu4rS6Q4+KzPDNNrkpweLC3yFL3ZR3EfdZQk6
         igS6JJx19m7Y16l0vY6FQW2gHDKUh+apscI9YWO4Cbh0c3cJeGd/Hqae2bH5FWvtaqO+
         czMlxgKM947gsxvDL3NEuWANIWvpr4s+vD2PzFnEVg4F3gU1xa5LwDlvBy75CQrEAWZR
         4hAdTJiAu/dh6VIpSankr4rUJBd9ZXWdawpSXS5H26WpdxAE9RdcDOCpM+qKyoXz1vof
         DGgw==
X-Gm-Message-State: ANoB5pmT7FLTfFe2bVEgzXpxLCkJO8Fg6k9uR7ShnpxQNh18wpN+tP9X
        yfSCI2Ixw6y6BoJZvr+N6RL9Djq8lrIqEj6DqSI=
X-Google-Smtp-Source: AA0mqf5OBhWIWwOlee3fsVYfdr5JB2njec+O99hwJEMEK7vtt9bKhU/9i2eDnxEJAhNei46Zu6pyMkD3ucFB9oItK5U=
X-Received: by 2002:a81:2546:0:b0:408:5edb:24e2 with SMTP id
 l67-20020a812546000000b004085edb24e2mr533231ywl.43.1670570823630; Thu, 08 Dec
 2022 23:27:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com> <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net> <20221209004918.GI28810@kitsune.suse.cz>
 <Y5KRQMcUlepwNlor@coredump.intra.peff.net>
In-Reply-To: <Y5KRQMcUlepwNlor@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 9 Dec 2022 15:26:52 +0800
Message-ID: <CAOLTT8SR6JWX6mRLbyq4keb4JCfJP6Vq07LzHpb_f+e1jMnsZQ@mail.gmail.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=E6=97=A5=E5=91=
=A8=E4=BA=94 09:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 09, 2022 at 01:49:18AM +0100, Michal Such=C3=A1nek wrote:
>
> > > In this case it's the mtime on the object file (or the pack containin=
g
> > > it). But yes, it is far from a complete race-free solution.
> >
> > So if you are pushing a branch that happens to reuse commits or other
> > objects from an earlier branh that might have been collected =C3=ADn th=
e
> > meantime you are basically doomed.
>
> Basically yes. We do "freshen" the mtimes on object files when we omit
> an object write (e.g., your index state ends up at the same tree as an
> old one). But for a push, there is no freshening. We check the graph at
> the time of the push and decide if we have everything we need (either
> newly pushed, or from what we already had in the repo). And that is
> what's racy; somebody might be deleting as that check is happening.
>
> > People deleting a branch and then pushing another variant in which many
> > objects are the same is a risk.
> >
> > People exporting files from somewhere and adding them to the repo which
> > are bit-identical when independently exported by multiple people and
> > sometimes deleting branches is a risk.
>
> Yes, both of those are risky (along with many other variants).
>

I'm wondering if there's an easy and poor performance way to do
gc safely? For example, add a file lock to the repository during
git push and git gc?

> -Peff
