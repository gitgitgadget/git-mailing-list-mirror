From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/6] push.c: add an --atomic argument
Date: Wed, 17 Dec 2014 10:32:56 -0800
Message-ID: <1418841177-12152-6-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418841177-12152-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPU-0000RE-AV
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbaLQSdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:11 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35816 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaLQSdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:09 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so15738995iec.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eygHmWA0Q51yQPowOft1DxU3NmKRAv4C14yIVWuJz/4=;
        b=NEWt/ZsV5GlUtpmuc0w8uFfh/9Clg+mGBsboA0/4bF6PucuRHnIwKlW4iigZ0S2HaR
         N65XtgEPF4bUDpcDs9vz74GRNQ/f6i5H7I9Khkr+lpZ/gD1HblT/li1B3XRSRRNRgh6h
         Ewj7UiZY4gJN9jAEeqFXOvUJfB+rQENjK0Vj1rkly7T1uQshiLKFOPQ5PKs9x1qBkaiG
         xA4hQxdO7MCFJ0gtiUiXlHxdP2kQEs9HKTjp3Oj7nCZ9m3Pk3iRgbZsapoOWqKrSkhjN
         IMykFp3yEJctiG9LEvxxHpredpvWesjX7FGW+kWDBw75cd/LCIv3SjeRfYGVxBBgrEFG
         eLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eygHmWA0Q51yQPowOft1DxU3NmKRAv4C14yIVWuJz/4=;
        b=f/+cb/6vWsQb6NptL43T+3To9iBQQNLx08Dlmer4zyh5lgceeVd2nqySBtZr3wu8Kv
         JT9oPrk/Sg2n53FQb8xz01Pxt17ztpb/t+NgGAWmfoYMwAktsl2XwPcr4sKt97n5yOzC
         66HKR0t286dxVCdwkSBGOUs9bKNag/YNrmh1rnQQBY5TE0wj3sv3k8KKzrp+GZGJRjjq
         GotpM2JV/Q+Ws+HNFbhfUhP9DSDSPEw3YdfQsPzT6AX9bNw1bPxFUqyUicwAgZGBLrJh
         Z1NZIX1pUVl1RcdqbWV/9rbGogjpzBrU0qN0mMY/5yU7tJxh+xB9BGmikgEV4VNqLVyo
         epUw==
X-Gm-Message-State: ALoCoQkjISpABZ3IodkFzUHPTVKvQldSWN/9xpAlCTwAB86Ri5bdUq5qcCsiUYVEkO/tN7zhhdI+
X-Received: by 10.107.129.80 with SMTP id c77mr7621178iod.92.1418841189009;
        Wed, 17 Dec 2014 10:33:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id p198sm2114830iop.36.2014.12.17.10.33.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418841177-12152-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261490>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes v1 -> v2
    	It's --atomic now! (dropping the -push)
    
    v2->v3:
    	* s/atomic-push/atomic/
    	* s/the an/an/
    	* no serverside, but just remote instead
    	* TRANSPORT_PUSH_ATOMIC instead of TRANSPORT_ATOMIC_PUSH

 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 2 ++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..da63bdf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
@@ -136,6 +136,11 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--atomic::
+	Use an atomic transaction on the remote side if available.
+	Either all refs are updated, or on error, no refs are updated.
+	If the server does not support atomic pushes the push will fail.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index a076b19..5731a0d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "atomic", &flags, N_("use an atomic transaction remote"),
+			TRANSPORT_PUSH_ATOMIC),
 		OPT_END()
 	};
 
diff --git a/transport.c b/transport.c
index c67feee..1373152 100644
--- a/transport.c
+++ b/transport.c
@@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/transport.h b/transport.h
index 3e0091e..18d2cf8 100644
--- a/transport.h
+++ b/transport.h
@@ -125,6 +125,7 @@ struct transport {
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 #define TRANSPORT_PUSH_CERT 2048
+#define TRANSPORT_PUSH_ATOMIC 4096
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.2.0.31.gad78000.dirty
