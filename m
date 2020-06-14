Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6FC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0D206A4
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xteddy-org.20150623.gappssmtp.com header.i=@xteddy-org.20150623.gappssmtp.com header.b="laOPGTup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFNO7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgFNO7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 10:59:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2DC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 07:59:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so14549021wrc.7
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xteddy-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q53efy42ca7WaZPTFOer/KKN/J9n/HpOB3lHFROrw2Y=;
        b=laOPGTupNAdMc2Qx9r1SQ7QmsK+ZxZkFqNjxi/BryIlYO/l2ap4ytb1ADPvY5QETNl
         VfIjUw9E2JL63Fmoz9Un+Kog2mL6VnFsda5GFyeIF3FNewOh9Cg+G7gLvJMBmXixiNdN
         eXcoqfKhtX9sg6yCEuaDw6sEm68bAk2VIvOWVSV8XwJe3IvwfR/eliEX+0uSZWMtkrSB
         imItdBWfJvS38AURvQCT6Ldy8YvNjzlW3BvAtxEu2WYOts0v2DsYbKoE+LP10b4h9hDX
         yXuoKINo5yLjawQ52nlNc/USIkh3DtcgUYwl4APBBWI3CK8MgqZed41vCwtsRTz0IWxY
         R5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q53efy42ca7WaZPTFOer/KKN/J9n/HpOB3lHFROrw2Y=;
        b=uMMrFzSiZRmFOrjtg4UpOS8uHUi70/wDZgiGLwbW9AFbU1yFmVPDoXCjg6ageOO3wO
         XdSm4K3+IgmmkCI7afU0KMioSHM+8sxjmiRFT+bwEi0jmFIqEgrhm4WHQgVLrdX8Oh21
         4+QynNDYZP9u2MtktToKNa6qLG2P+0gEcIZMyqEv9UsvIDtKn5guquUd3oq7a97ol6tJ
         r2Rn663Smd5vLVG3alAD4RsHrtgB617CgVbpDOtoPFWbOCvIqcOL0rn0QJwgVqzJxzg2
         9qjgP/3n4GfkSQlLrQ7bpSdATMRKpqKa4nznYdkb+aEXEsbgwraBDjF8D28TOAW04S/I
         H9xQ==
X-Gm-Message-State: AOAM533rap0ZJSXY/5f/EqgATQy/wE+f3s17lm1ZKXV1DmcRsSunmkds
        qvInrIMSYC9QKF//pd8mwteoaKEY+8KlCLx7S2zNgKPepLw=
X-Google-Smtp-Source: ABdhPJxX3PSOgXGTIoWlpyp+4rpxVHLSCz+sUxddxpTO7Z6LhGhhed38ckKBJluONFYcZs+vGgMz4qQwILstcdxXZj0=
X-Received: by 2002:a5d:6150:: with SMTP id y16mr26286750wrt.219.1592146752045;
 Sun, 14 Jun 2020 07:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
From:   Thomas Adam <thomas@xteddy.org>
Date:   Sun, 14 Jun 2020 15:59:01 +0100
Message-ID: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Simon Pieters <simon@bocoup.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 4 May 2020 at 18:22, Simon Pieters <simon@bocoup.com> wrote:
> To avoid offensive terminology and to avoid further inconsistency, I
> think git should use a different branch name than "master" when
> initiating a repo. I don't have a strong opinion, but I like "main"
> since it shares the first two characters and it's shorter.

Hi Simon,

Definitely agree, and thanks for starting this.

One question that's been rattling round my mind is how we change the
documentation to suit.  By that, I mean, it has become common parlance
at the moment to say "master" as the canonical branch, because that's
the one that's been baked as the default.  Now that we're making this
configurable, I'm curious how we're going to change our semantics to
match the "default" branch (which was "master") when talking about git
branches, either here on the list, or in documentation.

Kindly,
Thomas
