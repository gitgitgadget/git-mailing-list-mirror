Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E143FC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B575F20752
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1+E24zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCTPjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:39:13 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34110 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCTPjN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:39:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so3567365pje.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNOei0tkY08MMqYuEMZRqSclomPD7aPFxDnYFmR04n8=;
        b=m1+E24zRqtrgIcu4Wq2oXPfnzrwH4qHzwajUNE37kPk+uC6LK2cgf5jSmDbtJsQBv2
         i5dKtBfZb3ijKJs2F8NuXGGf5D4Xm88B2qlJjLcLZZEjXVSmLB0cZWxoNPEyOoY0REyb
         TFahDGXwUUdzCKpJQCW5UfsJZhEMHfgzXZpC+kOOUfa6zWYghhNjcMz//MMydUjc+Vl+
         vdbOCPOk14fkkueApXP3ZJM4iy+y+KrfaUyW70saJiE1kwRL4eCVUCwcHxZE0fz4FBiu
         G3qnQlASjVai6yzCVSgcSob/Vkzih7g2pUxU1VVQSXUgQVal75x1EesT9zAUeNyigv1+
         83DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNOei0tkY08MMqYuEMZRqSclomPD7aPFxDnYFmR04n8=;
        b=chH9RUNDKV0a7z7W6xKjtrKCTZS74nv/1BJjQHvkER5yckcnZ9P40NCZqEh7i3bfdC
         +jPj/LJXbLXdYyBYlyqeQl9y8pCYhoq/G97H9QpOtGUuttX9cirpUWEzLEgBwM2e8VAT
         0Bz1VzrClZ14lp8cbq9ONXJA53YpcgDT3Q78Sd0PRwb1cuGtyhNcBa/cerFlgM1aHipk
         GNfl6lGZ4kkbC70EuAxBsC+P7kMwAbDK/KN8hg9HEbHA5pSH5aawUwLArWIZd1ZCrWZn
         +gbE6lUsXo+pk5+jO2LQif3K+wt4SSFoEyK7uVCH0bD17NFB4UhncdYto8xQkaapEuil
         +PhQ==
X-Gm-Message-State: ANhLgQ3RhBb1hC8oIDwInXeGc1u6VqCGr62bVbuy/F5kuDkPvyLWqi5P
        tU0C0iBJ3ve9GwPFitOWvFs=
X-Google-Smtp-Source: ADFU+vu9VMIhtB4/CF0ncAIraMgKpdgHB08ND3P2kQFzo+JCqqFog4v/l8SaYNjwJYZxleQZcERf/w==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr9145887pll.211.1584718752507;
        Fri, 20 Mar 2020 08:39:12 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id c8sm6283166pfj.108.2020.03.20.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:39:11 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     kaartic.sivaraam@gmail.com
Cc:     git@vger.kernel.org, harshitjain1371999@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Re: RFC][Feature] submodule
Date:   Fri, 20 Mar 2020 21:09:05 +0530
Message-Id: <20200320153905.6156-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <555da203-0740-3d79-15cf-83c5a8d5dbae@gmail.com>
References: <555da203-0740-3d79-15cf-83c5a8d5dbae@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Kaartic,

Apologies, I totally missed out on that.

Regards,
Shourya Shukla
