Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0E51F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKPSHC (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 13:07:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46837 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfKPSHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 13:07:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so8193052pfc.13
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SLvtCuW2Q8aHplKMfZHG5kmEQwHW/OGBKEWIVgMGyc=;
        b=wac0GH0VsX0ey3HMTUALwdrkoD6vyeHODrcfq7vHeE7Cv90dUNgnjAokg7Pi7x2dnb
         hnuCnNBfmoe33kBx3QyCaiebG/TdrIcaMHyf4eCNkdlJcCxMMWj17x9meYSTjDFHsGMw
         96s824gub+llGOIlyI9oBJIFEc2OfhzgbaxjcT4W/Ii4UIosmmD5qei0Ok1SRr6hpgLi
         rBg8hy9XtaZhrGUCokmfcHzWFLrDRRk44ZSd1OrHr0PArDUgJ72OfnPJ2KidrirZLfTp
         nF2jIcojrg9n30Kieq+MFZb0g28lX4Zi5hNlIhCL2nNPsOFIn/pP1i3bzYoDAIobUBpU
         UkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SLvtCuW2Q8aHplKMfZHG5kmEQwHW/OGBKEWIVgMGyc=;
        b=LVh2FPVHUain+5rPMY7oqB+WVi2LvwR9w2VrtLCFC1l2P5iy00UFvexNd1sZTLEzDh
         h7VSqfhzYQm9kew2in4Q2/blHNB2FzIFcoC8FcnxZoSYbEmac2ElG4+l9taAsEVcjptW
         NMaYn/MQbplv6XFSfug+K4KHyJrDS6AhxZ2IJ/GamVG0Bb0uabT4tBOSKuwti22KqZsr
         XNvvsDo91TN/xEx1JsFJTLDolIyWDK2AARie8d7rm9oUm664EH6CeVwRNQmzfB3fEsig
         sMyeE6XI12hLiQaiVVGlU7sE4rS36qOXpelXdJcjZdRqT0e4k/xQd119HGv+aMJI3/q4
         WfBw==
X-Gm-Message-State: APjAAAXSEi1FHuonpmVOirH0OFeHWjxsmqKbEa0FIgikckCIuMRMjorn
        QDqxnRyfV8eke0LGSAjDWLAf5iU/mbg=
X-Google-Smtp-Source: APXvYqw65KjeO72sea8ARQjHqYlDsibL685/wqcASuXYBjAb00ejwVCieOyB3fyKgGanwo7v7YXAVw==
X-Received: by 2002:a63:8f5e:: with SMTP id r30mr6102059pgn.146.1573927619770;
        Sat, 16 Nov 2019 10:06:59 -0800 (PST)
Received: from localhost ([49.230.7.85])
        by smtp.gmail.com with ESMTPSA id e17sm15286294pfh.121.2019.11.16.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 10:06:59 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] Limit search for primary key fingerprint
Date:   Sat, 16 Nov 2019 18:06:54 +0000
Message-Id: <20191116180655.10988-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of implementing signature verification for git clone, I decided
to refactor/unify the code for commit and merge verification to make it
reusable during clones.

This lead me to discover that git requires merge signatures to be
trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
the behavior of verify-tag and verify-commit.

So, I figured that I'd make the minimum trust level configurable to make
the behavior of merge/commit/tag consistent.  And while doing so, I
noticed that parse_gpg_output() in gpg-interface.c assumes that the
VALIDSIG status line has a field with a fingerprint for the primary key;
but that is only the case for OpenPGP signatures [1].

The consequence of that assumption is that the subsequent status line is
interpreted as the primary fingerprint for X509 signatures.  I'm not
sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
status line always came after VALIDSIG -- and that breaks the config
option to set a minimum trust level (not part of this patch):

,----
| $ git log -n1 --format="primary key: %GP" signed-x509
| gpgsm: Signature made 2019-11-16 14:13:09 using certificate ID 0xFA23FD65
| gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
| gpgsm:                 aka "committer@example.com"
| primary key: TRUST_FULLY 0 shell
`----

[1]: https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS


Hans Jerry Illikainen (1):
  gpg-interface: limit search for primary key fingerprint

 gpg-interface.c | 20 +++++++++++++++-----
 t/t4202-log.sh  |  6 ++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

--
2.24.0.156.g69483321b9.dirty
