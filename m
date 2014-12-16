From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/6] push.c: add an --atomic-push argument
Date: Tue, 16 Dec 2014 10:49:06 -0800
Message-ID: <1418755747-22506-5-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418755747-22506-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 16 19:49:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xBa-0005n1-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaLPStV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:49:21 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36748 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaLPStT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:49:19 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so13516379ieb.9
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zmIAhr6QxQfTyYeycGFjdoxiBRTbJvhrKVyEeEvjjIo=;
        b=VlTazE/78Ba4LA1lIRJ8TNZ/B2wQwW5jRG7uza1kiJ2lRbTwdJyLa3A+Cd65fgc71b
         cCJ6th7pRCs+5YT4Ut11/pDbaIxXejgvTOJSxZhm38NZgDDSgPJR1d6ICFKOhQoob5HB
         3SwAA4JHczEeZzq6pwu4RmTCZNTIpJFeGC9kn8VeqQegg2G8WW7OiVbduM5j/8YKEmvl
         niexMhw3c3bvZ2t25c8fm4Us9bcM84yOOyIeGHbF3XJXDG27kdyXKs3ml4b54bnSdWCs
         ewFc2YNJKfGIskuzaV6PFWAQBF3fGeTx2LBb1YSjU3i1wVW51/TxelXPrUti1NnfCXUB
         vGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zmIAhr6QxQfTyYeycGFjdoxiBRTbJvhrKVyEeEvjjIo=;
        b=ErGMrer/bS3n1oqrNZTRtjm5m6QxGl37C3ZWOJOVaoo/+pbx8ghUEusjPlGyGUJtaj
         u5Vaswwk5m7zA09V16xxDisx75zX6iO3tAlRf2FVpcZO4E7cXBiESKYjpL98yMLS9lyy
         MzqjXYjimqZ1sl1haNbJwOZ0RSMbkZ7kLfbbhqQ978qReCgLi3zviZxv/cBRwsSP+54o
         lviabZsRdlx7+SNGwxML1/H2MAAfMb9yLnxTIxVO/jOg1YuiJxPVEQPT4eWZCYG2cNam
         TdG1f83fe+jLc3I39myAvxDHqBTNSqXCXlNwzqXZS0J8MVAm2qpCoYuEM0AcyZEvNEdk
         ItZg==
X-Gm-Message-State: ALoCoQm2chx89ae62224Ffg6YDlXToHPdfxzs7wFwBBxm7Cc0FQlU9KzA8F5hFCMKYmWaHZSFXwP
X-Received: by 10.50.142.68 with SMTP id ru4mr1640846igb.25.1418755758869;
        Tue, 16 Dec 2014 10:49:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4db1:657a:aafa:5d88])
        by mx.google.com with ESMTPSA id r18sm628775ioi.28.2014.12.16.10.49.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:49:18 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418755747-22506-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261444>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes v1 -> v2
    	It's --atomic now! (dropping the -push)

 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 2 ++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..3feacc5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic-push] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
@@ -136,6 +136,11 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--atomic::
+	Use the an atomic transaction on the server side if available.
+	Either all refs are updated, or on error, no refs are updated.
+	If the server does not support atomic pushes the push will fail.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index a076b19..fe0b8cc 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "atomic", &flags, N_("use a single atomic transaction at the serverside, if available"),
+			TRANSPORT_ATOMIC_PUSH),
 		OPT_END()
 	};
 
diff --git a/transport.c b/transport.c
index c67feee..5b29514 100644
--- a/transport.c
+++ b/transport.c
@@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.atomic = !!(flags & TRANSPORT_ATOMIC_PUSH);
 	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/transport.h b/transport.h
index 3e0091e..25fa1da 100644
--- a/transport.h
+++ b/transport.h
@@ -125,6 +125,7 @@ struct transport {
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 #define TRANSPORT_PUSH_CERT 2048
+#define TRANSPORT_ATOMIC_PUSH 4096
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.2.0.31.gad78000.dirty
