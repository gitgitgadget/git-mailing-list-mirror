Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C3C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbiEZOvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbiEZOur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21AE80207
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v15so1491864pgk.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCjALZCVMjQWg1rRFaU/qoeaWmGFUKaRsMpOTN1+XK0=;
        b=fPT2h+Ch8PkgArQUFbhpwa3/H2IDTOquh8r/2LI5z7/fCPPyXOjMkE9eeqHcl9BFFa
         6pxnnSzPBJLMRk6ckt0KOHb7iC7NELB2j0fc8C6xfG9V7070A9wNjOUtck2WQYoLVP1o
         HcTGXHZG6C6iYHnO9MTOz+fy0CgSTRiYnXgK1jKz1my03w/NQWMKCXMRxsrcKRkwdVR8
         +q8x6ajO+QulMVtvQNvd2ww12D64gT5ix3z30B3jMzz4oqTVDm9ykQIQi2eYIRrm7kbu
         /waReo/7aVT/8jA/ac+3aIm/xoFD5WK0Cn/yFbyv20NkNMeb5b5npJNvnFTe/CIzuday
         0stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCjALZCVMjQWg1rRFaU/qoeaWmGFUKaRsMpOTN1+XK0=;
        b=rtriTEiwUfrEPKyPWjFFqkWqFIGKNXrkCoPXmz00ikMXUCES9Is3IcsWfcGuCsoAXG
         gzo6MBd8CSOF1MgBG+gUgLtMRhoiyO9lZ3vpxuMoUvshLQEarwZWuOvB6xiBrm+PKOHd
         bnBT890I+O4M0Vr1oQ5YPFRIqnvCqOI642oHT8nNjJZ5Xav+gVkp9A2lHPA4fYp3j+U2
         Zn2LloVAyruX9WFT6Atq/+JpaxWZKpUHnFeVpOdyfStzcYTIWm1fcfHFKpl2MzvIHK6L
         ObdRxxOD2yFgB8g3cI3FnpWGNe0p3oRw1kI4ZA3c1AbDvMQZkYyctm0ZDZzFS05SflvU
         EPSA==
X-Gm-Message-State: AOAM531qx9Jj02hl18gKM0QMeIwEjYKZu9vM+nYhN5LUNkJsaZObypQ+
        NLjnQRseP78dQR/zINxihLU=
X-Google-Smtp-Source: ABdhPJzAfsSmgj5CvNuUGpUeVAHUwkBd+nuPN103UHknUbWrnEUCOYavewbCAhdWObiWxtvx1M6MHQ==
X-Received: by 2002:a63:ea4b:0:b0:3db:5325:d55a with SMTP id l11-20020a63ea4b000000b003db5325d55amr33287755pgk.588.1653576646392;
        Thu, 26 May 2022 07:50:46 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:46 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 06/10] po/git.pot: this is now a generated file
Date:   Thu, 26 May 2022 22:50:31 +0800
Message-Id: <20220526145035.18958-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer keep track of the contents of this file.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Please remove the "po/git.pot" file manually.

 po/git.pot | 25151 ---------------------------------------------------
 1 file changed, 25151 deletions(-)
 delete mode 100644 po/git.pot

