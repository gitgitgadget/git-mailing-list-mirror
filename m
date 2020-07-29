Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B18BC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA36B207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w0Lm4jxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Q6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:58:32 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:48104 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbgG2Q6b (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 12:58:31 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 12:58:27 EDT
Received: from mxback20g.mail.yandex.net (mxback20g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:320])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 7D9D21BE0C3B
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 19:53:20 +0300 (MSK)
Received: from sas2-b157fac3b6f2.qloud-c.yandex.net (sas2-b157fac3b6f2.qloud-c.yandex.net [2a02:6b8:c08:b282:0:640:b157:fac3])
        by mxback20g.mail.yandex.net (mxback/Yandex) with ESMTP id NoOFmeWT4j-rKrmtlMD;
        Wed, 29 Jul 2020 19:53:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1596041600;
        bh=ata4ZR7Mbn2NDo423kurCx3PEom8PJry/k8VZFKeZ+k=;
        h=Subject:To:From:Date:Message-ID;
        b=w0Lm4jxkgeuC76ogDaSvKAJCunX8veJBHMBA2JuIYYjkwbJNogglyvDKfTg6FjylU
         udcw3NDjLAKdocUWotqMtBx+BG11wXtAVAK+0WTImivBsajO6RXMcZ/O1a+mmc7pGI
         CGLprCsJu+bw4Qswn1t80baNv+KZ5WTTz6CyTWOU=
Authentication-Results: mxback20g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-b157fac3b6f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id qWgVCmGJWo-rJgak5N6;
        Wed, 29 Jul 2020 19:53:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 29 Jul 2020 19:53:18 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <186376813.20200729195318@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Cherry-pick picks more commits (and miss some) than provided
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

$ git --version
git version 2.28.0


If I do
git cherry-pick 90a075bf f2c161b7^..ae27237e fb7e608e f34c9562 76f2568a fb1=
41148

then more commits are copied and some commits are ignored
But when I do step by step then every thing is OK

git cherry-pick 90a075bf
git cherry-pick f2c161b7^..ae27237e
git cherry-pick fb7e608e f34c9562 76f2568a fb141148

Look at history before and after cherry-picking:

Before:
> fb141148 (local/dev) Delete confirmation
> 76f2568a SCHEMA 182: Added CHECK for passport data
> 7d0364c2 Use push to insert run obj to the array
> f34c9562 FIX: tooltip without tabulator div element
> fb7e608e Added defolt values for the p_tabulator
> 8bf04fcb Get table rows and insert they to a the table
> b52ce1f0 Use push to insert run obj to the array
> 335f23e2 Implement MsOffice::Word::Surgeon
> 0e5f8572 Added form to fill documents
> ae27237e Added form for mailing
> 3aa1b57c FIX: Removed doudled rows grouped by agreement
> 4afba7c4 Rename length -> rest, added comments
> 820f5d27 Implement options for reminding script
> 758d674b Update list again
> d96b2830 Do not mark documents as mailed while testing
> 8099effd Suspend reminding
=3D b7e56267 Reminding
=3D c1502c4e Remove line
> 3ef8eebc Added 'Invoice' verification
> 45c7d97a Rename btnPanel -> btnPnl
> 013995be Added highlight_bsd_row when pd row is deleted
> ab3af047 Use  formatter: "money" for 'suma' cell
> 7576249f Change rowClick -> rowDblClick
> a78fc015 FIX: btnPanel is not a function
> f58cee53 Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
> d2a68243 Added opportunity to prow documents
> 06a1060c FIX: Prow schet: 681 -> 361
> 53bc499b Allow many Prow at once
> f2c161b7 Allow many Prow at once
=3D 84180ade Added docdate column for p_tabulator
> 90a075bf Added mismatch report for msg:'Too many results:2 obtained'
| < e9cc2aa7 (HEAD -> dev) Play with Google OAuth
| < 45b7e647 Manual dumping for testing purpose
| =3D 56e0bc50 (xtucha/dev) Reminding
| =3D 9b9849fd Display date field
| =3D be498fae Remove line
|/ =20
o cb4a004b Do not show saldo for Internet invoices


