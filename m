From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH rr/fmt-merge-msg] merge, fmt_merge_msg --log: default value
 is DEFAULT_MERGE_LOG_LEN
Date: Tue, 24 Aug 2010 21:44:40 -0500
Message-ID: <20100825024440.GD11619@burratino>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-2-git-send-email-artagnon@gmail.com>
 <20100823220031.GA1308@burratino>
 <7vzkwcvsm5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 04:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo60l-00047X-9r
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab0HYCqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:46:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47657 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545Ab0HYCq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:46:28 -0400
Received: by qyk9 with SMTP id 9so4407728qyk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9i0ume44s2Ux1qhwCM7cPGqLfE81I3LTly0iN7/r9xk=;
        b=oFZiMKolpBfHO5wWiSSlcYhSQ7yeWE0HpQD3wYDfWwVkBKMfQkjfMitSL3tLi/YdbA
         CbfLSy5WuFMEKbha2pzhHxIgs4Dz+XyXj/nvbnzQeqBqTKvPr1CyclL2B8DR3+e0pidv
         YMY+ag4PEjsvJjUURDoSAGrozUfYl30b/UzA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wq6D9obeT10DeQ9HBsKDoS84uG2YPqXc64wk44cGu6Fqxus41b2TmK1cCKOcFf3Y7d
         2ge+4hDFei6KWA+QTllp2oxGKiFzUkeSx6fOvCOlmY08sWZQMrcldqDrPL0EtAN3mv9D
         JdD2dlwesS6V2VV0bXXT8W5Lp4kYoZ/iDkEOY=
Received: by 10.224.65.228 with SMTP id k36mr5139065qai.35.1282704387873;
        Tue, 24 Aug 2010 19:46:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm972344qcq.22.2010.08.24.19.46.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkwcvsm5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154393>

Most references to the DEFAULT_MERGE_LOG_LEN were changed to use that
symbolic constant, but a few uses of hardcoded "20" remain.

Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed this while looking over ab6beee (merge: Make '--log' an
integer option) from pu.  Maybe something like it could be squashed in
in the next round.

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 425900d..bc7c30f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -323,10 +323,11 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
 		  "populate log with <n> entries from shortlog",
-		  PARSE_OPT_OPTARG, NULL, 20 },
+		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
 		  "alias for --log (deprecated)",
-		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL, 20 },
+		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
+		  DEFAULT_MERGE_LOG_LEN },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
diff --git a/builtin/merge.c b/builtin/merge.c
index bf550a6..9e4733d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -177,7 +177,7 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
 	{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
 	  "add (at most <n>) entries from shortlog to merge commit message",
-	  PARSE_OPT_OPTARG, NULL, 20 },
+	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 	OPT_BOOLEAN(0, "squash", &squash,
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
-- 
