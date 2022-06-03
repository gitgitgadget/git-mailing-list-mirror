Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4703C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 14:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiFCOWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFCOWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 10:22:14 -0400
Received: from mnementh.co.uk (mail.mnementh.co.uk [IPv6:2a07:4580:b0d:4f0::c573])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BBB11810
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mnementh.co.uk; s=exim; h=Content-Transfer-Encoding:Content-Type:Subject:
        From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=st/et5gLFZC8J35HeNmb3Mi0AtHRIFB/ITR9HGEyRN4=; b=429Y6ch2H0h2/lynjA6P6/a+La
        jdi12WY6UePk99HP37bBism81gC9ruzrl5a8P6HZEnMCns4gDnR3CZQLk1G+Ql21MIpq8bCpyej6l
        tRxTZoTI8su2lFKLRFi8UovNqNI3N0L4qE0kgaOs16xy61nyL9WhLeBHHCr3MYS44UjP9p/Yw6rXB
        uirQlhPEFKqB2Nm+y26SSClQoAFdSVv1TRTa3gpi7mkCpdN0ARnkWzXQOPQI9rIQNE6APYrmeQb4u
        MLOVFP+UDqJIe2RGjDkODKnO+Ba5rqMCwxidlaq5ppfLEFhzFLHw2eN35/Krg3c4pi/yA9P70e4P6
        3jxu8CJA==;
Received: from 115.24.187.81.in-addr.arpa ([81.187.24.115] helo=[192.168.1.64])
        by mnementh.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git-ian@mnementh.co.uk>)
        id 1nx8Bl-009Qan-2K; Fri, 03 Jun 2022 15:22:08 +0100
Message-ID: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
Date:   Fri, 3 Jun 2022 15:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     git@vger.kernel.org
Content-Language: en-GB
Cc:     Ian Molton <git-ian@mnementh.co.uk>
From:   Ian Molton <git-ian@mnementh.co.uk>
Subject: BUG: git log on bare repository fails if the default branch is not
 called master
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please CC me in replies, I'm not on the list.

I've noticed that git log assumes the default branch is master, even if
it doesn't exist...

My latest repo has it set to "mainline" and all was well until I pushed
it to a bare repo on my server.

Expectation:

If I run

git log

in the bare repo, it should log the default (or only!) branch.

Reality:

git log
# fatal: your current branch 'master' does not have any commits yet

-Ian
