Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6EC433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C621BE5
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 08:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKSxf9QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgINIjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgINIjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 04:39:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A0C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 01:39:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z22so22001827ejl.7
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p+69g8zKtwHuSJSREZ3oQ+ovY0PMd7IWjImkMhGPIl8=;
        b=sKSxf9QOSzsoDptVjJ6rIcjNsaRk6UbhdgmItAxwKQg8PwUcTmzEikF44d7rT+foc/
         WqNs+NtSsdDu3666WLrrNy2MSsXw1iCtwUVZg+hzSi0cXxP7mtWMKw+JIrJUYfoBBn9C
         JhMWYk/bQe0ZCcSev0eRVVPaLQg4SxpWIIeF8EMsqvTweRCMX64cJ1cpFCe08CwsYanP
         /C8NeFOdtgqoDkj2+KAJrHwxOYoS6sp8xP5Cucy63gF8qfQN9dr3nex+v/Fdr5A4wJ/l
         SmKMW76WteS0DfBb4LoJYPYLEKt0vyxJnwQGPRylGADI1I1EOXYd8sGKOumxmyGsaiT8
         hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p+69g8zKtwHuSJSREZ3oQ+ovY0PMd7IWjImkMhGPIl8=;
        b=OBsloTkMWIAAnNdUFWz1kvoA/rZ+wsLGmuVVHQ3Y5wj7AYfNrYC205rtN5ymEIS7qX
         5GaShLvhofFVOIaibru+BMtraS2Z1zczlrcNcisLmVuEMlhwyGu8w4zOFKfxWskNpNTr
         HG4ErYVAktp7ULhsSTttzjuSUE+BJyICDidOmkpaPe7s2WYmO/i0/jLmii74uOC4zbFx
         KUAV2OabpBIzGeNQYLqpzTMkTdMuga/+YYOKJnDqY71gDzntLfhbnnLgvhDBoSgTPQZW
         1GzRWbleRZth4hhj9zZhaPVizrqjmSr27ZYGmVS5OGOMi8E1zCkXfH4DzwMnqiwNilSD
         VSdQ==
X-Gm-Message-State: AOAM533+FQMDSMvYSe2mwKlrAVFqgtuK4PEAarD8Yl3q4go4q+hwnfnE
        1JZWxlkaUd8xIRpXSFEwAFU=
X-Google-Smtp-Source: ABdhPJywL0kCSWELJ+7uOvUWwkeMiQAzCdhBP8RceOjAgJTjFC63iEjdjvTQo0PYYlXhPhI6uV4mew==
X-Received: by 2002:a17:906:b146:: with SMTP id bt6mr13398513ejb.287.1600072741416;
        Mon, 14 Sep 2020 01:39:01 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:b065:302e:2d15:edcc? ([2a02:a210:ca2:9c00:b065:302e:2d15:edcc])
        by smtp.gmail.com with ESMTPSA id p17sm6924708ejw.125.2020.09.14.01.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:39:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: Caching Git Pull
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <70DB3786-CB8E-4D82-9774-439AB2A79A8D@gmail.com>
Date:   Mon, 14 Sep 2020 10:39:00 +0200
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90AE4B78-36E8-40B6-9D7C-E198E3004941@gmail.com>
References: <492d0f93-578a-cf71-4d62-140471b33ae6@emailplus.org>
 <70DB3786-CB8E-4D82-9774-439AB2A79A8D@gmail.com>
To:     Benson Muite <benson_muite@emailplus.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: resend with plain-text format

Hi Benson,

> On Sep 14, 2020, at 07:27, Benson Muite <benson_muite@emailplus.org> =
wrote:
>=20
> Hi,
>=20
> Is there some way I can add functionality for caching git pull to =
allow continuation of a partially complete pull from a git repository to =
a local machine.=20

I believe there has been some recent works toward this direction with =
Packfile Uri feature [1] [2] where a packfile could be uploaded to
CDN and then advertised by the hosting remote so that clients who =
enabled the feature can download the big part of the clone
via CDN instead.

[1]: =
https://github.com/git/git/blob/master/Documentation/technical/packfile-ur=
i.txt
[2]: =
https://public-inbox.org/git/cover.1591821067.git.jonathantanmy@google.com=
/

However I don't think any major Git hosting provider (Github, Bitbucket, =
Gitlab etc...) have started using this feature.

> As an example the command wget -c allows continuation of a partially =
complete download. This would be very helpful for large commits which =
fail with:
>=20
> fatal: the remote end hung up unexpectedly
> fatal: early EOF
>=20
> Regards,
> Benson

I will cc Jonathan Tan(author) to discuss more regarding path toward =
resumable git clone.

Cheers,
Son Luong.=
