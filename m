Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6EC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjBHOef (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjBHOeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:34:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF71DB96
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:34:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so20709376edb.7
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 06:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6swnxJzzVv4jqKYQdDP9RfuTntZ7QEy8d+wPztODKo0=;
        b=hX7MElUfuo5T27wjAeG0iNF35PD8yqMZ4HOSXwzWNxQfCgbbekqLrPLWvIGSob79Kp
         ov0u21fmpRUrV1KX3CCUaqGGhtFkVPFhC+GrRt29I7GJ4w98LkGcp7wEYTTgNdKkldIY
         UczxJpxfwfUnvNx3YMf6lDOEZyn2p9kgfK1YMhi9nbxVT9c2A+B8hZUHXLWuGfknJ1kK
         j59GNAFVWnKSD/C4WDyonVldAaFaR2yT0QjSr/V4Uf33JVJBHE86Jpl5iz0CHAI1YGhN
         yo3Ex2lt/SB9uWD/hIGlDuhi7Epl0lCIHpYFdABKFz4f2cu4r2Ka7URELj4C2ck4YsH6
         5W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6swnxJzzVv4jqKYQdDP9RfuTntZ7QEy8d+wPztODKo0=;
        b=xQksJkbzhF9sBy4yTxdCWWLGbVKYTj+knIyVplsYh3RH4/wcqF6UPBNLv2imd3fRFa
         msb2wdFUXcuTfZIFqEnPI60LSMZ3koXHaMzjJIbPYnM6nMaTzt9eLyHM2yFTjwiS1Ct1
         GTZGBFDnLInnacH1fKJj+z86dyCT/oW3J0ooryhfwGpkjtQeqASFO86M2pz8EW/IjPB3
         Lw6P0azDFfgdKIui52hcrCtYDJjkOU/q0GAI/l6Qu3AyV/FHNehUaPWZHw1gmSo/8JGx
         ZTQSxryw1pBccJ1nq+9PbUBNgezUMvwU0Xrpl6B4tv2J2TQwCm4jMPkN2ZXPvMmM/qBa
         FT6w==
X-Gm-Message-State: AO0yUKUbK1S4RGAm3mq6QidG7ORFJLryP1l4kRnnjW9VqMSOqbNhAhu7
        /rrWDWN3f9WByKaCdWzwHpEg7GZ/67GiyPoz
X-Google-Smtp-Source: AK7set8/fh+Ed6aSIBv2fOPaIvWhSiNkMFxYtKpfJ65JdYGDtLyLnO0YZtWNI/pq450NbUReaJnu2w==
X-Received: by 2002:a50:d08c:0:b0:4ab:15d4:4e0d with SMTP id v12-20020a50d08c000000b004ab15d44e0dmr1654023edd.31.1675866869261;
        Wed, 08 Feb 2023 06:34:29 -0800 (PST)
Received: from smtpclient.apple (132-216-166-62.ftth.glasoperator.nl. [62.166.216.132])
        by smtp.gmail.com with ESMTPSA id ew10-20020a056402538a00b0048ecd372fc9sm7923375edb.2.2023.02.08.06.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:34:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: CMakeLists.txt from contrib/buildsystems fails to build on Mac
From:   Ilya Kantor <iliakan@gmail.com>
In-Reply-To: <a120ea47-722d-2bb0-9c49-294a850af6af@dunelm.org.uk>
Date:   Wed, 8 Feb 2023 15:34:18 +0100
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <68C6062A-7833-48F2-8F44-3BB129E5E9E5@gmail.com>
References: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
 <230208.86sffgz7i1.gmgdl@evledraar.gmail.com>
 <a120ea47-722d-2bb0-9c49-294a850af6af@dunelm.org.uk>
To:     phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thank you for the responses.

Yes, I saw the discussion, but couldn't figure out the final outcome.

Indeed, I'd suggest to remove the mention of any other platforms if it's =
windows-only.

And if it's windows-only, then it makes sense to move it to =
git-for-windows, at least for a bird's-eye view.

Kind regards,
Ilya Kantor

> On 8 Feb 2023, at 15:31, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>=20
> Hi =C3=86var
>=20
> On 08/02/2023 11:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Or rather, that GFW would be fixing it up, but then I don't see why =
it
>> should be in git.git, which as your message shows just leads to
>> confusion about why this component is in git.git's tree.
>=20
> I think Ilya's message shows we need to update the instructions in =
CMakeLists.txt to make it clear it is Windows only.
>=20
> Best Wishes
>=20
> Phillip

