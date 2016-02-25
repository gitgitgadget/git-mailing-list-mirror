From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 02/11] submodule-config: drop check against NULL
Date: Thu, 25 Feb 2016 15:48:30 -0800
Message-ID: <1456444119-6934-3-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:48:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5eR-00088S-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbcBYXsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:53 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34773 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbcBYXsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:50 -0500
Received: by mail-pf0-f182.google.com with SMTP id x65so41121828pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhDAMJO8T6VhrAGSxj9wN/RW5qX7B5343VWv3q4zgjU=;
        b=Mn6/Lf5oPm0EHiENITMf04JfWBR/fIQk3b+DpqBV9EnQju1FgBbmiUcYogI/7qGYx6
         YqDJRxSNWLi1nIQHifnKM6ctmRzOEKa/EbMfl1c7rQYKPjBfG5sKwsIl0OwUd5KlC+Rx
         mWVuDatOyw3Ef58T6NmKpI8TA3Alg4gkNMSRDqN732s+9onubDO+D0HUITJsl8/Rtxls
         EYJnrb6pxJV4U4jVGvWXMKUIX0GCHEBDLSb1+pHJvo0Qyn/7KUZIYE4NsnZ2cy6/65rU
         1ylN7NkxOWZQ+Jof1HdQ5UVm690e0CE6ySm0Hvue6dvQiE4VvcYYHfdT+VF+IxOKuaUF
         RdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhDAMJO8T6VhrAGSxj9wN/RW5qX7B5343VWv3q4zgjU=;
        b=IX2qIx0sf/zpuho3MPGdNP2APVBaBm9JwC791IKOAfDKAQWJfCBPpmjMG7vwPKhv2/
         Rv9+r14Fk4xpvIUuUO83xBTJqPun6MzDjeJ86FrDD9tSk6e0eUYk8qOutezH9Z+TQIqT
         vi5SmtQEhUOe26+hSaBQIjpjOaQoZrGUOWCHK1oydWWzCWfcncXEW7bGuLaKVdJgsSjd
         xQzkH6rENXu+a2dnN4GHusyz/ZA/cKYNGRalESbTgcj9SY4dR4bdd8IjziyAJhF8aw1U
         UIYPtqMatIKULhJeD9qCW/2ADc8iqLqYn3xS9//zKdzWVOYusAfar6Exy8UVw6dlILIe
         46rQ==
X-Gm-Message-State: AG10YOQDQhYdTuF6N4b3DizIl+/99iTziHG62OU7QhBVCWL2xvcIJ2XANr8uwr7waZiXVm3u
X-Received: by 10.98.11.134 with SMTP id 6mr67894064pfl.109.1456444129767;
        Thu, 25 Feb 2016 15:48:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id 82sm14576883pfn.89.2016.02.25.15.48.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:49 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287497>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index a5cd2ee..9fa2269 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -267,7 +267,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -291,7 +291,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -307,7 +307,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
-- 
2.7.0.rc0.36.g75877e4.dirty
