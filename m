Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B901F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfAOUau (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:30:50 -0500
Received: from mout.web.de ([212.227.15.3]:46399 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbfAOUat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547584241;
        bh=0ZeB7zF21atpQw5xZcOMfST0sU1/x0H1RZQiPynSvr8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NSMWcr86TLebiaiocvVTNXwxdMrCy//Pw3+4Dwhs5Mz9HmMjGnIxsMnMh3yEAwmUP
         bhCsibE9S6kL5R89oOyB1qPmeP6dsD5jurYcGgVUIIGLLyKMwaVHWoN5UuYw/vB/Ne
         iKcMNmRhIvE757IBkdgYdl5u5MNMODOZrv0Y/n2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MUnqm-1gkbG92oRw-00Y84a; Tue, 15 Jan 2019 21:30:41 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, szeder.dev@gmail.com,
        zhiyou.jx@alibaba-inc.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] test-lint: sed -E (or -a, -l) are not portable
Date:   Tue, 15 Jan 2019 21:30:38 +0100
Message-Id: <20190115203038.10574-1-tboegi@web.de>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671
In-Reply-To: <20190110115704.GL4673@szeder.dev>
References: <20190110115704.GL4673@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+EyBHW2sRLAwprBLk9u5nOHJ3cm+4h9vi4sVXpQIWAJFMSOcYV
 YZbDJZwMK6fkg0fL70cYRly1SlEt8ymjxE5eK347haBzumwncVpwWDyawGyFsNblCNE8Ne3
 tOSkbG7LM1DCNQXU7vQ1dreNUEVkAgLjlr7QGcfcQQFnIMBCP98VulqN2P0OnXWwPB9waLl
 PKY3YvJy5n2/DBAibULKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpQU8fohTUw=:y2+kpc9AOsHtcLcDbfDbx+
 Xi9pRjRRg05idlvc5r2yAovMWZ/YwA/6ppWEYbL2zK8Biei+2sUvXishQCCePksqCjfLrvntP
 1vz/2n00bFEdXO54WyeUhrPE8cf/EkyRyd8VtRVw01NhswaiSzZsf76nttNLEG4VmBFkpSSCs
 vUulmICJ7mbiR6O00f9dhQlyeSy7/CMj8Pl8RpJUieYYlXZzu13Gk6pDSsJt81Hn5dsy6vk+a
 Zixvrf1pyn1Nu0+6C5Qx9SKjXj06mJUUFcFvxzksuUjq2pk8cmj9SkrVv9ppW7cN20/mkw/UT
 cEWzv5ZHM7JiKyFnZDAEd1LmwpWqln9e4NlE//H8rUfEsbGFSMu8MMO6JiNBToE4nxMwb0Mx7
 QHSzybzCFN29OWaY6zmrVSwiF7uGtPvMeL1ty90jQOO1oz6UUJocnAJEZYnQV7OmZUJAdj7cm
 7/Bh3Viv6ad0iNY4BjgEF7REyxFnaM7mnLc9mto1f1eCj30t1C7MGSL96UhS36cmcmzvLN91n
 LdDmYeOwlBY/DM8nl1BxuQc0PxAgoxNTZSqN29i8r5esWYF+24qdFD5Dg7EWEfGU8ueg4v2Io
 W64GXU3lTs2kdLKCZxaGK8UNJxqrfwPgBQwZNX/9ZQfnoNHERbszuUWGABVa3a9f22S3134BM
 6kaL1WFdJqoBs44Pvjog9LhirYSQjmKaf4TWR7rl1UKP/MKXsnVpLzSqx2X+mWDI20BhN22sU
 bd4JGAtnQ5HvHL2sbualwaBTzOfgpneoydVRD5Uh1TxYf0HGkF480daUx496G3UMqTwUiR932
 GSNxHcxyzFw9w6IXHeBmdrUQUzJo6AipEtlYSvkf0jbWhEbIy3X9IMjG/rJz+Vzr39ysXJYSr
 94dgYMK1O6qaRPgUE7xD004qdAArr5aCTbVlPCqbaeVl2Y+Nup6jheBIziyTS7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

=46rom `man sed` (on a Mac OS X box):
The -E, -a and -i options are non-standard FreeBSD extensions and may not =
be available
on other operating systems.

=46rom `man sed` on a Linux box:
REGULAR EXPRESSIONS
       POSIX.2 BREs should be supported, but they aren't completely becaus=
e of
       performance problems.  The \n sequence in a regular expression matc=
hes
       the newline character,  and  similarly  for \a, \t, and other seque=
nces.
       The -E option switches to using extended regular expressions instea=
d;
       the -E option has been supported for years by GNU sed, and is now
       included in POSIX.

Well, there are still a lot of systems out there, which don't support it.

Beside that, see IEEE Std 1003.1TM-2017
http://pubs.opengroup.org/onlinepubs/9699919799/
does not mention -E either.

To be on the safe side, don't allow it.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

I am somewhat unsure if we should disable all options except -e -f -n
instead ?
/\bsed\s+-[^efn]/ and err 'Not portable option with sed. Only -n -e -f are=
 portable';

That would cause a false positive in t9001 here:
"--cc-cmd=3D./cccmd-sed --suppress-cc=3Dself"

which could either be fixed by an anchor:
/^\s*sed\s+-[^efn]/

Or by allowing '--' like this:
/\bsed\s+-[^-efn]/

Any thoughts, please ?

t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b45bdac688..96b6afdeb8 100755
=2D-- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,7 +35,7 @@ sub err {
 		chomp;
 	}

-	/\bsed\s+-i/ and err 'sed -i is not portable';
+	/\bsed\s+-[Eail]/ and err 'Not portable option with sed. Only -e -f -n a=
re portable';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)=
';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
=2D-
2.20.1.2.gb21ebb671

