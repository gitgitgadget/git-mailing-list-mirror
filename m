Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA6820285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbdHXTEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:04:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbdHXTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:04:23 -0400
Received: from mail-pg0-f71.google.com ([74.125.83.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <nish.aravamudan@canonical.com>)
        id 1dkxQU-0004Rb-KM
        for git@vger.kernel.org; Thu, 24 Aug 2017 19:04:22 +0000
Received: by mail-pg0-f71.google.com with SMTP id 83so1398993pgb.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V2rXkj0q4JDQzVmtNHgcRVaNtM6vayvvixdkMSMd48Q=;
        b=pEFiu5hf168E7Eh/aJOQX1O+Z1ZV+iCldUm4rH6wkNI/S7U1I3dJbPCNA30gvBgOgm
         onX889/tZXzH9oBzphRGlzuhs9MkgyAC2o2ddYPfjlo4BAUU+9uDmfJVIdLfAqxMJYAV
         W++yfDQoy53ffm4v8HlcvCGhZWGMPuSTV1/T7mTAmt4jLG0GlKqSccNUh8zdZdrEI03D
         We87ro19+gFp+fzddOk+KKVUCL9aWgh7v4zs3pQHhpBpqNxa0peY3m5EtDgruAHWyANN
         5IvEJv8PAQZGYk380oR2jdhj+dNSM2WtnRWljsSzwLICAFs9UDOlzPyU0adHQcXzotrq
         N2hA==
X-Gm-Message-State: AHYfb5gpoJzGs4XaJJMS+XwkUNroRkbrAmUhTgSLX1TyOqo/8nKd+D6x
        DMAAYDrb1T8E9Ttp+9cJbt+dSGcLoau8LXGwbUOesQePVEn31khTIyCu6Ox0g0C6IHgXMuhdNim
        +OML7/PxXGLNfPM/Bk6GT
X-Received: by 10.98.104.130 with SMTP id d124mr7437278pfc.247.1503601461356;
        Thu, 24 Aug 2017 12:04:21 -0700 (PDT)
X-Received: by 10.98.104.130 with SMTP id d124mr7437263pfc.247.1503601461130;
        Thu, 24 Aug 2017 12:04:21 -0700 (PDT)
Received: from pitfall (174-25-112-249.ptld.qwest.net. [174.25.112.249])
        by smtp.gmail.com with ESMTPSA id 66sm8056757pfb.149.2017.08.24.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Aug 2017 12:04:20 -0700 (PDT)
Date:   Thu, 24 Aug 2017 12:04:18 -0700
From:   Nish Aravamudan <nish.aravamudan@canonical.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        me@ikke.info
Subject: Re: [PATCH] Fix branch renaming not updating HEADs correctly
Message-ID: <20170824190418.tdhg45fugibtfgwb@pitfall>
References: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
 <20170824104124.6263-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170824104124.6263-1-pclouds@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.08.2017 [17:41:24 +0700], Nguyễn Thái Ngọc Duy wrote:
> There are two bugs that sort of work together and cause problems. Let's
> start with one in replace_each_worktree_head_symref.

<snip>

> Correct add_head_info(), remove RESOLVE_REF_READING flag. With the flag
> gone, we should always return good "head_ref" in orphan checkouts (either
> temporary or permanent). With good head_ref, things start to work again.
> 
> Noticed-by: Nish Aravamudan <nish.aravamudan@canonical.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Tested-by: Nish Aravamudan <nish.aravamudan@canonical.com>

Thank you for the quick turnaround on the patch!

-Nish
-- 
Nishanth Aravamudan
Ubuntu Server
Canonical Ltd
