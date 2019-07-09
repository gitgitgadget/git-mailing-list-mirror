Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B164B1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 09:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIJnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 05:43:10 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:53292 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfGIJnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 05:43:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 6C8E5A015B
        for <git@vger.kernel.org>; Tue,  9 Jul 2019 11:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1562665372; bh=PD5X9Ha89tRCj5Lm2a8VfqycBLuq0Vpyt
        NPw8RZ6288=; b=vLSNDsZAzcCQaah9WEgc5lGnBaMIIK4/dpfBHjex+9Rr1COoR
        IzSVVHSUwp0LHSbiCgAoSF2gGyOo9CmrFePrSMy6sMLhwAnS5rYbU5qEFDfwFrTy
        T507LixkHICKkEx6CBvWTVbjfBLMo0iYGEW8ATS1XzPtItHBBLdtPNHiitXYbCdW
        k+MSr7brdeJ/EAYCvWfiDFu/yGeI03m5XCeik0tSgxVH5jQYkTA1laibJXwuIDm2
        L7IyREqDhj5rog9noLUZ02lcmAdn517hv0jcy1xv9vUmebxpslq7HTD1vLhApVe7
        r+G6a4frTKQesjItdlqvygVCeqTMwwKiqHDhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1562665388; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PD5X9Ha89tRCj5Lm2a8VfqycBLuq0VpytNPw8RZ6288=;
        b=YTjnpD3wcuqy/hMFlTAHSxRhqj1Nhhty6A1pf1QpEEiRY7Dx98Tjp53dv+vppsZVjhfz0c
        ogxXpa9/d5hVARTHrIO4H/PXUrjNFQpkuLb9UOsB/DWeERLl9xQ7qAWwsCPGII1e79egSd
        yE3VWZmlhS6LVzFcXv/EIDT2FUhSfWeM1IiCIfgDxjruOeEyjj0bPePaN4siTTr1oMraBD
        tVnNDbinqc3/oNLg8x15rahADfe7OJijauTD9YGwrdLHzd+znpItbnru1DN2+OpnyM6cfc
        ZcpzR1jYEzNJ+biaioyF7p1NUjjHOFyv4mdWWreHDVqpmK2PImmHW+nrPAhZzg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id PsI9-k2q0hMD for <git@vger.kernel.org>;
        Tue,  9 Jul 2019 11:42:52 +0200 (CEST)
Date:   Tue, 9 Jul 2019 11:42:51 +0200 (CEST)
From:   usbuser@mailbox.org
To:     git@vger.kernel.org
Message-ID: <423596682.8516.1562665372094@office.mailbox.org>
Subject: Unexpected or wrong ff, no-ff and ff-only behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm rather confused about --ff, --no-ff and --ff-only. They seam to be all mutual exclusive while the man page documentation and help reads as if only the first two are mutual exclusive, while the later is a check that can be enabled additionally to the former ones. I'm not sure why I couldn't find anything online about this issue.

The expected behaviour would be that a git merge --ff-only --no-ff only accepts merges where HEAD is up to date and generates then a merge commit. The observed behaviour is that a merge with conflict / non up to data HEAD is entered. If the two flags are swapped it can be observed that no merge commit is created and the branch is fast forwarded.

Sincerely,
eyenseo
