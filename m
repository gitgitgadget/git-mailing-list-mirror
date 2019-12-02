Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF6C43215
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B9B2176D
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTjLOR2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLBLde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:33:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBLde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 06:33:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so9991513wmi.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZcVrR64j5Wkx6FSjayBramr2+xYCxktni1aiRnccl2Y=;
        b=RTjLOR2kFRNgSa62CC2S06fCWUzNZSlBAvI1LrTUhlfMdDhl07xRgPAs4udvP/pkcf
         hFpcod6KvSMoYZDC5oLgzYoJCAw2CGhUkBj+zF4TGhBXf/dObuXkjipn+qUph3FYao3R
         8TbQkFghTpM9R+/yNmTr/0PNHix4ST1QOG7d3L90D9IVdNJelPY4wK+Rl154wmzo35t3
         B5/sScuCC0unzV76gDxa15STNFee4mMcw04YpKqWivPeLNCTVqkbGQlWaGt/AFncx6Nq
         ystFWyofpfPMbvs6S1a8Gev0GZ1iaFwuu3srqbJn1RZuxlk5imj/A6qfeeYq+ZoL+1lX
         9hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZcVrR64j5Wkx6FSjayBramr2+xYCxktni1aiRnccl2Y=;
        b=g6cFj8e2jPBqb4pQDAzotN0m8x0zaQkBQuSSdtb7Zpzt9liR1kVBx87E3Os9vA474E
         t8U2JKMX8cB9RnNx9oSH6H/XlR7lyEdMgRcC5cmuQDBwL93YYOlkAPqdDGgPax08A3n4
         GETycghn+rB16oDMPimPXrP5TC4rporrMUgm7Gx3M+gdd8kVpNXIW/SqDrpcXxhhItmQ
         mfe3r2jIEP3DiGAEI7DYt8UQk7JAWYiJxWrFruIJwVfNBDONtdWTd4rW6McTxp+ZMem4
         dMpqWD6pryfFMgORrRN98h413YkI0KFLnr+6C/bIPKgw3oOM5onhDXq6lDSsOKX1p1so
         5Qpw==
X-Gm-Message-State: APjAAAUR8y32VWYjSGCESInMv7kDCExPCcs1/oWsciOCYyww+/mPdKye
        ikzozFb1erqtjHzFfhHdX6xifjmp
X-Google-Smtp-Source: APXvYqzj0qM2AxryHrOO4nT+Lv1Da9A7a1uesUkXAS+bEYblgdeoFlfh+bBforJllMf5ic8rrDn2ug==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr27735287wml.141.1575286412150;
        Mon, 02 Dec 2019 03:33:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j184sm6226500wmb.44.2019.12.02.03.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 03:33:31 -0800 (PST)
Message-Id: <e04e1269b308bb000ea2dad2e5f2d04ef6f17502.1575286409.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 11:33:29 +0000
Subject: [PATCH v3 2/2] mingw: translate ERROR_SUCCESS to errno = 0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Johannes Sixt pointed out that the `err_win_to_posix()` function
mishandles `ERROR_SUCCESS`: it maps it to `ENOSYS`.

The only purpose of this function is to map Win32 API errors to `errno`
ones, and there is actually no equivalent to `ERROR_SUCCESS`: the idea
of `errno` is that it will only be set in case of an error, and left
alone in case of success.

Therefore, as pointed out by Junio Hamano, it is a bug to call this
function when there was not even any error to map.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 432adc1aed..827065d96d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -114,6 +114,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
 	case ERROR_SHARING_VIOLATION: error = EACCES; break;
 	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
+	case ERROR_SUCCESS: BUG("err_win_to_posix() called without an error!");
 	case ERROR_SWAPERROR: error = ENOENT; break;
 	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
 	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;
-- 
gitgitgadget
