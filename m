Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6CF20401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdFPEWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:22:55 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33587 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdFPEWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:22:54 -0400
Received: by mail-pg0-f42.google.com with SMTP id f185so15659351pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WyUk6/tYG858HaUA7PPaxGF4SfJ1mV2ZOEIaL5I3NhQ=;
        b=vZUr1PDk0BLiUigXwEKLoOqoTLUz/yekUmmB9p+E3UihMx7UJVZV6BDBSDq2WEEqzn
         A97dg8VRzpqS46soeoO/2fapJdinG3Yhjjs74QvF7YqxpWlFIJhIV02R+QIUvbxv/fLG
         1ceWACsbHsYYTvahBu6ON0Ts83s69a/0PjTlZ6sLIJ2cGxMV7fY3Nwhwvbm3Po8sjPOb
         QbeDGY87Ou6WpD+JHPmpGgdZohcQkQA+wAWOFduXRRWTG9rU+hFenvtlnWjE5sUs9JbY
         TI75DsbABD9lOMLqBtkGT5ez2uRSmPRSMsQSwl7pNttq6lhz8swG2t2aYcymTq6JcCjW
         LDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WyUk6/tYG858HaUA7PPaxGF4SfJ1mV2ZOEIaL5I3NhQ=;
        b=f4mYDGoHx0J0Nxa9ssucg911U3s8/eBAWWYwkhfeWNaMAuKsbzkP9cwUN64h3WlkN4
         n/WSrUfU6f4yPcENnsFrJjTRS8PubW32WyxxrmEgL/d1huhKZASH0F6dOCOpXTWdX2TN
         M+g+doBoz0klHKZrkH70EEZIfRimaIUhDBsdiHg/vPGcZOsLtgjcAlbefGKSp02+pRk9
         lTb0g3QoHBhFbaXCsf8UTs83poSWOnaGUNiunTlJgTZL1hCNREP+A6dtEP2Y1aO2bOp3
         QjNQwoezPsG3h4iSakLv5y6PbEQ0zpS0LSfyGAhtQFD+wB7K93XQD2CSJDtA0nyAOxdO
         Sw6g==
X-Gm-Message-State: AKS2vOzeape1llei+S9x4fHpDGxesiEyBL3cwtUIDeTy3kIkCQXAox+Q
        ERxUqdudMtg23Z6PQht3Guj0Q1IMcinpHyBnqQ==
X-Received: by 10.101.85.69 with SMTP id t5mr9049504pgr.201.1497586973839;
 Thu, 15 Jun 2017 21:22:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Thu, 15 Jun 2017 21:22:53 -0700 (PDT)
In-Reply-To: <59432BCC.2040901@eagerm.com>
References: <59432BCC.2040901@eagerm.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Jun 2017 21:22:53 -0700
Message-ID: <CAGZ79kZMCz9g7PW6km3gQJU5qipw27jvkVDXD64MUNKJykYZOw@mail.gmail.com>
Subject: Re: Best practices for updating old repos
To:     Michael Eager <eager@eagerm.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 5:52 PM, Michael Eager <eager@eagerm.com> wrote:

> One other variant of the rebase approach I've thought of is to do
> this incrementally, rebasing the old repo against an upstream commit
> a short time after the old repo was forked, fixing any conflicts,
> rebuilding and fixing build failures.  Then repeat, with a bit
> newer commit.  Then repeat, until I get to the top.  This sounds
> tedious, but some of it can be automated.  It also might result in
> my making the changes compatible with upstream code which was later
> abandoned or significantly changed.

This sounds like

https://github.com/mhagger/git-imerge
https://www.youtube.com/watch?v=FMZ2_-Ny_zc
