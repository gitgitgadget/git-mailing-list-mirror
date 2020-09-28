Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C3C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A262A2100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601293662;
	bh=NicJgrslxYcSwCaalHtYiuRJWP612nVmrdk+uxu1cWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHncxJB3WseKj6jvp5xhMufOTdsTs2jgXWnbAomC9ZbkTbgMot3mGWpDd/dx3iIih
	 bkFXN0QhH4JMANJ99oKMuOyWtgJ/ADYxuuxzVidwIRz49ZQM/zxIUk4PNfRMPzyvp0
	 2Fg9aP3izhbUNX8XM1NZisgv9pySwcdExFced7f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgI1Lrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1Lrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:47:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0FC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:47:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w12so597601qki.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=qQSLjvFsoHD9Ct3IOnNaRjI6m7IUvl4f5dEGOp7mpgk=;
        b=WfM3m9qGGL+MtWddVHuwcYv2mYeCUE9TgQkqMISTNoeOlEbZIIlC2C3DYFtJq4Pbze
         dU+wv/6AImXkdWecnekFxI/E6feZj9YIW+3UFfLZPLVnjVnUi5leiYs+YEL6Fm2Ep5p7
         1CcEBZ4c/mZF4gtqptFtJtOalp6XFSXx79od0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qQSLjvFsoHD9Ct3IOnNaRjI6m7IUvl4f5dEGOp7mpgk=;
        b=mlJj+whYvJt4RNSA9hfAf/y2rezf/KDxHDT8UW/v8VNrDU+0kh1DV+kgc0jfrbQPf3
         uXvb3nKT/FUUZydSXTk8rld/8yb9FGA7ym26ceMjdsoB6y291ZFX8hNQBOtXdaOLmWAS
         cPaoG2bAV27TXwEj/cIFMpycbd7zCbYGJKfCyrt0oTyp3bhKY0PCTp6ZY2nDPCgWnndE
         BLayTLe9ub5Rn4gJDSHAsEjkF30aoUTl/MxhVIf4XIKQwEClYv30m9/xj53phykKn9JZ
         cv+1KhqFWplp3/AkgUIRDgJDOP9QAJuxoclRORxbmU+biyh1N05uS2R73gjoV2vkBDHV
         2XjA==
X-Gm-Message-State: AOAM53144DTuQNUv1fDw6pMHOmJBLk2/H7lr/2bwrpxHVfIYtfvuH4jC
        0XNMKKkriU8eTkwvVJkLcPnevQ==
X-Google-Smtp-Source: ABdhPJzD5Rk8d3t2M/xsuS3fFPWVC9XH+JRwDjdOWXSp9QJMzwi9fcRyoJBWcoeaE8YlySZfdFktPw==
X-Received: by 2002:a05:620a:7fb:: with SMTP id k27mr933026qkk.124.1601293659348;
        Mon, 28 Sep 2020 04:47:39 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id l26sm696536qki.62.2020.09.28.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:47:38 -0700 (PDT)
Sender: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 07:47:36 -0400
From:   Konstantin Ryabitsev <mricon@kernel.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Patchwork housekeeping for: git
Message-ID: <20200928114736.aqlvj7yupqvon45m@chatter.i7.local>
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <160105219546.14506.13918434797892986172.git-patchwork-housekeeping@kernel.org>
 <CAMwyc-SZ_babReRWkSAgegJAQ1mUwzJ27PQVw2RYBzA-r60-dQ@mail.gmail.com>
 <20200925212626.GB1270882@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925212626.GB1270882@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 02:26:26PM -0700, Jonathan Nieder wrote:
> > I enabled the patchwork-bot on the git patchwork project, in order 
> > to
> > help keep the number of patches shown by default to a saner limit. You
> > don't need to do anything in response to these, but I thought you
> > should be notified of these changes. Please let me know if you'd
> > rather not.
> 
> Yay!  Thanks for this.
> 
> I don't mind the noise.  If I change my mind later and want to disable
> these notifications, where do I flip the knob?

The knob is at the end of this email, so just ask. :)

Best,
-K
