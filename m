Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F15C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 14:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiBVOFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBVOFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 09:05:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06698127D5A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:04:37 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l8so15693115pls.7
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBlm+2HPXOnC7mLH5l+Qfon6M146F/VKrcUEPT90Zz0=;
        b=h+/YhPpyGaDmfSRfxud9HRLIo6aMOF29YNnMIvkUssenYhJkQoPswDFhtsqckSZYSk
         +FabzEMuAa717XnckvRqQkOnuq8EazXOMLoAlNh6mbJ53HLRqPk6YGcXzMMnvLMlF+TI
         RhK4hin0mcDFt6HddOyimuDDgqWjeN0uUYjqRZ0kHMyujiy44PhgAFOtbAmx16m9FjZT
         TX9gwKC2mXtAMek64b3kc6eJl4cQJ90NJaLlHCw7TX4tNzmmRz13ndfSYtjU1NJzken+
         1wd+RwgyT9ugGz0c9yVblrfzE58VCmhjOQB9nydWiC1ALrNTqUhF+vNOY/Po8McsFho8
         BgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBlm+2HPXOnC7mLH5l+Qfon6M146F/VKrcUEPT90Zz0=;
        b=zwg8TXfKpMYp0mOx+538X3/nhpogt/SmBeMKtygHJFuHxmFUftA68EmD4gqel0JT4U
         lWoz+F8Vb0uQBeT+AsfQT6kdg1aBns4NIVxaSrTgGTOeaOSyUSOZWDhgFRowyj3SwqWy
         cK5fF13+u5E7QXl6vEFvnhDY+4NANs4KnDFY4oCon4UJUOkymC/kMrJIocK9cFNaddyJ
         52E9qeHQaBBO26UuClhJOMZAIHVoCmznM0RYFgcxqQKmm5RQlrByjoiIE4HD07tN6HBL
         0OUmong6YX/gGVKSAHjxnPRCNz4GmzJzix7aTT49ZhcJOo4wDanN7SqCUUBPjycofXoP
         fGPA==
X-Gm-Message-State: AOAM533FZdkLShZw2XN4EJ8NqPmM4Y5ZenoXoEbKRFqOV+/nok7jhurc
        mH3+tgD1H4sXvEWKlDCE9vs=
X-Google-Smtp-Source: ABdhPJxG+3dCuMJo4z4e0wPJMNv4raBrwNp0IiZ6m639F0KmwbL2ZfmokgQr2SCTfyl8siwzh61O4w==
X-Received: by 2002:a17:902:ea81:b0:14f:a4ce:ef79 with SMTP id x1-20020a170902ea8100b0014fa4ceef79mr12219777plb.136.1645538676310;
        Tue, 22 Feb 2022 06:04:36 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.56])
        by smtp.gmail.com with ESMTPSA id s11sm18087116pfk.8.2022.02.22.06.04.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Feb 2022 06:04:35 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Tue, 22 Feb 2022 19:33:47 +0530
Message-Id: <20220222140347.85321-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
References: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julia Lawall wrote:

> Of there are some cases that are useful to do statically, with only local
> information, then using Coccinelle could be useful to get the problem out
> of the way once and for all.  Coccinelle doesn't support much processing
> of strings directly, but you can always write some python code to test the
> contents of a string and to create a new one.
>
> Let me know if you want to try this.  You can also check, eg the demo
> demos/pythontococci.cocci to see how to create code in a python script and
> then use it in a normal SmPL rule.
> ...
> If the context that you are interested in is in a called function or is in
> the calling context, then Coccinelle might not be the ideal choice.
> Coccinelle works on one function at a time, so to do anything
> interprocedural, you have to do some hacks.

Thank you Julia for this helpful info. Looking at your description, I think
the `add check to parse-options.c` (that Ævar suggested as the most ideal
method for it) method is more simpler than this. Moreover,as this is only
about checking usage-strings, so adding complexity to it will not be a
good idea.

Thanks :)
