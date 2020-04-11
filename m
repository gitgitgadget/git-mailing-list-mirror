Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F48C2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144502084D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anirban-org.20150623.gappssmtp.com header.i=@anirban-org.20150623.gappssmtp.com header.b="YOqkZyGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDKNZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:25:10 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37960 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKNZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 09:25:10 -0400
Received: by mail-pj1-f43.google.com with SMTP id t40so1783174pjb.3
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anirban-org.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=AC/HVMIHPC0PLNClolcVjFJxmkum7JoytkSCZ63JZkg=;
        b=YOqkZyGEpVWuxQJBOB4WxR963WvNomhCQNeB7idQOrigXU4A+d81IuCiNYTCf4D7IT
         kXqeQH5kmqOWMtgjocnyXxnYaY1dqlJttwFxI6dkZqffxFlUakGvRmivbOEVvpWf8g7U
         Zd1lRbxPO0hVyifRK8b2OjSgkqdC+pIttPU0DiZPVg/cudwWxiEUaqKRoDbTDnoQbAA1
         9wepBDidR5d0t102X2PFg69T2qISyBm47InUGi5w8lrtnefrMEWobkuIiygxImQHTVzI
         Rq1rwbcMqsbiEzpsL7YtUJGMtKb7gkjVuFBGlv4nBnQOLw0sSLL7rumWWzgt+oHCfDug
         ybdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=AC/HVMIHPC0PLNClolcVjFJxmkum7JoytkSCZ63JZkg=;
        b=YY/4cbuqdsLI+8JRh2xhma4DheSbAT7FlKAm+BpuRIuMCN43U3uzAa5ZH2ZRJD/QXO
         x6cH/TSu6o5xreaK/4QQz8TC2d38la7HqyuYMjvdLnfk3kMcvPTOEdzP518T3WjJ7ntF
         XTHpyO4nz8U5l0FweFH4eHyaMqSEkLfYRSk0yaSxsBr+zSnLI6msu6fEQAdqLgmrgJWJ
         Cm8fvXa1go/UtneL5d/E+dYvqRK9u24PX0KR5nGaldQgCB7q8dJri6axHlsbCo52mDE0
         29O54LHLQEpgv/mpK1yQ4lgL6UM4aRFf6z/twgi90CefwCyKVeG9rMyaZpmtRVs3Eh/r
         +kuw==
X-Gm-Message-State: AGi0PubsMxUh1TaW2CCx02u5cXO+jvlzeTNqbwTl9LyO0r5AfP/5fma6
        3gydeP1LrcZufU/kb4YpL8as26EIWOQ=
X-Google-Smtp-Source: APiQypK3OXNiIlHYl1IvQjwG0gOMv+EE3311eN4kijrEwPBdaV1IhL9uvXeKiCAQTXbrFaMzT8e53g==
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr10980338pjb.50.1586611508928;
        Sat, 11 Apr 2020 06:25:08 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.129.142])
        by smtp.gmail.com with ESMTPSA id j62sm3573563pfg.192.2020.04.11.06.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 06:25:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Ani Sinha <ani@anirban.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Cherry pick a commit but with files in another location
Date:   Sat, 11 Apr 2020 18:55:06 +0530
Message-Id: <AE1E8050-EF04-47A0-96E0-27EEC4A0C013@anirban.org>
References: <CAN0heSodSeT=Sj4pnutFPgbu9jjwQ_JBtBee1iyP=D3Oc_5G=g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAN0heSodSeT=Sj4pnutFPgbu9jjwQ_JBtBee1iyP=D3Oc_5G=g@mail.gmail.com>
To:     =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
X-Mailer: iPad Mail (17E255)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Apr 11, 2020, at 6:13 PM, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>=20
> Do you use "git cherry-pick", "git am" or "git apply"?

Yes


> (Or
> something else entirely?) Are you aware of "-p<n>" for "git apply"
> (and "--directory=3D<root>"?) and are wondering what similar options are
> available with "git cherry-pick"?
Yes was wondering if similar options exist for cherry pick. I wanted to use c=
herry-pick  so that cherry picks can be tracked by git.=
