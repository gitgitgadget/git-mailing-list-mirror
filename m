Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9FC77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 07:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDMHRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMHRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 03:17:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA35FFE
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 00:17:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z9so7977647ejx.11
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681370259; x=1683962259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8qQrm5RXETU/rr0l1m/TQPuHmQvpx8iFFvSp20heJ0=;
        b=lWPVRywzE2g0z/h3nq3+mx9dHnTx/qeUglUtwMc7K2mo+7/hNKilyMQ/7kAb8ndGoj
         vGAjP1wMafgpKo3AhFHoUpwwtbbSXsbpBhxTGweUImAsyiVSt6F9D3AWrovLCDvt9lTI
         csS9OiBlri+SNgOcLOX0RXUTrmVpfY+YgTWQjxTv398tkl0eXCFFt13bcWn+1bpBAAJQ
         qFfLMl9c7WW3vyJmmtViQvVq3oXiMfg4qEZI5QalMEJplkaiBiX3F3+Y7WOtETzP+eAN
         L0XOPlS6VKSl5p6lio3oIOuVUjd5myNfsGq7bW0HkvEOe3dT6gQTorxzx0+nyzfLbgiv
         KibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681370259; x=1683962259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8qQrm5RXETU/rr0l1m/TQPuHmQvpx8iFFvSp20heJ0=;
        b=PvBVaGTZRXGeICEP/W3KESZJJj0gnM2RNehl5wjkaMos7IgUUFjUAcbGqKpUz2hC5O
         cdiFeIGjX5rYhwYSB0TSIx8sDnq5skfAPPg5cjqLnpWExh+DwIZ+wr8/x6E5I06j15V1
         ojfCtecssQxOfehJnvo6JxX/hDOz903HrVOvZHb5dzB0eq0sgf4DAta40gqMl/Y3oJxS
         5gRpC7RY05IMiZfHjU00Q7mTcUIHiIFY7+m13yFRvR1yB2roxmzvT0Bb9q853LCwESso
         sIZ03i95v7Reh9gSwQmzfezTzkq8iO8rnAzKAbm1Yz5G13iljorMHaUG25bvd1i4Uulk
         wQOQ==
X-Gm-Message-State: AAQBX9d+sfxEQdEY+O/TL/C89k/QruL9FY4LRLywTc8E5iGNH/wJgOzo
        KDuD3ZWDltOd8vy3nRfSsh+VqBgJ1qLVu7zPrk/q6A9M
X-Google-Smtp-Source: AKy350Y4YbftbKX54t4XgLQ3iTThE7oOXslwZtKpwJAefBU93edvApU26i7/2kWA1xmozGAupE9FgMd8OsOOWExP1mc=
X-Received: by 2002:a17:907:d090:b0:94e:aa09:7618 with SMTP id
 vc16-20020a170907d09000b0094eaa097618mr342031ejc.2.1681370258618; Thu, 13 Apr
 2023 00:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqjzyoq35x.fsf@gitster.g> <20230407175316.6404-1-oystwa@gmail.com>
 <a8b34639-60fb-8a23-d1d9-1ef4410a2ba4@gmail.com>
In-Reply-To: <a8b34639-60fb-8a23-d1d9-1ef4410a2ba4@gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Thu, 13 Apr 2023 09:17:02 +0200
Message-ID: <CAFaJEqtWg-6wvLNQy1DVSquVOu==E67gN7QYw-sAUf9fufOngw@mail.gmail.com>
Subject: Re: [PATCH v3] branch, for-each-ref, tag: add option to omit empty lines
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,

On Thu, 13 Apr 2023 at 01:44, Andrei Rybak <rybak.a.v@gmail.com> wrote:

> It seems that a word is missing in the first sentence. Perhaps,
>
>    s/printed it/printed for it/
>
> ?

Sort of... I think I meant s/printed it/printed/ :-)

> "git tag" is mentioned in the subject line, but not here.

It should definitely be added, yes. Junio, should I resend or will you touc=
h up
the message? Not sure what the proper procedure is since it's already in se=
en.

Thanks.

=C3=98sse
