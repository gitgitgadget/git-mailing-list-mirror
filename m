Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4730D215F4
	for <e@80x24.org>; Tue,  1 May 2018 16:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeEAQ7i (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 12:59:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41657 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbeEAQ7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 12:59:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63so9500341pfk.8
        for <git@vger.kernel.org>; Tue, 01 May 2018 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6E+intRgAZ05TyaPDcl2GjEIIN9BAiMmNqg2/31wr78=;
        b=c/bG+S3JA0Y+YUUKMkR4NITkvazu3zwjRz8SEnbefqABnoPTGYdAxSN3POKH+YxwUL
         25FY3oh8Rr1y2XyVf5I+zhyLjHNOPXnGyDw10nEliN/p5ic8ViKZRkjnNQMTKaRd266S
         XLrFJ3+nkZU1OP/osVay0vK9AdCtv86OOc/QyewCexL7I2joAW4GQXx6XUtyMrRlM72o
         gVmDHIsL/Mv3BPiAwXk0O9RRx7mLzEi7kEsi7AeKoyFt7fMpmfpVgljH1hf7KuhoKUHz
         09SitrlwJ2mkYQMi6KtoT0xlNoFNTFWGgHUiinx17xmZuZEPhuKVMEluddRbkWCFe4Du
         Pktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6E+intRgAZ05TyaPDcl2GjEIIN9BAiMmNqg2/31wr78=;
        b=VBPIxRM7gdA2weYkjK+tRaA5/fn5JUOikl+lLsM3oS7etcOhdBw+iqeWDCmYmNI/Vo
         kt9hx3GOxUut0sbugD/Ws9KRKHeVTO8M0Jx1wzv/fUTHgyIfcSWrWtpSUEDUBlWsSlOi
         /0AXwxWAhkE6FfAD8Fpff6afF20Yphf96Q5G2rmxxTsuSsqeWfKEhhCQ5F2bW1cBJrVj
         +B1ETjdPoklMx5GzBe1URtmpnTXXCd+HkwKJU8csGbzxm4oppFiqEXs3K/CvddY1F809
         NiwTlkZtH1lwpoyy4oQ/I6YOpnc1Ne+Gzj16iKzQIi27+29c+l2SzjOpOYUVKvAlE1cX
         gWDw==
X-Gm-Message-State: ALQs6tApXA4ClrwDU8Pi3aB05YnLPEA0JzF5wekSSgLqAQp1dObcsK/Y
        PlcrBQAuZxF7QEPtHIwqm24E6MQDYXw=
X-Google-Smtp-Source: AB8JxZpLaN35D9ufP5/8qrLBvEerzX2eLZzwrYDXgOZ1ES3xZsrXH9qFgBSn/tBnkKm9os85/uGS1w==
X-Received: by 2002:a63:618b:: with SMTP id v133-v6mr13242295pgb.285.1525193976222;
        Tue, 01 May 2018 09:59:36 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:6e43::93dc])
        by smtp.gmail.com with ESMTPSA id r81sm22313311pfj.79.2018.05.01.09.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:59:34 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com
Subject: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
Date:   Tue,  1 May 2018 09:59:28 -0700
Message-Id: <20180501165931.25515-1-wink@saville.com>
X-Mailer: git-send-email 2.17.0.393.g4573f5e134
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed on the git email list [1] with the subject
"Fetching tags overwrites existing tags" there is a bug
where fetching tags can overwrite existing tags.

Ævar Arnfjörð Bjarmasono, has created a patch series [2]
which requires a '--force' flag when fetching if the user
actually wants to overwrite any existing flags.

This patch series allows tags in remotes to be placed in
a sub hierarchy, refs/remote-tags when "git remote add" is
passed the --remote-tags option.

The patch series also modifies tag so "git tag -l" will list
tags in refs/remote-tags properly. It also test for
"git remote add" which uses "git tag -l".

[1]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#m4928340a9f49c6ffa9db5b94243e46df6958eaa5
[2]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#mb68d54667a9ad8eee60a22ebdf2264f8022d07a8

Wink Saville (3):
  Teach remote add the --remote-tags option
  Teach tag to list remote-tags
  Test git remote add -f --remote-tags

 Documentation/git-remote.txt |  8 +++++--
 builtin/remote.c             | 44 ++++++++++++++++++++++++++++++++----
 builtin/tag.c                |  2 +-
 ref-filter.c                 |  9 ++++++--
 ref-filter.h                 | 11 +++++----
 refs.c                       |  1 +
 remote.c                     |  2 ++
 t/t5505-remote.sh            | 20 ++++++++++++++++
 8 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.17.0.393.g4573f5e134

