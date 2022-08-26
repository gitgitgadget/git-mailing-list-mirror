Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9FDECAAD5
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 22:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiHZWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiHZWqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 18:46:42 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158FE1939
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661553990;
        bh=F2gTxydCDMklGwOdiXgj/F0nNDzoR3pFYUjxeexLJ78=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dgru+5OTJir8yzq4M7NRBRte0uxjTvIXoQ2HLN6vBBxAkWZutMKqhzG3CCDdiVlwr
         nRRrIxLsPru82AE8Z6FCcXD+3gHoG3MuPwzpvtJKcPMdJ6oxDm66Y1ElMXNlFwFQ0i
         DgmZZqHygO6G2Lb9kzIVP+9t55ZDMj6vkeGQpNOM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.21.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5fd-1ov6OR1I0z-00YFo8; Sat, 27
 Aug 2022 00:46:30 +0200
Message-ID: <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
Date:   Sat, 27 Aug 2022 00:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: curiosities with tempfile.active
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLBSM3CW4w8kmsnsXCEPOmBxmjZNJbSGMo4AiAFz8El6bQEoEo7
 ncUNsHRK71YoOPMcogzvcD+SwPzoQ/YwZVIAf9tgK5FSFmsJTQ9Mr0nftGf4yxLVK+T31QV
 mDUeQn+z6LbaDNefmzWGotKy+8aZw2mViy1BvxKo6kJa3dD2+O8GHC29M0b4e/WB35pgx1F
 fz5rv6DfM8GnkJ+YQCN6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JyStri/zASg=:ZBN2g7ED8YWv5dn9mLJV3b
 gyyGwt4i9ynwQGzp0qXLjLNlktzcLR5yMb1TFCMP4GQBD2r1Tdk/ABdxXzKl1KgHFw3VE3F/X
 OaA/vT2lAD87K1/0fG8xSmseI04H5MWAzP1S6C6CZHOPpNcukK0BBjzodcH1lGeKLpdwDsWxk
 z/DoFzDQ69rh8mzIxxs+r30ZH0jRJXJjUHYKm2AOyKDEY6q/uvmVIH+YzQ4KZdhChxF1lHjLS
 nEPMjkokEgP2NBnh3GU0w6AARTUvDgClsenBAAPHKPY2JmllqBkjZigEob9gBBN32RMeFp2ho
 Tx4o6u+2YfTHiSOWfBIugVmaNPKekX3AkifyBNCddqeNuekC3eLsL1btA8luoMI25dtAzZKeV
 3wopV9P3d0/uKPHWYvbQdeT4m2KFinq1PvRanmmziiPhGPQLNm0rZMkAtXoARV7MLB84YLoq8
 +k/UBX8S3Fhlll4Sr8erc6XQRWLFkWYZZY3/m9vFfIPQQzJVCUya8b1VHZOidxTx8UgD5V6O3
 riWqZ0KQOfgWZagxJ2fugNExJcbXm6nrecjGOnEJnQnr3oXKjqwArhWKpUrOHS+/j2+LEfk2f
 v0ZVfTsSkngFHRsME3Rs1mj95D13kTAZGxpKc1TF3gkJH/jpiN4EUoi0jbEp3RKYKWemPM+gT
 7Kdym0AiNBKlWPsIz7Fglixh3IBJKu78W9pIaJsKE5zwMOLqVVAtV+HEEJ8xTvwp5DywxGgs7
 E5CEGr2DCDiW9k3tKYoJTIvQQP1WHayZ8ZbBojliS9IZohK1yUHMwDTsiaRi2pJjtgEqwfLPc
 w0hzz2hZ45SH1dORD8BdgOJajHD+jGZbgeNQMvYOp/ebn7PZXkmu7elkodUQrL3Eex3FNTYXY
 0lP/Inyr1fiJpFQmggGVrP6KOaZaqnJGJ9cLTy71EVVQuYRW7lNweKU8BqrfMCZjU1b80y6fc
 KbEQhgQ9CcHozHjrtkSW+j1yauIP83NgDeXDW3ZXSDiUhLaCwbxnuzc8GOtvbI7ykPXWOyItH
 THH853sNyqcya8WpuJohoqdi8J1BbW2h1hiYJ35/BePLZTjbZ5DMRYbg6XXF+7o7ooKhHkmPh
 S7N9qGKccUnQS4KF6E/qLHnldlwQctHVsIX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.08.22 um 11:35 schrieb Jeff King:
