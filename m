Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5923AC33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 14:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FC3207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 14:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="AMmW4j53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEOBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 09:01:01 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:38389 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgAEOBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 09:01:01 -0500
Received: by mail-pj1-f47.google.com with SMTP id l35so6640414pje.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6f7o9lINz4DVFBM0T9tDCxmfwgqY4pKnNz+MHPTMVA=;
        b=AMmW4j53AeOvHY03mf5cWvCiRrw3/cvrG/SVVsD++KiEzV9APbF6TkLB7ksHDVirvh
         ahGB3Pur1FDO4dvQMlnDi5PLq7fphrAYm0lyc3uesnU2RgTg9RSD0cpqkGKkcTOoDQKk
         ZKm5zSkLxEgnHmU8FlvjewDOBf6pp1PiXSp1Uh2rKIF265LK3irewVeppvETS/cldf6u
         +r9u+sFjX8tcU6cuDdsl+Gl/cCy98BUxUyU7BRebhPUI3ir0AQjw13hmur1l3xM3XLLz
         wuyMwyWmfm4gnYEEnQdkxkRJpycZ/DsBadCIyQElhF6WKzqBmuxcFVg+HtviLk9s0jNL
         fz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6f7o9lINz4DVFBM0T9tDCxmfwgqY4pKnNz+MHPTMVA=;
        b=jwejsPgYHc/PldpVx8rDI0hFn8NXNWV5kNM04J9rhiUgGY5q2zvX6Zr7VKAb1FDPJP
         BhHAfrt6zhyb9C3FbI28BJaKaNQEFSvuURA3AYoh4Tqn+wfb3jeNJCWywIQeeUx3zHnX
         TdT9TDmFyted0C0K/xRn+Gr8XpOVolQ9Lc61dxA/rEx9DWBe9jxa6wQqcCoylbM3Lh3F
         Qty7bwmSs6F4QBdfDuusk9XtBlZytrBVHAwazIb1J10dhGKU+swc8B35vbTBE+pir4k5
         oaBeREGggTNk/aAkkzrcQTb+koEZ3z4HVhPW/lWfrJHP6NspAtN6/WYXqWxV/UdxaQwk
         6RGA==
X-Gm-Message-State: APjAAAUDOq9vfmZ2v02kQJ1MgxIE5ZijDfhHglIVBFoS5l3R4htZZqTj
        myaSALF7VBAJ7MXjdEuiI8fYzABo04A=
X-Google-Smtp-Source: APXvYqwdiYj5FrO1VHYMVzELJc53ARV3I1aUpAqk9lFN+rYksPKQ6YNKxCA6IWCPl8XaJ49mpr3Tgg==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr37603442pjn.97.1578232859395;
        Sun, 05 Jan 2020 06:00:59 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id a22sm79626343pfk.108.2020.01.05.06.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 06:00:59 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] Add *.txt to .editorconfig
Date:   Sun,  5 Jan 2020 14:00:54 +0000
Message-Id: <20200105140055.19679-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor patch that adds *.txt to .editorconfig to avoid annoyance when
editing git docs with an editor set to indent with space as a default.

Hans Jerry Illikainen (1):
  editorconfig: indent text files with tabs

 .editorconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.20.1
