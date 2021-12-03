Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11F8C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381945AbhLCQJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbhLCQJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 11:09:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD961C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 08:05:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5478020pjj.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CcJfdjuoIi4UQ5d6M8qnZZkHZUZLkIyDhZj53de3dho=;
        b=kaxoPm873jgiEHZniCNOGceWup2wsK6hBovZDh/bRAVPEIcVSysNWtyNNcx3GKbb8E
         9TCvXgB0xhskwbYexW8Wr9bgelLMX6kDBzk93Lp1OjhOv/GXX+UXvtUpAnjl+OUR2USN
         dkNYBAX0TvYHVQ9E/yCj79Vtm9Cv5o2waFrfvYdts+2y2HOTkWnGhuzBY0NQsHiwwis7
         ZW1W4/C2M+dfg6ciVDfQ7zlSUMtMgDi0BsP5qIyo3n9QQrg5dQ9UfzHfBqXzuPn5XDQj
         G1CLWwbX+fJqqumVSDi7vXMV0IcYPVZE08F1nAmw1xmznZZpiuGu/XdLgcq/n6e21E7e
         o6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CcJfdjuoIi4UQ5d6M8qnZZkHZUZLkIyDhZj53de3dho=;
        b=o4vA5KL7CUrR+GcKXT9bCzvpzvPW+s2SXjvoBEzjc2MoPp64y76lIUOVYCUaUdSO3w
         m7PoTze8osC3LI6H2megVCxazqy2z/8BYILMoWqpDloG8lwPJ6O1Dhu7+i0EGOjiC8IF
         SNE7rZz5VI8uKtzt1OmoE1ystt/eRxuwG0x3tEiaCHzM92IHn3kU8+PQdeXz3D2QhCxx
         3tKpVlX8US0YWijyQnFpZJGN9uingcZIAHkwkQcTmgtwMCY8dXPKw4OZGfLGZYjubvW0
         H49/wEqFYhe4XV2Qo1W/jXbHrUtliWvgoogMAFHTU/LIruon70wT092yaj8s4NEbFJHh
         QNxQ==
X-Gm-Message-State: AOAM531OA3xoEvOqMLREuD4xN6q13hbQZOgorjUJb2fRFsIKhOCOe19i
        I6VnMEi2zAXlZvM04VT+R4G1Tu5aJrY63Q==
X-Google-Smtp-Source: ABdhPJyNPN52GPy7uzgoCck1ZvszaIFpTy2znnBg9nrkmQ4Y6jlAmksHJVSOyaDnMz3eDGrpV5Qhbg==
X-Received: by 2002:a17:90b:1c07:: with SMTP id oc7mr14948311pjb.127.1638547559299;
        Fri, 03 Dec 2021 08:05:59 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.236.175])
        by smtp.gmail.com with ESMTPSA id j10sm3390254pfj.106.2021.12.03.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 08:05:58 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     philipoakley@iee.email
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [RFC PATCH 0/1] making --set-upstream have default arguments
Date:   Fri,  3 Dec 2021 21:33:46 +0530
Message-Id: <20211203160346.18221-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
References: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:

> Can we protect the expectations of a user with a `pushDefault` setting?

Are you talking about 'push.default'? If so, then I think, the proposed
change would not affect the working of 'push.default' (if the idea is
implemented in the right way). I am adding tests to be sure about it. 

> If the user has one set, then the upstream won't be where they push in a
> triangular repo workflow.

Pardon me, I am unable to understand what you are trying to say. Could you
please explain a little bit?

Thanks.

