Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C13C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88612205ED
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 07:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrQ8n+iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQHiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:38:21 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41872 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQHiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 03:38:21 -0400
Received: by mail-ed1-f47.google.com with SMTP id v6so9995903edw.8
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ehNb8bUy2PZ/Ar4RPXxZCXt7JpHRuMaI0iajorgjF+s=;
        b=VrQ8n+iQDq6g+6/+vOC7x98ntHxc2miR8X6yNryAEffTkh0PV6ZQMsMPV0vtDXuTTT
         eR/LRsl85VYYiVl7ws3htiAY52hxT6fwADeXEG8s6zv6tJoo4DAY/Mod+tglvP4liMXR
         KmNYvrFQms0k/yh2iMKMqRun2I7Q9gy539Gh2uPaWKUc8IDnB/nNiXadTW6sHZMRjy/x
         1EnnP08jldYufsN8hrJ2H4hOeIUOd93Gv9FZ0Jo4uDfRFUhFSurMXMVMbz0ZK7Mor2a8
         5fi1GiXilus7u43OJCwQlOqYSr1jUzR+dnmH5QzExi8I8kn/2gNc1ddEXSqApSido+/5
         FZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehNb8bUy2PZ/Ar4RPXxZCXt7JpHRuMaI0iajorgjF+s=;
        b=ksPK2P6shsF7Bol7/YFPPU82UsZjpBbKF902daAr9+Usvz+q/PLr5jwlX/C0ICNwA0
         jr1Jxf6r0Z2CYuXi0V/W5lmjeJ7S8Ugf6MDajZY3sjTIYG/s/U8ErYpEB7s+q+dN6355
         DPVbNdb/u4YwyDTRMvu7gQdQ8JUvh/rpRubad2CM+m65BvgXMygzIgpCktxm2Ojj17Ye
         OhhDS8ppSdiIo5BWLcA9+mVEgMJzwjY0BD1V4j3ft7gOv1tc/mXyzInojfeFyPQpvaVu
         xZ06uBwm/C7ajc5gUrXfJJvoyDOBDHqB9kzoElf2DZurykpXB0/CErg98hvUoui3F4y/
         Jf1g==
X-Gm-Message-State: ANhLgQ3LqO8q9WnfXOizJLrTUAbI+ydlotuQRPa/dCCnPLlnsuEymOaU
        va1SbyNMqRkE4g3rIk56C7+Vt2OMod8bMKwWYDk87eEO
X-Google-Smtp-Source: ADFU+vs2CXQbTW2KK/HCf963BOok8J7fildtCG9BdFhaiAEJAEbdPyCTuiRWr8DJ27mcCtEvUYpsZvIP70XqV2Qx5XY=
X-Received: by 2002:a05:6402:8ca:: with SMTP id d10mr3882750edz.362.1584430699100;
 Tue, 17 Mar 2020 00:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au> <58425B78-7C6D-41CD-92AE-434D0A58F968@jramsay.com.au>
In-Reply-To: <58425B78-7C6D-41CD-92AE-434D0A58F968@jramsay.com.au>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Mar 2020 08:38:08 +0100
Message-ID: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
Subject: Allowing only blob filtering was: [TOPIC 5/17] Partial Clone
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, James Ramsay <james@jramsay.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and Peff,

On Thu, Mar 12, 2020 at 5:01 AM James Ramsay <james@jramsay.com.au> wrote:
>
> 1. Stolee: what is the status, who is deploying it, what issues need to
> be handled? Example, downloading tags. Hard to highly recommend it.
>
> 2. Taylor: we deployed it. No activity except for internal testing. Some
> more activity, but no crashes. Have been dragging our feet. Chicken egg,
> can=E2=80=99t deploy it because the client may not work, but hoping to he=
ar
> about problems.
>
> 3. ZJ: dark launched for a mission critical repos. Internal questions
> from CI team, not sure about performance. Build farm hitting it hard
> with different filter specs.
>
> 4. Taylor: we have patches we are promising to the list. Blob none and
> limit, for now, but add them incrementally. Bitmap patches are on the
> list

We (GitLab) would be interested in seeing the patches you already have
that only allow blob filtering.

Thanks,
Christian.
