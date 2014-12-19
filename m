From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] push.c: add an --atomic argument
Date: Fri, 19 Dec 2014 11:39:00 -0800
Message-ID: <1419017941-7090-7-git-send-email-sbeller@google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23Ol-0005nE-5a
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaLSTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:24 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:48617 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaLSTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:20 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so1200103igi.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+p+OvDo4sZ4qYI4Y32QlyDYBlnMmoVBrCzJEB/UiVQ=;
        b=W8gfF5oAdb/eegvB+sHv5HqcagUgyIVm98bfacMMojyjZedRHHkCANS1UeplDVdksk
         sR0luZMLXaQ0XqfPvtN1wvSV39epfhae3lex81oOP7Abka3R0B1rdZdip44EAoV2/GpQ
         UsspaigcruF4zEM2YJGTJ/EOMlF+o41Xu38mnS/N0xIcOhHRZhuKOoEYrP2K7X8l+tHq
         DOoP4uB71dIbLhQweq2v7L7pkX25843sg0NCPPTRwc8j88oL+1z7t+f96m9il9KNR1mD
         ZW5Qhot1xTVFVn0dpY5gITp8kadE1Ojggoy6xPOm0dlrzzGlarexra0YVdDr0hXvfU7D
         xiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+p+OvDo4sZ4qYI4Y32QlyDYBlnMmoVBrCzJEB/UiVQ=;
        b=AHxC3WkeOIaS0XNPSdZbItOgaqm/Au0emOilZ0/U0WTeWqeazdpvvba9Bc/GQwUv18
         AwHrtoH4cB3S+LMK6r6k+qXx/P7z3mv2WMgYAfCaM6tMiey6fPkvHwb3OvvOphmdKYgD
         YypJ7o2bnnYe9w0XdufIHLaIutUMKyhLHLbeoGPuDhDHT1xcwM/2Ooc7YtHRwisr5wz+
         OF/IvFpQfrP3B3Gz4pzN/vHBEvxt/V1VH42DaGQh+yT7GW8CQpfm1hw3lsoll8R1ouv0
         BNr468ITcTwg9oKV4EOPCfsn3WjYDnVvYzgQySrZB8Ls1724+SR+DAo5w5UKw2GWBmpR
         KnjQ==
X-Gm-Message-State: ALoCoQlcweR6xcwyt3dEI+c/sFRnOZzRDiCEVYVAOUBz/8daryTnJ6aUUuPN3vQcddR3wp1nDvms
X-Received: by 10.50.18.6 with SMTP id s6mr4949218igd.18.1419017959539;
        Fri, 19 Dec 2014 11:39:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id f1sm2477441iga.1.2014.12.19.11.39.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:19 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261593>

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
    
    skipped v4 v5
    
    v6:
    -		OPT_BIT(0, "atomic", &flags, N_("use an atomic transaction remote"),
    +		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"),

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
index a076b19..1689cec 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"),
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
2.2.1.62.g3f15098
