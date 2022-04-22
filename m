Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83798C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiDWAA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDWAAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 20:00:50 -0400
X-Greylist: delayed 1041 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 16:57:47 PDT
Received: from frv72.fwdcdn.com (frv72.fwdcdn.com [212.42.77.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 203EB1D5183
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:57:47 -0700 (PDT)
Received: from frv157.fwdcdn.com ([212.42.77.157]) by frv72.fwdcdn.com QID:1ni2t0-0009Bi-7D/RC:1; Sat, 23 Apr 2022 02:40:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ukr.net;
        s=fsm; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:
        Date:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=F3cYiycKCGdsIqtupLmcg/ZLsv9lNLgj+rui1YROnKs=; b=X
        4Z2GbvupUuG7aqF/ZO0rHiywgE7kEQiFIFTG+yrPT+9JlnoeuKkCyX9uMFR69l7Su2X49AyoDqNWT
        UiUwVqjY7YQDDWZbHCZmSPJ8pGbnjv3npwX0wQG1xXBxaX8l4z1YubuxOGhImq78W77RuOuXKg+cz
        5P17POihoie5FWLM=;
Received: from host-176-38-168-243.b026.la.net.ua ([176.38.168.243] helo=[192.168.0.101])
        by frv157.fwdcdn.com with esmtpsa ID 1ni2sy-000969-2U
        for git@vger.kernel.org; Sat, 23 Apr 2022 02:40:24 +0300
Message-ID: <9a1a7a84-76a6-c710-414d-fa566a3e0793@ukr.net>
Date:   Sat, 23 Apr 2022 02:40:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
To:     git@vger.kernel.org
Content-Language: en-GB
From:   Mikhail Merkuryev <mercury13@ukr.net>
Subject: Is it possible to treat symlinks just as normal files in Git?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Result: IP=176.38.168.243; mail.from=mercury13@ukr.net; dkim=pass; header.d=ukr.net
X-Ukrnet-Yellow: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My task. I have unit.h in both repo1 and repo2. I make a symlink from 
repo1 to repo2 and want such a behaviour: in both repos I want to treat 
unit.h like normal file, not symlink.

Why to do this though Git has submodules?
1. One of repos may be unrelated, private, corporate…
2. Auxiliary things like unit testing require additional bookkeeping, 
e.g. moving unit testing framework (Google Test etc) to the submodule, 
special directory setup…
3. The repo becomes harder to pick up if you do not have/want Git. With 
submodules, if you do “download ZIP”, you get uncompileable source. Even 
in Linux where Git is out-of-the-box, you do some command-line magic 
before repo starts to work.
4. Submodules are just a “big gun” for library <30k in size.
5. Developing alone does not involve pulling, but with submodules it 
becomes the case.

Men at Git for Windows thought it’s not just a Windows issue and sent me 
here.