After:
=3D f91b4583 (HEAD -> dev) Delete confirmation
=3D f9a371c8 SCHEMA 182: Added CHECK for passport data
=3D bcd3e4e9 FIX: tooltip without tabulator div element
=3D 8b695e08 Use push to insert run obj to the array
=3D 15e7de1e Added defolt values for the p_tabulator
=3D e2f18b8e Get table rows and insert they to a the table
=3D ab813f58 Use push to insert run obj to the array
=3D 00146b97 Implement MsOffice::Word::Surgeon
=3D 64258d59 Added form to fill documents
=3D fa6b6ccd Added form for mailing
=3D 21b52c6d FIX: Removed doudled rows grouped by agreement
=3D 93d44323 Rename length -> rest, added comments
=3D fc94fe09 Implement options for reminding script
=3D 40503f4b Update list again
=3D 73afd954 Do not mark documents as mailed while testing
=3D 477fc86d Suspend reminding
=3D 9493156e Added 'Invoice' verification
=3D 19164b0d Rename btnPanel -> btnPnl
=3D 8d760e51 Added highlight_bsd_row when pd row is deleted
=3D 69e9e548 Use  formatter: "money" for 'suma' cell
=3D f651d0ed Change rowClick -> rowDblClick
=3D 62d12ec7 FIX: btnPanel is not a function
=3D 6503edf3 Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
=3D f533ff36 Added opportunity to prow documents
=3D 217902d2 FIX: Prow schet: 681 -> 361
=3D 58adb0f4 Allow many Prow at once
=3D 2fdf2877 Allow many Prow at once
< e9cc2aa7 Play with Google OAuth
< 45b7e647 Manual dumping for testing purpose
=3D 56e0bc50 (xtucha/dev) Reminding
=3D 9b9849fd Display date field
=3D be498fae Remove line
| =3D fb141148 (local/dev) Delete confirmation
| =3D 76f2568a SCHEMA 182: Added CHECK for passport data
| =3D 7d0364c2 Use push to insert run obj to the array
| =3D f34c9562 FIX: tooltip without tabulator div element
| =3D fb7e608e Added defolt values for the p_tabulator
| =3D 8bf04fcb Get table rows and insert they to a the table
| =3D b52ce1f0 Use push to insert run obj to the array
| =3D 335f23e2 Implement MsOffice::Word::Surgeon
| =3D 0e5f8572 Added form to fill documents
| =3D ae27237e Added form for mailing
| =3D 3aa1b57c FIX: Removed doudled rows grouped by agreement
| =3D 4afba7c4 Rename length -> rest, added comments
| =3D 820f5d27 Implement options for reminding script
| =3D 758d674b Update list again
| =3D d96b2830 Do not mark documents as mailed while testing
| =3D 8099effd Suspend reminding
| =3D b7e56267 Reminding
| =3D c1502c4e Remove line
| =3D 3ef8eebc Added 'Invoice' verification
| =3D 45c7d97a Rename btnPanel -> btnPnl
| =3D 013995be Added highlight_bsd_row when pd row is deleted
| =3D ab3af047 Use  formatter: "money" for 'suma' cell
| =3D 7576249f Change rowClick -> rowDblClick
| =3D a78fc015 FIX: btnPanel is not a function
| =3D f58cee53 Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
| =3D d2a68243 Added opportunity to prow documents
| =3D 06a1060c FIX: Prow schet: 681 -> 361
| =3D 53bc499b Allow many Prow at once
| =3D f2c161b7 Allow many Prow at once
| =3D 84180ade Added docdate column for p_tabulator
| > 90a075bf Added mismatch report for msg:'Too many results:2 obtained'
|/ =20
o cb4a004b Do not show saldo for Internet invoices

Here history after step-by-step cherry picking:

