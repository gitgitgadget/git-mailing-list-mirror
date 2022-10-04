Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B94C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJDHix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJDHir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 03:38:47 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1644D4F4
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664869122; bh=A0R3SzWQ+Czo4NrvORDUetM1QafKYv1F2routpIW05I=;
        h=X-UI-Sender-Class:From:Date:Subject:To;
        b=sxfrhRhRVZsZLeD2pYJnLggYEs77LKnWUSf36HglJ+XFWS317f/sAzZtvTQ1J30Ft
         H12Su/LF2Sy2UdqlHV3x+UQniOX0cQn4o1gySbFF5r3LuDYNYEy9dvIUFDWBgdaCic
         GwtN+zptiQUCEBtIdEMFcHl2MsC6uRtZB+pskN8/KAhJK/SVStKZ5yZyefAbBFeait
         OJnQzgz5dF4v0x5NSuq5rTcP3f/H6FK+Nd36RNYWDQ3Fckm7zb+8bVhE5QuGY4s4wf
         flJAANCdqbkvsMMq0OZEhGIkIiFxOeYeEYJB1IQp3Iogembsu7+BzRMGtPU0g7++dm
         REe+jPtikoo0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N3Xnl-1pMY8914aZ-010Dhw for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:38:42
 +0200
Received: by mail-oi1-f180.google.com with SMTP id t79so205715oie.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 00:38:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf33n43uXEqxvXOhigY1ml7c9TrcBjlxMCQ/jylJba5kWh+UG3xC
        ZpqruGtGMwj05yFPi8ajz3DMpXSO0unZAzHHaFE=
X-Google-Smtp-Source: AMsMyM7LsQwZi4UxaZVM3Slk1gDAHO+6Cyg3PQq24HfV2MfPvVtYP1IOIlZb3SqHMQdRg/m8O5MvIYm1D1DAwBbF3K4=
X-Received: by 2002:aca:1e14:0:b0:350:a004:6255 with SMTP id
 m20-20020aca1e14000000b00350a0046255mr5917181oic.168.1664869120917; Tue, 04
 Oct 2022 00:38:40 -0700 (PDT)
MIME-Version: 1.0
From:   darkdragon <darkdragon-001@web.de>
Date:   Tue, 4 Oct 2022 09:38:24 +0200
X-Gmail-Original-Message-ID: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
Message-ID: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
Subject: Install-prefix when building should not be hardcoded
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6JO1fHy2t99ctkrtvk9MAe87xcOvZKseyBq1RxxPDXENZVD3W1N
 NJISeh0tbVQIoePOsPwYR32e1BsPPPmFmfwSdVbMf/ZQiMOWG5d6yeO176SgohySil0ziPx
 /gPp/UFsFi9+vFDQ9wAYdZ5+feTE2PHRKixR+R69Ey9AUPTxJHFRd4YQbDLkXjljuE+9nb4
 59Efg8F3HNKNNysYirPRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wpg0A1KtmvM=:ckcNnm8bMcL1MOdwa8Ihyf
 kvuM7kcUUbtZHCY7wBwfY9b/9k96d/P7ng6I69bc+A85yhBIFvapSRY/dqo5d0d4LIfTSS0Jg
 fLVVX4OK89Ql2kr3LqVvVf5kFhiESwGu4oOczkmV2DZg9GB1uOBvMIk9c2VtI3tiisuUNa4Mw
 0BDx7VpKXpOIfErQs4Z5RX08kJ3+bx9ohk5zlJC+DqlTMNZoFId2zB9mBZLbN4xqLXz1A8A+h
 eVG3ws/90SWKNnS01aoXnWgqPQqwrErHjLtd1txzDKZ7nseEtFxRLk4zgCDEpmvDHKfYEckDs
 lQlEur9vRMMF99hI8PqHp32AJHXB3ZL32mfEZq7P5runhEA1L8SCmt4zm6rT1cPayisxpvbyQ
 4ZUDGzF2B6vkNE7DRFzBwUFWvO6eU+aS84aRcLIfBLmLOmWlnZ2HdlphH+GgsFh5dAY/mq99B
 FBKbD30X6hZDEJjyxcp3V6RvF+tZ9ipYnQBjqYCgH7BI7AuV958HO0zhOAxJ/tuP+sNNegH5q
 Nad8La7Vdqo0nC3ZVAjSSZT7ndRpV/3xYUmortsxaCeVRGEkJustFmjY86A/33x6YI+0f6SE2
 6Ab4mQ5UJYYjg0/OYumIVzjAd5IGiW7Dy5x+MfGMrob40MQxkYTQ/pslQNGeMKhl7E6A0t35l
 KgcDVRT9cZHYzTEPsCVFlqaY7f7uaSpmk7zXGHqdoHislwus0jNkXyQPcfF+HnstXUGbGUGTU
 E5yjrusyEmUqrKxRLv3r9VNJhopFsTmgOdYIVD+tucF7C8lrUigFKEMGG3VjXdZvFi/94q3L4
 sBaiQn/bycopPf+Lz7c2ykgGmuaIc+62HoFcFqcx2JD2rrX+db7BJkwGQ5KQLB97+8TMF85zo
 bZEZmpCuJh6va8NUTrMxOc7tPsvX6gkHCJDwVKGIgkKBTtPpI5dZWM/ue8SdlkZtm0EMrkm+b
 6IT/SxNDyaRkP6XvrJvzSjna+37H67JN4MC0s2yncBK9mm8U0xqWRSjFf/PvCWKpqC8nMZtCF
 mmPJyV/NNbZU5u0ztwS6MpqbWVLD98In7GW66wzTt3ZGQksBx++YxiEO6T0uCpSJxSa2dhcyO
 wCw++T+ht54Eav8yZceDVJZausZ34c5bHXb9UQxvPI2gENysGbjskS8MT7tx3SxPgtPd3ZVPK
 eVo436PSHJstXQAof/JYGF8Ulx
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though in Makefile, it is stated that git will figure out
gitexecdir at runtime based on the path to the executable, there are
many output files where $(prefix) will be hardcoded. Even git
--exec-path will print out $(compile_prefix)/libexec/git-core instead
of using run_prefix.

Example: We are building git in Docker at a separate stage to /deploy
(since /usr/local is populated with our compiler toolchain). The final
image is assembled by copying the contents of /deploy to /usr/local.
Commands like "git submodule" will fail because of the wrong git exec
path. Searching via "grep -r /deploy" in /deploy after make install
yields many results.
