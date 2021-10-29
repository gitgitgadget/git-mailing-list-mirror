Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C809C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DF36117A
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 15:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2Pbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhJ2Pbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 11:31:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC447C061570;
        Fri, 29 Oct 2021 08:29:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so16616067wrd.13;
        Fri, 29 Oct 2021 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhbqOXnoHXwyC+f7gmkg5ckm2abm1xltijn+kiK9wfs=;
        b=MQL8wxLzztGSjA2MuYakZfo5NmEHUQZiLT1KIM3GyNkosQ5tmkjatnBEZvZj3c3lK0
         Jart5MkoeQnmOhoVEh1O8Db3XxIfIhqV467ErN/m+sbZBQ9LttOndmUFw9oqvUK9PwNc
         1K3CrFnwteQdQEMf6PbfykWqAb1TN/qk0KTDhXON5OwMdIpS2wn/HRbZqqM0ST4Lkf9R
         I8dY1WSYApM52YqaKVmWTb/iFy1Kx2vkVIUpw7YODk6YE7MujXPsTREs+H+1tImhtTHq
         loS5BsMmKTqhfRTYUrHFtqM6dZMYcj5xC1HI0Njw6ni5NY144Ukq22dczgSoAI84shl8
         Hlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhbqOXnoHXwyC+f7gmkg5ckm2abm1xltijn+kiK9wfs=;
        b=oWLcZ9k5lW2h9m5kCNooLppXNeXk0UtAPWJ1oofv1Di+IAHcjG2Zw2iPumJp1g5bnE
         gCSy9WtP8k60snkBK7hz1PkabpwKXyWKejVqgoB2/OYQVOXsCQ30KAPP/FkMyZNPCS5Z
         OP2EXXn+dmLA5Xqlhsq38gFGzyUrLB8X64HLsNQ3ddIjQ++Ij6WTzc0yJAfz2MEkrWEV
         eryZVP86Ll6fRerorMCKfA1R0/SECNsMcDF7zhjjdDFa77Xn45a2rufgs0K7Kjx1zd/5
         Fy7KIs32quLqGfh/DSkoJHOWIU7rHOdvBmqjCjHCMwWgwc/907QqoVq4J99kzSS3eJfL
         PYmg==
X-Gm-Message-State: AOAM533cvwn8/mrCC/3/NBpNHpg9LyBN2eWvmdBOWw0gvLqMeNpX/kJO
        A/3eXhcfUdwPMth8m0z7REQ=
X-Google-Smtp-Source: ABdhPJxwB+0uH4h5PTmB8QYQVrp6xpguAo2+sVaW1C/1PNXpdJtXo4lWSZv1cRc9i9t+wCgZlvhvjA==
X-Received: by 2002:a5d:5244:: with SMTP id k4mr3880987wrc.77.1635521358292;
        Fri, 29 Oct 2021 08:29:18 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id p12sm6598235wrr.67.2021.10.29.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:29:17 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git <git@vger.kernel.org>, Glibc <libc-alpha@sourceware.org>,
        OpenBSD <tech@openbsd.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Benoit Lecocq <benoit@openbsd.org>,
        Klemens Nanni <kn@openbsd.org>,
        Randall <rsbecker@nexbridge.com>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Theo de Raadt <deraadt@openbsd.org>,
        Zack Weinberg <zack@owlfolio.org>
Subject: [PATCH] getpass.3: SYNOPSIS: Mark getpass() as [[deprecated]]
Date:   Fri, 29 Oct 2021 17:27:29 +0200
Message-Id: <20211029152728.42938-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
References: <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suggest readpassphrase(3bsd) as an alternative.

See the long discussion in the mailing list for more details (link
at the bottom of this commit message).  I'll quote some relevant
parts here:

