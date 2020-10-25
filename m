Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2DCC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 20:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784BE20757
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 20:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="R14mj+rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418708AbgJYUgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 16:36:45 -0400
Received: from smtp96.ord1c.emailsrvr.com ([108.166.43.96]:44152 "EHLO
        smtp96.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438309AbgJYUgp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Oct 2020 16:36:45 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 16:36:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1603657747;
        bh=1JY4izNzroz6HiXoFfdcxJifTJFPLRQ3h2a+Wrs1GaU=;
        h=From:Subject:Date:To:From;
        b=R14mj+rLfCFUTh9gz7IxTximtcKFSM5xvIbwxz+r3NbrqZ1X3nCI1eVi7G29NFtV9
         B5uouWbbMQ0BWpXFyNzm/Xyzu3G65jTMLZJ203FvcsB5rfFp3+1GQHUDL/NnJ2yCI2
         Sy38iUTCHw8pOwGb03skwfrM0BrQ8+ksQmQJSvVA=
X-Auth-ID: toonn@toonn.io
Received: by smtp5.relay.ord1c.emailsrvr.com (Authenticated sender: toonn-AT-toonn.io) with ESMTPSA id 868B140117;
        Sun, 25 Oct 2020 16:29:06 -0400 (EDT)
From:   toonn <toonn@toonn.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: [PATCH] git-status: Document type changed status
Message-Id: <1EC08C35-5E17-4347-BDE9-5436A3819258@toonn.io>
Date:   Sun, 25 Oct 2020 21:29:04 +0100
Cc:     martin.agren@gmail.com
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.7)
X-Classification-ID: 8214b719-ab86-4c71-8b95-579538a883c6-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: I composed this email manually because I could not get `git =
send-email` to work. I apologize for any additional trouble this causes =
and would appreciate any help to properly set it up.
`git send-email` with `--smtp-debug=3D1`:
```
Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
Net::SMTP>>> Net::SMTP(2.31)
Net::SMTP>>>   Net::Cmd(2.29)
Net::SMTP>>>     Exporter(5.68)
Net::SMTP>>>   IO::Socket::INET(1.33)
Net::SMTP>>>     IO::Socket(1.36)
Net::SMTP>>>       IO::Handle(1.34)
Net::SMTP: Unexpected EOF on command channel at =
/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/git-send-e=
mail line 1499.
Unable to initialize SMTP properly. Check config and use --smtp-debug. =
VALUES: server=3Dsecure.emailsrvr.com encryption=3Dtls =
hello=3Dterra.telenet.be port=3D465 at =
/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/git-send-e=
mail line 1527.
```

Below the `git format-patch` output:

`git status -s` output a T for me after replacing a file with a symlink.
I'd never seen this status so I checked `git help status` but "T" wasn't
documented. `man git-diff-files` does have it listed among the possible
statuses.

I added both the terse description in the list of statuses and two lines
to the table explaining the difference between occuring in the X or Y
position. Improvements to both wording and formatting are welcome.

Signed-off-by: toonn <toonn@toonn.io>
---
 Documentation/git-status.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f07..2ad85abe8c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -196,6 +196,7 @@ codes can be interpreted as follows:
 * 'D' =3D deleted
 * 'R' =3D renamed
 * 'C' =3D copied
+* 'T' =3D type changed
 * 'U' =3D updated but unmerged
=20
 Ignored files are not listed, unless `--ignored` option is in effect,
@@ -215,6 +216,9 @@ C        [ MD]   copied in index
 [ MARC]     D    deleted in work tree
 [ D]        R    renamed in work tree
 [ D]        C    copied in work tree
+-------------------------------------------------
+	   T    type changed in work tree
+T                type changed in index
 -------------------------------------------------
 D           D    unmerged, both deleted
 A           U    unmerged, added by us
--=20
2.17.2 (Apple Git-113)=
