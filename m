Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AC71F453
	for <e@80x24.org>; Wed, 31 Oct 2018 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeJaTNf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 15:13:35 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:46742 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeJaTNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 15:13:34 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HnXagXodRpXFjHnXfgCXqx; Wed, 31 Oct 2018 10:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540980963;
        bh=MBl0cFgyuEWFLNHTmFrDCY8bjgTQct+EhYLmIEoQ7zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=NRm5uMubnYCz92lof+plKOWbBnQ4N3mnY6RaVcl5cdM77I19SUQTWpmq7VKHOcWvw
         SUP3+Jucs6nWCobIG1lHl/VsG2BInLQCWmg+CaMxe2y4egpvtRp5HaCLYx+k3md0M5
         HqMmoqrfjUVXCj1iDQuvB5i9NwyNTBmwANk74DsE=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=iuGNbSBixgLDAZXCjX4A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/5] am/rebase: share read_author_script()
Date:   Wed, 31 Oct 2018 10:15:51 +0000
Message-Id: <20181031101556.27169-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180912101029.28052-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPFOwfkUsPpkuvC3Mub7twmMMQxAVkUWVCPb5Q9FVAir3KLeKPydHdUxhu2KOnsCQIY5kB84egGmmGR8BmXFfcA+83Q8wVmvKFInY6zh6LizpURUWkxm
 wB4WrozhKp5Q5RWQm+qJrL5SsFOcr3LKL/UrOaamlMp6nW9PYaWLXN9Q5yWT1nSdJIdryvbcc+T5d83zeco3zA2GMkyW4843sXFkm2j/Nh6ZiRzEjM8lPNjy
 Co9ZEE5BbEur3w6VymbveQhDvbRVhoAjMZSaPsxlihqdRNPHruuPtI/7/rXFecYrlLB0J6muWqs2WjXT0lx2BvC9hMvlght+UZssB9syiyI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Sorry for the confusion with v3, here are the updated patches.

Thanks to Junio for the feedback on v2. I've updated patch 4 based on
those comments, the rest are unchanged.

v1 cover letter:

This is a follow up to pw/rebase-i-author-script-fix, it reduces code
duplication and improves rebase's parsing of the author script. After
this I'll do another series to share the code to write the author
script.


Phillip Wood (5):
  am: don't die in read_author_script()
  am: improve author-script error reporting
  am: rename read_author_script()
  add read_author_script() to libgit
  sequencer: use read_author_script()

 builtin/am.c |  60 ++--------------
 sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
 sequencer.h  |   3 +
 3 files changed, 128 insertions(+), 127 deletions(-)

-- 
2.19.1

