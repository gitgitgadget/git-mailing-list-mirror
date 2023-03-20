Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0419C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjCTRJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjCTRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:09:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679228EAA
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:04:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q16so4932714lfe.10
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679331814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkmabA3ZjbrPzHcgN+sw98Jc8sBvyhki/3uJkJ+/tyA=;
        b=UghX5U+sBkElF/WKUIhIot+guKmjpm3KlHl7LTOmtqZOQrcUXfdKsHp4ZIVQDC75pG
         /McueRD5XeJXpZPnf9O4qhUwil/uejOQSsgINh75p2/POsZv3GRWQtKrCJlbMmYLru0j
         66RkD/rTBvZI8003mpth5upnEscDi/e6yIDfNrH1cB1FnHrICmfc0Z4Psbr+UujicOrg
         bu81PH/i0EIFlQIQt23XvJLbv45X7Tox6J74hqY3h7x2F6JY0/f8q6jWrFLVLyZLpHyP
         9xHbWDSrPZLeW9CcKFLldQIxG0yuZhhwKilCFMsf8voec3fr85zCehvde/0ITzBs/Cr8
         5zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkmabA3ZjbrPzHcgN+sw98Jc8sBvyhki/3uJkJ+/tyA=;
        b=uIpl175yMZZvrs/8bqidNeTtPV1snGGTMKVkgULkzFgyc3l3l7l13VUXFPdS0s/JQd
         Y7NErCY8STnRoukDl1tQl0mY21fs4PUl7azugFxFBeXElOrM23i3jwpaV0hiojcZVqmx
         jKlwfS184tbTLYA0KPspDLq4ipTZMtVrLkv4Ej7PKCnPNoaCSIo/PFR8/N4RadclMeLP
         4EdhoZW9F4aIO0P8/TWpgDWob2j7/z8KmGnSWKhdtviRKJKbAsDJBv8w5+XYX/eJulFF
         53K8P38VAThMlJHgMz+nENhrjrgdIcyKn1wX9dpbVhFAX7AFdSlSpn03E6JR5M/oqgkZ
         QDoQ==
X-Gm-Message-State: AO0yUKWFQluyNxtY9Vome5JCemVnbLTEUOpB5/jWPHogjbeuZzO+K8BO
        kBEg+AiaXhBopUCThRDhnfaWjGzXCW0gv0uGJ0/HnD1irhk=
X-Google-Smtp-Source: AK7set9o3ia0IISbQRVjFEFdL5MlBwJBd1195dYVvFHnh8On+XGYYdRdlK7tV/Qza8VECMMSOwms/1VlBWmvGGFRh/w=
X-Received: by 2002:ac2:5927:0:b0:4e8:6261:58c2 with SMTP id
 v7-20020ac25927000000b004e8626158c2mr195147lfi.7.1679331220438; Mon, 20 Mar
 2023 09:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230319165648.656738-1-szeder.dev@gmail.com>
In-Reply-To: <20230319165648.656738-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Mar 2023 09:53:28 -0700
Message-ID: <CABPp-BGXuQEef1Z2fDeHNJi=RSiTK1Jp1PehCtFvT1nzvJmoYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] parse-options.h: use designated initializers in OPT_* macros
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2023 at 10:06=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmai=
l.com> wrote:
>
> Use designated initializers in the expansions of the OPT_* macros to
> make it more readable which one-letter macro parameter initializes
> which field in the resulting 'struct option'.

This series makes the code easier for me to read; thanks for
submitting them.  The series is pretty short and easy to read, and I
couldn't find any issues anywhere.

Reviewed-by: Elijah Newren <newren@gmail.com>
