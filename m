Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA6C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BAA206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh1yMUak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfLZRq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:46:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33419 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZRqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:46:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so12038626qkc.0
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aFReqeZHb52455jfd4oqO/s2IRO+zWLx6bfsdfPpv+g=;
        b=Gh1yMUakekCRqjifd84HQ6ekPxlJpWl0UVvGmpEQGR3wl+5FtdD9nPAUFBjRYRsqi3
         q5fIAstGHgVAXKE5058QyNVNl8p5gteptXeBeXuIy/rGvzEv0JL8s+V+uKKe4L1Gz/hu
         O/O9kehlDNvGuSDHOpHWhMkyqgQEEzbqd352JvzEdaSlF4cwTOYdb5LWNJmBdOvEtAjs
         K6W1ZYZ9Xm6KuFxC5BFCIChL45KfDYzYk6WD5RTQc4ikOEywyaON/BwVCuk1jPdmxm9C
         Byk1kx/yXHBiEncTFaL/2Y+KdpvI0/0pyXbgWo6Slj78pLHLhrcNT8/W/bFApuIdflD+
         UF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aFReqeZHb52455jfd4oqO/s2IRO+zWLx6bfsdfPpv+g=;
        b=k44Be7Kls/PU5VQOyfT2ej0AFiMAssgiI73ec7Pl12hO1DmjrouUiLo32/564FRheZ
         5jmGAZqF+We7mjmj9OMMiXXybjKx/B14H/LNkAeM1iWOQwKp1aphDQmYi3BzqGHzULqV
         BMRpMhyJ8fE7bnITRUBD3w32C7b8aWdwB1W62Hx2reKi738GJLEZa9tix811SCWY8Q+J
         0oOPA+DiBBG0EHqhe53oT8gX7OwT/9NQqBp/q1Ebqx6KK5Z7XoDQaTdFj6RbaeORNuj7
         /xpwIrFbhFXz18HCnlGJmhbmw9VWiqxt6touEFcQRVDtdgZcQxJRUVA/107JD/SsHc87
         Atwg==
X-Gm-Message-State: APjAAAW+gIBMgky2JM4aWdrOfNgPDmK/p4TvgLhIlhSyEJGDKrhLiShg
        0iU7rmR9jtMO0gejyA8QpwM=
X-Google-Smtp-Source: APXvYqwZFeGT6nswIzqrjuZOb5S2HDKfc9SOkODOAOdQh/8o8XHEUrufEIIp7xor6/qgAeT9jqBI1w==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr40195392qkf.20.1577382414937;
        Thu, 26 Dec 2019 09:46:54 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g9sm8795115qkm.9.2019.12.26.09.46.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Dec 2019 09:46:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex must match in starting revision
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqwoatecq0.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Dec 2019 12:46:50 -0500
Cc:     Derrick Stolee <stolee@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85985FB4-A32A-477E-BA95-53EBB5034621@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com> <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com> <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com> <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com> <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com> <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com> <xmqqwoatecq0.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 18 d=C3=A9c. 2019 =C3=A0 12:59, Junio C Hamano <gitster@pobox.com> =
a =C3=A9crit :
> ...
> Yup, that is why I suggested not to focus too much on regexp and
> "match"-ing, but express it in terms of the lines that are specified
> by given arguments to "exist".  The word "match" gives an incorrect
> connotation that the description in the paragraph that uses the verb
> applies only to regexp.

I agree. Thanks for the suggestion. I changed it to =C2=AB exist =C2=BB =
in v2.=
