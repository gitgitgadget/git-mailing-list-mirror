Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E735B2018D
	for <e@80x24.org>; Wed, 10 May 2017 05:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdEJFMl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:12:41 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35888 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdEJFMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:12:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id 64so2631534pgb.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BiG24liwK7fco4tmaX3d7x/x3WJsppsuUisXteTfbEo=;
        b=U/41tbjIAZGp87Wf0vaWcWGmy0z4o2T/dMhymizA5rn8TT4/TEcxiG2rVX/VGw9J5V
         B9sF0+5Ecc8h92G8HwTIlSsY7ngmMnk/4me0WBAcyDr4P0Y4ZmXaLkbhahHf0L3Imnbm
         qU0XhvfRa5WkKhqpqyYesLVp9HNpT1ey7moRYdUkikw2U9cUggxtUJO8uHuj8bzF6mgt
         BSdAtQGeCoyObRLxs5koHSxmLwZZ2rP4OUG7wpv9Xb38JFGDBRRXJKB41QpWDa6dOtzN
         iytWG0fciPr+6keuMAupnbP4ZCY7llOvnXUN1HTQOH7HggdlmXkGxuwyVx+xWUjRObiL
         nxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BiG24liwK7fco4tmaX3d7x/x3WJsppsuUisXteTfbEo=;
        b=VtGX3lE2k2AikKLM9vnK9A/WK3L9IwodrpwS1ZW9w+9ekWTv/S6hDXgWJvGczpjpOd
         9LYrs+lEiVuM2CeSUkqVdAPfBpKBJ2Q9G3W21dDTzGLytHHV6GHo5m2/VexdRpixqc2f
         HraEsZHazsKn6b5TZ8rP2OrwCfTIKLJzVpxjNl4rrydQCqw1VXULNfwAA9QQ/w+Fu2LC
         4B4fzWr3Vgyxwdu5cXOHW7aKmQBXin+hkS93OZpj08JVp3tx3B66ZjNh91Op3CoXyFOz
         I0f/t+tM9y8DMgJOsw28N3FnjdXUCR8zjyR7cdLej6MfY/NjiMa6zcj0vmxs5YVml76k
         Anlg==
X-Gm-Message-State: AODbwcD00aAbskMlVhDXL/M9H58u8ywKY9oLh08ajDwZgATQvpwr2/OX
        sE+MNFC8ob7BbQ==
X-Received: by 10.99.173.12 with SMTP id g12mr4138709pgf.225.1494393159772;
        Tue, 09 May 2017 22:12:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id i63sm2737396pgc.26.2017.05.09.22.12.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 22:12:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
References: <20170420112609.26089-1-pclouds@gmail.com>
        <20170503101706.9223-1-pclouds@gmail.com>
        <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com>
        <CAPc5daVwnsC2iqrX4PYL9LJyfD76dA1TS3xCNM7qHtmfHd0aWg@mail.gmail.com>
        <CACsJy8DyAV4y_-gsjk1QSGkcq+-jGX6y-ymuHvUEMfV3gxJa_g@mail.gmail.com>
        <xmqqzielzlqm.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 10 May 2017 14:12:38 +0900
In-Reply-To: <xmqqzielzlqm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 10 May 2017 07:52:33 +0900")
Message-ID: <xmqqmvalxpkp.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's do the same for Macs, as it is BSD variant after all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a25ffddb3e..1743890164 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -110,6 +110,7 @@ ifeq ($(uname_S),Darwin)
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
2.13.0-336-gf73534b083

