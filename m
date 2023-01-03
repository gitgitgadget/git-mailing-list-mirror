Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00465C46467
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjACQUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjACQUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 11:20:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DEDFE4
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 08:20:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso23707816wmp.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXheeTCmGZHZJt3LiN+qNiddDcmKoq6s8asmY4uFsGw=;
        b=J+neYm2XKvrgJYK0rnQz93gR+x01UyfqfSCbsAx/Xh/B2QcvKa9ELUIc+z3DCYQfV9
         wtXsUollhrLTI1ODmVvblckPVo00moG+3IFw5AULw/qLYmaAz5G/LFac0YAwHVwqZZfb
         nQ1RPe7/2/956wJfssPZXg1mtrcbk3GJZB1ZUXR9biLPXijxKWXnaS1zZjbiR/YQ3xqc
         rF4Yy1NOuu1tyS/WGzQAXxv9yK1WjFUDfJspw8SXFPdiHwVg7BQ2r/Gi4RM2m1TqIX0r
         0kW/anBLOdAa3iU9NlqvQ1LjWST1U7OznbRTabUB2o/v1ebBAxZP+1DmJ/Ulm8JK4Dda
         czSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXheeTCmGZHZJt3LiN+qNiddDcmKoq6s8asmY4uFsGw=;
        b=DNQFG5WDPSOVg0Pl4alDgxduwrGSwxzoseeVDCVSTiidMd2bso8Xgz9G1oniV2iNFd
         camAGJ84CdO/r8XbqmOApMTivhHVuGMj1aRyeugFxdGPgmz93lZ5TbkfXxBb6ssQxyzc
         d+OgJQs2r8FzAC6pvDbAEUDVTqKlbmixs39uO0FUPQmZ+3zUxpxLCD1iff1QDnzsHNiM
         lqZBjmR5D8KZtkyeKlyVfEWSRpSMAC3xE91//Jc9rlE2cJZJnlKeyuOBGwK0Zo8p1KNP
         SWApeTmtriqWRh6Ad1tctCKgv+ry6CzcZha/sVfjnnyRs/8GHgqZ3q+7qs/U/ihhFvFP
         I8+A==
X-Gm-Message-State: AFqh2kpb46yBDTSCfFpKH4I7Be3DCwRj/UqxF9cqGuPAbbPjE2V/HhCp
        ksZCrowECSFDI/TVE2zt6SWTExbuX1o=
X-Google-Smtp-Source: AMrXdXsGibEKfhQJpMwHuhqVyhOzjoKiLnuhPZPS7pTZPjxOfXQShj1tARFBH8ZYg1PUxwgA2W+JOg==
X-Received: by 2002:a05:600c:1c06:b0:3d0:a768:a702 with SMTP id j6-20020a05600c1c0600b003d0a768a702mr35340582wms.19.1672762821504;
        Tue, 03 Jan 2023 08:20:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003d96efd09b7sm44939224wmp.19.2023.01.03.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:20:21 -0800 (PST)
Message-Id: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
References: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 16:20:17 +0000
Subject: [PATCH v13 0/2] win32: close handles of threads that have been joined
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
  win32: prepare pthread.c for change by formatting
  win32: close handles of threads that have been joined

 compat/win32/pthread.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)


base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v13
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v12:

 1:  e0cc43efc6c ! 1:  6f89b120641 win32-pthread: prepare pthread.c for change by formatting
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32-pthread: prepare pthread.c for change by formatting
     +    win32: prepare pthread.c for change by formatting
      
     -    File has been formatted to meet coding guidelines
     +    File has been formatted to meet coding guidelines.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ compat/win32/pthread.c: static unsigned __stdcall win32_start_routine(void *arg)
       
       	if (!thread->handle)
       		return errno;
     -@@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused,
     - 
     - int win32_pthread_join(pthread_t *thread, void **value_ptr)
     +@@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_ptr)
       {
     --	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
     --	switch (result) {
     + 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
     + 	switch (result) {
      -		case WAIT_OBJECT_0:
      -			if (value_ptr)
      -				*value_ptr = thread->arg;
     @@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused
      -			return EINVAL;
      -		default:
      -			return err_win_to_posix(GetLastError());
     -+	switch (WaitForSingleObject(thread->handle, INFINITE)) {
      +	case WAIT_OBJECT_0:
      +		if (value_ptr)
      +			*value_ptr = thread->arg;
 2:  fa5cbfa5e0c = 2:  f126d6416d5 win32: close handles of threads that have been joined

-- 
gitgitgadget
