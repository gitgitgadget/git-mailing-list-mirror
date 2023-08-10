Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E659C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjHJWAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHJWAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 18:00:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AB1703
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:00:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586bd766310so18030757b3.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704842; x=1692309642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wg8VtgMX8ILOvwW4O5m6/zimC62MKue7YdM+m3cFII=;
        b=fg2wW8aMZzj5Ww2ZG8Vfqn7Wp3d8M9fUKutJiwNaBlDJK9majs0P7HX6R75PHlbnp+
         8qDoHvaW5doe/xTeg3m+Gc3B+4d1JfhNoRhs18rDvUdriniuxrjPj2ZaOeB7hQVGTS7J
         wMCUN6ArZfhH1FGcgs5VpVgDj2BsamzggoLrKbrEFXOWy754iM6GmVR5EzV6JDqX2xNl
         G2/am6ZPrwVlu5yG9O6jH8P7vfDFe8vK/k7iwtINxx5FAvLn5jsqAQ4YTmHiBmJkMsAY
         LeBZzKNVLbDJ4CcxPCHb57mDIRzrCtmgtxn2GVkbLYsZvBtON5egIlXjOIA58PBeaCp2
         F7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704842; x=1692309642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wg8VtgMX8ILOvwW4O5m6/zimC62MKue7YdM+m3cFII=;
        b=cIgRlbxAPEoBhYLzPxX49fC1SarBJl+qsu7UM+0LUg8M0TW98ACuVtNja6g79j2LWr
         XJw7zRMlhCyyEODfJM7hW1kWrhPbH3iz/00VzVf2okAUHjhRAQ/hbyCN4CBJV6elG29o
         nxGnwf2zNKhQ2guUhzSwy9+h6vH1I9EnHXeGGGrYv+VoApAapF25ufuwnUo2/ES2gNvB
         0imEr25T6Cqk+0dkT0KL4js2IHaHJgyuHoOwJu1/f8iDFvzJcg8C9qnwVxrHJTa5LXIE
         z82//Mk33kOpXvdV0TbTrqIoAF/g6CMvxgl0zkbJuLhi5oywUnI5cqc9s5ShblEyT0TT
         Id8Q==
X-Gm-Message-State: AOJu0YyzIrxHHsqNUb/lyGmLdVGW5vCSuhQOrED9g09uaHpAR12f2imu
        6WIlXuQv1F75D8aNbj7h5L3aWPf6iks=
X-Google-Smtp-Source: AGHT+IFyAauJhDK9Y0tC3tznP2WsmRZFDFJRTw6l8v62bN0sbVAhIm16zHsa5iNCVePH8QukGY8DHrLOx8k=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:af0f:0:b0:586:4f9e:24a3 with SMTP id
 n15-20020a81af0f000000b005864f9e24a3mr4132ywh.3.1691704842701; Thu, 10 Aug
 2023 15:00:42 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:00:41 -0700
In-Reply-To: <owly8raih8ho.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de> <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com>
Message-ID: <owly5y5mh81i.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
From:   Linus Arver <linusa@google.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> How about
> the following rewording?
>
>     While git creates a basic commit message automatically, it is
>     _strongly_ recommended to explain why the original commit is being
>     reverted. In addition, repeatedly reverting the same commit will

Hmph, "repeatedly reverting the same commit" sounds wrong because
strictly speaking there is only 1 "same commit" (the original commit).
Perhaps

    In addition, repeatedly reverting the same progression of reverts will

or even

    In addition, repeatedly reverting the same revert chain will

is better here?
