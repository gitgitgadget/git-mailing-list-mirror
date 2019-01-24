Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ECF91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 22:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAXWnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 17:43:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34371 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAXWnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 17:43:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so3426238wmd.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1QjZdp/JPPC8hTki2eJlS73uYjTEO0Bq9RRHKQ6KXI=;
        b=DyYufPbO+tt7SHR02a2jEWHGK53R5KX8TNiYF5+vWvyMUXSS3nKvJ+aMN7aiGhNiZZ
         Sam72qYi6nmUm2T6M8KQ9eNQBiEzK0AFCJtA/8plufOziMrn4apT2ySsSEABIm1s8pde
         lRWBkyWabAhjEeS8IIT8nycS0Q/BlCeuNcpyofsGgIkETGeWaCwVTm+2o7BXUglvQB+N
         q5rONcDjV6PVJeC25JNdlrCI9B0CxbeaPDSxd+r8zscIWJqkGDzsi3sNmBux29sHnnZC
         n+N1tVSf3DpMZxJ5YZMaW9mgrlZZB+WfbR5wmItzlgjdUqJDoX34051hi7sL/Fsz9pfU
         inyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1QjZdp/JPPC8hTki2eJlS73uYjTEO0Bq9RRHKQ6KXI=;
        b=LnZuQ6SIF5aFB8+eoFXcFApWv8AAWS9AMOz8hY1gcf3xIyp3772MdWU+/6B4Jj/VDJ
         JegpGRJ2blZrrixaZJFkUvVIzja5BRFlPeRLfrjP2qmoiL3L5s4OLCUsoR6nuEQLOENR
         q7KwuL1OJFeyWSGJbG8fB2KLo5LUMwrEdmKP9ZWQRotK2ATyyiDGTxxfbYV6KELOqb1b
         /ZdQGEPKZ71+m8egepnyaNiCkh9x/Ee+Lx+hYjpU3JldwzpA8xWVgwXVwsoCVpHipQN0
         dP/KpF1M/NNtIwWm0TNnxeQqrCBsFFox00Z2luBIaH4aS1/un3OZXdFOcIlHV3+sul7T
         lo9A==
X-Gm-Message-State: AJcUukfn3OZDaErAuo/KfFKcy21wTz4wv0W29d+/ofp9RIo6f5jmY9Pw
        eg0Hux5eSdgF3VaflD77IBStW0/1
X-Google-Smtp-Source: ALg8bN6qUnnqfBKfn0iNDaIZhezuoonzQ2mj+atvzQ4752Sa84zi6EcuUE0GXgHgvLZAzmjW13/YsA==
X-Received: by 2002:a1c:1b4f:: with SMTP id b76mr4470587wmb.147.1548369801127;
        Thu, 24 Jan 2019 14:43:21 -0800 (PST)
Received: from andromeda.localnet (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.gmail.com with ESMTPSA id l6sm98349149wrv.70.2019.01.24.14.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 14:43:20 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 00/16] sequencer: refactor functions working on a todo_list
Date:   Thu, 24 Jan 2019 23:43:09 +0100
Message-ID: <2759286.8cvUeAOlzz@andromeda>
In-Reply-To: <xmqqd0olhgb2.fsf@gitster-ct.c.googlers.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com> <20190123205821.27459-1-alban.gruin@gmail.com> <xmqqd0olhgb2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I=E2=80=99m resending this as I clicked on the wrong button=E2=80=A6]

Hi,

Le 24/01/2019 =C3=A0 22:54, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
>=20
> Before I comment on anything else.
>=20
> > This is based on nd/the-index (36e7ed69de, "rebase-interactive.c: remove
> > the_repository references").
>=20
> My attempt to apply these in order on top of that commit seems to
> stop at step 5/16.  Are you sure you based them on it?
>=20
> Thanks.

It is based on that commit, but I mistakenly added a newline between `--- a/
sequencer.c` and `+++ b/sequencer.c` before sending this series.  Sorry abo=
ut=20
this.

I just reapplied all the patches I sent, and there is no other problem. =20
Should I send this back?

=2D- Alban




