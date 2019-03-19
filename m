Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBE120248
	for <e@80x24.org>; Tue, 19 Mar 2019 23:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCSXUS (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 19:20:18 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38512 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSXUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 19:20:17 -0400
Received: by mail-oi1-f177.google.com with SMTP id w137so326110oiw.5
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=klPMXkGe6remFlOeTemqLC2g/Asy2yMrlT17dkGFIdA=;
        b=VgwIp1S+uO/wplTtJMMKMlfYg6qVwESoV9IOK/1j7LYtVBu5G/FIi6bhbkN4ipM2EB
         SFmXBanO4hYrMt06iwWEsvLSVVUsKPG5PVTCQxBHwX2nfdogPlhi5Bix5f8wV7rV82St
         iqAMujhdHmqVMlVWkF/oyxFDLoZZPNgjCa1fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=klPMXkGe6remFlOeTemqLC2g/Asy2yMrlT17dkGFIdA=;
        b=FQO5ccdBOqrxbYi1+xvyuqYgM5gka456/3k/Iflmlg/qCmWOzlnAoK59UJLLITLWsG
         sjLb8n3mpvpzEg5R2tUBwqbexoTMZMJunL8mjRZzJvfsGQD0g0TD3wsNftaRCqR4wpsx
         kuNSICBXSmDMu1Sj1HG/CZ8labylRviMRmjxEYDBeHVR/6fHSka2aDw3WiRcXA4TVNwc
         hdSeQ4J/o+LhnU9LWKbhpOHr3YJw7DWas53LSbE2J2IMkh/RHWrQyxrBQV+JhyXlu/ey
         cRFfWQtQWctSdUdj5OdUkeQpBghUAeopsTimExYJU79IUkZnv8i84szky7HhZPW6C1d7
         6CLA==
X-Gm-Message-State: APjAAAVCXUhBz7zdGUW24neTCZyc0LvMcppPEavPL1JadAY9Hnvf3SJJ
        gLYhyzltqtSE7DJ3Z5ONWEEEWzeNUUc=
X-Google-Smtp-Source: APXvYqwWSRiw8SVenZsJdp8HheqezoptCKXYbawUVyyjiCaT0FoMhJr9UsIFHe4FNGs6FnnD81Wtig==
X-Received: by 2002:aca:318a:: with SMTP id x132mr3255858oix.172.1553037616905;
        Tue, 19 Mar 2019 16:20:16 -0700 (PDT)
Received: from localhost (172-126-240-27.lightspeed.irvnca.sbcglobal.net. [172.126.240.27])
        by smtp.gmail.com with ESMTPSA id o17sm153813otl.27.2019.03.19.16.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 16:20:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:20:13 -0700
From:   Dave Huseby <dhuseby@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 1/1] t/lib-gpg.sh: fix GPG keyring import options
Message-ID: <20190319232013.t5pmbgfgojjbczqh@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the way GPG keyrings are imported during testing to prevent GPG from 
prompting for approval to change the default config. This appears to have no
adverse affects on GPG users with "normal" configurations but fixes the
always-interactive prompting I see with my multi-keyring setup.

v2: fixed the whitespace.

Signed-off-by: Dave Huseby <dhuseby@linuxfoundation.org>
---
 t/lib-gpg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 8d28652b72..e72e0554f1 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -32,8 +32,8 @@ then
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --import-options merge-only --homedir "${GNUPGHOME}" 2>/dev/null \
+			--import "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
-- 
2.11.0

