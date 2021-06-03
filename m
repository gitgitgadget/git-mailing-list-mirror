Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69064C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B94A613F1
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCTJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFCTJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:09:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CDC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 12:07:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i68so3458660qke.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x7ita9R8csYeJjVMDnANzpQIbpZpGGcGCq33oW3gK4k=;
        b=cgPn/MzLsad+TRm5o3a+S8nw52e5MqiMcdWd/wjX3+m5iZTBRhctkWrPS8ob3Y+SZd
         OjML26EURq3vjqwqoQFpy7wM5k0AjEbMbIs4YtrOPzXBr3SvplPFGBXtb8kPhMps06rL
         V+EVkXYloBYkbAfrgDYwpFzAGV3MRfLe5tYlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x7ita9R8csYeJjVMDnANzpQIbpZpGGcGCq33oW3gK4k=;
        b=Uzl+pP3lTwKHF4aOo6yadToDOrPGP6bquQPLJJw1W+1irmUyY91utcYefC20YT1AUF
         JnzMl2lgeqo3UMHREy1w4zrkXKG3aHCiTPdV5/hT+JL33z3Zh9WiMAhd0XArHC3tHpMY
         gx6tYYdpxHoZ/MIqBrnwmdHAXuqnXymCDunST54DbPeuFN/zeWQGNP5wO6JbeP0j9uKZ
         w+9OqpkC9jd3wKuA0pSl2ndBvQVeFgxl4Djn6/navXmZFqDiKLAjk+NyDY1Kyj4Qz8So
         sET3NWYuvelEtxZ3MGjONSVZNpPn1I27fFCV0b47mtllG7Jw0fLU3e5m6N9F8VLvOOXW
         TPHA==
X-Gm-Message-State: AOAM530UV52t2yTtzh68eGgYIkyjVMD457WdgY2Er4aGLKJYORtmAxfX
        u4uAQsuFUfSv5Ko4RPy0PnAXwQ==
X-Google-Smtp-Source: ABdhPJyFfaZ5J+0Tr8w4qAL2SBol669930v9nFnaHOWWgvoV+Lk4rgN+c6paUyT8/tTT+IkYxU6ZpQ==
X-Received: by 2002:a05:620a:448e:: with SMTP id x14mr761631qkp.10.1622747278108;
        Thu, 03 Jun 2021 12:07:58 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id f8sm2530310qko.131.2021.06.03.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 12:07:57 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:07:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <20210603190756.ri5o4udl2bvusyhw@nitro.local>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <20210603183220.47nx7f2aazk6wy33@nitro.local>
 <20210603190231.GT8544@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603190231.GT8544@kitsune.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 09:02:31PM +0200, Michal Suchánek wrote:
> > I'm not going to argue too much, but I'd say that someone who's looking for
> > solution to use with git-send-email is *likely* going to have access to a
> > smartphone. :)
> 
> I do have a smartphone. Due to the battery life of smartphones I don't
> have access to it most of the time.

As a note, you wouldn't need to use it "all the time" -- just for the initial
login via the browser. Once it's done and you set up the app passwords for
SMTP/IMAP access, you would rarely ever need to access the TOTP token again.

-K
