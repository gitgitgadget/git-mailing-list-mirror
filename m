From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] string_list: Remove string_list_insert_at_index from its API
Date: Mon, 24 Nov 2014 13:22:04 -0800
Message-ID: <1416864124-15231-3-git-send-email-sbeller@google.com>
References: <1416864124-15231-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, marius@trolltech.com, julian@quantumfyre.co.uk,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 22:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt15X-0006lk-OI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbaKXVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:22:17 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:39261 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaKXVWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:22:15 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so3892430igb.5
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TgIGdBs0hsgu3MKHf1uoBV2Vn/gbeiOg6443A9/yWVA=;
        b=EWIVgz3wFfHV4aAY2kob4VrjNxmbLS25j88tBa3OV0W5nsMd0nNOG3Boc/Lm38rrWO
         y7QCYL05qneTJiAfaZP2y0oNhlMpg0Szu1CU24MT2mMruPnq2OzbF7KjsfgLWKBSS1I6
         AMwV9BoO9SVLccophxasq5z8hT48ZaBtVqNJAUWVvcuWDiprpUUWk+Nr4WAOYaonWgwT
         rgQoCjF8/oDalQcZjELDLyImzJG8t94QFn35q/lonNcS/Ow2WEGqwnV+c4lGs6TuAvMQ
         fyGhVxweM1ukOZjAxAQZn0r/egfj1lJ8cbH3zTpVxR1mZ6nlPdMe2Ftfokez9DI3KuKK
         xSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TgIGdBs0hsgu3MKHf1uoBV2Vn/gbeiOg6443A9/yWVA=;
        b=I5RKarE4Uy9ktMmdDWEXlTKWmrISg1r7LQfVXaHF1TB6oHsJsnoSC2l0m0qg5VAAKA
         mTlI7CsxIhTHakFgHgKqqYrKyWSLbjduP5pezyylKKeULFl6znxybUFHV7eSsdxlYntX
         9mSLzNlOaibvf83uvSC+aUUxQoD6D4v9m5tieeOinlCp1v92/tcx2ARkkmZbrnotwq0m
         Bn48o8RVEU44QkDFPgwzTekSaKLeMYgd+OjdO/zpy0iC41S+EUthHUJLnqLw51qvpqTu
         jzkrIEnFSYKLZGxtDEYFO+lUeL9Sh8BdaCVsxIOUMfkHOTKmJ0VB0AKU724tyMElmBeC
         uDZQ==
X-Gm-Message-State: ALoCoQlLZecmNIMJ7Z1k2QfYYlPWW1LMJdEIMPneLWm4BsU1AXc3nTAAshIawRHhOWdFsNPk5Kj9
X-Received: by 10.50.78.164 with SMTP id c4mr12636269igx.1.1416864135178;
        Mon, 24 Nov 2014 13:22:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:413f:9e9a:731:9749])
        by mx.google.com with ESMTPSA id c1sm5045386igo.17.2014.11.24.13.22.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 13:22:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1416864124-15231-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260149>

This function behaves the same as string_list_insert, just the
starting indexes for searching, where to insert into the list is also
a parameter. So if you have knowledge on where to search for the string
to be inserted, you may have a speed up version of string_list_insert.

As we're not using this function throughout the codebase, get rid of it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 8 +-------
 string-list.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/string-list.c b/string-list.c
index c5aa076..9584fa6 100644
--- a/string-list.c
+++ b/string-list.c
@@ -59,13 +59,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	return string_list_insert_at_index(list, -1, string);
-}
-
-struct string_list_item *string_list_insert_at_index(struct string_list *list,
-						     int insert_at, const char *string)
-{
-	int index = add_entry(insert_at, list, string);
+	int index = add_entry(-1, list, string);
 
 	if (index < 0)
 		index = -1 - index;
diff --git a/string-list.h b/string-list.h
index 40ffe0c..ee9b100 100644
--- a/string-list.h
+++ b/string-list.h
@@ -61,8 +61,6 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
  * Returns the string_list_item, the string is part of.
  */
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
-struct string_list_item *string_list_insert_at_index(struct string_list *list,
-						     int insert_at, const char *string);
 
 /*
  * Checks if the given string is part of a sorted list. If it is part of the list,
-- 
2.2.0.rc3
