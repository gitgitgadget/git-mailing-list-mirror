Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B3C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiLUEq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiLUEqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:46:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972818377
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z10so3237332wrh.10
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfnrTqD7KSJOJIcvbEx0Y2aH6sChx/8AAaLrPk9nmrg=;
        b=eLsHckNZsV9ep+om2LV1SapHhes+kPmlMcK3IFtvrlFm35i2+nCelDh6Wm7gYvc/Iu
         esUWt8Oq3fjFP+WyrEOzwRqVzoQct9FWJVRJj90IPBJPQmk/LJ2wbA8KQClebYPkjBBi
         qXhYQ9OIDRVkY3sQLWRkomLRgba/ruTfyeb0aP3CpAbQGi3p8+JODqpe9h/r93HCRwAW
         3iXp6NBUXal13KNy+xvb6vvuOYK9MPvXd5f79/jFKzYjT08jX1n8q1wOSBWSl/ph2roe
         2DdPjfLe10F8ghdGw6AI+MegcHRjn60pfwdS220nljCZyQ+tM+1aARtIwR1A6sL1R0RS
         jZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfnrTqD7KSJOJIcvbEx0Y2aH6sChx/8AAaLrPk9nmrg=;
        b=zJ32IXYpoS1mi6ltIgm/T2bHCuV1qKwQniWcaoq+OEsAD7HnlmiLkdP8BsumBto8ge
         Lz1j+pBid1R/UL4ebG1/cD4ZeBM3JqMOlhvAYgl2+qzmCfJBb13C35CwRwWRHRHbcAMx
         8ue5wXf8aTkfJQbtSTmH/1YhiDb96s3rmJSjyd/Lv1sD8VGgltcZ0EzzBAlcmbMI7bit
         1zY9lsadq18qUXSKBcKgErVd2RCTCvujXA/q3yJ4RMnSE+bhthMzNBVq2SRk7Ncws7Yz
         qHkY2d+9M86c/EQPHePFOP3aqtYGnV7gwVCNj4tyt6Pxfw6c8vwj0wJNtAGTU9cxtM7J
         mS+w==
X-Gm-Message-State: AFqh2krxHD/MZe3VX3HhNZor3FLLcaeq01PNactRYC3RvjvZ9Tgyi2EA
        ItA8GIIZ0zt9xF/4xBY0iIXKi51X/IU=
X-Google-Smtp-Source: AMrXdXuV9wJKcJpjbaNKgKLM3zQx9M+xc5+v6Rk0qI5vZ/D6G/tV9WvIh6oVt/qauzpe8UmKtuUDGQ==
X-Received: by 2002:a05:6000:239:b0:242:6665:6523 with SMTP id l25-20020a056000023900b0024266656523mr3176289wrz.52.1671598009538;
        Tue, 20 Dec 2022 20:46:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020adfec12000000b00236488f62d6sm14319313wrn.79.2022.12.20.20.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:46:49 -0800 (PST)
Message-Id: <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
References: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:46:46 +0000
Subject: [PATCH v7 0/2] win32: close handles of threads that have been joined
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
  win32: close handles of threads that have been joined
  prep

 compat/win32/pthread.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v7
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v6:

 -:  ----------- > 1:  b40287508df win32: close handles of threads that have been joined
 1:  0b5afdb93db ! 2:  f780ed525eb win32: close handles of threads that have been joined
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32: close handles of threads that have been joined
     -
     -    After joining threads, the handle to the original thread
     -    should be closed as it no longer needs to be open.
     -
     -    This change makes the function POSIX compliant.
     +    prep
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## compat/win32/pthread.c ##
     +@@ compat/win32/pthread.c: static unsigned __stdcall win32_start_routine(void *arg)
     + }
     + 
     + int pthread_create(pthread_t *thread, const void *unused,
     +-		   void *(*start_routine)(void*), void *arg)
     ++		   void *(*start_routine)(void *), void *arg)
     + {
     + 	thread->arg = arg;
     + 	thread->start_routine = start_routine;
     +-	thread->handle = (HANDLE)
     +-		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
     ++	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
     ++						thread, 0, NULL);
     + 
     + 	if (!thread->handle)
     + 		return errno;
      @@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused,
       
       int win32_pthread_join(pthread_t *thread, void **value_ptr)
     @@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused
      -		case WAIT_OBJECT_0:
      -			if (value_ptr)
      -				*value_ptr = thread->arg;
     +-			CloseHandle(thread->handle);
      -			return 0;
      -		case WAIT_ABANDONED:
     +-			CloseHandle(thread->handle);
      -			return EINVAL;
      -		default:
     +-			/* the function failed, so do not detach */
      -			return err_win_to_posix(GetLastError());
      +	switch (WaitForSingleObject(thread->handle, INFINITE)) {
      +	case WAIT_OBJECT_0:
 2:  5b35362e5d2 < -:  ----------- prep

-- 
gitgitgadget
