Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69189C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 07:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiLAHdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 02:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLAHdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 02:33:19 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5014B303EA
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:33:18 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l15so479112qtv.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnkNFzR08FcU/bb5PDRRvBAGKzQNpcQQb94XY3ukVAQ=;
        b=XjbU9HzHIJJ7KhXprFjFLlEGyMdC5vLwEajCq0iNkgDuxCIGOB5OHqyaSxzydWSTFW
         Lu4uTI2zMHNY6hrGFUwUoHXAi+Kh5tVqP+oQEdLOyPTUO2Qh9ot8tqLKUvfyv1YBa433
         +P3E311/Zqvgn1fAxYMf20f28RN3DNOM5W6JS1uMQencsDc/YimDmFoluiGk25lqNsHl
         P8jYmwtU0lv808yS8Ug/jtkT62U55Fj7VAlqzab4yomc1vJlUBTijXY/OxLBdFAmGQtd
         wqsKgGxx4QDSTA65niV6S0hveSvK2BMmRLbuj5B/wSxrlnrUHyhou3e9yKqpN/0id6js
         cEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnkNFzR08FcU/bb5PDRRvBAGKzQNpcQQb94XY3ukVAQ=;
        b=QPCgMTZCo1YO+qqIO/ta5q8cqra8iqoC5ze0hItJUZIbsjefMXsS0w75qiyPzL8+GL
         ts09uuEy0h99p6A8EmD98RZEiBm0cAl3mk3JY5LpCKO2ASL4N0t3aZynmsUUhl3HgwHq
         pfWpmsEZAAWXt3T9oDSE0cwY4MD3xAa9AaCLgZ5b6AJY9h0ll1/FitEV6RFUMuNCnQPJ
         AtJifLbbVlf0W19idFA0cVy8w0lBKJbXb7MGEMGnMc6bXjgyFAWfG5YNbvaW3IvY9BE/
         cz6G1yeKZhe9aIP7WKapGjBMkpxrsaBk/6qgp+hDRR+iywPrnyynvvlApQn6rowu8zoj
         GU6g==
X-Gm-Message-State: ANoB5pluLag4dBN9P/MMFf91+lMd+ZRM16W4lqP2Tf2uUpVhqM8rddBw
        BydkuEX1e2erMvZ2ZhTZhqn9+CnRXOOYLtpERxs=
X-Google-Smtp-Source: AA0mqf5vZ+FxFJ6H5mZCuiytX06ua/1n8havGNFdw7pyyayKp11n+uNYM/0dhyAEYYxMKG3sa0qcewVwj+qDD57+sG8=
X-Received: by 2002:a05:622a:4c05:b0:3a5:274c:6118 with SMTP id
 ey5-20020a05622a4c0500b003a5274c6118mr59968398qtb.425.1669879997522; Wed, 30
 Nov 2022 23:33:17 -0800 (PST)
MIME-Version: 1.0
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com> <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net> <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
In-Reply-To: <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
From:   Ping Yin <pkufranky@gmail.com>
Date:   Thu, 1 Dec 2022 15:33:06 +0800
Message-ID: <CACSwcnRDmiiJU8hL+ON6c+b4Q8UtLVbtku_rHSD+c+BwcNEX+Q@mail.gmail.com>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > If the rule is "break on ascii whitespace",

Is there a way to achieve this: break english by word, and break
chinese by utf-8 character
