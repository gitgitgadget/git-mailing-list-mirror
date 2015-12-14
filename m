From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] submodule-config: drop check against NULL
Date: Mon, 14 Dec 2015 14:54:19 -0800
Message-ID: <1450133665-3783-3-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:56:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c2A-0001oa-3O
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbbLNWzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:33 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33049 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbbLNWy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:54:59 -0500
Received: by pfnn128 with SMTP id n128so113007487pfn.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4vc3/q05nWHHT0vVm5lT4T4Hc9gtyYoHc9oKMLAYwQ=;
        b=Vhzhilycfld7Y4ZdPd56vGjqP+zV7pf+fST7PiNXVkqdtFZYdgARcqJPCdwFt1LfDz
         T2euAdMtxAMoI2DtWFLZTiSDE7x+ZdfmfAF1Cx/9OgCEINT6a0AxZ1MVTNibDMUNSmzd
         0cuqcEVukZJnniiwV0gZrEsnx1xELFkW7kjKMHKw9dzGXInQlZuf2ZSb3Lbijl4woy8y
         /agtDSQypxlDU3QLwz9bDCE/KnYFkS2vPanbCM8tU7JH2cIYBnC2Iw0yBeKIniIcHiHY
         zSabZgu5w8BHpe+mWhJcx42iqHWWZCojfnhColUAnLKNs6ODvFjL0ACf95JlpSXCWVIt
         G1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4vc3/q05nWHHT0vVm5lT4T4Hc9gtyYoHc9oKMLAYwQ=;
        b=LHo6ugXsQhcIX5pDMcOl9LdIdCOpGQpjzz4nOfU59C1j58fPhfJDTAv0z8ID/XRsvW
         ldVB3WkwW+mpWIqjiQ0fLpL+GKXcUPkEvDMymHBjKWTHcYKW8yABG8LwbgoAfhZ236GR
         n+l/cIGOJU28gWcHRM30NDSFjS+L9UpUIPhz/adiL4WMeAALczJvAcY5d/4h0owUNYB4
         qq4XzmB0uuJmsVzMquwntMt3mjVrekgJ3pACTYkusxw4s6BD1d+sxg2C45oQ9shIU+Ja
         U2NzlBIXJobS96FJSh9fRC2quiaW8TaLZUSVYzBz5BBkVXGd7PtQn9oKSHiFEzbhKanI
         V9cw==
X-Gm-Message-State: ALoCoQkFXyInDEEYzUdvVnukMvF1s9zx1rQFD8BHUaIHnjETFW6HoqZ0mMqF1gVG3Vn4LwLW9OVE/ZPXjNRhhu89k3CUg+Uraw==
X-Received: by 10.98.13.154 with SMTP id 26mr39905779pfn.149.1450133698715;
        Mon, 14 Dec 2015 14:54:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id qy7sm45020913pab.37.2015.12.14.14.54.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:54:57 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282441>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4239b0e..6d01941 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -265,7 +265,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -289,7 +289,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -305,7 +305,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
@@ -315,7 +315,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->update != NULL)
+		else if (!me->overwrite && submodule->update)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "update");
 		else {
-- 
2.6.4.443.ge094245.dirty
