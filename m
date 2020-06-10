Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB40AC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 05:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794722074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 05:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/TUuaA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFJFPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgFJFPV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 01:15:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1CFC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 22:15:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e11so709329ilr.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJehKcnyxuJ72q7W2+DzoVKaHc3o0M0UyUT18KJeV8A=;
        b=k/TUuaA5oIssa51OgNYgBrGpUf86VKMsxRfYRTB7R/iKhbrTG94cJapDL9tg3XVTrB
         2x5QNAYQMrtQrgEAoQTmAaotCVXXXdmFulT3mJmdUuSVNHx2HX7MMEaM+cfWaWXB+tvK
         CG8cbKwP1u9Jq7pw/0ScBFTyaXCKEv9ABpUSRoXcdrbywzZ1W3kTPs0AvZkXiicIdEBm
         Oe87vfkhxwKrWAA8L8XEGU0LSDbicUAa+4b2Us7Nn8Dge3xu53tQk3oyl4lLAGvVlzGh
         axa1GMEzJCp70CCz73ESj4fsjnY7vKUOdbSgLNIinplDirVKyEn3bOFSReJ/c2phxX0f
         0HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJehKcnyxuJ72q7W2+DzoVKaHc3o0M0UyUT18KJeV8A=;
        b=ZhCMJHnLFNP1lTf0YuAbufqmpbV7KzX0FV+2fEda2maj7ueBrfi/WfA9QhDpBsgDnK
         7d5yWRVnNlcP4CoPsC3uPZ9fQ8xIVW5meQjvTjYxJQRVxhSw7TJhs6x9yMJpPtb6KYZV
         z44sIwkIutSu/sHiFPpenLOPwjKnF1FYz8tQlQB6NPNQ8UJOoMdHYUy6yfVBXvewuBBC
         ClkkW+uJCKOPJ7MehrMsDU2GiU6Da5uhalK1vu7LP7+pjCGKpNx394jWr2jQpD/xz3Ie
         vdkXM6+odblgISmoTG8YryHIjHXnZxcRyWbyKtAPYB67StM/wtp8gqtJarfjUjJgH7cJ
         gtCw==
X-Gm-Message-State: AOAM532L5QPLu0hByELycvLYe4ScdG1Tpk4OCvrIk8iCEIeVq0GmAYx1
        rDUYOJSLvxst9W9VULUkd9lOV7YKSjeRdHkqKM3udK2HRB0=
X-Google-Smtp-Source: ABdhPJxBOM5roiZX4uGqAmr7rXNgp+/Mu9njCuui9WSpqSEgejBvypPs+0CJSEowW9ddEVoAYkgjjMljj++6aCPUSDs=
X-Received: by 2002:a92:280b:: with SMTP id l11mr1359766ilf.179.1591766119715;
 Tue, 09 Jun 2020 22:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200607054849.1014185-1-eantoranz@gmail.com> <xmqqwo4ggfb5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo4ggfb5.fsf@gitster.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Tue, 9 Jun 2020 23:15:08 -0600
Message-ID: <CAOc6etaRe8a=njHxwdTsqFVP0Myb0MVrBMo_+2hcChJ0RJasaA@mail.gmail.com>
Subject: Re: [PATCH v1] builtin/checkout.c: replace bit-shift values for
 macros in call to check_stages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 2:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> The patch does not make sense.  The hardcoded numbers you touched
> have nothing to do with these macros.
>

Totally misguided myself. Sorry for the confusion.
