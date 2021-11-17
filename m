Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6B0C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6620D61B7D
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhKQJ1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhKQJ1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:27:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F1C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:24:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b15so8040085edd.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BVlgnVTiYdRG8j+w6kiarP0F0ZuXrdOKxU/fTve5bHw=;
        b=JSGlHF/4aW9smRWrmDDh43c80mSXgCFIq4Xuykn5XLymDQJ5kU669WRMnKkkNzimTF
         3VyfF1RL6hVn1o5JiGU2pujfr0OKhbGClVuP2yWdKXi1vErRpXGRAOFgh6EeE+LN4K0v
         wKYjHBSCmu1ax0zvdMMuX15zu332cEK7iAKuitkRaoJWQ/abusVhYNFSA5av+uNmYsz4
         tTy3Cvws4DGDi70VV7tgP6vGCR9dqCz5JQTMrfzlV4xMTdo1gYj2tUs28ImCJkfREub/
         +0miGCj1lpkqFPZseKUlJK/BCWdDFMxaWxnOTgGlYkCe7/xBE/O8aMj+IpJUITbXKdtl
         OGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BVlgnVTiYdRG8j+w6kiarP0F0ZuXrdOKxU/fTve5bHw=;
        b=v2Q4eiVDkSc4Z7hw5zq0ZTcuCiTPAn1eRWGO0fCtUJHkkes/kll0uVmJiPjtZ4L32j
         6liwXl0iAfPnt4zjCgHndww9rCkikFRV3ndJxpvmkfqelNooog5e+SfrsfQYJfhgLgbf
         q6qKiTCNV4FFkYRMVpttzM5I05Hiacd+iOUmllLyz+H8SvAE/ExYU43v/u2mpedT5ejx
         gRxYPSVsBVVrpnLx4z7AbtW5R8XbseTy8oSW994CvX0bBZh+vXr5UIhgI2jCNVcJI9uw
         k8JgpCR1aR8791pNjkw7fZddkpyomOXwmirHLsNkeY/IWiiBvL868cOqVA43Aa3GikNc
         ZSOA==
X-Gm-Message-State: AOAM533NiPP2K1699M4bp69ZQ3fc+Pz7flbHGkXOzYDNP47GS4J3Wi+t
        x5NVjynhRYf0XqK6k/ke4WTc//FcgCVv4w==
X-Google-Smtp-Source: ABdhPJzhVqM/iATGTW+M2azedEm1obzQws3601qUhCsT/XRiveffw87zKyZqfJGSyMQsmPw6MmlPKA==
X-Received: by 2002:a17:907:2454:: with SMTP id yw20mr19636180ejb.428.1637141081521;
        Wed, 17 Nov 2021 01:24:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r7sm11293180edd.5.2021.11.17.01.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:24:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnHBI-0004gB-HU;
        Wed, 17 Nov 2021 10:24:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 15/23] Makefile: add a "TRACK_template" for
 GIT-*{FLAGS,DEFINES,...}
Date:   Wed, 17 Nov 2021 10:24:24 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-15.23-fac30fe8b56-20211116T114334Z-avarab@gmail.com>
 <20211117021937.r63hm3irwqsw4p3y@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117021937.r63hm3irwqsw4p3y@glandium.org>
Message-ID: <211117.861r3f878n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Tue, Nov 16, 2021 at 01:00:15PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> +		echo $(wspfx_sq) "$(1) PARAMETERS (new)" $@; \
>> +		echo "$$$$FLAGS" >$(1); \
>> +	elif test x"$$$$FLAGS" !=3D x"`cat $(1) 2>/dev/null`" ; then \
>> +		echo $(wspfx_sq) "$(1) PARAMETERS (changed)" $@; \
>
> These $@ will expand to nothing, I think.

That's correct, oops, I had that left over from some previous
version. Will fix.
