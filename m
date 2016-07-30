Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46431F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbcG3PMU (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 11:12:20 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33709 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcG3PMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 11:12:18 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so6874196pap.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 08:12:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ff5Tpy24LCLwBliAV5iqd1C2zbjTCKgT6P2W7ITtcAk=;
        b=KCl0O+Zr01176te3X9Kpwj0nnu0x8/0Jtp6Q8kM9/7FpNFUaQxgWECPoy0exqhHzo9
         +XzTYmZjEOAnGO4KVbo//nfDaXaGcL6Y+rl8iDg41heN+Am67+X2mzKJVD0IHbAc5+sh
         6Btm3TuXmV/Gt3BU1wN631EPN0fdB2czI6OCH/MRebtPS5uSlEkF51gs173JFP3pbA5a
         FWf+jv9miHb1QtBbyzOzQiyRNdrTrm57GoVlxlDPmduMr4aE4OAe8Bkr5lAUUEW6uojg
         DdEctqbMVvpEuttW98TjRGIAza47gkcszAQhe31/LZM3n1xir1A0G/G6eBN7xQIpEXif
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ff5Tpy24LCLwBliAV5iqd1C2zbjTCKgT6P2W7ITtcAk=;
        b=U0x3CrXC9sAvQPhlkwstV+bNxe6zr+ZHDJhLJTHPNnGa2nh/s+JqrLtoB55ey3sNg5
         kQmf/73GvvPflgcht4dTI/ceHxCs9fScWgXAnkyQ/LEvQw/87QtLw08DULXzRyDAmdLd
         LPhMOutluiRseb5COsw5G7fhEJZCiCLEyyNb3J+5pNuhnRoVvX3dqOyuKHZTYQhfWZpv
         0Z5DuF8OSzknnD3Zq8lNGp0Ijum9ZiFOgTb15IiLlSOXVxj62egqpxKoqcKBCarebR/L
         9nzUpmn1dEt7tfQcM45VcggBwWVkpow6OivCqgL67tMpX0KdGJD97p23p/cO7wWOXzIc
         WsuQ==
X-Gm-Message-State: AEkooush9VoD4dM52H/A25Z7HX71HVBT2EEyEvf/2RCPBxnTLKDS4reSztjojqm7E1GuHA==
X-Received: by 10.66.101.41 with SMTP id fd9mr78329776pab.108.1469891537684;
        Sat, 30 Jul 2016 08:12:17 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id x184sm33113398pfd.70.2016.07.30.08.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 08:12:17 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH 0/3] diff-highlight: add support for git log --graph output.
Date:	Sat, 30 Jul 2016 08:11:46 -0700
Message-Id: <20160730151149.15980-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

(resending as thread instead of attachments take 3
I realized that I was adding the To field only to the cover letter and I wasn't
catching that git-send-email wasn't adding it to the other patches. Apologies.)

Hi, I've been working with Jeff King on this patch, but he encouraged me to
email the list.

I recently learned about the diff-highlight tool, and find it very helpful,
however, I frequently use the --graph option to git log which breaks the tool.
This patch looks to fix this.

I wanted to try and add some tests as well, but I was unsure what number to
pick for the second digit. As there were limited tests in the contrib directory
(only t93xx and one t7900) I just chose the next number in the 9xxx range.
Please let me know if I need to change it.

I'm also not super happy about my test case for the graph option. If anyone has
any better ideas, please let me know!

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  13 +--
 contrib/diff-highlight/t/Makefile                |  19 ++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  76 ++++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 111 +++++++++++++++++++++++
 5 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
 create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

-- 
2.9.0

