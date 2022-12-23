Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F7C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiLWTTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiLWTTl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:19:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FE8FFB
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja17so4164142wmb.3
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUaFqnW3mmBcV7mYzTzYKZrx8jQffBXuTvDP3P79sEs=;
        b=U+gsWuwc+kgqy0NRoOd9ccK2a7O95H2D+bo46Gks47+79hNGlxVRh1nQk8ajYZITgr
         aPU+XdXcI89GYXEBKpc9PDtOZLWPCNUMVssS9cpdf8kU842PpbFiKL1Gb2LsJ+01Q9ep
         SL+U6V6HqRq3TDkunYgTF8vYaJxI3sHPuuYAT3FZT3G4Ph7awfJgJeXXFc5Uio9AJanl
         r4UEQkCbKqFTDnLqvCjVJPSbpycONT5E9nSxWXsgwMfyQEB/43qR3e8yYCfBUao0rusD
         P7aw205pXV8hr6EtxcVNG4oQUc99mQYSbAaAMt401xdEXwYWuh6sSewUux/Gi61NZC8U
         HK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUaFqnW3mmBcV7mYzTzYKZrx8jQffBXuTvDP3P79sEs=;
        b=Ni3QszISWRFMOd8Zr/QkkxlN+gfV9C6oFiZO26l5pl7WMA7sjWNF7P9KEY9VXfYk2b
         qQ6oDyrwh2ktIBTKjWncTBi1sER62EgyPo9si9vjiJ/P5PsfiwNAc0fESZ9JdA5PHcUw
         uOyNiuNTUvfIGqgA9yg1dcEsGegT+u/UpT3RLktY+HSgDNxI2rKnJMcKUOaQ18PNmvrO
         oylTxuzMkhrQ0VVPpot/5rB8SKTf082JRSI00G7EcX0p4VGJ4yuZ3K4HH95XGb+J325t
         O8rG3ngoRlhXRU2duNUuej964KBK/2BOsUd/aVC7m4EuTT9HCW3FaykuHkVOzzbpxdGN
         M8Lg==
X-Gm-Message-State: AFqh2kpkYAaBeoSIcoy19J2f+DrWJRWMOWpOaUJRTaO+iFx2Y9xCR9vG
        V+jJdskpX72TPbbcoT5hV+Q0Dcq/w0U=
X-Google-Smtp-Source: AMrXdXtQ+bzh4mSxTLFoRMMcGVU5PySWNZ/ACVkFnx9N9/d4MTgjMWHaJs4uod+RKmFzJSPc5cyXkw==
X-Received: by 2002:a05:600c:33a2:b0:3c6:e63e:816f with SMTP id o34-20020a05600c33a200b003c6e63e816fmr8106000wmp.38.1671823178279;
        Fri, 23 Dec 2022 11:19:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003c6b70a4d69sm5392854wmq.42.2022.12.23.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:19:37 -0800 (PST)
Message-Id: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
References: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:19:35 +0000
Subject: [PATCH v11 0/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After joining threads, the handle to the original thread should be closed as
it no longer needs to be open.

Signed-off-by: Seija Kijin doremylover123@gmail.com

Seija Kijin (2):
  win32-pthread: prepare pthread.c for change by formatting
  win32: close handles of threads that have been joined

 compat/win32/pthread.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v11
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v10:

 1:  e0cc43efc6c = 1:  e0cc43efc6c win32-pthread: prepare pthread.c for change by formatting
 2:  d05d4c2e4b2 ! 2:  c5d2ddad166 win32: close handles of threads that have been joined
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +		CloseHandle(thread->handle);
       		return EINVAL;
       	default:
     +-		return err_win_to_posix(GetLastError());
      +		/* the wait failed, so do not detach */
     - 		return err_win_to_posix(GetLastError());
     ++		errno = err_win_to_posix(GetLastError());
     ++		return errno;
       	}
       }
     + 

-- 
gitgitgadget
