Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC2C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBFVRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBFVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:17:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2396181
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:17:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g6so3744570wrv.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9cf1OsfLNKtLHzYsb0wazhNeHvZ9CKJ6bA6hGzRjVo=;
        b=IdudcFRRni0RtDx2jHfxasahPYNinIHHlH2i/1RUxiHdrjvO9Q8kJXOY50FHL3x/hM
         hxMsj0pWZDfn3YOsc0s2xEdQenk/pSOsgX2NrtptC5oiZw/U65doDiUwxBDzz/O2U+Cq
         bxWXcFnMOnw6mz5roampNOVNxFsi4mPjBM1vawLECAGGOgZTK+xFUfMD2VINn+n7mRaN
         S2ALet35KBF7y5uv1Uzyyfi4YTYujFRvDKbcfiDgaNJd5vY2xReWueT/nd60tzMnu7/4
         EjPTJvURhHjeuBuWuZimHonPTon5Em46pHKlzcQm/UDiFWBScBrglbA/BrDJ6kBvjEEP
         Thgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9cf1OsfLNKtLHzYsb0wazhNeHvZ9CKJ6bA6hGzRjVo=;
        b=J94NkdUOxsxm5QN/mW4MdEdbrbZVEDADT0yNQRyHS3T67VBuHMRwzXyHho/KAju+qQ
         eIlNAWlr/JSezTOuafoEiLyZ1Y/Dy0pqNt9caSJydkqdrUivIAfydC9XPfXVlA3ZO6aQ
         9/xS36D42syZVX7EXmDx45F7UcWp/ZTMheG75HKZEuLsY1cILWKo+h9xqiOkEJaD4kM8
         VwohdkUpip4hiMtwQADoShnAjdmEMTYZp5S+7lnVzF6pzmlk+ux8mRH7fIipmnAJNrUW
         GoxXvdEesq/Si79nJ3zGX5366Fm7Jnrdyj1hax85v0oA3mUzvXWwhKvQ36pIYAkBW/nB
         rRXg==
X-Gm-Message-State: AO0yUKV9s4gEmLGTSMSumBojWT2RwxrzHVvwr1DCryeupCHG/3uhUEXI
        3Djvey0O5NL1zn9NmrrSSom02qPUbT3rbC0Nwnmaj6HzQfY=
X-Google-Smtp-Source: AK7set+h2qqddG+tiQEFfODKiWX9wOzloXHESuK8C0t/H1vDM7naD0dpZhqTqUZxd2DmYrCkIXzJesX5d0TFpQ2hrKM=
X-Received: by 2002:adf:f490:0:b0:2c3:ed5b:cb67 with SMTP id
 l16-20020adff490000000b002c3ed5bcb67mr15246wro.275.1675718248511; Mon, 06 Feb
 2023 13:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20230202171821.10508-1-cheskaqiqi@gmail.com> <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230205145245.11078-4-cheskaqiqi@gmail.com> <CAPig+cTH_5Bu48fO1Eub25CLZmRCmz4EjYz9O++H12HGTVXU0w@mail.gmail.com>
In-Reply-To: <CAPig+cTH_5Bu48fO1Eub25CLZmRCmz4EjYz9O++H12HGTVXU0w@mail.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 6 Feb 2023 16:17:15 -0500
Message-ID: <CAMO4yUFnSQzf9w=gKU6JhaRYbSwhCi_QK1pAQbOuaTa8uEiEog@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] t4113: indent with space
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric

On Sun, Feb 5, 2023 at 3:30 PM Eric Sunshine <sunshine@sunshineco.com> wrot=
e:

> This probably ought to say "indent with tab" since that's what this
> patch is doing.

Thanks ,I will fix it .

> If you do find a reason to re-roll, though, I might suggest swapping
> patches 2 and 3 since the current organization leaves a mix of tab and
> space indentation in the tests, which makes reviewers do extra work
> since they have to look ahead in the patch series to see if you fix
> the inconsistent indentation in a later patch.

Yeah ,I didn=E2=80=98t realize that .Thanks for reply! I will send the V4 s=
oon.
----------
Thanks,
Shuqi
