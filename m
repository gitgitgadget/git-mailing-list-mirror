From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] docs/git-mailinfo: Mention the manual separator (---)
Date: Wed, 24 Sep 2014 08:25:32 -0700
Message-ID: <28b04f1c17f2cc2fe252948bc0b7bb10df24b489.1411571629.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWoVC-00070c-U1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 17:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbaIXP3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 11:29:05 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:59494 "EHLO
	resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020AbaIXP3C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2014 11:29:02 -0400
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
	by resqmta-po-09v.sys.comcast.net with comcast
	id v3Ua1o0075AAYLo013V0aX; Wed, 24 Sep 2014 15:29:00 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-po-15v.sys.comcast.net with comcast
	id v3Uy1o00m152l3L013Uzvy; Wed, 24 Sep 2014 15:29:00 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.150])
	by odin.tremily.us (Postfix) with ESMTPS id AFFC413AAAE7;
	Wed, 24 Sep 2014 08:28:58 -0700 (PDT)
Received: (nullmailer pid 2133 invoked by uid 1000);
	Wed, 24 Sep 2014 15:25:39 -0000
X-Mailer: git-send-email 2.1.0.60.g85f0837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1411572540;
	bh=mcmp963TPYiab5RLsrqZQV9kx4BJc4qxgnCeig7iCBU=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=VklKRRxRh4zBW9dcwiBEiqi083F0zrCcufoaKAkQ4KoK8hPb9AP9cEtenIdcnY/gj
	 s8H8nB3tr7LYMV4MbqwY6yMAwsGbCVWLPJOxwsJtVxD2E9cXqmys2flvk20AZ/kufK
	 UdPBq+Iya/Lmv2/o2zYn0nSpMXvkDh82qXt3X62zoVA4HiebxZw1OPw7TOPDqj08TW
	 39vvkor/h4OF0QIqUBkdn2uOt8V7gvUv29S+kZdImij07apBWSPA7NoO6Un7zMvxVP
	 6W7qEkVwP8MNRH5Q1jZ1EdaI1n8LAnf923nvm8ktlmedwEdW9QW/2SBd0VwghkGTUo
	 JdrTJu1bEPW9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257460>

And explain how it interacts with the scissors setting.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
The three-dash limit comes from f0658cf2 (restrict the patch
filtering, 2007-03-12), but I couldn't find any associated
documentation.  Since the effect is so similar to the scissors line, I
thought about adding the information to the --scissors entry.  The
manual separator is really independent from the scissors though, so I
settled on explaining both separators in the DESCRIPTION.

This patch is against 'maint'.

 Documentation/git-mailinfo.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 164a3c6..6c6c527 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -21,6 +21,29 @@ written out to the standard output to be used by 'git am'
 to create a commit.  It is usually not necessary to use this
 command directly.  See linkgit:git-am[1] instead.
 
+The commit message extracted from the e-mail depends on the scissors
+setting (see '--[no-]scissors' in the OPTIONS section).  Besides the
+scissors option (which discards content before the scissors), you can
+also use '---' as a separator (which discards content after the
+separator).  For example, without scissors you can have a body like
+this:
+
+------------
+Your commit message.
+---
+Comments that aren't part of the commit message.
+------------
+
+With scissors, you can have a body like this:
+
+------------
+Comments that aren't part of the commit message.
+--->8---
+Your commit message.
+---
+More comments that aren't part of the commit message.
+------------
+
 
 OPTIONS
 -------
-- 
2.1.0.60.g85f0837
