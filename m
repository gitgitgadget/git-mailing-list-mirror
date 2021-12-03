Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECB7C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 17:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358636AbhLCRc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbhLCRc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 12:32:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B02C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 09:29:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z6so2587946plk.6
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDFLfdVtEMQU2SboQE76SpOjfMDBXK3ivOepLyNEzlg=;
        b=JYLMx8siABtlRX+ReHOzFADOrmnU0GZnBmioI41+MGhB/TiYCunGv80TtVlMo+rYZP
         JmeZIZh1aO0Nb0Hg6kYgIkBUSQbyDUDj5uffJ3m5jAKPgH86jgK/5BZ4NAidNGJp11T4
         GFJxIeNPYPkf0U3qC2JoTw/pqf3+tlm1DmR+4Gw+E2jXUP+RWio8lHRQh8IA97yBUB4Y
         opqfd3HQJz4vtm3Hi5DPMO7Rfb6Nfpkd5FoRWVtxAZi9kmWgfPD2ZeiVriZ4b2qRSFwz
         TfaFqpFiQvHEQM3azwaCVPTACHkI7ulrezQbBOXzAMfgu7qJUAGOAyLm3oo1ZKzbdOQi
         YySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDFLfdVtEMQU2SboQE76SpOjfMDBXK3ivOepLyNEzlg=;
        b=uoiuVCoWodb+UMncoU+I2LstE6GjQGtJaRfntPNSVIYdc9DJhqpLwn/va1lZALxZTH
         EZvTJwl6hMtuyuXta/BdnJjFS5D48b+EBEMJcCkABIJ5PutTMwif5gbdkn8m+xM6b36Z
         lVUdH/6T5gz61IlcE+XXbi17wcME/U6+EcyCrrXEK4Vor/CPnn5zHg2AjzFOepQvKjD6
         NJ9Q6ubnYN0K9/cnL2LiJUBXgxCczHpqmgVexQ0/eXzGj4EFPBN2fW/PaJmTbcjYzLxn
         TOkmzmO5XYjPI3ORm/yvA6bHEnCzMHYj9mK4u/yiZOGzAeoYT1Onmv0pA2470McK8bgs
         h0bg==
X-Gm-Message-State: AOAM531B18xQ8DjDBnTQ4ngb03f3Q8H84QfD9gyfmUyyXsxknRaItbqC
        hV4NJyg3bezmg1/3tetXxdg=
X-Google-Smtp-Source: ABdhPJx2PY0TUuB9/yIqg1qbQHfS9jZEJ2AbKMPe7BRsD5UYUp/7tJBXRn1E4sL3xWRQE68HORET5w==
X-Received: by 2002:a17:90a:6e0c:: with SMTP id b12mr15326039pjk.41.1638552542624;
        Fri, 03 Dec 2021 09:29:02 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.236.175])
        by smtp.gmail.com with ESMTPSA id il13sm6517988pjb.52.2021.12.03.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 09:29:02 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     philipoakley@iee.email
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [RFC PATCH 0/1] making --set-upstream have default arguments
Date:   Fri,  3 Dec 2021 22:58:19 +0530
Message-Id: <20211203172819.18343-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
References: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:

> Can we protect the expectations of a user with a `pushDefault` setting? 
> If the user has one set, then the upstream won't be where they push in a
> triangular repo workflow.

Ohh, sorry! now I understand. You are talking about 'remote.pushDefault'.
I didn't think about it. Checking if the proposed change is affecting it.
Thanks for pointing out!
