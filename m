Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F90C5518C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E972C2075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy4Wtdex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDWACo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDWACi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 20:02:38 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDEEC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:02:38 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c17so3904285uae.12
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHdtu+N3PsWzQ/kpha3heU8LQqiYvck9yIAQsK2wWGk=;
        b=Cy4WtdexyuGH3z1MOYeEecQVDC6tdyNz8e3DAM8Ne/RnCnP+Meexsbu/0L9WImmMea
         traY2V00JHjW6G1A/fv6JwNLOUXew0H5qnW/mwWh/GW+qVcyF8dpA4goMqGE0VUfaUqa
         Li4lxLqPCKWmBmcbaIgRbI9ELHFg4z8r8U0twTEdQ0Kq5wxViwohFuG4/onM7XoMIJ2w
         D5hKe4XVsqhoXk9ifozoa9PI+d22MXkL5b8oeZh1KcRY1SUMzdsn9hQ60dZJ+my2zJqV
         N1dv0tqzLx+BEKVpMJ0G3DaOEfy8BUx/K8zzsNc/YOpahMkO9+d+rKttoGrpvpnTgW2l
         Zm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHdtu+N3PsWzQ/kpha3heU8LQqiYvck9yIAQsK2wWGk=;
        b=LIMK8uRpkToN+URjKkSdnda38R/s+tWZV1QrON6KhC9z94NNIiHgz8l82AYTSQ07tE
         fpgA5wiO2yY+EdHR3cLh1ylfiO9Y7UygH/bq+EHhbOztOaRt30ihfE33t14B01tZCJci
         j4kVvYMBmP63hr+cB4qwtzmd+cvRWV63TMRA6kfli0akfKbrM39+flNSQWTjmTEklsNS
         QgNX0l2KaEP2VxAxx/K9Y4nam+ApZ+5zmvQ/yjAbjquSPurndvTXhrNCbzpYsRpcFm7p
         FLST2ATunUtb6ZT9/1gaG5g45elkPLKdUKuSGJ7ISsqCaYQHRTVS28fSQQKdi+YuVNf8
         E/wQ==
X-Gm-Message-State: AGi0PuZXgEHTj8JG19quy2OYHcmsizhi8wbZG0NAeKY17xj/1h3Gk4sQ
        bObqFuoPxNbg/o5GbM/h5Xiw0BmiyDp2Wy7tfSk=
X-Google-Smtp-Source: APiQypJxx+bF3M3CfNOHF1PnrgFN6c/0+MKMCIA9m/8yJcDcnLhot7A5QPDelkpwaIuu+TFJEwdV+OE1WjDU+HlkmWY=
X-Received: by 2002:a67:f7c9:: with SMTP id a9mr1204396vsp.7.1587600157719;
 Wed, 22 Apr 2020 17:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
 <20200422233854.GE140314@google.com>
In-Reply-To: <20200422233854.GE140314@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Apr 2020 17:02:26 -0700
Message-ID: <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a
 non-strict mode
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 4:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Johannes Schindelin wrote:
> > @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
> >               host = at + 1;
> >       }
> >
> > -     c->protocol = xmemdupz(url, proto_end - url);
> > -     c->host = url_decode_mem(host, slash - host);
> > +     if (proto_end && proto_end - url > 0)
> > +             c->protocol = xmemdupz(url, proto_end - url);
>
> What should happen when the protocol isn't present?  Does this mean
> callers will need to be audited to make sure they handle NULL?

the previous code was ensuring protocol was always at least "" (albeit it
might had been easier to understand with a comment)

removing the proto_end - url check would have the same effect, but then
we will need to also add a explicit xmemdupz("") for the nonstrict part
or audit (and with certainty add) checks to prevent a NULL protocol to
introduce regressions

Carlo
