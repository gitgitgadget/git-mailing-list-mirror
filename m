Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65FC433E0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADBD20725
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594502360;
	bh=+d2+U7KfYVbf+8gl4yd+5H4SMHfEKJr7p6byOkJcz6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NvGvU8yUszpY8LKajtNl9svESv3yZBNx6k3zl+VLeYzhiRe/hqARtij4ft+mCh7ZZ
	 fQF2nZ4ChUc8Ls8PcTbLCvBS4XisPS1SZIORUqhcOy+PW8g+LXr8E0ZzHKlA7ZtEBA
	 zqiKUxJBsh2R76/Zg6cj4SKJ/h0l878EMuBaU6Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGKVTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGKVTT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 17:19:19 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DBAC08C5DD
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 14:19:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w27so7195572qtb.7
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+d2+U7KfYVbf+8gl4yd+5H4SMHfEKJr7p6byOkJcz6w=;
        b=ApCu4bY1IRNaJuZ76K0+MiA12F3jKyVHn35xwSHzZBUEkloVZKezpZGaFTPta4LA3o
         gVPLvN4PJ0djEuR98CRZoi59K8c7k5eFFNCyvLUeKiKTvlnDvgTrRkyOsuFSbrJt0OZq
         yqYqFce75iMDXqPw9p7r+RvOxgyQRV4tIifx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+d2+U7KfYVbf+8gl4yd+5H4SMHfEKJr7p6byOkJcz6w=;
        b=MKvjmJAy+wPKoZ2rF0VXzKqOtZSMtred+FItXzI18n7B9PhKDGwk8i6JgAyBhpxvya
         +irxuN4m7f68hn9xdDNQGEey3jm54GqnyjilXj5IZ7zTgAJGO1bHgq6xTYQP59QrmGBa
         hu0F8XHv6xmfkmCY0MW6F/qKy3pWJb6jqPbta1CDeKRT7oS87YrFWwyP2i3M0aP0LbvN
         QhAthWfZfXkis3Qm76t8s0yJpkwgnQPxk26tBrOinKIW6YaaumCEbIlvYzj2cAR1caM3
         x7NKE/b75EQddU8YsVX+Y/6VP4ZZ1kXFeMQd3gOLdc9QlvgreVUXdW2+grhIV/bEZMyu
         Qvlw==
X-Gm-Message-State: AOAM532lDFHY1pgu5ACRe2mLiDfqdrK08RCQomCwrj5GMdnI7Qs8tlCR
        ha7rQHhya08gmq885TSuu51XXLfYDY0=
X-Google-Smtp-Source: ABdhPJwWc0c42FdEoXYlmacamGnFd//bBW79no7z2c8Zi2109dmhUlki5QdhRfW6fKQ69kY68Ywstg==
X-Received: by 2002:ac8:a03:: with SMTP id b3mr77962757qti.240.1594502358771;
        Sat, 11 Jul 2020 14:19:18 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id 21sm12820587qkj.56.2020.07.11.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 14:19:17 -0700 (PDT)
Date:   Sat, 11 Jul 2020 17:19:15 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimetrcay.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 11, 2020 at 02:07:01PM -0700, Junio C Hamano wrote:
> So, unless your script depends on the presence and/or the contents
> of FETCH_HEAD, you can safely remove it.

Excellent, that just saved me 20G per each mirror. :)

Thanks,
-K