=3D 91a14a19 (HEAD -> dev) Delete confirmation
=3D 0f8d9449 SCHEMA 182: Added CHECK for passport data
=3D 0150098b FIX: tooltip without tabulator div element
=3D 09fb6335 Added defolt values for the p_tabulator
=3D 301d0894 Added form for mailing
=3D cfd579a3 FIX: Removed doudled rows grouped by agreement
=3D 01adfdd8 Rename length -> rest, added comments
=3D 41df6d2d Implement options for reminding script
=3D b3b8039b Update list again
=3D 6e728987 Do not mark documents as mailed while testing
=3D fb3c8e6d Suspend reminding
=3D ee345786 Added 'Invoice' verification
=3D 0ba9ee11 Rename btnPanel -> btnPnl
=3D 14f627fb Added highlight_bsd_row when pd row is deleted
=3D 28c237e1 Use  formatter: "money" for 'suma' cell
=3D 9e03486e Change rowClick -> rowDblClick
=3D 4fb5c652 FIX: btnPanel is not a function
=3D f1528390 Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
=3D 9918bd67 Added opportunity to prow documents
=3D f0b86d08 FIX: Prow schet: 681 -> 361
=3D 29be8500 Allow many Prow at once
=3D 3a655cb2 Allow many Prow at once
=3D c2094b0e Added mismatch report for msg:'Too many results:2 obtained'
< e9cc2aa7 Play with Google OAuth
< 45b7e647 Manual dumping for testing purpose
=3D 56e0bc50 (xtucha/dev) Reminding
=3D 9b9849fd Display date field
=3D be498fae Remove line
| =3D fb141148 (local/dev) Delete confirmation
| =3D 76f2568a SCHEMA 182: Added CHECK for passport data
| > 7d0364c2 Use push to insert run obj to the array
| =3D f34c9562 FIX: tooltip without tabulator div element
| =3D fb7e608e Added defolt values for the p_tabulator
| > 8bf04fcb Get table rows and insert they to a the table
| > b52ce1f0 Use push to insert run obj to the array
| > 335f23e2 Implement MsOffice::Word::Surgeon
| > 0e5f8572 Added form to fill documents
| =3D ae27237e Added form for mailing
| =3D 3aa1b57c FIX: Removed doudled rows grouped by agreement
| =3D 4afba7c4 Rename length -> rest, added comments
| =3D 820f5d27 Implement options for reminding script
| =3D 758d674b Update list again
| =3D d96b2830 Do not mark documents as mailed while testing
| =3D 8099effd Suspend reminding
| =3D b7e56267 Reminding
| =3D c1502c4e Remove line
| =3D 3ef8eebc Added 'Invoice' verification
| =3D 45c7d97a Rename btnPanel -> btnPnl
| =3D 013995be Added highlight_bsd_row when pd row is deleted
| =3D ab3af047 Use  formatter: "money" for 'suma' cell
| =3D 7576249f Change rowClick -> rowDblClick
| =3D a78fc015 FIX: btnPanel is not a function
| =3D f58cee53 Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
| =3D d2a68243 Added opportunity to prow documents
| =3D 06a1060c FIX: Prow schet: 681 -> 361
| =3D 53bc499b Allow many Prow at once
| =3D f2c161b7 Allow many Prow at once
| =3D 84180ade Added docdate column for p_tabulator
| =3D 90a075bf Added mismatch report for msg:'Too many results:2 obtained'
|/ =20
o cb4a004b Do not show saldo for Internet invoices



git cherry-pick 90a075bf f2c161b7^..ae27237e fb7e608e f34c9562 76f2568a fb1=
41148
[dev 2fdf2877] Allow many Prow at once
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Fri Jul 10 12:08:49 2020 +0300
 1 file changed, 24 insertions(+), 1 deletion(-)
[dev 58adb0f4] Allow many Prow at once
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 15 11:35:25 2020 +0300
 1 file changed, 22 insertions(+)
[dev 217902d2] FIX: Prow schet: 681 -> 361
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Sat Jul 11 13:58:02 2020 +0300
 1 file changed, 1 insertion(+), 1 deletion(-)
[dev f533ff36] Added opportunity to prow documents
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Sat Jul 11 18:27:26 2020 +0300
 3 files changed, 110 insertions(+), 12 deletions(-)
 create mode 100644 lib/MaitreD/Controller/Operation/Document.pm
[dev 6503edf3] Rename '=CE=CF=CB=C0=D2=DB' -> '=CF=CB=C0=D2=C5=C6=C8'
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Mon Jul 13 12:08:20 2020 +0300
 2 files changed, 2 insertions(+), 2 deletions(-)
[dev 62d12ec7] FIX: btnPanel is not a function
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Mon Jul 13 13:36:18 2020 +0300
 1 file changed, 3 insertions(+), 3 deletions(-)
[dev f651d0ed] Change rowClick -> rowDblClick
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Mon Jul 13 13:42:19 2020 +0300
 1 file changed, 1 insertion(+), 10 deletions(-)
[dev 69e9e548] Use  formatter: "money" for 'suma' cell
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 14 17:09:36 2020 +0300
 6 files changed, 62 insertions(+), 58 deletions(-)
[dev 8d760e51] Added highlight_bsd_row when pd row is deleted
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 14 18:33:45 2020 +0300
 1 file changed, 7 insertions(+)
[dev 19164b0d] Rename btnPanel -> btnPnl
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 15 11:58:52 2020 +0300
 1 file changed, 2 insertions(+), 2 deletions(-)
[dev 9493156e] Added 'Invoice' verification
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 15 13:05:54 2020 +0300
 1 file changed, 3 insertions(+)
