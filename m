Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF4C4332B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79E864DB2
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBIUxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:53:07 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33942 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhBIUjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:39:32 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9ZIC-00403u-Kq; Tue, 09 Feb 2021 13:07:24 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1l9ZIC-00084U-2X; Tue, 09 Feb 2021 13:07:24 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id CAF58501666;
        Tue,  9 Feb 2021 13:07:23 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YTUgvPCdVLs1; Tue,  9 Feb 2021 13:07:23 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 149C3500269;
        Tue,  9 Feb 2021 13:07:23 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue,  9 Feb 2021 13:07:09 -0700
Message-Id: <20210209200712.156540-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20210130054655.48237-1-seth@eseth.com>
References: <20210130054655.48237-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l9ZIC-00084U-2X;;;mid=<20210209200712.156540-1-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v11 0/3]  mergetool: add hideResolved configuration (was automerge)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v10:

- Update the calls to `git config` to return normalized strings.

  Junio, thank you for explaining the existence/omission and normalized
  strings tristate. I missed that in the docs and that's perfect.

- Adopt Junio's replacement preference hierarchy conditionals to respect
  opt-ins and not just opt-outs.

  Your suggested code worked out-of-box in all the scenarios I could
  think to test.  \o/

- Tweak the mergetool.hideResolved docs to call out the role of LOCAL
  and REMOTE.

- Reword commit messages and docs to better differentiate between config
  flags users set and code that merge tool maintainers write.

Seth House (3):
  mergetool: add hideResolved configuration
  mergetool: break setup_tool out into separate initialization function
  mergetool: add per-tool support and overrides for the hideResolved
    flag

 Documentation/config/mergetool.txt   | 14 ++++++++
 Documentation/git-mergetool--lib.txt |  4 +++
 git-difftool--helper.sh              |  6 ++++
 git-mergetool--lib.sh                | 11 ++++--
 git-mergetool.sh                     | 52 ++++++++++++++++++++++++++++
 t/t7610-mergetool.sh                 | 18 ++++++++++
 6 files changed, 102 insertions(+), 3 deletions(-)

-- 
2.29.2


