Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92241F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 17:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdAYRmK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 12:42:10 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32800 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdAYRmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 12:42:10 -0500
Received: by mail-lf0-f48.google.com with SMTP id x1so46193742lff.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mk4lL3dh5e10mAI6yASxQB0TDH4seR2z35xCSQJBTn4=;
        b=oUTPciReiJJevlXXmTm3oVrhUXRrmi8WBgnX+ph6vCzI3kgQpa+c/CaUnGKZGAjCwo
         TYFMpEyNvD9DzGIecm8POf7BNb2MvUoX4fVO/7r6W/3+aiRJ7NVfziESylfaXeCqVt2F
         Z2b3SlZkvyQt7t6NlGRc/l3Cj7UrhZfRlPBbYkm2EhsFtFNiFGSJujROlHT46ayoanhw
         v5kwsIxeFeLFzQIusZW3UKXmDql4pTbzmWTTyC+Fy08SAz67QurKGhTFBMb8sJV4akoa
         /LHaMQ7CR9XfOiFDFkxLIdcq9viUB4emrRRm8uqZInjJh8WkCTfU9aklpCJItnBhUaYS
         a3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mk4lL3dh5e10mAI6yASxQB0TDH4seR2z35xCSQJBTn4=;
        b=nHGJba0DSgmQ25wqo0QsBUvI/TDbvpHUrSFQl0OloE5lyLh4jF21hrJiIaWgZXmMC6
         1d1U2WA6DYOlwbJWuqv37j2fRAMzZ32FfNeaGteBAY4Podtq7rd5BJGEOBK2fjo1czdq
         4pRT7IVXxfoJkGjccYwWInz/1rNZG6O0R42hmedaeW0gp1RP/yoo95Z43Arec8VuLZ0X
         CLfk/o1VdG0OoHZD8A3k0P8fHw13NRM4hskADlNg7JjawAMsf/vv2zmesZRoS9Nq+5lV
         Ym9xRTqaP4/ZRgR2lZpT14TL/VPBrTaPXFWVh4NpmfmeziF6CnQm519L8NCr+Q7ZBv7S
         y2GA==
X-Gm-Message-State: AIkVDXIbs05khQypRww/pOzA9L/L35/nij/6NF4vdBlivD5ItcW7a8AUSyaoPKIJvlYaZsBIaPDb95eY/fFijA==
X-Received: by 10.46.14.26 with SMTP id 26mr11801834ljo.59.1485366128090; Wed,
 25 Jan 2017 09:42:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 09:41:46 -0800 (PST)
In-Reply-To: <20170125125054.7422-5-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com> <20170125125054.7422-5-pclouds@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 09:41:46 -0800
Message-ID: <CA+P7+xoL28hTdjbPfau_cgui3j73pMJqOBsM+5-kKSA369yJ1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 4:50 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Behavior change: "--exclude --blah --remotes" will not exclude remote
> branches any more. Only "--exclude --remotes" does.
>
> This is because --exclude is going to have a new friend --decorate-reflog
> who haves the same way. When you allow a distant --remotes to complement
> a previous option, things get complicated. In
>
>     --exclude .. --decorate-reflog ... --remotes
>
> Does it mean decorate remote reflogs, or does it mean exclude remotes
> from the selected revisions?
>
> Granted, there may be valid use cases for such a combination (e.g.
> "decorate all reflogs except remote ones") but I feel option order is
> not a good fit to express them.
>

Limiting the scope of the exclude seems somewhat reasonable to me,
because it makes it much easier to explain and show the user. We do
need to make sure it's not going to break any scripts or other issues.
Is it possible for us to produce an error if the user does "--exclude"
without a necessary connecting option?

Thanks,
Jake
