Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB4C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCUSfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCUSfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:35:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F093E60E
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:35:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54184571389so296315637b3.4
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679423702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B6l4YfAdFLOFtZJce8zJtCws6isWHEf/Bz3wxs8EHo=;
        b=a1ZFipgh+y3lBec+ZPIjXZoIYEDxm5GOS5ZTylHQ9l8KstNlUro8HooFUmVgeORUa6
         90kxCzyikpI3m9uydNsPYTACmZzltsuzDZ3lNxmKZjyx2AKn3EhIsmBBcYQsMF3yhMlK
         i43U0chu80iJCiFeUyQkWAccUtcb70lFF9NrTQc8JfRvxbGbC9bjiAbp3cqMer5IDzLY
         jFmEUOok2PKBwoGjBCcOGfMheufru02FMnn8txr+nzsHcFwdJRbprjItCUyGfninM+BS
         /ezK9wPSPEQGuZigxzz7s1VB1XANI/2erM3vECaKLAeV5w3U72gOZtYHK/YC5L9K8EPZ
         tJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/B6l4YfAdFLOFtZJce8zJtCws6isWHEf/Bz3wxs8EHo=;
        b=ChbYs7VkfEbYY1DY0vrVXSERDeFUcyaO04VgIbD3A0iU6v+w2MaJ5iytbaiToA6sL2
         xpBm0WnfkVCqItZG8LUlyLixTf7I63eRmVHmfv0su0WtWkucGfcYOKMKF7eIIbFJrSz9
         9tSUGvN7sH/ZVF3MofbqcBjDmAat4/us4PO7pMN2q9UQWHpnmzlLHnocTecyC4SDKmD6
         IpfrR4uBAfatYjPpLNfmJS000oUs+Xu9iYEsVIs+f739Lf/Ektl7fw4TokoW5/j3LDGz
         rb75n6TV3FGPjBDPcHw0PzFkMRkqDv7uK208Jw1vuftr+Cckh5d2CBvJpf/bWI9hEbaX
         5hCg==
X-Gm-Message-State: AAQBX9eW2ig+mWTjEACtdPOtDD7pEP9mZpxLQgnTM1ARjE+tIh9tV3rq
        R4Z+j+O0yiObP4XpsOMjbF7pJKpmw1QBrBKNJxY=
X-Google-Smtp-Source: AKy350aGVm9F2rP1+wAM85DAfkm6VZP3XTzOZHVJ54/9BuOxJU7ZZ7CDe3/iax9CEaoZLru01QpyDVe5pPKvAqKd7FM=
X-Received: by 2002:a81:b641:0:b0:541:753d:32f9 with SMTP id
 h1-20020a81b641000000b00541753d32f9mr1715356ywk.9.1679423702672; Tue, 21 Mar
 2023 11:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
 <20230321173206.GC3119834@coredump.intra.peff.net> <xmqqcz52hu7n.fsf@gitster.g>
 <20230321181702.GI3119834@coredump.intra.peff.net>
In-Reply-To: <20230321181702.GI3119834@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 21 Mar 2023 12:34:51 -0600
Message-ID: <CAMP44s22GzW6rFEEbNo8Bx3oKhf6occ6+Y8hP+vcp8bid-kqWw@mail.gmail.com>
Subject: Re: [PATCH] doc: remove GNU troff workaround
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 12:17=E2=80=AFPM Jeff King <peff@peff.net> wrote:

> I suspect they were not using Git back then, and these commits were
> later imported, which may have caused some of our confusion (searching
> for docbook 1.76 shows releases on SourceForge, which implies a non-Git
> VCS).

They were using Subversion:
https://sourceforge.net/p/docbook/code/HEAD/tree/

> The announcement of 1.76.0 in 2010 mentions a fix for the apostrophe
> issue:
>
>   https://lists.oasis-open.org/archives/docbook-apps/201009/msg00023.html

The tarball contains the fix:
https://sourceforge.net/projects/docbook/files/docbook-xsl/1.76.0/

So yeah, it was fixed back in 2010.

--=20
Felipe Contreras
