Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E6C7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 22:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjDTWdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjDTWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 18:32:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CE66EBD
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:32:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74e00fcdec6so68803785a.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682029929; x=1684621929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4LrUQ8bONVXyilX186f3w7kaTrZ/77pyRw2GDEcFiw=;
        b=oAkV+ofnFmWP8mRTpcXQRrpN33w1VvCY8Y4hdOjZAfY280BICD4FxcyWAUGz/gVYEa
         Pnr48MieZQ/lBCDF0zzMZT8RpFdPuacI5iyA+vo5vmtIzPuXMS9EHUTRQYO6FTZp3+Bh
         Nn3VW0j2Tt5HJn39dL8VW/TBoZ32i2b+DSupb+oOoO5XpfEWAiom6Q3y6ULpPrhOjBPs
         MftIQreouW0WqJpiJsHslv72CTffUrnJh/J/TlMcKOW2cnNPsz8HyXiGSR2ZS1r34Ot9
         X8kDqnoCjDQN4RZpG5ENvEPk8ljVwfJ1Hn+B1Bg8BuGMLyW6ORfUp//FArdv7y372FmY
         WHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029929; x=1684621929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4LrUQ8bONVXyilX186f3w7kaTrZ/77pyRw2GDEcFiw=;
        b=DXNOGKt1ANOr9UL8lHLvV6OyL9N9h895tUyjPIy/KptMp/Cp2jB5IPGI6xK7fXYkrI
         dtt+GWGucrWKykQHnxnlh+4MayuGpWgewMfONyu1JA2tAIX+3xfa5bXYTEcD8OVqdONI
         iakPs47olubqb3DX3PghCZQ7Z4tpSYF+FO1d9EyPZcHUTqfT+k5urc6f/iU8BWQxjJkG
         JoxVdmc+8uV8oimd1BXichquk+/xnuKFWL4PK3mVGb74pAXm/po1hpkH0QI49qh/Za7C
         NjhULQ17lxucr8/1dvcAbJpQGDsaUzZlzOEr+7uKmalRdipbjyMEZle/cQFGSglpQUe4
         ZyfQ==
X-Gm-Message-State: AAQBX9dfItLCiDUfbrlhqeQ0ADGq4pieHOjXSu3Fo3c1ZwOkb6KQcOFJ
        4p22NJIJ1TJ4wRI5Egr4XR0W6BCUzlTLl0mcaI/MBD2zSvs=
X-Google-Smtp-Source: AKy350YllywHfki/OMsV10N36C2L6KbdRMpgRM9W0QIRaoDvTGdqU5lwKTYgJKuZTTXvfmqzsZmYiRSrOogYytr2Ps4=
X-Received: by 2002:a05:6214:2aad:b0:5e9:81a0:87e6 with SMTP id
 js13-20020a0562142aad00b005e981a087e6mr4580317qvb.18.1682029929086; Thu, 20
 Apr 2023 15:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230420074616.1642742-1-myoga.murase@gmail.com>
 <20230420074616.1642742-2-myoga.murase@gmail.com> <xmqqmt321ozz.fsf@gitster.g>
In-Reply-To: <xmqqmt321ozz.fsf@gitster.g>
From:   Koichi Murase <myoga.murase@gmail.com>
Date:   Fri, 21 Apr 2023 07:31:33 +0900
Message-ID: <CAFLRLk9aLXx-j=W++qqiu5-Z0TpqdnyfR35+QA5aMZM=YRZvGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] completion: suppress unwanted unescaping of `read`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your review. The same as the other patch, this is also a
change submitted to our project and then forwarded here.

2023=E5=B9=B44=E6=9C=8821=E6=97=A5(=E9=87=91) 1:45 Junio C Hamano <gitster@=
pobox.com>:
> [...] But I didn't validate
> the other claim "may contain backslash"---the "... file paths, which
> may contain ..." in the above example is a totally made up claim, as
> I do not have access to a platform whose pathname separator is
> backslash.  Please replace that part to describe the real world
> problem you encountered that led to this fix, if there is one.

Because of the background of this patch (which was originally
submitted as a part of the consistent coding style in our project), I
wouldn't think this change is associated with a problem that has
happened in real use cases. But maybe Edwin has experienced actual
problems.

Edwin, did you have actual problems with the current implementation of
`__git_eread`?

For the record, I now installed Git for Windows in my Windows and
created a repository, but .git/HEAD contains something like "ref:
refs/heads/master" as usual.

Anyway, the default behavior of `read` without `-r` processing
backslashes is just a historical one, and it is generally considered
the best practice to always use `read -r` unless one intensionally
unescapes backslashes. Using `read` without `-r` is exceptional, and
doing so for no reason would be noisy in reading the code as the
intent is unclear. If flag -r in `__git_eread` would be rejected, I
would suggest adding code comments in `__git_eread` like "# We
intensionally process backslashes in the file because XXX".

I'll soon submit a new patch with an updated commit message in the next rep=
ly.
