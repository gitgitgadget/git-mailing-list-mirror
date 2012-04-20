From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Fri, 20 Apr 2012 12:21:41 -0700
Message-ID: <xmqqvckumcoq.fsf@junio.mtv.corp.google.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLJWA-0004Bb-9p
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2DTT3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 15:29:13 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:53660 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab2DTT3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 15:29:12 -0400
Received: by bkcjm19 with SMTP id jm19so474268bkc.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 12:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=aoeIgGr+o8lbyigcMcwRUnsska9F3b2zOHlzkZW4s20=;
        b=YG4tAZo8K0oAzOaFEk9q8c2ejroyvIQ2ZrcVQ0MWZmcWbPGr/ldGkRLFd1Y0E4jxWA
         TR0JabXZXlQrJAPKiC6kNu59fWT9AIhr5R8rSWYyeuHnURAE/oywgYEd+MBDkrENkemw
         NSixFrhfRdmU5EWwasYmWldyMFAaRgmp76AVurGjIqlloOVgtGTA2vel4D4EKkqOOmXE
         5a7NC3HEOk2IPJEUuOXNjyxlnNQD8aFb8F8i2OEIH2rXw23zuKyOGhQuB+DLr+PvlEC6
         4Ml4F4n7rGFe67uzJDVqbeE7XpukodZPmthtRlvCvsK4b6vNPNL+SHJrIoH0U74nnvjg
         c9dQ==
Received: by 10.14.47.80 with SMTP id s56mr2098749eeb.6.1334949702808;
        Fri, 20 Apr 2012 12:21:42 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr2098728eeb.6.1334949702683;
        Fri, 20 Apr 2012 12:21:42 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si1322812eef.1.2012.04.20.12.21.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 12:21:42 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 7AAB75C0050;
	Fri, 20 Apr 2012 12:21:42 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id C48C4E120A; Fri, 20 Apr 2012 12:21:41 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmyqf+fjZBCFFkY8YeIyLeSJQGgTdlE11sTLZ1v8vmzb//rlBWWGqWqlN41nYv0MTUTEcKM/qEV5S3dpqZ3gowcqpvSi5ia3e7dTPbM76EfxaH4u044v+itezWQWLxxufrIpengOtLrskXbvZtNHMJU09op2OX6T5FEy09SSQhoroxqa4Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196013>

Looks good, modulo perhaps these fixes on top.

 - It would be better to say "dropped" to stress that we inspect and
   actively discard, instead of saying "ignored".

 - There is no need to use "changeset", the term glossary even
   discourages, to make sense of the sentence.

 - There was still a stray keep_if_made_empty.

 - s/Add keep/add keep/ on the title as well.

No need to resend, unless you have fixes other than the following does.

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 0c004e9..3d25a20 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -113,12 +113,12 @@ effect to your index in a row.
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
-	previous commit are ignored.  To force the inclusion of those commits
+	previous commit are dropped.  To force the inclusion of those commits
 	use `--keep-redundant-commits`.
 
 --keep-redundant-commits::
 	If a commit being cherry picked duplicates a commit already in the
-	current history, it will result in an empty changeset.  By default these
+	current history, it will become empty.  By default these
 	redundant commits are ignored.  This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
diff --git a/builtin/revert.c b/builtin/revert.c
index f135502..b0b9b1a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -141,7 +141,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--abort", rollback,
 				NULL);
 
-	/* keep_if_made_empty implies allow_empty */
+	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
