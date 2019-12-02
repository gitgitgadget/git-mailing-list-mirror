Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F4C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ED6215E5
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prkUtigd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLBLdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:33:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfLBLdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 06:33:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so43766753wru.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PQri2xUXcdMq9AE2qadkFjJLQqwFCjHhHm6ichCFwUY=;
        b=prkUtigd5ig+XIF7RdEvNK/++FC/BRRtyz+UC7ocuqKHeDlvB5451+dvC8L1hoxnpd
         ogDTrjZTpnN1+YrU9SefVcIOy9f3ycPn8UEHauXyaVVwvm3n75pdjtOqTrPtxKPZ32m0
         yoQandPEQpxnQkvny1nMoBt7L1q8Axqc844WtYWf6v3+PkepYa+Yf+jAyCfzlZToknla
         buGDYFkacIDLy9VcmYI476JglgJ6OFQ0btcy09pMTxcTA6ZL0+ZVFp4aIE7Dr/WTm4Jj
         oGTyEZHmiOHM7YnHz9aGuk9gHPIezqHqbT3lyMvdtM+P+5maPbxr5oGGBDPByK9YMdyN
         /Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PQri2xUXcdMq9AE2qadkFjJLQqwFCjHhHm6ichCFwUY=;
        b=BIOy44U/vofxFGjttz8+LDTX0H/ZWnIVLRyggQE8r+Wx8VvhgM2bbZIWR+vgx9vOQ0
         XttUADlSdAOs1dv6fZKQkXYb1Ti+widB0XoGBJdT4MEy7I6lKqtHI1r84o4SwZQLCEnT
         AH80OCwWvvGV9IFGurbkIVh0DOaXa5j5RdwK9BADfZB8aJwddJS34ySL9wQXAEAmA0Gw
         TZTUQ0l/XUF56l6P3jmaTSqYTaED64qLaXGuT4t7zg1BuN8V0eNlfBqo4kI0LcVpr2Xj
         97AFXhuE6GdL8d3A8FVWI5RPUwuHQ8r1dP/Be/ZGi3cWT5YVEip89gexo/CitP6gZyFL
         UMQw==
X-Gm-Message-State: APjAAAWBfO7VYzOuhcmtLQ6VMnZBZahlt4SmDq49CtfOe2Jn9MTZlwu6
        ZEkCTpVLlhNpizZXQn59ygsNmB2X
X-Google-Smtp-Source: APXvYqw50+m/a4M0pz4b3LOA7BxcbkLj/3Ii+v9KzQhVnYZBz35tNvTA2IX5GOMBvdL987XCTY7RVQ==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr49411789wrn.133.1575286410373;
        Mon, 02 Dec 2019 03:33:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h97sm42644135wrh.56.2019.12.02.03.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 03:33:29 -0800 (PST)
Message-Id: <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 11:33:27 +0000
Subject: [PATCH v3 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
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

Change since v2:

 * We no longer map ERROR_SUCCESS to 0, but instead raise a bug message when
   the code is asked to handle the "No error" error.

Changes since v1:

 * A copy/edit fail in the commit message was fixed.
 * We now assign errno only when the call to CreateProcessW() failed.
 * For good measure, we teach the err_win_to_posix() function to translate 
   ERROR_SUCCESS into the errno value 0.

Johannes Schindelin (2):
  mingw: do set `errno` correctly when trying to restrict handle
    inheritance
  mingw: translate ERROR_SUCCESS to errno = 0

 compat/mingw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: ac33519ddfa818f420b4ef5a09b4a7b3ac8adeb8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-480%2Fdscho%2Fmingw-inherit-only-std-handles-set-errno-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-480/dscho/mingw-inherit-only-std-handles-set-errno-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/480

Range-diff vs v2:

 1:  280b6d08a4 = 1:  280b6d08a4 mingw: do set `errno` correctly when trying to restrict handle inheritance
 2:  c3dea00fb1 ! 2:  e04e1269b3 mingw: translate ERROR_SUCCESS to errno = 0
     @@ -3,12 +3,15 @@
          mingw: translate ERROR_SUCCESS to errno = 0
      
          Johannes Sixt pointed out that the `err_win_to_posix()` function
     -    mishandles `ERROR_SUCCESS`. This commit fixes that.
     +    mishandles `ERROR_SUCCESS`: it maps it to `ENOSYS`.
      
     -    Technically, we try to only assign `errno` to the corresponding value of
     -    `GetLastError()` (which translation is performed by that function) when
     -    a Win32 API call failed, so this change is purely defensive and is not
     -    expected to fix an existing bug in our code base.
     +    The only purpose of this function is to map Win32 API errors to `errno`
     +    ones, and there is actually no equivalent to `ERROR_SUCCESS`: the idea
     +    of `errno` is that it will only be set in case of an error, and left
     +    alone in case of success.
     +
     +    Therefore, as pointed out by Junio Hamano, it is a bug to call this
     +    function when there was not even any error to map.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -19,7 +22,7 @@
       	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
       	case ERROR_SHARING_VIOLATION: error = EACCES; break;
       	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
     -+	case ERROR_SUCCESS: error = 0; break;
     ++	case ERROR_SUCCESS: BUG("err_win_to_posix() called without an error!");
       	case ERROR_SWAPERROR: error = ENOENT; break;
       	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
       	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;

-- 
gitgitgadget
