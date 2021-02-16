Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF5C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDF164E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhBPWbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBPWbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:31:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA27EC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:31:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d13so6307331plg.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mail-followup-to:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=VDR6Yv+3yhGlzSaJO1X/8o5DqeLIfiS9iSdWOIpPF74=;
        b=iGoZuJuumXYWxGBsxcnM3XkQWf3bgwdbbrsFV6SgRPwDAFgaBuOfdMJdMqqDsRMRzq
         /vJDB+lqJHRzPFAFs1YEviqqpFxgDDwdQcGt41jB1tCOKNMQolYmgx0NIjQ8vOSKzHe+
         EkBosjtO2vPt+lLcXP6pmpyw4AOve1HFz7J4+ZhGR+zl3Fwpnpz6y/sgck2JEaTiqwyL
         vfS2fnLqOKCZTbfyf8WmNLYG0LCs8NyE5pvOyNxj/SNLeV3ewmIcNBYv47GG6DtwyevN
         jsirLFU1ZHGJz3GaYpGSryB/fULcjH660PAT9Ryqdds6CCPMuwMoNvsjjggRJG3RhmX3
         L5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mail-followup-to:references:mime-version
         :in-reply-to:date:message-id:subject:to:cc;
        bh=VDR6Yv+3yhGlzSaJO1X/8o5DqeLIfiS9iSdWOIpPF74=;
        b=VaoH0rxk7963vsYqn2BEbt4zEz4pBWYB7bMhj6aRtDRVziLCIJ9UiU7qyrMg2nCxKm
         ynqZsY6BXFQS27aGMnMbvwcty1uKn3NjI0WZewMvjl6UCU2OOsNuRpm3biT4viFHVFtW
         fy3HTFcz5VYoRXsswa7120MYxQnmdUd3TZXF3sWA8WtYjxfbKibN94iSAQlyTQFKg+Kh
         wweADeEPXhTJz0xFla2kXA2X6PeqwYap0xSwRxz1MRv3LAfh0jseV05cLRRQ6LuIpWZG
         x+R3i5IBTwz1mCmOCXMlSDk8er4R8lmbalcv4kHVjP4pwkc/1fM2STEOlZqBict6srNe
         1uWw==
X-Gm-Message-State: AOAM533hhuIDZUoVyex+A57tayeKSqF0m2ZPTwrdFv4UDlqjoc5OF5WQ
        cu08ePTerbQPt4LQ9T0mu9O7PZBTeDdU67WL4ik=
X-Google-Smtp-Source: ABdhPJxYGZwtB5SR41oSN9SOZmRRYZZcznuG4INV8IWj/pj6usePvm31SrgPFdWMD3NCiqVz4M16RQoynKJXw//onlU=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr21441493pll.0.1613514661528; Tue, 16
 Feb 2021 14:31:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Feb 2021 14:31:00 -0800
From:   =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= 
        <khardix@gmail.com>
Mail-Followup-To: =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= <khardix@gmail.com>, 
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com> <YCvotU6KVruFuf9/@coredump.intra.peff.net>
 <xmqq35xvrgbg.fsf@gitster.c.googlers.com> <YCwXf1CA0Xyw/B88@coredump.intra.peff.net>
MIME-Version: 1.0
In-Reply-To: <YCwXf1CA0Xyw/B88@coredump.intra.peff.net>
Date:   Tue, 16 Feb 2021 14:31:00 -0800
Message-ID: <CAG+K25NhVdM6f2sXG3bDODH2ZEBXyfPuoXYtHoeC1X2YFOwnRQ@mail.gmail.com>
Subject: Re: git-send-email: smtpserver in $HOME
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003db7c305bb7ba8e6"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000003db7c305bb7ba8e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2021-02-16, Jeff King wrote:
> =E2=80=A6 It matches alias config, credential config, and perhaps others
> as "treat this as a shell command".

I will have to take closer look at the '!' prefix in other git parts,
but I like that approach.

> (I'd prefer to just have $smtp_program or similar as that signal
> instead, but it doesn't seem worth trying to retrofit it now).

That would also be my preference, but it would be a larger change
and I'm not currently confident enough to go this route.

From the points and ideas raised (and btw, thanks a lot for those),
the easiest one seems to be treating $smtp_server as path options,
the cleanest one a new $smtp_program options,
and the middle ground being adding support for '!' prefix.
Unless someone beats me to it, I will try to throw together a patch,
aiming for now for the '!' prefix and falling back to path option
=E2=80=93 as this is potentially my first contribution here,
I'll see how it goes.
--
Jan Stan=C4=9Bk =E2=80=93 Khardix

--0000000000003db7c305bb7ba8e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7bd0b89f3bc39238_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVZdjczM3Vsa24w
UVpmdWczS1hMeUEzc2tPMjBGQW1Bc1I1NEFDZ2tRS1hMeUEzc2sKTzIwSHR3Ly9XQW43SVEzaUVm
RjJHOFVNVTN3aHBnQk5mT0UvNDFxWUFrM1o1MzJsVTJMb1FCNDhkUGxybXpOVgpvR2RYcGpMeVdl
ZHg4UjZpMjJadG5qYzRwd3JsdUZWVm1kUEp5cjZ2QzBzeW9YLzVITHdJN2h1SEhUSDJuSmVwClMy
TTdsd0NWWlVuRFVlMG9oM3ZkS002dm94ejBPTzhMMmo2RHpsdFROS0RUSFJXNVhDWmdQWERQZ1VC
QXVqQjQKWGRIbFNna1MwcGNnRDNpcWRmbmFxRUFRTktrWXdjVUJhK3ltUjF6T2x0TE9QeXhNc3Bn
ano0cXRyeEJjcHZ4UwowV1lOS1hicnpDUzI1ZlY2VDVKSU5EM3VUdXNGUktjd3djN25DWlc3QkpS
TWdZOHJPdCtoS0E5enpuKzZNZkVlCmRvR2VlQWNSUS9Td3YzSnVUL25lTWZ4SDRxRTJNWGZqbnR5
NTVZdmJwcWZpZzIwOHp5OUp5OUxaemc4Sy9ieFkKaUt5M1Y5MGhWc0lCOC9vVityai9maGdXYXR2
WlNITmhEL0I1SDRGak50Z0E1dGsrbSszZzRIOGZoSitPYm1aTwpFQWNpOE1jTUVhMkFNb3QwclhS
Tlo5OTRHWUhnaDFrNlpTWjh3OTc4VTR0WERDYzU2cmJTakdVUmNyQ2xYbVBICk1iY1JVZFlUSzNh
bkk5aS91T2tjdUx4RnhtTmFOejFxQWw4aGJ4ek43d3d5a0R5djdJcWhmOVhHSmd5d3dZNnIKcndQ
S0hjZkk4MDQvV3Q4SURDamk4ZVdkOGdiVDJFeXVMbnZvU05DVGxRaDE1Z0lTRHl1MXJIZUlvWUUr
dHQwVwpId1I4dENSTHpuSzdLdTdJMHREZC9pbm9GQ0JlVXJPVjh2MjlSNVBJMFhxbHY5MVRYZlk9
Cj11MXh1Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=
--0000000000003db7c305bb7ba8e6--
