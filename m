From: Stefan Beller <sbeller@google.com>
Subject: (unknown)
Date: Tue, 17 Feb 2015 10:27:08 -0800
Message-ID: <1424197628-568-1-git-send-email-sbeller@google.com>
References: <xmqqoaos2yn5.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 17 19:27:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmrd-00030j-7u
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 19:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbbBQS1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 13:27:13 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37117 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbBQS1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 13:27:12 -0500
Received: by iecrl12 with SMTP id rl12so40530523iec.4
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LrKIbfmg0tov3T54wEJtYcXmDMk/7kc1eW7fVDTPP5o=;
        b=TCFU6BXH3C5l9vcEmpfs12y2cn4ALnHZvJ9m4GyfXrG3/EMs3j8Gc6pJLjQsVBZVz3
         N5U89zxSXyVbglmFGjRkiQyvtbXGCWWBl7UNSziW5Q8hyGH2999dvjp6Xt0BbtaN4JSZ
         HwgSH7Yvq0tYlFhueNewB7cy1xzDOqv8w0QQJJhdjx9ZPrIadcbVJRYBdXp5Fs5pnBtb
         9tzs7SbGFr2axeTgYNLKY/7EUtUKWwMlsYNN4bdqasrla/Fd4UkbGMz3briDjZ4ytsp0
         dMx42OhpbK7af57KQlo9cq1c/gVFqUrWeJFerVOkd9vnOjLv2aUSYrIwBMJ7o94Pjwhy
         S7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LrKIbfmg0tov3T54wEJtYcXmDMk/7kc1eW7fVDTPP5o=;
        b=QN6wowz8pquN9sPjsXcXzNUJ2n+H2LHuKxsfz5PsUtPvfplyQLdZhLGKfItRPnBYdu
         w0xwthBST22ReKtz15mdyA8UIrWPSpZVAsA2dvD8eTPR/r18EOFMEF95g/+3pZpv0j8w
         YppRTZ91uukHhXXJRE7VxvdqOkWfBS+EZfffLXu3vt0yqZ30tI/isswD84NOQMkKkTWd
         T1SLhh4GwELexkNUs9e6LsqJrVe+0FLmXtWh+QkQxc+DTT/iohA3rm8j+OIqK22rpJKv
         3xwYAOXp7OZNGU5K42r+Eb9N4fkXo3BszWK2gTcefPXu9GUmT2EpG4eVEJJvtS+yUZdP
         yIsw==
X-Gm-Message-State: ALoCoQmN8RN/+FVP4tZl0ix9iBeeXwxYMh/DiihuOKD0nZIRCxpkMCN0v3j9Bk1q36K5XJpJhWS1
X-Received: by 10.42.13.193 with SMTP id e1mr34325496ica.59.1424197631434;
        Tue, 17 Feb 2015 10:27:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d457:48b:a341:557a])
        by mx.google.com with ESMTPSA id s17sm10497447igr.2.2015.02.17.10.27.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Feb 2015 10:27:10 -0800 (PST)
Subject: 
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <xmqqoaos2yn5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263975>


On Tue, Feb 17, 2015 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This fixes a memory leak, when building the cache entries as
>> refresh_cache_entry may decide to return NULL in case of
>>
>
> in case of what?

Yeah, I got distracted when rewriting the commit message as I was 
looking at refresh_cache_ent() wondering if there is a better place to 
free the memory. Just as you said below.

Maybe we can drop that part of the sentence as it doesn't matter
why refresh_cache_ent() returns NULL. All that matters is the 
possibility of it returning NULL.

>
> I briefly wondered if refresh_cache_ent() should do the freeing but
> that does not make sense at all if done unconditionally because the
> other caller of the function does want to retain ce on error, and it
> makes little sense to invent FREE_CE_ON_ERROR bit in refresh_option,
> either, so this fix looks sensible.
>

So here is a reworded commit message:

---8<---
From 3a1f646c1dbe828b68e1b269290d2b5593f86455 Mon Sep 17 00:00:00 2001
From: Stefan Beller <sbeller@google.com>
Date: Tue, 17 Feb 2015 10:05:36 -0800
Subject: [PATCH] read-cache.c: free cache entry when refreshing fails

This fixes a memory leak when building the cache entries as
refresh_cache_entry may decide to return NULL, but it doesn't
free the cache entry structure which was passed in as an argument.

I am not sure how severe this memory leak is as it was found by
scan.coverity.com, CID 290041.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9cff715..8d71860 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -725,7 +725,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 		unsigned int refresh_options)
 {
 	int size, len;
-	struct cache_entry *ce;
+	struct cache_entry *ce, *ret;
 
 	if (!verify_path(path)) {
 		error("Invalid path '%s'", path);
@@ -742,7 +742,13 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	return refresh_cache_entry(ce, refresh_options);
+	ret = refresh_cache_entry(ce, refresh_options);
+	if (!ret) {
+		free(ce);
+		return NULL;
+	} else {
+		return ret;
+	}
 }
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
-- 
2.3.0.81.gc37f363
