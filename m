Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16102C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 02:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA6D21835
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJgcp6Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRCrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:47:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46105 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLRCrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 21:47:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so305579qke.13
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8rl9xLE0YFoZnuDST7lEd3TfxxiLM9+nKl2aH7KkuXU=;
        b=DJgcp6Y0FeoJAwkwiTXJmT0FDL+zJsigO3JzN9xB1bG2fjGCNYgN8MXL8W5OXGkF+B
         wlXPHXBSVBfARts/TH7lmCfaNsoNutgKNJyubEvHmTUVCYOTZW9BjYGUW5jX0l3B3+55
         3nKw08m7ImWnz2+Ke62FhqOWHK3uQmqQMHqSePLMYEKzsMT6HfSZ/lcEZM86olFnlgjY
         w0N9Iq/nFb0qXp9VfZoDGhMBUeuaWEXGSnykNFAAowB9NpP27TFQaJllOQrKwry9AJ+z
         4GUwRGArhIm5t1vRQ12rw0FcM6YYuHli+j4aqE98efDSnbR2T0AXQbQI7RypCVLOhuEb
         xMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8rl9xLE0YFoZnuDST7lEd3TfxxiLM9+nKl2aH7KkuXU=;
        b=BZoZGy3gOo7XE5//dySf0mchuIs5BuJ+7t/UgkQwpvVOvqR8f8+Qn8LN+6ibTMonrd
         /uSkB1y2ha4xZI3shkpk8TukrpGnd+v+VG4kny5hyI+Jmq5N9wo3xSXFXEaOb6fSGAEu
         VWsqy3LF5adnVasMRCnj+5/T4nj4ebRtM/++su4tjvC/bkgRkWu+kjafP8+I9BmE5gBT
         3nZzPSkJEOz/8WWHv+MRKjKoj393UITebUaUYP+pH37TsfxZcLrg5ThIAkOAMd6cY1zi
         13E1ee9KACEXzsLS6OsG1uU2NHdR82VNZoWByn0rmtxLUH49axnsKxy1c+dZpBtfPvfw
         ihwA==
X-Gm-Message-State: APjAAAU6OMHrRnVnH5MCXLUnOimdOmRhmpY8U/ly4aQ6T3cEwVsFTe+z
        Gi7M/F9u8FnG8KawkeehiME=
X-Google-Smtp-Source: APXvYqy19q2bORQOe9NgTB0N7edbK3iSHHy1abxG107gQNpa2dHNHyNRQrtVAlsoaIfmhwZG7cHlyg==
X-Received: by 2002:a37:66c2:: with SMTP id a185mr198679qkc.211.1576637266738;
        Tue, 17 Dec 2019 18:47:46 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id r66sm190867qkd.125.2019.12.17.18.47.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 18:47:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] Documentation/git-log: document accepted line-log diff formats
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <ba68e03a-18ff-0fb4-e64a-002b6d6c4d4a@gmail.com>
Date:   Tue, 17 Dec 2019 21:47:44 -0500
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F535392-AB61-42C7-8E18-12661A51BF9F@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com> <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com> <ba68e03a-18ff-0fb4-e64a-002b6d6c4d4a@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 17 d=C3=A9c. 2019 =C3=A0 10:33, Derrick Stolee <stolee@gmail.com> a =
=C3=A9crit :
>=20
> I would prefer the longer "--no-patch" over "-s", especially because =
you
> follow with several options in this style.

That=E2=80=99s a good idea. Thanks for the review!=
