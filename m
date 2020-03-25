Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788DC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328720777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB4F8rBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCYSD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:03:58 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40114 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCYSD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:03:58 -0400
Received: by mail-vs1-f65.google.com with SMTP id d18so2111402vso.7
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8UXVQCFMrZT7ZSKml7MdWI2mD4gVI8QU/JB8BYxvsG8=;
        b=nB4F8rBubdogHexei1q1vVTKpXYhAQDrIw4+TDwv87TNofLeq+9CewmvMOebiIrT4n
         NSIpkxAVqtrso4GmynyIwNVApSMxDF/Y7LxgF1LlU1RyJP3Yv/rlsY+0gzpLSD7v5fCZ
         zNnv6S5uSh5tu/jVy+wqK+7NMbtpK5agMgjGfuDg3HlITcQLpJ++5r6oV7SaKCol6ORt
         nAWaGz1bNKkTUwBYgQ6aZVnni5gTa+C66MxnYHiglAZOiTueDn9RRjMPCffXsNNE3BVb
         pLnGHrMMRGq8EuWRXxpxrNjS7loqvcuROodJpp1feH/c/vEnxNgsClxyF9Ilx/tpcQvX
         nptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8UXVQCFMrZT7ZSKml7MdWI2mD4gVI8QU/JB8BYxvsG8=;
        b=hFoH0RC2GkCClMWsL4uf/lIX+7z+sAhxUPSqGODUNiWxPgX7fIi9292Hox7A3/Q6Mq
         67AchEMOJX3er1DMTbuLluTT48KGBDNRKxgdIiyWKD5tCKmb45rk5cRSM70Wupfw9t79
         QdEyT2DVg6MsiWWErNH0GDWL9ahwzjWzCiK5SBA17CKx1iWIun3gwa41feJpJUBFDMjx
         yKK7kRwipExsxWH5mysjwnr7zDUpkbm+nim5q4Q1+FsFSHBqRjQUBBeo34iDzone1DnV
         LaIeKMAZbc6YdrE7onsgMP4Iw5iwBfcs1oJ5l8aQD9cgdOFHBYXBx956F70UZxDRjmjr
         B2kQ==
X-Gm-Message-State: ANhLgQ0nI+WCsUYgadL+z04/foIuDfiN6FifxWwIjUioYuzQH1elJyD3
        8OJjVePN+wqkswAOo+Uk7JUuGsXYUMvQCoz6WKM=
X-Google-Smtp-Source: ADFU+vvSlH91vUucfSMAhHcri4dTLQx/Cre+xj17t9PQmEIxhrhSkwh80qkuL1F4YssF46+f4+tH2VvRljRfRs/ZFbs=
X-Received: by 2002:a67:cb84:: with SMTP id h4mr3739599vsl.85.1585159436648;
 Wed, 25 Mar 2020 11:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200325013434.219775-1-sandals@crustytoothpaste.net>
 <20200325013434.219775-2-sandals@crustytoothpaste.net> <CAN0heSofpxFW81=sB+4ukx9S0JOJo_XuKDTBSkTy_-QK+jDz0Q@mail.gmail.com>
 <20200325110328.GK6499@camp.crustytoothpaste.net>
In-Reply-To: <20200325110328.GK6499@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Mar 2020 19:03:45 +0100
Message-ID: <CAN0heSomisiFsO-_bkGYFgj0nS5yZy9ewU883APDiMK5Sw=srg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: add a FAQ
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Mar 2020 at 12:03, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-03-25 at 06:23:49, Martin =C3=85gren wrote:
> > On Wed, 25 Mar 2020 at 02:37, brian m. carlson
> > I read this as:
> >
> >   How do I prevent users from making "certain changes with hooks"?
> >
> > As opposed to your intended meaning:
> >
> >   How do I (with hooks) prevent users from making certain changes?
> >
> > I'm not suggesting the latter as a "fix" for this "problem" though,
> > since it's a bit clumsy. How about adding a comma:
> >
> >   How do I prevent users from making certain changes, with hooks?
> >
> > Or maybe just dropping those last two words.
> >
> > Please trust your judgement on whether this is a problem, and if so, ho=
w
> > to go about addressing it -- I know you have lots of such judgement.
>
> How about, "How do I use hooks to prevent users from making certain
> changes?"  That seems to both read smoothly and avoid the misplaced
> modifier.

Very nice.

Martin
