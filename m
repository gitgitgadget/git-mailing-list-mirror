From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/8] submodule-config: parse_config
Date: Wed, 28 Oct 2015 16:21:40 -0700
Message-ID: <1446074504-6014-5-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra31-00039f-VS
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbbJ1XWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34950 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbJ1XWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:04 -0400
Received: by pasz6 with SMTP id z6so20295997pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZfpGNeaHFdzsompir9Uzld2dQUSVaywjlg/L7Jvc8A=;
        b=gnSf9acNMvKxqoiGPlwg2yx7PZX2zFWhnYb+bHj4JB2rizBdHW4xzTJjG/QsOu6HOy
         lXMFJzXualep5aytqRe8Sm535V11QSmGRLrRfQ2ctV8CyrbVrzftSsQFLGprdH1sd/ze
         Fcyz2lSAhxHXZGY/D86FnjLJDAYXncEusDX3CRiTR9Qcm9v99mmVUITKqaukfDOFtsGO
         NF7gLtzYPBFHJkDEJLb/xnedwZW0B9JL4E3+fmjxGNOVLvSsiPR6yBe+YQ+3NIIsR7wx
         r9WKeVXzV5eW9XuhHvzGG6VKuNAJPSowNmFr05ql1UvzImk7ljVuhfU+o+yYfgJ/L3jU
         lDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZfpGNeaHFdzsompir9Uzld2dQUSVaywjlg/L7Jvc8A=;
        b=Uz151xWvC3TYH1YXfAIhqjTkL+UVjqYmDf/rz4gTuf5OrJ86pO7geDwAMIkqmUTkWY
         MENpw67U7JXlPl2XAOGmx4HblJe+hMhmXbPIw6eWWifEozIdwS6CILrnNxt9NGf5B/uw
         401Sxewe/urKLdvygpWd2Lr7cvaZRL2s3yCUsclJiQTkkN8Ty+ARDpAyacIQfDYVkNmW
         9duIQEoXGN9xQs4QhbHi25cNecxcJp3VYEN1h8FeZA9r1wgHMexmsN/RwbvbobdIQaKV
         rcXpfgK0lYByOQY/bZQY/AoKoZsQRAuTG3AqKGbh/ivsFCYQ4Eh8VffU8iS4Hc+xw2IF
         mv6Q==
X-Gm-Message-State: ALoCoQnAXg9LOv6+Zg5X0suMjLtn/+ujnZBp/rqXhtDfmPfYNJl8lWRb1Tt0gLc5vwt7d2nrZR6L
X-Received: by 10.68.221.133 with SMTP id qe5mr37582950pbc.93.1446074524309;
        Wed, 28 Oct 2015 16:22:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id ph8sm47424530pbc.8.2015.10.28.16.22.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280428>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.jobs".

Signed-off-by: Stefan Beller <sbeller@google.com>

# Conflicts:
#	submodule-config.c

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 58 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4d0563c..1cea404 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -231,27 +231,23 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_generic_submodule_config(const char *var,
+					  const char *key,
+					  const char *value)
 {
-	struct parse_config_parameter *me = data;
-	struct submodule *submodule;
-	int subsection_len, ret = 0;
-	const char *subsection, *key;
-	char *name;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0)
-		return 0;
-
-	if (!subsection_len)
-		return 0;
+	return 0;
+}
 
-	/* subsection is not null terminated */
-	name = xmemdupz(subsection, subsection_len);
-	submodule = lookup_or_create_by_name(me->cache,
-					     me->gitmodules_sha1,
-					     name);
-	free(name);
+static int parse_specific_submodule_config(struct parse_config_parameter *me,
+					   const char *name,
+					   const char *key,
+					   const char *value,
+					   const char *var)
+{
+	int ret = 0;
+	struct submodule *submodule = lookup_or_create_by_name(me->cache,
+							       me->gitmodules_sha1,
+							       name);
 
 	if (!strcmp(key, "path")) {
 		if (!value)
@@ -318,6 +314,30 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+
+	int subsection_len;
+	const char *subsection, *key;
+	char *name;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection_len)
+		return parse_generic_submodule_config(var, key, value);
+	else {
+		int ret;
+		/* subsection is not null terminated */
+		name = xmemdupz(subsection, subsection_len);
+		ret = parse_specific_submodule_config(me, name, key, value, var);
+		free(name);
+		return ret;
+	}
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.5.0.281.g4ed9cdb
