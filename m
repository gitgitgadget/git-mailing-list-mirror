From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 24/73] gettextize: git-checkout "Switched to a .. branch" message
Date: Tue, 22 Feb 2011 23:41:43 +0000
Message-ID: <1298418152-27789-25-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tl-0007ye-GN
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab1BVXn5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:57 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1BVXnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:55 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TOTo01pt4JAWCKe3ICWNlZnntxE5dCuFzMXUMn1FAFo=;
        b=tKN2K19/DZ0vjsxTjYlkynDxkKwEpTx7C/xwkNqiijxqLxZ3M/T7vDxRRKl4LSjYVi
         vz7agUUhXInh45ywMDEoDjjA4PDiCm1vyLAkqTKcj0B/X3GJbx+jy8pupcHNtlJAv0Ec
         d0OhA2UgmmP3VlxFmsxZ6dRTGKpYJW4g4P7xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=U6ELAqw2KbTFu4fxNd/Zh8YofRCJKaGkozVDJEr89kSyGRf1qYM+a1ABD4OVgXxO2P
         1qDZL4eWb8vxnaJKY4PLqtyiOtMq+5f7hnLaAzcO5dswwYj0hE4e45FJ4f7GhRBCEn6a
         wYPPssPC4JHNRzAm15N4leejuduUCcqFyiu1I=
Received: by 10.204.138.130 with SMTP id a2mr3020458bku.211.1298418235068;
        Tue, 22 Feb 2011 15:43:55 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.54
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:54 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167597>

Split up the "Switched to and reset branch" and "Switched to a new
branch" messages to make them easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f833330..2bb7759 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -550,9 +550,10 @@ static void update_refs_for_switch(struct checkout=
_opts *opts,
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
 			else if (opts->new_branch)
-				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->branch_exists ? " and reset" : " a new",
-					new->name);
+				if (opts->branch_exists)
+					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->na=
me);
+				else
+					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name);
 			else
 				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new->name);
--=20
1.7.2.3
