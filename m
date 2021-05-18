Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B13C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD215610FA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhERDJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhERDI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:08:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17AC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:07:42 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so5980129pga.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=+KX7nkMp6v22lX2NLUxTOVGOMwU/LsEWSOzS3iRTYbU=;
        b=WjEh6A1F7lkapnHviFCtrNgpOA1DfEg/J6AXhKyudbQIzP5A0zs/qbInRISgw6canu
         bvx7fMRKRwkGvQEgPwxS/LkmksOtHexjFe1aFg9N2JqOdKws0/5vkn3vILsjOswWmb3I
         uyOKFLCaXGqCqYTj47MrApCZMX251IEmlfbW6AWeYWCfcV6TCjlxAf9bU9NuuzVWW0zk
         FOU0CkPR3V+vEHOPHLJ5nAEHSQgv1YpkUEU0FbA3kRXGjHx9CI/6gTdD58pc3wdBddZZ
         YBuMDVJuq+QPOeae0+wM9vMJvAg0mgKBE5VheZD52LyIjtZD37P/DH/o27gMNYGBajp3
         Z34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=+KX7nkMp6v22lX2NLUxTOVGOMwU/LsEWSOzS3iRTYbU=;
        b=d9RVWATnTCPoUyyEiNbGYZUoD6PzaaRLD/7Ac0bNbXcVj5LMN6AtLBpIa5BoLYt99c
         Y5amG7CunA98aCxojGAG5X/ovM18a0b95AdRXSPlWB8hPC2AEzlkRUIALlCUeJUtZML8
         cdfj/1Nvvv7hKGSJGrUG83mYFE5BPm4ySOPuEfO9/gXvQJ3BLbU1VC/rtdUsLLfzKf5N
         pA2eyUzbqSEFTPHaRnHnqODBPQBtMbo5SMV7JG6pF9THHkNZFSIANGTy2oiRRv/YchH7
         MjyjndigKEKXVlcv6zRHHrBy+g/5eq/YyT6gi4m2D9+fhh/s4ITXo5WIDPTyvOWYrejP
         6Brw==
X-Gm-Message-State: AOAM531yoMTiiPzPhBXGtk56numIMFJ0OZrbbsQIFcQHrFRES0nF/wPO
        Uw21UK2rfyG9dXg68IPfjUmA4Vzd2YEtVc8S
X-Google-Smtp-Source: ABdhPJxxTiN4UiW2Bkg2ezT0ZUaNP3ouOJtUggJu7Ayw4N6c85rk9YO/cc+eC6hWmWdpGRTwYNN77Q==
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr2737735pgd.443.1621307261137;
        Mon, 17 May 2021 20:07:41 -0700 (PDT)
Received: from C02WD045HTDG ([2001:8003:c82b:cf01:d07b:810c:fa5b:3a18])
        by smtp.gmail.com with ESMTPSA id h1sm10814541pfo.200.2021.05.17.20.07.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:07:40 -0700 (PDT)
Date:   Tue, 18 May 2021 13:07:36 +1000
From:   Ben Humphreys <behumphreys@atlassian.com>
To:     git@vger.kernel.org
Subject: Git 2.23.0-rc0 HTTP authentication failure - error message change
Message-ID: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've run 2.32.0-rc0 through the Bitbucket Server test matrix and it picked up a
change in error message that perhaps is unintentional.

On 2.31.1:
  $ git ls-remote http://notauser@localhost:7990/bitbucket/scm/project_1/rep_1.git
  Password for 'http://notauser@localhost:7990':
  fatal: Authentication failed for 'http://localhost:7990/bitbucket/scm/project_1/rep_1.git/'

and on 2.32.0-rc0:
  $ git ls-remote http://notauser@localhost:7990/bitbucket/scm/project_1/rep_1.git
  Password for 'http://notauser@localhost:7990':
  fatal: unable to access 'http://localhost:7990/bitbucket/scm/project_1/rep_1.git/': The requested URL returned error: 401

This appears to be a side effect of 1b0d9545bb8, if I revert that commit the old
behavior returns. Certainly we can update our pattern matching to match the new message,
but I wonder if the old message is preferred for folks who are not familiar with HTTP
status codes.

Best Regards,
Ben Humphreys
