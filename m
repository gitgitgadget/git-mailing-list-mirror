From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] string_list: use string-list API in unsorted_string_list_lookup()
Date: Mon, 25 Apr 2016 19:40:00 +0200
Message-ID: <20160425174000.24943-1-ralf.thielow@gmail.com>
References: <20160422173500.32329-1-ralf.thielow@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 19:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukUa-0005pt-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbcDYRkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:40:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35549 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbcDYRkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:40:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so23590255wme.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XnakXZWVaSjazHi/XE5eF2ZuasaLFnjBW6k2SwgvFUM=;
        b=oCUQtos1/5yaDS6w/VCZqNAEOIYrXpVdGQ8W+z8LSSNN1XYIbuq7WuBu078hH9Uok/
         JRZRvXWa+eP2Sc7UK20AZzGpWCPNudVA8Q/JKIPhPeDyqU22KAQNeiVBDpz/aaaT+aoX
         hFumqhzde5Xa6aUMD1QVyatti0gJYsX/lE0b8r8v0iWo+yf2fMUJd+B2noM73xrooxhM
         cYq4zE4Lf1XmJoH0qvYAaUwLV2mjBxTeUKeS7PXkEdY5kFz9inmRBSMe7uES4IW8W0vf
         xfvg+CIfG5ePUilNPzg+lL7XDb3QgEbAu5LhMiWzkdnOUXTmnzJUi/k+cf8fguuHKy9N
         Lv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XnakXZWVaSjazHi/XE5eF2ZuasaLFnjBW6k2SwgvFUM=;
        b=SrH+TlcaL95iXEfHFKVcghLG7OUCaTLKE69Nsojd2nhYYsk9uZaCWNDanURN5hVQJt
         RgwBSdqVsmbA/KI3NETu6wBU6JuafAoer0txxT0l9AtPXD/QTFOXldgywbGphKfYPizS
         8gMXenN7/6msoxhGYcNUMav6Ap64KGjqOCIhmRWJ2EJVROPJYXCvB52mG2cOvHcV5Nzj
         1SWQ2Ha22XCNNuyhyYeIZC99Wbr/eMqugkFrNU4G4Igy/0TidmuINo4aQeJi01eCJSkF
         alyq6cqmi+sS91ThAG/kz/+SCguVrIEDKsq51yrAtSF6O+KiSSDVBpm0HeRycfzqbwns
         cZ1Q==
X-Gm-Message-State: AOPr4FWsMhVVWtKM+TzENm2mbdxZyq8vMFy9C52NY3F7b7UFbu4eHKdUGdfEZwKYAlK1rQ==
X-Received: by 10.194.248.200 with SMTP id yo8mr35964667wjc.38.1461606007811;
        Mon, 25 Apr 2016 10:40:07 -0700 (PDT)
Received: from localhost (cable-86-56-27-240.cust.telecolumbus.net. [86.56.27.240])
        by smtp.gmail.com with ESMTPSA id r2sm24687521wjm.8.2016.04.25.10.40.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 10:40:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.430.g7c694c5
In-Reply-To: <20160422173500.32329-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292531>

Using the string-list API in function unsorted_string_list_lookup()
makes the code more readable.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Changes since v1:
- remove extra curly braces

 string-list.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index 2a32a3f..62d2084 100644
--- a/string-list.c
+++ b/string-list.c
@@ -231,12 +231,12 @@ void string_list_sort(struct string_list *list)
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
-	int i;
+	struct string_list_item *item;
 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
-	for (i = 0; i < list->nr; i++)
-		if (!cmp(string, list->items[i].string))
-			return list->items + i;
+	for_each_string_list_item(item, list)
+		if (!cmp(string, item->string))
+			return item;
 	return NULL;
 }
 
-- 
2.8.1.430.g7c694c5
