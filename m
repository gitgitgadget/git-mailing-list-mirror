Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A98220562
	for <e@80x24.org>; Fri, 27 Oct 2017 23:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbdJ0XUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:20:51 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:50630 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbdJ0XUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:20:48 -0400
Received: by mail-pf0-f172.google.com with SMTP id b6so5949139pfh.7
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YI6fYAV//VhbvTfNnwVvZ1Kp7zFBvvs4aJfojT5/cR4=;
        b=ONqi+gU5DWT2eYSc+6tnkppOLR1wQeFYQrEX//t4P6LSOKqaxd6VioY2tDrbu/p+n9
         5hewSyj0mzFATYSKzASrhiiVxqvR7nzRKCVny7famVpkN/QFEH2P12nGaGBrUBh/S/iu
         N1rwZydglnpignCnfNIt0JQEuiEaiPnAfVaDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YI6fYAV//VhbvTfNnwVvZ1Kp7zFBvvs4aJfojT5/cR4=;
        b=hkgDPV9ZAHjJs1IvtaaGln7zh1imaFdZOyya6UWcP+yRgci9utRwY5dfpX6H3Li6/B
         1yqifT7RCUaiGdi8WYGta+M0AtJPVmqkbpu4I2twFkf403Ajph6FLrig92RSS3nx1YWU
         jAl7sx6zMnRTi94K0O9pyu270lI+gV5wtUX4rb4SKCZ09srGE5weipV7nIwvkFUuWHPJ
         ngci72N7V4nb1wWweKgUbw/H0RgD0m6kqDMD93pdFiPVvRgPx4rxjGHDgdl/kwZPEEXK
         foFsQQWJNpmsk1nuTGZ87l2hxShmGpU8IlhV6YE4l8fYWMJw99RZ6tYITosn3A8vPRI5
         Yl4Q==
X-Gm-Message-State: AMCzsaX/3y4oUFAtIDY/NAlgULXlzPbIMpX7OTP6Ror20h0b2ogp6QHL
        DTlSNpEub1g8jkhNvAqLIWk4kQ==
X-Google-Smtp-Source: ABhQp+SbPcg+rmSsbNv9tdMMO7xQmAxLki8ABfRvLiDT0FgnhtHcirYVR+Grd0FA1vcyPB4vKSvM/g==
X-Received: by 10.99.52.194 with SMTP id b185mr1545298pga.170.1509146447836;
        Fri, 27 Oct 2017 16:20:47 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br02.corp.dropbox.com. [205.189.0.164])
        by smtp.gmail.com with ESMTPSA id k25sm14853061pgf.62.2017.10.27.16.20.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:20:47 -0700 (PDT)
Date:   Fri, 27 Oct 2017 16:20:39 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
In-Reply-To: <16467d0e-b585-17d7-fb22-3eed7efe6747@gmail.com>
Message-ID: <alpine.DEB.2.10.1710271619180.1371@alexmv-linux>
References: <20171026013117.30034-1-alexmv@dropbox.com> <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com> <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com> <alpine.DEB.2.10.1710261425390.9817@alexmv-linux>
 <16467d0e-b585-17d7-fb22-3eed7efe6747@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 26 Oct 2017, Ben Peart wrote:
> I saw your response but actually can't replicate it locally.  I've been
> running with Watchman integration on all my repos for months and my "watchman
> watch-list" command only shows the root of the various working directories -
> no subdirectories.

Weird.  I double-checked and I see the same behavior with watchman
4.9.0 as with 4.7.0 that I had been using previously.  I wonder if
something's different between `git` in `next` from wherever your
branch was based.
 - Alex
