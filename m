Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22659C432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC4A2075C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edrbb3LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfK3Kgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 05:36:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51039 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfK3Kgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 05:36:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so16482622wmh.0
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iigSQ5eNt0/d1dcy9kKpJc0GCD6MOEgW4ga1TCulvhE=;
        b=edrbb3LUsU5AQ2u5A2kylemFN73i2epSk1sSXgoR2t4NUyR42g8BSx/fqxMEqB3DnK
         dXF7kLxV8aPCm3OirBvj24awKtxkm+LDmRXvgcULyRNKCTcVbji72RM29VRpNpYlw27t
         b/w1Sugk1+TEX0z6osOOKZMMX5O8v85m2HAcKXIfzI2by+qysAC1EebrBir3K/Di2LJl
         d0CQW0VJW/NwHU2elqDQhNUDLmmyPDFZ5t/8zV3NmSlj/+xFrWwc5Po2ZvfIlTCpJ+kL
         /B+6s5yiF9I1IV96gjvpslj9a5cfRLYKj//QIItvMQ5teP1+QRpbqeEDMnLuoJcg+G2p
         k9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iigSQ5eNt0/d1dcy9kKpJc0GCD6MOEgW4ga1TCulvhE=;
        b=drl5uyOtr2YgAlxdUYG1+k3BA2d8qANGDXj6YhhY/Q22rh5ccs/rdnGghI6Rv4fLMq
         3zeNoZjSXF7jpY1S6bcKMtoRpRb5dKTy8bLQ7f2f9b1EHmt9LTGsoVn+BehKMrj3JJlQ
         RrTwxiQAIUQpDdilkWD+HSu/j1fav0LGAGGWwws/xMVnU9jjXi7U3tsOZZC9LFXsJK+6
         kZKQAdUD2a6oZokOUsBKMi0zC+2U5KWgRj84cdTFrCp8Lptl8M2mxmS6Fr51LQG2CCpr
         NQXJmvWvq2pH2kh8A86Z0Xw1VCRzoHyt0cD2zXNtBbR4KcRjja6Zv2XRH/REvMZRb5c6
         9AKg==
X-Gm-Message-State: APjAAAXbYz41+eaX8emTGQRRdYLWjlokCV4XR9hUPRbtz0/43Y10qB52
        gVOADANVJ7GDwznOSMdIuBYq1jrw
X-Google-Smtp-Source: APXvYqzvqqRn1zGMz00B1w0+8hvu4tRcrhVFzeNDDF3hNjL8gyQWW59Oqhr0sXBZOYxIF9uOCKTjrg==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr1404618wmc.34.1575110202747;
        Sat, 30 Nov 2019 02:36:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w188sm17526786wmg.32.2019.11.30.02.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 02:36:41 -0800 (PST)
Message-Id: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.git.1575063876.gitgitgadget@gmail.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 Nov 2019 10:36:38 +0000
Subject: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-480%2Fdscho%2Fmingw-inherit-only-std-handles-set-errno-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-480/dscho/mingw-inherit-only-std-handles-set-errno-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/480

Range-diff vs v1:

 1:  685360f735 ! 1:  280b6d08a4 mingw: do set `errno` correctly when trying to restrict handle inheritance
     @@ -28,7 +28,10 @@
          test suite, `HOME` points to the test directory), the `errno` has the
          expected value, but for the wrong reasons.
      
     -    Let's fix that by making sure that `errno` is set correctly.
     +    Let's fix that by making sure that `errno` is set correctly. It even
     +    appears that `errno` was set in the _wrong_ case previously:
     +    `CreateProcessW()` returns non-zero upon success, but `errno` was set
     +    only in the non-zero case.
      
          It would be nice if we could somehow fix t0061 to make sure that this
          does not regress again. One approach that seemed like it should work,
     @@ -37,9 +40,8 @@
      
          However, when `mingw_spawnvpe()` wants to see whether the file in
          question is a script, it calls `parse_interpreter()`, which in turn
     -    tries to `open()` the file.0/compat/mingw.c#L1134. Obviously,
     -    this call fails, and sets `errno` to `ENOENT`, deep inside the call
     -    chain started from that test helper.
     +    tries to `open()` the file. Obviously, this call fails, and sets `errno`
     +    to `ENOENT`, deep inside the call chain started from that test helper.
      
          Instead, we force re-set `errno` at the beginning of the function
          `mingw_spawnve_fd()`, which _should_ be safe given that callers of that
     @@ -66,9 +68,10 @@
       		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
       				     TRUE, flags, wenvblk, dir ? wdir : NULL,
       				     &si.StartupInfo, &pi);
     -+		errno = err_win_to_posix(GetLastError());
     - 		if (ret && buf.len) {
     --			errno = err_win_to_posix(GetLastError());
     +-		if (ret && buf.len) {
     ++		if (!ret)
     + 			errno = err_win_to_posix(GetLastError());
     ++		if (ret && buf.len) {
       			warning("failed to restrict file handles (%ld)\n\n%s",
       				err, buf.buf);
       		}
 -:  ---------- > 2:  c3dea00fb1 mingw: translate ERROR_SUCCESS to errno = 0

-- 
gitgitgadget
