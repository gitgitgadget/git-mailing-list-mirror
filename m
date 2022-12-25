Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0610C4167B
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 01:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLYBkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 20:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYBkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 20:40:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08096467
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so5812144wmb.5
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gtGPm1pzJL5r63uC24zmwZC6Wm2BeyyzRoQmed4nTA=;
        b=h8vhHuExLpLhidHFEM4TJD9D7BCqwAv87XpW1SEgLmggKGbynpRjeOAwnbYdWLONtt
         Y7VMsGbPNflj/nX7Uo3Fes3mO/1s6ik7uK+wObO/BiUFqJArK6L6VW8Juo41wE0OXqi3
         uBXzvo0O9Jw9mSDEGBqiAfbQ9DwASSq/0J9lSEGVaAPb3r3m+Hp47LK6hD+DvPWbZTca
         cN+pcVTHhK9ec+Hh0RgX5XG49kR/ReLrhla7EW1PT+PmKneCvAR5Mw9KalnMLSrZg7/E
         IzS+BkkpBfDAbucbrWPMMKPjLbxjUaumefF3R5sx9uX0p0oafPo8yO8cOt03PmlWU/bt
         i4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gtGPm1pzJL5r63uC24zmwZC6Wm2BeyyzRoQmed4nTA=;
        b=H2Exaygm0B3yynp4dEJeflHsyKWTBjz3TmvDggOkXchjKHU63wj47ygHuOw3RHpotG
         5Pt95NClRD9jvnYP5qlOB+ScQ6t2KO5ohfiZUXLFqQ7eHUNaxkx2vG/nIA3pzWng//eQ
         Zl0+MHg2zQ+dNgBmnUjRd0t5sSbSEt3M6FERCO2qqYvhGLjxBcJ8KgLsn/nGeVD4b5w/
         4KvxttELKPXcBhUu6KUyIUrh9Gih9nxUkID+sohUQlEU9a8tN/fjBKxxCuObhY5fCiHm
         D+aJUBXm+OjTewxLj9nmJHqqrQsVYeaDRdBCVhKDwOm1kKY1C8HpigJWMPomBR8a8Zci
         2ULA==
X-Gm-Message-State: AFqh2kqCGMSr7QRdebgefjq2uupi6d/kPW5GvHiHzNsZfPIQa4giD6dP
        NB4KpivkhxaweF6ch75FstMnqxCbDkw=
X-Google-Smtp-Source: AMrXdXtS/ZhQ7NN8ECNRk33us9clrfl7ohoLcVoxl0lMUbDw1jSaEQeOLrfBtYxxjh/sPTZnhJhS+g==
X-Received: by 2002:a05:600c:22ca:b0:3d1:ebdf:d586 with SMTP id 10-20020a05600c22ca00b003d1ebdfd586mr10290934wmg.29.1671932406755;
        Sat, 24 Dec 2022 17:40:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d5111000000b00269e69e65c4sm6639004wrt.62.2022.12.24.17.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 17:40:06 -0800 (PST)
Message-Id: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
References: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 01:40:03 +0000
Subject: [PATCH v12 0/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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

 compat/win32/pthread.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v12
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v11:

 1:  e0cc43efc6c = 1:  e0cc43efc6c win32-pthread: prepare pthread.c for change by formatting
 2:  c5d2ddad166 ! 2:  fa5cbfa5e0c win32: close handles of threads that have been joined
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +		CloseHandle(thread->handle);
       		return EINVAL;
       	default:
     --		return err_win_to_posix(GetLastError());
      +		/* the wait failed, so do not detach */
     -+		errno = err_win_to_posix(GetLastError());
     -+		return errno;
     + 		return err_win_to_posix(GetLastError());
       	}
       }
     - 

-- 
gitgitgadget
