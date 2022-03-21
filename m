Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F34C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbiCUJYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345798AbiCUJYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 05:24:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD311A02
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:23:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x34so15875315ede.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jGc5FgqU0AMrk703Di9jNDSuzQWb2CKvZRpnpSePSvI=;
        b=kbSnF5hvp6Wxo+rdZXfwcJe+aXaP8CipW7C/kbmk6Mow8gyfzfzbSbUZfah8GfL8AH
         p6ml5Ex5+eVt7rgdZNKNyut4AjBTZra38OAm0ervaRGr2fv+5WGAHze69b6QoPCvR/qj
         PUXAJu5odakWqqCkdXdx0S8qalm58clt8sisjk4O6zLtLqMV2ef450bOXb4Xx2rhqlN5
         9Sh+mUDcfvlZRPhG/SFUsYQrH7ktYM/fAh2ewyG+o1QusZ5xatnHaMBLSy12AL91QVMw
         0Lw2bUUjHlyOs1NUIUKXk8ZCPmoB2qKJdX1H6qgcP4/tIJpkMiSJMoXZqn4lM+Vii/NC
         iGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jGc5FgqU0AMrk703Di9jNDSuzQWb2CKvZRpnpSePSvI=;
        b=f8GQujEClNPip1Jl245IGzmeTb8D7XVU65mk/dqrSyqdO2Vy6bjP1wzKxxaA6AhgGQ
         VuG5UJnoit9ESJztGVtit8+saiKdXB25gdM4RwtAeq8q81KYbHWwV4XXdthnYkIegMa3
         Ce44Y0+PthyDFgGJS5V6w4nSw0jnosvECWOSeUCbPzFCcrWeAK1//TomDcokTc6OHZiK
         nNRZuwfWtjJx6lDDWs5tagk4865028npMj1nhHp2h1d3qaGOKwZEPZ2yXax2eJ9FN6VX
         h5mBwLhQ9w9HGj01ZE+0JMtY+XBqzGvcUXnvXu+jmMVbCVIsjYSlVJFsYcUIBfjp8XXe
         vyTA==
X-Gm-Message-State: AOAM530GBA/Wh0d3iSpnbbKi9nkRCPLx6b4Is4klXDVmNI9GOvJ5SPhf
        kcSU+6KCh3YwNVm1xVPYpJY=
X-Google-Smtp-Source: ABdhPJxPqo1z+tlxL/3dvQcVmf6L7KqDtzmWZ6vGlqS75bDLHLBmnPC2DCL1aEbxj2hnz3tRU9HycA==
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id g12-20020a056402090c00b00415d3404ae2mr21888219edz.331.1647854591967;
        Mon, 21 Mar 2022 02:23:11 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6561338eje.183.2022.03.21.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:23:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWEFq-0007Tu-Nh;
        Mon, 21 Mar 2022 10:23:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 11/16] ls-tree: introduce "--format" option
Date:   Mon, 21 Mar 2022 10:22:44 +0100
References: <cover.1647846935.git.dyroneteng@gmail.com>
 <7451242daae018c629a62cf2fdb5631b556ad3b8.1647846935.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <7451242daae018c629a62cf2fdb5631b556ad3b8.1647846935.git.dyroneteng@gmail.com>
Message-ID: <220321.86wngnbqwx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Teng Long wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> [...]
> +	} else if (format && (!strcmp(format, name_only_format))) {
> +		shown_fields =3D FIELD_PATH_NAME;
> +		fn =3D show_tree;
> +	} else if (format)
> +		fn =3D show_tree_fmt;

Missing {} braces for this "else if" arm.
