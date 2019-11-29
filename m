Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B2C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E29B2464A
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUEPv9Fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK2Vok (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:44:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2Vok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:44:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so33311461wrl.13
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FVpANwDKmrTeuKVeakyamw0VJf/oicWr4e+CIMyDVAM=;
        b=mUEPv9FwphcFPgc1I7CPKGP9RsI5+fs+Tr1SlnNeBkaG+L1uo5EtAU8SFsujC4I6eT
         VvpNCatLr3iVAWxD0GRCuk4/kJ53Bj0oG960YN1mWmXxKynGyiBdK5eSPZbMJjKMNeJv
         H9EwBvtSSbdgifCdGoKEMFsOUzfctwTwo02QqRiHu0+j6+lO5m5PbCuUUrnBcHyNCfLY
         NmR8qN/Ac13E0qLSQgOUxe6nGjOJUjyNKUvwtuH/TI18VzCoVVY//Eo1ji5HKFVg+pjy
         uInd1qg0aQa9j8C8cQbb37avb1XfgHbF+6n8nFTw5QMRY5VtxcsdgKtZ3D97Qi0l/Kn5
         /P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FVpANwDKmrTeuKVeakyamw0VJf/oicWr4e+CIMyDVAM=;
        b=Jma8mex//TGK5zxu7e9ho30i2BtPz7QcV9YE+1JGgUGVz/NN4yXa83iTq/OUkLE7J0
         d2Qi3TDCm03HPmgjr3wiUKMj+vIkvY92YE2GzfHEqMPFoACWI91+h8YKspK+IMJcH8W2
         9RzDRoseAkHJ75zgg3OJkQdzL8YsBUu/04fEoYBbxy/QBdBtOGR7i1gfAm84gw9/NfW4
         uzVioei1+C05jwvs02mZT4pWWzft2rMx1qJDq94NtmgdycQpZ+HBkO9fOxE64omFxEOg
         nK4EZ9ScYs0T76jk+FmvUu6irNvM4eiyNYjlN+ELnj+J5+RLK4ey9VNglaSMi4f/sCv9
         wAzQ==
X-Gm-Message-State: APjAAAUTCpKxCuNV1iqGCc35ZjDt+eHRbrUlf28K8GDd5fvdSpXJf6A2
        IsJZJD9+Gy9m8hhn7mq28H1QMw64
X-Google-Smtp-Source: APXvYqyrwwYHaOC8UyO+Jnh8ODvC/pEaFt48bqpnEy276puGAz7mLx+Fch8UtlDLKuC5qtliIHxPMQ==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr55025828wrx.145.1575063877497;
        Fri, 29 Nov 2019 13:44:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm28386026wrt.57.2019.11.29.13.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:44:37 -0800 (PST)
Message-Id: <pull.480.git.1575063876.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:44:35 +0000
Subject: [PATCH 0/1] Brown-bag fix on top of js/mingw-inherit-only-std-handles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes "Hannes" Sixt pointed out that this patch series (which already
made it to next) introduces a problem: when falling back to spawning the
process without restricting the file handles, errno is not set accurately.

Sadly, the regression test failure observed by Hannes did not show up over
here, nor in the PR builds (or, for that matter, the literally hundreds of
CI builds that patch series underwent as part of Git for Windows' master 
branch). The cause was that errno is set to the expected ENOENT by another 
part of the code, too, that happens right before the calls to 
CreateProcessW(): the test whether a given path refers to a script that
needs to be executed via an interpreter (such as sh.exe) obviously needs to
open the file, and that obviously fails, setting errno = ENOENT!

I have currently no idea what function call could be responsible for
re-setting errno to the reported ERANGE... But at least over here, when I
partially apply this patch, the part that sets errno = 0;, t0061.2 fails for
me, too.

Johannes Schindelin (1):
  mingw: do set `errno` correctly when trying to restrict handle
    inheritance

 compat/mingw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: ac33519ddfa818f420b4ef5a09b4a7b3ac8adeb8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-480%2Fdscho%2Fmingw-inherit-only-std-handles-set-errno-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-480/dscho/mingw-inherit-only-std-handles-set-errno-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/480
-- 
gitgitgadget
