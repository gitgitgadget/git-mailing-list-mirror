Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC17C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E19214D8
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592329333;
	bh=oNBoH9WacdwodEhOLxu9rXNoy3ewr4t+FGwPUSsXSRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UI4A7ybUib99hv+PurB/BrhuLGwCsKfoUnC46EReNW3IrKdFiLwfdKspUc0CRY1Aw
	 EiIR/eDGWbpnUR0rwWsKVGx7J0O2GpPvmzuaVszokTHrH1Hu9RrfngshIeuTArM6dT
	 w1PAJsp06MSL+B3M7UhBexAcEqOoKAYiKE3NJQGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFPRmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgFPRmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:42:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8067FC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 10:42:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x16so9894487qvr.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZIIiGmjrpuWiQ4YIpVhcRQ6QM+q8VGNYrW6tjF0p64s=;
        b=C/WzRbILLkX5mUL5IxXWKrlM5z6jLGPnSzOX/RM4+9currT+vrl2IJJNQ1YCPErlKQ
         1Uhvdlj2Bq8OcwzcfyvM1jPMv98fZRUqyKVd06ZvgtsmNmxsmXkwqK8q00qq/t5xkxC+
         Tp0xIAyaI7mQNMq28GeBXdNcbxR9oH7oCtmWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ZIIiGmjrpuWiQ4YIpVhcRQ6QM+q8VGNYrW6tjF0p64s=;
        b=lRr98w6OfkvYEZl8IYihd31Swa1GgByRc4N/jPDqkQ2kaD+9P7Tiqmg4iYDfsVyWYj
         0/o6PSMu/htH3OahKnjjG1JaP6dbFh5jfkEga57Eer/yWh95swKOkWvi5/zXDvSQKed+
         MQ/09Q9/+eikKAPrtuq+TK5Q1uqZ06pJe6nDUmyE4+vSZyGW9vGdNOSZ1oFHFet5w+YT
         h9LAXcKORvVR0fy1QuoCEhsJbD8xyTYQ3q2c+lNLJlyPmmkenV6OkhPe3RGLvf5dl+Y3
         HSl7pORw9NszlYfa7buS8O9/PRYo08yR+NzhYjuGD+BZU2k1VgpeNyP2WaiFk91uGnoa
         SVPQ==
X-Gm-Message-State: AOAM533mwGwFigbyszHorlXW2wnVQ7e+O1E0pxgQvlDUsmkn/UdAbHUN
        WYLgmeii+NfZBSj/ErDZmFi3BYvagZ4=
X-Google-Smtp-Source: ABdhPJwpzPYeeIsdX2PrLtwoiZJfTsT41BTFVdUkfxaKzGiHAeiZcqL9L+qB/B8/kIT+9gvCfW5WLw==
X-Received: by 2002:a0c:e9cd:: with SMTP id q13mr3566721qvo.23.1592329329113;
        Tue, 16 Jun 2020 10:42:09 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id n130sm14294903qke.77.2020.06.16.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:42:08 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 13:42:06 -0400
Date:   Tue, 16 Jun 2020 13:42:06 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Oleg <lego_12239@rambler.ru>
Cc:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616174206.oana33736jkemyqs@chatter.i7.local>
Mail-Followup-To: Oleg <lego_12239@rambler.ru>, git@vger.kernel.org
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
 <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <20200616142651.GA27946@legohost>
 <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
 <20200616172749.GB18874@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616172749.GB18874@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 08:27:49PM +0300, Oleg wrote:
> > Russian sites use .рф domain names. If someone wants to make all 
> > their branch names in Cyrillic, why should we prevent them from 
> > doing so?
> 
> Because there are no such people. You try to fix non-existent problem.

We can reasonably expect that there will be a government decree coming 
out tomorrow that will make it illegal to use non-cyrillic terminology 
in government projects. You know this is entirely possible.

(Heck, every time we promote "pu" to "master" it can be seen as 
politically charged commentary on current Russian events.)

-K
