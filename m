Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E393AC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1646613DE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFCRs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFCRsz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 13:48:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA6AC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 10:46:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso6520376otu.10
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=STq48bmLUgazQxXt9srhq6PcdM4JrkAehFDWZCjgwtc=;
        b=uBA0czGKMnMExWTjWzBJfZtbMoaXqwlR322RdTlchdYch8f1v3qzBcgzKCBRPeSW0Y
         ng5G1foUn43jdNY87GmmiSWNJAr10IV0WRRXP4PHTW4v38VXCTfRbUmJA/skkJNau6JN
         cvjjeQ3zsEz1NiXQ+Ped23mza+uNtw7IspAvaRtKc9DrI6epH2//x8xYx6K7sYcv0IOy
         wlURQz8pNZitcHw1BPDOhd12V2N+afDvrZr0328TrC+xj2wqo1SIx3sYPhlY3GUFFYke
         95WjxVos/IKyWcn/suTKsXOqB4VW7tcwTtZcOhg0Zr2mbQUGpoUzB9XAcVaKMBdVGPmF
         oBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=STq48bmLUgazQxXt9srhq6PcdM4JrkAehFDWZCjgwtc=;
        b=E37Q+ipHPqjXHsz8bcZgXYLmwOGMSm9kim+ZxcKWVsv8B6cDsa74ljB5LU48pYLqw9
         eh0m2EfhtRhYkZuzdifn6JsajwEG54at6cnqUgpyLCpnsehK1RAD1Gav7umK9a/zTRM6
         pqZ8D2GoRQxTOnEu4vhRLVqeyBPvi+vwVbV/yZ270Pb11AIyYSO3ZRG/1b9jaruiiphl
         NSSqXnQPK1wRtDPNHnF5Yuy//ulsvlMihJMcvh3jtZa4sy89gggMreDO5cPlM8zMjFr2
         KW1sZ53v/6M+4WAwGXbq1AySDyHZjM4Hmr4evfViwzYWRJ6RgvMGiFMYT/5L9YZatSYU
         TNag==
X-Gm-Message-State: AOAM533xtR9yBIgcU35AKSHP6zQbvTnoZUW+lIyOiep0fqHuuccFd/OP
        f4qclXS2r6QrKr8u5FmbU6A=
X-Google-Smtp-Source: ABdhPJzHsJKHicuU07Lxne5f2zcPuAyKnsuvcmDSvVkjRek/q60+1VHnQrxh53EhxehPJsZSbPKpzQ==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr430084otl.8.1622742417284;
        Thu, 03 Jun 2021 10:46:57 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g11sm853869oif.27.2021.06.03.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 10:46:56 -0700 (PDT)
Date:   Thu, 03 Jun 2021 12:46:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Message-ID: <60b9158f92812_258801208e0@natae.notmuch>
In-Reply-To: <878s3r73g3.fsf@evledraar.gmail.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
 <878s3r73g3.fsf@evledraar.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Jun 02 2021, Jonathan Nieder wrote:
> > Bagas Sanjaya wrote:

> >> We wonder whether git send-email can support Gmail OAuth2 so that we=
 can
> >> seamlessly send patches without having to choose either action. But =
however,
> >> we have to create a GCP project [1] first in order to enable Gmail A=
PI. This
> >> can be overkill for some folks, but unfortunately that's the only wa=
y.
> >
> > Yes, that's how I have mutt and other tools working with my Gmail
> > account set up.  See [1] for details.
> >
> >> If we want to enable support for Gmail OAuth2, should we hands-off A=
PI
> >> configuration to git send-email users, or should we configure it on =
behalf
> >> of them? Note that when we go the former approach, some Gmail users =
simply
> >> can't afford GCP pricing for whatever reason
> >
> > I didn't have to pay for GCP in order to set this up; I only had to
> > follow the instructions at
> > https://developers.google.com/identity/protocols/oauth2 to create a
> > client ID and client secret for oauth access.
> >
> > Alas, I don't think Git can provide its own client secret to do this
> > out of the box.  I could imagine Git providing a way to supply an API=

> > key at build time, but distros would need to go through a procedure
> > similar to [2] to make use of it for their own builds.  If someone
> > wants to set that up, I think that would make sense as its _own_
> > separate package --- e.g. a "sendgmail" command that "git send-email"=

> > could use via the --sendmail-cmd option.  That way, it would be usefu=
l
> > for a variety of calling programs and not just Git.
> =

> It's been a while but I set this up at some point, why would git or
> distros need to make/register a private key? Last I checked you can tak=
e
> software like git-send-email or whatever, and just register a new
> "jonathan's e-mail sending script" with Google's OAuth thingy.
> =

> That "jonathan's e-mail sending script" happens to be git-send-email
> with a bit of configuration isn't something they know or care about.

If Google requires a client secret, then it can't be used with open
source applications. Period.

Sure, you could create a developer account, create an app, get a client
id and secret, put into your authentication script, and the finally do
the authentication.

Open a browser with the link, type your password, verify on your phone
with a 2FA app or whatever.

And finally you'll get a token. Which will have to be refreshed
regularly.


Or you can just create an app password.

Cheers.

-- =

Felipe Contreras=