Eugene Syromyatnikov <evgsyr@gmail.com>:
{
	And the only mention of getpass() in POSIX (at least,
	since the 2001's edition) indeed seems to be [1], in the
	list of functions that have not been carried forward from
	XSH5, the 1997 revision of “System Interfaces and Headers”
	(that is, SUSv2)[2], where it is inherited from SUSv1[4]
	from XPG[5] and, as Alejandro already mentioned, marked as
	obsolete, per XPG3 to XPG4 migration guide[6]; the
	previous, 1988, version of POSIX[3] does not mention
	getpass() at all.

	[1] https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap01.html
	[2] https://pubs.opengroup.org/onlinepubs/7908799/xsh/getpass.html
	[3] https://mirror.math.princeton.edu/pub/oldlinux/download/c953.pdf
	[4] https://pubs.opengroup.org/onlinepubs/9695969499/toc.pdf
	[5] https://bitsavers.computerhistory.org/pdf/xOpen/X_Open_Portability_Guide_1985/xpg_2_xopen_system_v_specification_2.pdf
	[6] http://archive.opengroup.org/publications/archive/CDROM/g501.pdf
}

Theo de Raadt <deraadt@openbsd.org>:
{
	The community finally had the balls to get rid of gets(3).

	getpass(3) shares the same flaw, that the buffer size
	isn't passed.  This has been an issue in the past, and
	incorrectly led to readpassphrase(3).

	readpassphrase(3) has a few too many features/extensions
	for my taste, but at least it is harder to abuse.
}

Alejandro Colomar <alx.manpages@gmail.com>:
{
	I found readpassphrase(3) in FreeBSD and OpenBSD.  It is
	also present in libbsd(7), which is available in most
	Linux distributions.  I also found it on a Mac that I have
	access.

	NetBSD has getpass_r(3) instead.  It is not in any other
	system I have access.
}

Zack Weinberg <zack@owlfolio.org>:
{
	I was about to post exactly the same thing.  getpass(3)
	is not deprecated because there's a better replacement,
	it's deprecated because it's _unsafe_.  The glibc
	implementation wraps getline(3) and therefore  doesn't
	truncate the passphrase or overflow a fixed-size buffer,
	no matter how long the input is, but portable code cannot
	rely on that.  And come to think of it, using getline(3)
	means that prefixes of the passphrase may be left lying
	around in malloc's free lists.

	(getpass also cannot be made thread safe, due to recycling
	of a static buffer, but a program in which multiple
	threads are racing to prompt the user for passwords would
	be a UX disaster anyway, so I don't think that's a
	critical flaw the way it is for e.g. strtok(3).)

	The Linux manpage project's documentation is, as I
	understand it, for Linux with glibc _first_, but not
	_only_; it should not describe this function as
	not-deprecated just because glibc has patched its worst
	problems and doesn't offer any better API.
}

List: linux-man <https://lore.kernel.org/linux-man/6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com/T/#t>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Git <git@vger.kernel.org>
Cc: Glibc <libc-alpha@sourceware.org>
Cc: OpenBSD <tech@openbsd.org>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Cc: Benoit Lecocq <benoit@openbsd.org>
Cc: Klemens Nanni <kn@openbsd.org>
Cc: Randall <rsbecker@nexbridge.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>
Cc: Theo de Raadt <deraadt@openbsd.org>
Cc: Zack Weinberg <zack@owlfolio.org>
Cc: Florian Weimer <libc-alpha@sourceware.org>
---
 man3/getpass.3 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/man3/getpass.3 b/man3/getpass.3
index fa2031544..7d6da07fa 100644
--- a/man3/getpass.3
+++ b/man3/getpass.3
@@ -28,7 +28,7 @@ getpass \- get a password
 .nf
 .B #include <unistd.h>
 .PP
-.BI "char *getpass(const char *" prompt );
+.BI "[[deprecated]] char *getpass(const char *" prompt );
 .fi
 .PP
 .RS -4
@@ -48,6 +48,7 @@ Feature Test Macro Requirements for glibc (see
 .SH DESCRIPTION
 This function is obsolete.
 Do not use it.
+See NOTES.
 If you want to read input without terminal echoing enabled,
 see the description of the
 .I ECHO
@@ -126,7 +127,11 @@ Removed in POSIX.1-2001.
 .\" are transmitted as part of the password.
 .\" Since libc 5.4.19 also line editing is disabled, so that also
 .\" backspace and the like will be seen as part of the password.
-.
+You should use instead
+.BR readpassphrase (3bsd),
+provided by
+.IR libbsd .
+.PP
 In the GNU C library implementation, if
 .I /dev/tty
 cannot be opened, the prompt is written to
-- 
2.33.1