On branch dev
Cherry-pick currently in progress.
  (run "git cherry-pick --continue" to continue)
  (use "git cherry-pick --skip" to skip this patch)
  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
nothing added to commit but untracked files present (use "git add" to track)
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git cherry-pick --skip'
kes@work ~/t $ git cherry-pick --skip
On branch dev
Cherry-pick currently in progress.
  (run "git cherry-pick --continue" to continue)
  (use "git cherry-pick --skip" to skip this patch)
  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
$ git cp --skip
[dev 477fc86d] Suspend reminding
 Date: Wed Jul 15 14:38:48 2020 +0300
 2 files changed, 13 insertions(+), 5 deletions(-)
[dev 73afd954] Do not mark documents as mailed while testing
 Date: Wed Jul 15 14:46:49 2020 +0300
 2 files changed, 6 insertions(+), 6 deletions(-)
[dev 40503f4b] Update list again
 Date: Wed Jul 15 16:08:54 2020 +0300
 1 file changed, 11 insertions(+), 7 deletions(-)
[dev fc94fe09] Implement options for reminding script
 Date: Wed Jul 15 18:28:36 2020 +0300
 1 file changed, 23 insertions(+), 2 deletions(-)
[dev 93d44323] Rename length -> rest, added comments
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 15 18:29:14 2020 +0300
 1 file changed, 5 insertions(+), 3 deletions(-)
[dev 21b52c6d] FIX: Removed doudled rows grouped by agreement
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 15 18:54:28 2020 +0300
 1 file changed, 19 insertions(+), 11 deletions(-)
[dev fa6b6ccd] Added form for mailing
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Thu Jul 16 19:33:09 2020 +0300
 5 files changed, 85 insertions(+), 24 deletions(-)
 create mode 100644 lib/MaitreD/Controller/Send.pm
 create mode 100644 templates/send/form.html.ep
[dev 64258d59] Added form to fill documents
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 21 18:33:48 2020 +0300
 4 files changed, 338 insertions(+)
 create mode 100644 lib/MaitreD/Controller/Docs.pm
 create mode 100644 templates/docs/form.html.ep
[dev 00146b97] Implement MsOffice::Word::Surgeon
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 21 18:35:28 2020 +0300
 2 files changed, 1710 insertions(+), 1688 deletions(-)
[dev ab813f58] Use push to insert run obj to the array
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 22 17:38:20 2020 +0300
 1 file changed, 29 insertions(+), 27 deletions(-)
[dev e2f18b8e] Get table rows and insert they to a the table
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Fri Jul 24 18:48:16 2020 +0300
 1 file changed, 66 insertions(+), 49 deletions(-)
[dev 15e7de1e] Added defolt values for the p_tabulator
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 28 13:16:14 2020 +0300
 1 file changed, 10 insertions(+), 6 deletions(-)
[dev 8b695e08] Use push to insert run obj to the array
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 22 17:32:04 2020 +0300
 1 file changed, 1 deletion(-)
[dev bcd3e4e9] FIX: tooltip without tabulator div element
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Tue Jul 28 17:49:23 2020 +0300
 1 file changed, 3 insertions(+), 1 deletion(-)
[dev f9a371c8] SCHEMA 182: Added CHECK for passport data
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 29 13:22:54 2020 +0300
 13 files changed, 10151 insertions(+), 5 deletions(-)
 create mode 100644 share/fixtures/182/conf/accounting.json
 create mode 100644 share/fixtures/182/conf/all_tables.json
 create mode 100644 share/fixtures/182/conf/initial.json
 create mode 100644 share/fixtures/182/conf/service.json
 create mode 100644 share/fixtures/182/conf/timezone.json
 create mode 100644 share/migrations/PostgreSQL/deploy/182/001-auto-__VERSI=
ON.sql
 create mode 100644 share/migrations/PostgreSQL/deploy/182/001-auto.sql
 create mode 100644 share/migrations/PostgreSQL/downgrade/182-181/001-auto.=
sql
 create mode 100644 share/migrations/PostgreSQL/upgrade/181-182/001-auto.sql
 create mode 100644 share/migrations/_source/deploy/182/001-auto-__VERSION.=
yml
 create mode 100644 share/migrations/_source/deploy/182/001-auto.yml
[dev f91b4583] Delete confirmation
 Author: Eugen  Konkov <kes-kes@yandex.ru>
 Date: Wed Jul 29 15:19:24 2020 +0300
 1 file changed, 12 insertions(+), 5 deletions(-)



--=20
Best regards,
Eugen Konkov

