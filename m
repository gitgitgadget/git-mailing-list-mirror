Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A600C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1773420FC3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8QJHsz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgFPNT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPNT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:19:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3DAC06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:19:26 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b4so1226109qkn.11
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4eJaZKdZggWMSEh1fFK1XxeF2Qy6LCLxOn8EyW4jFtY=;
        b=d8QJHsz3u5sAm7oZb1Bwen5DuwJ1z9h1/3J3P2g5GP8kF3TESAv3nYHNOrZxyjFv+I
         bViL/kZOtOR1C8wZ/PNOhsHI4NBSStkOnsRd9jwc7OhIiNm5mTxaR4GmJIs0gQuK0YmI
         yZL4Dig95ADA0botMDWjuagd9sEASuWWyW9l1tQQOcWGq4xOzIlvV7CS0ZkcxgvtPa6L
         DL9643G/hR7GDTDvnITxMC5IYqwZ0TUt5LqNlp4kPRdEtFpDKr4JkAc//En3tBJeG9Z+
         /A77PPdIZbTusPizylEMOXntDSMdODcAzi3Bnm25W3CUIg8W/zJGG5ggtXcxRsrVHc9X
         zwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4eJaZKdZggWMSEh1fFK1XxeF2Qy6LCLxOn8EyW4jFtY=;
        b=A8Vgz2Hzq7RrHcHmGA7ZHq5UTGqif4ochMhyX30wE3RFet+lMi7AkmJd7JfVdMLM6D
         PDwYsONWcvoDMY2wKcT5xYtRvYMcpyWQ6efIOfyXsu/5td+YDh0SdcpUYbV8NhLDvQKH
         AMJhxf0Lwyg33ADV+1GXSMO2lvEXhUudVTFvNnsT8j09E/bgXVsW7YcN8/6Ki91O/GnY
         BbbJe9EtZd5zYl7uf1HHiKT8GD5esHYdMmjhpNN6ymNMbPHzUskqBdSNWrQyQEpGl1LA
         /yDElYbYphkFuhluqslfNvnYISCZbKtUa35UYw5cQ4t5pliNnf/ZUqdMaU2erMUWyf/m
         NANw==
X-Gm-Message-State: AOAM532EFfDzzV6n1EfD2MxfvaDtVxTh5QvoAyEvg6oulQQk5fcLUr0H
        m3ZYsKoSDBgD0DZ1H2yq3HU75ZTKNAY=
X-Google-Smtp-Source: ABdhPJx8aeI7Gtg/l6CqehnVaeET5yy63z+VfTZGAK1BXtP1EedGYyTcFzVIh8UgXowMffHuzzUfBg==
X-Received: by 2002:a37:9a57:: with SMTP id c84mr20519977qke.248.1592313566023;
        Tue, 16 Jun 2020 06:19:26 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id m26sm13995101qtm.73.2020.06.16.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 06:19:25 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:19:22 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: CFT: imaps://public-inbox.org/INBOX.comp.version-control.git.7
Message-ID: <20200616131922.GA721186@generichostname>
References: <20200610184147.GA1887@dcvr>
 <20200610233127.GA51956@generichostname>
 <20200611003036.GA5446@dcvr>
 <20200616070832.GA13965@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616070832.GA13965@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Jun 16, 2020 at 07:08:32AM +0000, Eric Wong wrote:
> Eric Wong <e@80x24.org> wrote:
> > I'm dreading the cost of ~100K RAM/storage overhead per-client
> > connection to support sequence numbers properly...
> 
> OK, that ought to be fixed and I found what seems to be an
> acceptable solution w.r.t. server-side overhead:
> https://public-inbox.org/meta/20200612234924.GA31809@dcvr/

Aha, I noticed last night when I was using it that it seemed much
snappier! I can also confirm on my end that your patch works and it
makes the experience much better.

Thanks again!
