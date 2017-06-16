Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46E920401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdFPEbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:31:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34939 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdFPEbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:31:00 -0400
Received: by mail-io0-f196.google.com with SMTP id f79so3466455ioi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GchydvX7jI2MnMPFcWGcCqb9je+RlkPMnfDwYltKjj4=;
        b=S94UzrcMmQFJZlh00WqWtuSbl0gk9xEKvFBC7/GODLCcDP+EMDFuIKlWVonAjwOwoX
         uFA0p5omZT6mw1SxjH3M+u88uVtXQ/49VlcxnGaUPG7APUiURfxlBmaOSWzvOIsNT3Rd
         b6yDFwimDHX2EAEryfW8CKyRp8ifTxbwJorFNHen1PUF+8siibFwT/cSrfwT2oCpAdYG
         8vuQZD+GU9oa9EB9iIJbSKkGea1w7jRpI2CgxCoe2SGuF7EB4oTpkn0HsPRyR5DyjHR6
         g/mCplVgM/yOzDeAYj2EUVl3kCuVfkWBvrCdK9Zm052cfpJwTIMxE9SZGml41b9jh5Ok
         vHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GchydvX7jI2MnMPFcWGcCqb9je+RlkPMnfDwYltKjj4=;
        b=sVMrcB9VMtcWcPHR/xM5j+WSYo19Fb++HKxajs9M7ds4+zyKe45JGQVnmyXfME7P6x
         f7yPhWDAEUJu0XMMTMLQi8ALJunyoJ54J0nUlLOby1iRmoTfHt4jZF+a9MGdsKE8FJ8j
         OWMRhuhCYuepQ/Ha8IY3drXucHN0PMf+wIaOsxYu6LFh975r4pEMjxPko7QaD/t7V/Xp
         Dk3VXu4I1iHd1NNsFXmnTlXtuTfz9Zmvqb382PmmDhjKXsn39uA91AfHgXUd432l9MfR
         aIRPAjcfibjR1yyenboyx9FaHlv9zqevdsjQ+Y0kWDXEPxkLH+tBS+jXb0CvUCoof2A3
         aHTQ==
X-Gm-Message-State: AKS2vOx0/B/kci0gTImNZ7SKV/FuPQ8ajCy5jaFj4tlhPdsUYMem10yz
        CEkINuag0j+0CB3CvJc=
X-Received: by 10.107.18.16 with SMTP id a16mr8502002ioj.93.1497587459047;
        Thu, 15 Jun 2017 21:30:59 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p22sm627405iod.22.2017.06.15.21.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 21:30:58 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/3] add stash count information to git-status command
Date:   Fri, 16 Jun 2017 00:30:47 -0400
Message-Id: <20170616043050.29192-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed here [*1*], this allows `git status` to show the number of
entries currently stashed away.

I also tried to update the related parts of the documentation to use
'stash entry' instead of 'stash' as we agreed that it was a bit better.
I don't mind dropping the documentation update and using something like
"You have %d stash/stashes" in the status message if it makes the change
"too big".

*1* https://public-inbox.org/git/CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com/

Liam Beguin (3):
  stash: update documentation to use 'stash entries'
  wt-status: add optional stash status information
  glossary: define stash entries

 Documentation/config.txt           | 11 ++++++---
 Documentation/git-pull.txt         |  2 +-
 Documentation/git-rebase.txt       |  2 +-
 Documentation/git-stash.txt        | 49 +++++++++++++++++++-------------------
 Documentation/gitcli.txt           |  2 +-
 Documentation/glossary-content.txt |  4 ++++
 git-stash.sh                       |  6 ++---
 wt-status.c                        | 24 +++++++++++++++++++
 8 files changed, 67 insertions(+), 33 deletions(-)

-- 
2.9.4