> But here's the interesting twist. Commit 2c2db194bd (tempfile: add
> mks_tempfile_dt(), 2022-04-20) recently taught remove_tempfiles() to
> drop a surrounding directory. And it does so by munging the filename
> buffer. It has to, because we can't allocate a new buffer in a signal
> handler.
>
> But is it also idempotent(-ish)? The directory removal itself is,
> because it checks:
>
>   tempfile->filename.buf[tempfile->directorylen] =3D=3D '/'
>
> before overwriting that byte with a NUL, so it should only be true once
> (though I note this violates the usual "volatile" rules for signal
> handlers, it's probably OK in practice since we know the NUL will be
> written before we call rmdir()).
>
> But after that happens, the filename buffer now contains a C string that
> points to the directory. And if we end up in remove_tempfiles() again
> due to another signal, we'll try to unlink(p->filename.buf), which will
> now unlink the directory! I'm not sure how that behaves on all systems.
> On Linux it's a noop. And if it just deleted the directory, that would
> be OK. I seem to recall on old versions of SunOS it did bad things
> (maybe because it really did unlink it, but without checking for
> orphaned entries inside).

https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html
says of the unlink(2) parameter: "The path argument shall not name a
directory unless the process has appropriate privileges and the
implementation supports using unlink() on directories."  So we better
not do that..

=2D-- >8 ---
Subject: [PATCH] tempfile: avoid directory cleanup race

The temporary directory created by mks_tempfile_dt() is deleted by first
deleting the file within, then truncating the filename strbuf and
passing the resulting string to rmdir(2).  When the cleanup routine is
invoked concurrently by a signal handler we can end up passing the now
truncated string to unlink(2), however, which could cause problems on
some systems.

Avoid that issue by remembering the directory name separately.  This way
the paths stay unchanged.  A signal handler can still race with normal
cleanup, but deleting the same files and directories twice is harmless.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tempfile.c | 14 ++++++--------
 tempfile.h |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 2024c82691..7414c81e31 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -59,14 +59,11 @@ static VOLATILE_LIST_HEAD(tempfile_list);
 static void remove_template_directory(struct tempfile *tempfile,
 				      int in_signal_handler)
 {
-	if (tempfile->directorylen > 0 &&
-	    tempfile->directorylen < tempfile->filename.len &&
-	    tempfile->filename.buf[tempfile->directorylen] =3D=3D '/') {
-		strbuf_setlen(&tempfile->filename, tempfile->directorylen);
+	if (tempfile->directory) {
 		if (in_signal_handler)
-			rmdir(tempfile->filename.buf);
+			rmdir(tempfile->directory);
 		else
-			rmdir_or_warn(tempfile->filename.buf);
+			rmdir_or_warn(tempfile->directory);
 	}
 }

@@ -115,7 +112,7 @@ static struct tempfile *new_tempfile(void)
 	tempfile->owner =3D 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
-	tempfile->directorylen =3D 0;
+	tempfile->directory =3D NULL;
 	return tempfile;
 }

@@ -141,6 +138,7 @@ static void deactivate_tempfile(struct tempfile *tempf=
ile)
 {
 	tempfile->active =3D 0;
 	strbuf_release(&tempfile->filename);
+	free(tempfile->directory);
 	volatile_list_del(&tempfile->list);
 	free(tempfile);
 }
@@ -254,7 +252,7 @@ struct tempfile *mks_tempfile_dt(const char *directory=
_template,

 	tempfile =3D new_tempfile();
 	strbuf_swap(&tempfile->filename, &sb);
-	tempfile->directorylen =3D directorylen;
+	tempfile->directory =3D xmemdupz(tempfile->filename.buf, directorylen);
 	tempfile->fd =3D fd;
 	activate_tempfile(tempfile);
 	return tempfile;
diff --git a/tempfile.h b/tempfile.h
index d7804a214a..5b9e8743dd 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -82,7 +82,7 @@ struct tempfile {
 	FILE *volatile fp;
 	volatile pid_t owner;
 	struct strbuf filename;
-	size_t directorylen;
+	char *directory;
 };

 /*
=2D-
2.37.2

