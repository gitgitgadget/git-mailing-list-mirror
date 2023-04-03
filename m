Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8EC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjDCJWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjDCJWK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 05:22:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE611026D
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 02:21:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m8so5754297wmq.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680513699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Kj8b20hd9HB2HMoOtSN1Hvm4aXXrX+PhdlW46hrHSbTn6dOLHPozpkoT3G7RWteENE
         X6w7PXLg/QVUi+xp+1N0IT3sDZygVvJEJLSL5NxVOd7rGclGpOb5MfFJ5oKpfyNHa56x
         a6bOqxCmTV0JgMhM8o0lT09hPS5kH10tvt35dOUe5O9yyqNE+rZ6Cpljx9MyDkoyBeoj
         i2twTXEV62Es9gCWpDrGVBF4AdFoVK43hbKS/tKZeB9+lXWhLKgo5GYpWdlQ42oYEOFq
         ukQntiysARFtHRCDSDPa5KCETTdaqDDPoFlJGV0a+vXE7toa9M+ufKlmK0J/qLgEjAQR
         4mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Wrca7q2SxJhiOivEoLchI45c1eivFBQXzFhVU7+iJFtRnfOO8xR/y8dP1YgwcSmhUP
         7KpkwE2g3AOktTKd6kw+GwPrjris9cUeZpwfOhuYzEonKQFSIzzPPXn4AZ8I+wwGYwnh
         1J2UyCVBebKYtTeD8qKNuobg2u5SnnWN2enGCrO5G6dYidfUrZb3ebLtU4XCHVYAQcqI
         8P5ISqiJmmq/FR9eRtzFVdVdFFNyp2P9k+9zONEiv2ezYbPFLfLggWJ2Y7/ypuwF1XC1
         LrIb6gEg4xGMC4e8BiE0zVqXXIOPJQe2BsteK6fj/hxJ54mQM2a1vI+W0qCS6UVux5ud
         7SMg==
X-Gm-Message-State: AAQBX9fnSmncoV4phwD4H4BQBGNFZDB57Q8zXAgHtx5541GiWivT+Q0n
        LgRN2IaUxKEgGujoprERicA=
X-Google-Smtp-Source: AKy350Z56QO6IAgo+CBiFsMdzjam7blrxjKckO5k5KDPruemspRHQZ37tJL6+7T8uOE7QhOCoQmh3g==
X-Received: by 2002:a05:600c:35c5:b0:3ee:136f:bcf4 with SMTP id r5-20020a05600c35c500b003ee136fbcf4mr12658779wmq.5.1680513699336;
        Mon, 03 Apr 2023 02:21:39 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm18757221wmo.25.2023.04.03.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:21:38 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     sunshine@sunshineco.com
Cc:     edwinfernando734@gmail.com, git@vger.kernel.org,
        rybak.a.v@gmail.com
Subject: Re: [GSOC][PATCH v4] t3701: don't lose "git" exit codes in test scripts
Date:   Mon,  3 Apr 2023 10:21:30 +0100
Message-Id: <20230403092130.40900-1-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
References: <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

