Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798AAC2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E8E2063A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sasXnbGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414969AbgDOPzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414948AbgDOPzh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 11:55:37 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5ABC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:55:37 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c13so239879ybp.9
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0heb9p+CCuUIB4yRT+GUzq/RN1Q+iamradLAo++Fn4M=;
        b=sasXnbGp0XnUExSa7KyDo9xOXVcTBFmIcZBV94kPlxsUSbOHkVRJ8soQyJqsdCRVxQ
         JNd9xcI7BYJX0dGk4sJVDmGMUu94hxCdijd7SwA+waG0zKQKmgznfGMdlNQ3tjyGO5CM
         owsQbX0vWggdkoTxnhuE6zbeeIYDG92SImt7jHrkKyilcCXjuO+kB88US+h4bRy7P4SE
         Cw/v1/0l690cmWvq7ptfbcLplJwekpcbK2SYvOySMNSspis73yod1xYsUQ/Y/2O/LHqv
         Mz+w5qfkHOR8QIcn0lxLcCMTZpHRNJgcpRBDtomI6x7Svzkif6temS2DKsxJ8kkYsvsW
         UoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0heb9p+CCuUIB4yRT+GUzq/RN1Q+iamradLAo++Fn4M=;
        b=s8VGMUWwjkM2wUdnjkdooMNNfcoT3ehtKxBmlh58vWUSfTisPYZeKI2peTzCqGp+Ne
         mQbG9xskynZyyJ0L+MC6moxT7W58yMp7YZwf3ZOkkzLCg5zh5qQm0Wy0xSb/yhv9aM7/
         sY/g48JTW81bmO+PrhavebDhF9v4UGrwCHxTS2fWbIpvDNlGlwlkkeXitrjnwC7J5JSR
         nsbc3Qh3q3oOMjXnmVYHStGwIlHZ0cvl2L9gJPTSwh2WH7mHhtHmwKfBYydznc6DbTpM
         pB+xMaIepDVocKyLG0PxHl+/mXNNH71iRTv1ybPZveYS3rbhX98ZU66bU6No4fx/kClq
         ffkw==
X-Gm-Message-State: AGi0PubQ3GXKB2aGM6mQ+mm+Kdz2uQbESkQXMe77obPa+FN9UVAWIind
        K8mWt822cDFPb6E7eehJ5JYQzELTP0fxg/rB2bw=
X-Google-Smtp-Source: APiQypJ48OYRBO2g7KcKiRgPG2CF/o9nhD0TE9UjSvrg/QmKviswE661q1en5qUGVR9bTF9Sy8QgdBITP8WBXx/Y3zo=
X-Received: by 2002:a25:a06:: with SMTP id 6mr9416045ybk.238.1586966136395;
 Wed, 15 Apr 2020 08:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq3697cax0.fsf@gitster.c.googlers.com> <20200414123257.27449-4-worldhello.net@gmail.com>
 <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 15 Apr 2020 23:55:25 +0800
Message-ID: <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 2cc18bbffd..fbbb01135e 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -13,6 +13,7 @@
> >  #include "remote.h"
> >  #include "connect.h"
> >  #include "string-list.h"
> > +#include "string.h"
> >  #include "sha1-array.h"
> >  #include "connected.h"
> >  #include "argv-array.h"
>
> What are you using from the system <string.h>, that is not covered
> by existing inclusion of "git-compat-util.h"?
>
> Don't include any system header directly in our *.c code (unless it
> is a platform-specific compat/ thing).

Will correct it.

What I am working on for reroll v13:

* Add new commit "receive-pack: feed extended_status to post-receive=E2=80=
=9C

   When commands are fed to the "post-receive" hook, `extended_status` will
   be parsed and the real old-oid, new-oid, reference name will feed to
   the "post-receive" hook.

* Add test cases for "git push --porcelain".

   I found some changes not covered by test.  So I decide add some
   test cases for "git push --porcelain".  I will split the test cases into
   multiple files inside "t5411/" like:

       t5411/test-0000-normal-push.sh
       t5411/test-0001-normal-push--porcelain.sh

* Other minor fixes.
