Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A57CC636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjBBUuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjBBUt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:49:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563984235
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:49:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lu11so9662807ejb.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYDjoS+MGIGMJ+pIad636PXGVrTjqK+/UkcltH+/PA0=;
        b=Z/5HYvfNlIHg0iFglDfNW5poc7+mLlskF3Y57IFgA7jGY1AD+j4a0kAQzbT6IjraeY
         JW35wzhCq/g3MKAAi40U25IPc7loOoAXhC64WlPAo7qrWemWKtofBXHxeXWkUf+b+Cw3
         EIPdcqel2muxmbQ+TIoxQN6wD8SMqCxexpDVzvmCmn4qTgoy8155nlL0cs2Ek5V8kfi9
         Iy+4mpcnXPMD47H7WpMyglPPdU5ninfG1zOCLRYFi86NLDs5s6IkZGiOhQri2+ny9dVj
         sqHCANCQh/nhlQknsnDAM2ab4bKdpvZvLTD3zHSpCoAqLdUWphq9KMuomAzNTw2pPZ80
         S+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYDjoS+MGIGMJ+pIad636PXGVrTjqK+/UkcltH+/PA0=;
        b=Ol7WZ30ZfAgvLXUMhO+K4q3WggEaccuThfCmg9PO+GXrTGFrEuEouEP12LxSmri0gt
         cnTVXb52yk5GFpaGPX8ZQOwEFFwlFNFkOO5FxuCB7iDRKVIoF1mdwl4A2uRM7iWC1wlT
         I05ICIa24zu7eapLNiZWjtIxBJ17IQesO4Up/ZR23fiEz2W1I5FCAmgwk1LwOYb/g+kA
         nNAcpeAkiYyni2+EsjlEglzwV1pmoCFGUSLhjAhwTZVB0cuiFFoKwbtt3CIxQJKVu1C1
         SBIvQwn8LpqFjXDRmkGxv2R28G1j6Dqndh0LGxeBXWWXAdvhGgMiUCR4tT1dRihWABT/
         CzqQ==
X-Gm-Message-State: AO0yUKXlkAXgz0uNjeGTVxcvk8nDu/6vWKNRJ5Y622aYbqO9OCzgw3JQ
        1sSpVLXosIeKqGrXCfeJVMwxVsufFI2j3JWTq1s=
X-Google-Smtp-Source: AK7set+P/l1uquxZ93HXVLaKfEPC35O6tYacSGxEb8CtGULZWBlLhRZ0LSppov/JJFLaPJUL7viR3LXeTlYgvCxmlts=
X-Received: by 2002:a17:906:ecef:b0:884:3f4f:fa8 with SMTP id
 qt15-20020a170906ecef00b008843f4f0fa8mr2084415ejb.29.1675370996731; Thu, 02
 Feb 2023 12:49:56 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net> <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
In-Reply-To: <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 2 Feb 2023 15:49:45 -0500
Message-ID: <CALnO6CD_x5Dhh-x8wq6BGT10Qv7iPzsjZyD8Pun0GCKwKKRczw@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     demerphq <demerphq@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 11:22 AM demerphq <demerphq@gmail.com> wrote:
> I've been lurking watching some of the regex discussion on the list
> and personally I think it is asking for trouble to use "whatever regex
> engine is traditional in a given environment" instead of just choosing
> a good open source engine and using it consistently everywhere.  I
> don't really buy the arguments I have seen to justify a policy of "use
> the standard library version"; regex engines vary widely in
> performance and implementation and feature set, and even the really
> good ones do not entirely agree on every semantic[1], so if you don't
> standardize you will be forever dealing with bugs related to those
> differences.

My understanding is that the patch suspected in the subject and linked
several times in this thread _does_ use the native Darwin regex
library which causes the problem, but I can't reproduce it in a
smaller program (see previous mail).


-- 
D. Ben Knoble
