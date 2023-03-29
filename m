Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E52C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 08:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjC2Iwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjC2Iwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 04:52:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0EB5276
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 01:51:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r187so18394704ybr.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680079909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caIE4+s8wMBBaf12+twaszUESDpQU9Ojxqd6YodjzNc=;
        b=b/M5Ip8pcLf9c+FV/fyZoVCbq8HIDaWPTYtNF15TvI1rPv7UhTrbKlg8x//qtg+ax4
         kKAcftVGDrwvsFKRXMJ9MTE2LfTupXbi36rYGF1gHH1XKZ27MiUuLSWTxyqITbHAhjf9
         8oN1orDAuPqbqiZ8A4hBDnhid4/83bHPHyt4EBg9JKpBH2vdNB80FeLLht97vuzYtibI
         0T5sRwHYo6WRP85BU+tOPhiMPdSc8hIt6/W0EGLqKb8h9Bw166i2ID5EotiyFoHGjUOg
         8eve1XsMCbojq+wotABuVIkM66H0FEhhTDAh4yNA9HV/6YICDcgYnCg2TlCS5leWpTwR
         amBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caIE4+s8wMBBaf12+twaszUESDpQU9Ojxqd6YodjzNc=;
        b=n/BM2Yn6E5f8EJ9mvX/4tTquusO5eTYodN90HTxI6aJWcFuZEQtpHDR4d7w5l+K3Fe
         S7ei7mVHCvl6OeQ+P6kbd3vBeRSrcnzm8cq+sJ6yRK/BXxx7eU8EEBVcXjfJy5OUsgvD
         gZipYBrXEtcwULg3r3g5x4biQ0Chf8XmlW9ToFAWUoIkmhF0BFebf22cU35z/YfbKGrQ
         5U4mMIzk1HocwdgUSRwBi/S7JtyaIk5OH9Ejc5P4Vu80iZhdo3GU7smSBsc+28YcdX53
         p3JB2KyZTRMoOd66oqNQ4YB1kjPLyQAsVh6gvEfBkbig6IZLK/m9phgawQ+w27KzwdKV
         BfVw==
X-Gm-Message-State: AAQBX9fdBNPKSr8uYuGoiNbo6eJr9VQPGwcWorgsqTkyTHTEFRxCcHnh
        juMqeDFENKeY7u5likx8SbW7hgL72DPeesE7wQnBU8hM9HEOEw==
X-Google-Smtp-Source: AKy350ZVdPNL2sx2UuXpRsu2fSOLCzvo7yH7CHPzay1lndRlbMf8f9jtYjKVNKyteu8igaPu3vQMyjthzC/QdbdeK7I=
X-Received: by 2002:a05:6902:1586:b0:b69:fab9:de39 with SMTP id
 k6-20020a056902158600b00b69fab9de39mr9736097ybu.2.1680079909125; Wed, 29 Mar
 2023 01:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <83c29b890e7c31e0f174b8a5da22c5b20ce647da.camel@gmail.com>
In-Reply-To: <83c29b890e7c31e0f174b8a5da22c5b20ce647da.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Mar 2023 10:51:38 +0200
Message-ID: <CAP8UFD1SwJeAF_n=yTjrDFZg10Y7oBNiQORKSkH=USHQLVfo5g@mail.gmail.com>
Subject: Re: Removing old objects from partial clone
To:     uzytkownik2@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 29, 2023 at 2:13=E2=80=AFAM <uzytkownik2@gmail.com> wrote:
>
> Hi,
>
> I'd like to periodically remove objects which:
>
>  - Are not reachable from newest N commits from any branch
>  - Can be fetched from server if needed
>
> Unfortunatly I work on large repo and git gc doesn't work as all
> objects are still technically reachable.

John Cai and I have been working on a new `--filter` option for `git
repack` that might help you but is dangerous to use (as it could
remove objects that haven't be pushed which could corrupt the repo).

We haven't been able to get it accepted but you may still find the
discussions and code interesting.

See https://lore.kernel.org/git/20221221040446.2860985-1-christian.couder@g=
mail.com/
