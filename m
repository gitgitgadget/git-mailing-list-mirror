Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7219E20323
	for <e@80x24.org>; Wed, 22 Mar 2017 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759229AbdCVNzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 09:55:45 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38674 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdCVNzj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 09:55:39 -0400
Received: by mail-wm0-f41.google.com with SMTP id t189so38549372wmt.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=2CDIOw7S9uKlntEjHDUA7gOah9VT+/sIvB74YlrVkpk=;
        b=U4hKCwtNjNgaRE96FEt+xO+/xo2GYNgkjcyVNlToLHNKh/pC6sprojDnM5ES8vVwvF
         XSmfS2FLGKd5D/Fp8w8dmTiShF0gWgiTVvjtsX2Dc+Iiz16Fp2TNhSgHfcJEFprl+P5D
         A+0oQYJmmvvjL8Mkxs7SPQpscDVXlI7991kVpPrFJQpfpKmdTo579YddJRLEFyiq2fFF
         qJyBDK/UV/1DPHsI9lvgmDSBBo/jO1u6fA4yIhtwxV7xtuk1Z08wXQjLInHfGmAc8CLj
         DsjDBL1WazGgbSYlLOxcG6emD2ZbuUYLAzMuNIcIMzFw74clRyT+wPceeBFcTOPa8SUk
         WD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=2CDIOw7S9uKlntEjHDUA7gOah9VT+/sIvB74YlrVkpk=;
        b=XVScHwf0cyKBcL3xcSsc/6xWzu6cl+H0Zfy59dcu5ng3yIlajyV5nFqNSh9I5a6Aqs
         PIhI2z6lRv7DCUGNZjDBbWa0gPKdm5N1UF1OTyivPE2g2GnrxV9HxuJNWBbcG8PFN55k
         SPzVtKNg+wThG9cuSRUWdJLpGFBNJFcLhZ3jJ3p8OZG44vOeY/wxiLteG75pWUjPLyL/
         sNEaGa/I5Ch/a7jf8yv2eLFeDoxQdmfBVrbjmcQRwVUZqpaJJnk0ruWy4PTP7AO/tMfH
         HgLMduwCtatve6JXSBrVtlx0dNL0kvz7WCwHN4hl+fa8l6eWdnC/fhRdYSl/UfvKXAuP
         Qjbg==
X-Gm-Message-State: AFeK/H22sNlxfrRD3n6+tqjuygZMr9Wy6rWa8HI+yVgXRtseOZC7y93zXeWTF22c0s2cAg==
X-Received: by 10.28.207.14 with SMTP id f14mr7880732wmg.72.1490190937611;
        Wed, 22 Mar 2017 06:55:37 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w99sm1946037wrb.3.2017.03.22.06.55.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 06:55:36 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Warn user about known Git Rebase bug?!
Date:   Wed, 22 Mar 2017 14:55:36 +0100
Message-Id: <C45FE2B3-E4B5-4988-85B4-3CCB41C9ACC3@gmail.com>
Cc:     ulrich.haberl@autodesk.com
To:     Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

we rebased a branch using "--preserve-merges --interactive" and were 
surprised that the operation reported success although it silently 
omitted commits (Git 2.12 on Windows). A little search revealed that 
these are likely known bugs [1]. Would it make sense to print an 
appropriate warning message if a user runs rebase with 
"--preserve-merges --interactive"?

Thanks,
Lars

[1] https://git-scm.com/docs/git-rebase#_bugs
