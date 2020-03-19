Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB8C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5842072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR1ByQLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgCSRCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:02:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51285 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgCSRCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:02:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id hg10so1282890pjb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqF+kwDtYmSk6AZ9BstMvq6FcTyJlV7Uosu+mv1uRyg=;
        b=dR1ByQLd7tia7+o34gg4DdHsTJ3a/KCB25bux3tPZFdUuPuJPj4HsmhhTudeRySuWl
         5CE4kb91FSf3yo7psCCPKVlLlYv+BlN6YJSydyQEVHb8nOSkdqaBj00AjU9I3vxQQe0G
         aWUWKItFhmhgIU/rUFPKi/Ynie9kWxwZOirXWisw8Ph01aJ0mkvzoikngHrYwM32fGcm
         1BeL+B9eWlp/Eu7SvLC4lXjju8EF8GQO1shBmBmojRd6yzmvsjX78hIuIxcGLSiDjlWw
         NFcXvhQXJeQDz28ZJ6lPD1RVgCt5YnkgaW1FzSduW58W1Q+ixrNmv8mIb1NQxmhj+ku0
         3z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqF+kwDtYmSk6AZ9BstMvq6FcTyJlV7Uosu+mv1uRyg=;
        b=biEVgvjdtgeLki1bwAAHptRLXUku5EGrYF8X5dpKMBCsL7+4sQhmapRLEe/wn3D44q
         ILD7PFfeLzRDGlD1IPrv+2SsrCJlSsxReJIB48o3rNZIgGtkfH/wRVczK1BuP+qETfAf
         lSKf2G+MC+x4BGy+4bpL+kV/GCBbadoh1YLNo3JUlo1K8DP2YcWdL+ZINci9WbHnd5oq
         +UjpAbGjjtDQY+ivX7P7PsUQHL8grFdUqG1OGs1mjJhA6XmM0w6f0GsJudZDiXCzAmDo
         uR3wFjooUmjhQfvjsqQcmqOTe2+P0crNope0VQQlrhG+GKdHHPuZ1Ms78yf3bsN9bRsk
         TtIg==
X-Gm-Message-State: ANhLgQ3xeOmChaeNJsoQgH6dfnyU6DWh2R8juiyp1VM/vp4wsbgPF+Ln
        hlFVMK28k/QZgbJb//dAhRrSo1akhP8Q3Hj0
X-Google-Smtp-Source: ADFU+vuzLcgJ6t9AoPCiYIJL7R+OKrzL6BfrRAekm6KQjCEVcOPssFe9Hc6DzAuYtrfS+P4rXM9Mvg==
X-Received: by 2002:a17:90a:218b:: with SMTP id q11mr4764272pjc.163.1584637332889;
        Thu, 19 Mar 2020 10:02:12 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id c62sm3045344pfc.136.2020.03.19.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:02:12 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sandals@crustytoothpaste.net
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 1/1] docs: add a FAQ
Date:   Thu, 19 Mar 2020 22:32:04 +0530
Message-Id: <20200319170204.5291-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315223923.170371-2-sandals@crustytoothpaste.net>
References: <20200315223923.170371-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems like a really good idea! There are tons of redundant questions on StackOverflow
regarding Git in fact. One thing I want to ask, is that will this FAQ cover questions of the type:

"How do I change the remote of my repository?"
"What is the difference between a git merge and a git pull?"
"Git is tracking the files mentioned in .gitignore, what to do?"
"When do I rebase and when do I merge?"

And stuff like that. Basically questions which are more of a help to someone. Or are we focusing
only on the FAQs to kind of guide the user in Git, aiming to answer the fundamental questions and
not the general problems faced by a user?

Also, I had some FAQs in mind, can I add some into this?

I really appreciate your initiative! :)

Regards,
Shourya Shukla
