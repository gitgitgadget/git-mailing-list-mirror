Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBC01F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdFEUeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:34:14 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34254 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEUeN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:34:13 -0400
Received: by mail-wr0-f174.google.com with SMTP id g76so44281627wrd.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6MYxcExlKVYcxZv/ghPSSHBD4PspJELsxxA5Odig+1Y=;
        b=kIOTmbJ40xAxG6MJeTowyulESKCsm064tG+eFox0CoBdy4fDKo2CjAgyrI+7YwZic9
         yDxZOry/HbBir+awpVTbLiy+woia7KMS6BdQQX1OnFxe2qe09/n768wcutEVCca+H2gv
         zh9zuZL00bLJJeSbK8fm2UP6mM4aK71YC/U88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6MYxcExlKVYcxZv/ghPSSHBD4PspJELsxxA5Odig+1Y=;
        b=JxKxJzUXAZQxRfq2JMCjJ6hY+cEVDSYi8UET5c8S3SNhFXUrg785Z+ke1JG6bKPs9o
         +li5RNK2a8c3r+2amyI48/YmyZxSn0q5FHJDt7FNC9T6+BNcPr8QfXrdNin+4Bisb3fk
         2Ik8yLW+nwv3cV3T8wSDVyoRD3A3mXse9L0rE66Ny5l+RaVuUUcfVmsurtpyVdlPqvrE
         zfDoT96/vpv838CobZ/LgPBgrgev6Id2VjnpEbp2msEfghvfBpDbNkmcOk8LFC5vDIow
         cmiv1gantMgMzyI5Aou3eHU40jOsoBZS+nXO2JiTH5+96HxdQSaI61p9yo4ErcKC+m6C
         CZtQ==
X-Gm-Message-State: AODbwcDzmJcEZvbXw1A/RdvuDV3o2NAVgvRBcQmfhCWANiCb0lawaMGm
        cO/27yPKQvzzIMO3I+GmZg==
X-Received: by 10.223.162.217 with SMTP id t25mr13727141wra.173.1496694851659;
        Mon, 05 Jun 2017 13:34:11 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w128sm8288526wmd.7.2017.06.05.13.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 13:34:10 -0700 (PDT)
Date:   Mon, 5 Jun 2017 21:34:09 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Git v2.13.1 SHA1 very broken
Message-ID: <20170605203409.GB25777@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to compile Git v2.13.1 to release for Cygwin, but it appears
a010391 ("sha1dc: update from upstream", 2017-05-20) is breaking a very
significant number of test cases in both 32-bit and 64-bit Cygwin
builds.

The first failure is t0000.46 "validate object ID of a known tree"; output with
-x and -v is below, although it's not very interesting:

    expecting success:
	    test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a

    ++ test ceb282701536fe61bea01075664405caa7d6343f = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
    + test_eval_ret_=1
    + want_trace
    + test t = t
    + test t = t
    + set +x
    error: last command exited with $?=1
    not ok 46 - validate object ID of a known tree
    #
    #               test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
    #

I have no idea where to even begin debugging this, but I'm happy to take
pointers / try things out on my box.

Cheers,

Adam
