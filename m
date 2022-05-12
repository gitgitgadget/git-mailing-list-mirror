Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD3C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358257AbiELUCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358242AbiELUB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 16:01:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784935E747
        for <git@vger.kernel.org>; Thu, 12 May 2022 13:01:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b32so7870856ljf.1
        for <git@vger.kernel.org>; Thu, 12 May 2022 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=4SoH2hobGJa5Hu6/TVfpWvOKIMZiZtmM6iBJumuzhuc=;
        b=fG8GvzCIp6X2nxW7445xPpfRkggtmGorK367wWpwcxk3rfYxWCbXCPjD+OzOtDRbKp
         osuCvIpzQ5ZMCEr6q8UeWD7bJsiF8HtarW4YDtd9oMFb/u3lF6tCJ48VE6XzcTVauqmG
         pSPZpYe0D5CSiAXBKFDiYy6QShEqeg2pwOH+7zWur/HG5V74dbCUBAohUo7DcXyHl/MX
         IOfqRnZ5EGd94yc+EYsLuJ30IXZDun9zNreJCRVCdtJAJSZFty6vVCwk+gMy4ZiazJZU
         mbnV/F8C2AyDyk145J8xasAMs/tWlsTsPDLsT/Bq+L42rwMfKO8T37quRg0LnrY51Ceu
         wF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=4SoH2hobGJa5Hu6/TVfpWvOKIMZiZtmM6iBJumuzhuc=;
        b=7zv0+Ef+wXKxd9Hxn+uZFgFWl8DG5qlwqDZQtmyF73yDNN4YqdsuLRvmQCY8dRnlb0
         dqp6EQO1C6zK6crgjZruMSfzCclAlQNfGt8txIyPzo7wZwFzbHfp1ePkkCpTeIX4usU8
         SWs9tvpF9HoPktktH8KsnzZlpJMgKIMztVt1P3apDEESdGHO/u+aafyeTkstBNUIWbof
         5HyOhx9hOfznZWIzetnLX/KPcCqStwD0+vuBU102rYx44sNr6jTaFUYnoB4PQs6f7OT0
         zWp4QGXvtvmFY1CPUU3R0XO1Agfxtj+KxB1BF4+mhbZyyayVaK076d42OAtJgYe2+mbP
         rl7w==
X-Gm-Message-State: AOAM531VMDCVNJY8bEI9fXSE7Tl3dGQA3Ue4NZrhRuG3ASKeNG23L0if
        4q4EvD8s8bTLEBBc35K7bfELnUflJoU=
X-Google-Smtp-Source: ABdhPJw3o1DKf2oWxRqun4JuSinEyAg8wd7Oiqt1hzvo3RckLYVCW2cH93isyE2Wr6sglvPvyBRuwA==
X-Received: by 2002:a2e:a0d5:0:b0:250:8290:c58 with SMTP id f21-20020a2ea0d5000000b0025082900c58mr1019282ljm.12.1652385715371;
        Thu, 12 May 2022 13:01:55 -0700 (PDT)
Received: from smtpclient.apple ([188.170.76.182])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512360e00b0047255d211e5sm68344lfs.276.2022.05.12.13.01.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 13:01:54 -0700 (PDT)
From:   =?utf-8?B?0JLQsNC00LjQvCDQptCy0LXRgtC60L7Qsg==?= 
        <vadim.tsvetkov80@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Git Submodules ref setting
Message-Id: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
Date:   Thu, 12 May 2022 23:01:53 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've started a small project which involves several git repositories, =
which depends on each other.
For dealing with these repos I wanted to use git submodules as a simple =
package manager.
However, it seems impossible to lock a submodule to particular ref, only =
to a branch.
I would like to ask if this is deliberate design choice?
And if it's not, may I contribute this feature?=
