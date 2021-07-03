Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E9C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514DB6193F
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 17:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGCRf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhGCRf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 13:35:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B8C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 10:33:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so15559132oih.4
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=CmoLtz0RaCV/2mUmT2WN6cxbKAptYs1fALQHrlhKhx0=;
        b=L1bUZn13njP8NG/eyV/4oxnN522kphT208EC6X3g+TLDLGlmlPVyDYT8hauFqfHIl0
         h8RtbGvCGH1widEudPIpu7yf5CclSMTtTOobN9j6VqgZHi3ouZc+IrQMBpyudjt1kOkl
         GNWvMWxQloc6kgUtQnraQhf+FcNeBoB9kQ/kPZl8a6KznwsgAzBpRZTNeuRvzpc8SUKT
         tuTWbAnQDXfQL1B+VIyyF9uSCQ/sjz0PRYQtkZNvGeZWk0viXPL+0SnOQGakfge8DW2/
         phVkL2e4U+Q3JdwyuXg3Zy94aSo1yeCHhiP78O+zhGGzPxUI38+iEd7/OUzT6jB/vbah
         MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=CmoLtz0RaCV/2mUmT2WN6cxbKAptYs1fALQHrlhKhx0=;
        b=lRWQ+Rr6RquRC4gfvnMWc+DPOiWYXOMbAQRDovenCMtBVGwIn9350cwvcBlPtw+Coa
         wkb4uopTHYxsWjAzrfwGYQwI+cXQbfVACXbjLbIoAU9y3dCt3EurDsbxhSfkc7eEEhCl
         xgmCIsb/Kr2G7Rt+FOD67Y9aDuEIoRD4jeUDiOmBq7FiQZ/oN7ntNLC+ovexoCzttiTO
         MfzCN7yP311myQ2ggsP7vzs+ROVR3gaoPaYi/mIQJgcvrkciTA4tMXv0gfHgJDJq3vGX
         J+udrT5WfQslH41qITztUm50J2kVtOK0ZoT6+FmOVs6EdffXec/kw5t+jpqVYSu4UQvW
         TmMg==
X-Gm-Message-State: AOAM532xUVJ6CxjOhQpzBSZTkTmrxvfM7MT2BqTINJAe1n+nmYCi3ayG
        Y3qDOrRw5xSacEbmWgJWCkM=
X-Google-Smtp-Source: ABdhPJwrCosDx8AH06x4kREuFxYtNw1+++r/EeFY1rZyFhEqgxKvoGMuCaWeEzxHX2r8OCCeqjnYfA==
X-Received: by 2002:a54:4e87:: with SMTP id c7mr4487533oiy.82.1625333600211;
        Sat, 03 Jul 2021 10:33:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 36sm357821otw.17.2021.07.03.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 10:33:19 -0700 (PDT)
Date:   Sat, 03 Jul 2021 12:33:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60e09f5e70ae5_92c020866@natae.notmuch>
In-Reply-To: <cd495a08-bbf7-35f8-e1a8-a87cdc9c3ef1@gmail.com>
References: <60df97ed24687_34a92088a@natae.notmuch>
 <cd495a08-bbf7-35f8-e1a8-a87cdc9c3ef1@gmail.com>
Subject: Re: The git spring cleanup challenge completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 03/07/21 05.49, Felipe Contreras wrote:
> > Other than that, it's fair to say that *everyone* needs some command
> > aliases to use git. This past month shell completions have saved me, but
> > not completely. I can't imagine how a newcomer must feel using git
> > without any alias.
> 
> I personally use git *sans* aliases. I prefer writing full commands 
> (like `git checkout`) rather than shorter aliases (like `git co`) so 
> that I know what my intentions are.

OK. Virtually everyone.

Have you tried aliases? I just went through a month of getting outside
my confort zone.

-- 
Felipe Contreras
