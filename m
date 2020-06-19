Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0ABC433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CCF20890
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="gcAC+QZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392022AbgFSUXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:23:41 -0400
Received: from sonic311-19.consmr.mail.bf2.yahoo.com ([74.6.131.193]:37668
        "EHLO sonic311-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391863AbgFSUXk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 16:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592598218; bh=5mala9jDUgOnEzAGbKMLLm4X7ae8L3df5v5mCgU8aNk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gcAC+QZdM9sYkH35AXlUNSyZltTitAHpmZK08+XmZbD94k0IoDy0rU0bqp2aiTeSelqVQOxKOlW01o13K+o+HUvUEu/rJincRO1Sp7NfX8dUT6bePVF9ERkhYzvZuZVkcPZGoxSATowVAXZVZUoI5oU62C5HtrzEtVhvKKLZGY/imfFkMtulcr6KVZdwNEOYugFIwmgcF9Ethbfce4ZXj2wcJsqfuCZPLrwlc2kXglNEpRWzTaXS+b1TztWMcseggQN0eGN+GX6p6LZVIgiQfk1f/ZEHQCG3g/Yfqk6B8h5PDwR2TP32EN5bnAr2QD9t/dL6mEL4ZZ92ryjKeuO2YA==
X-YMail-OSG: wZ.1ArwVM1loBJ2AxnGmxiCYE27nHJqzOYI1XY4FMXHuDSTgNm0IxZltuWHpX_y
 qSx_7a3QTrYk8xrSViofw8uP8L71e0svnSPUig.nVruIQfE7O77pZJppel.Kx8hPk56U3nmDPALv
 CmB5eHFfSp92Phbl2oXDbcv.DaLkCz8rQfi6jJITJ32dMFpU9S9Gkd0dj_7hAJDKqm_4DUMesf5G
 2tiIxXecb77N9Hsb6z0ouLnwBetasxxn5yh_7ynJwAH55Tw02bX3kMIAou1fyKLRKOxz.TRLZ6.E
 m5huG7UcQQffnY9JG45xIES5vRkeGNZrYmlopvIhHtVHGXR9aoQWSldxikzrUKQCfG9QGcfSObZZ
 s4i5.KoqCHrLoVCMgPmQqO6o5tMT_vDF4cpxLsf.4Dp4okWU_M.6W.eP72ncvdqp_3d7vTtER_vu
 Q_OoBB2FUPDJxOtlJbj9Ar3KZukZDC6RqmnmeR_eHj0nIe.Mrrz4Fl0CfNvLip_1nbIt1NF17K.A
 oLEP1ZCtVlqNtUKfAL9T4VmxN9iT4WqFsg_ilHjuyRgT9ZLfX4ch.vH26RdMas5DKQyrY6GuaXO8
 DiCMk6o_9eflFHHeToT9T2eSL2K5XaXD5B2OvpaSYAoyCGFXW3uhWioqD700HG.OTnF2IYvhvrBH
 liweSyKKzOA.OYKdTrURAdpUKxXguBt0YGLAV4dpsgQzQEsWmndDk3Flqo7a9fgl528lmyMT6qNt
 hUvK7BcPSCqTtVuzwRHx4TvwUkh4S9yfw6cHLMp0sXbT.44IgaXRIhJ6FwOS2o0EkAUe_9hHZnbz
 Vlsqe5ztQOlK07IhrJ5z9AdZZYT8r543vr5j5FKPAR0qtAH3itMs3srIzIpwFcZ.psUsMOsJ1Nse
 Z9BYtSL8biFj6QEcS8ap0zZR73YD3vFhSleO9h_Q.78RCYww.9ACDte4RostS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 20:23:38 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f9cdc319e6c5c02f6098bff69147f340;
          Fri, 19 Jun 2020 20:23:36 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v2 2/2] strbuf: remove unreferenced strbuf_write_fd method.
Date:   Fri, 19 Jun 2020 16:23:20 -0400
Message-Id: <20200619202320.4619-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200619202320.4619-1-randall.s.becker@rogers.com>
References: <20200619202320.4619-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

strbuf_write_fd was only used in bugreport.c. Since that file now uses
write_in_full, this method is no longer needed. In addition, strbuf_write_fd
did not guard against exceeding MAX_IO_SIZE for the platform, nor
provided error handling in the event of a failure if only partial data
was written to the file descriptor. Since already write_in_full has this 
capability and is in general use, it should be used instead. The change
impacts strbuf.c and strbuf.h.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 strbuf.c | 5 -----
 strbuf.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 2f1a7d3209..e3397cc4c7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -556,11 +556,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
-ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
-{
-	return sb->len ? write(fd, sb->buf, sb->len) : 0;
-}
-
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index 7062eb6410..223ee2094a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -473,7 +473,6 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  * NUL bytes.
  */
 ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
-ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents of
-- 
2.21.0

