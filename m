From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] Add treap implementation
Date: Thu, 12 Aug 2010 17:11:15 -0500
Message-ID: <20100812221115.GJ2029@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100809221734.GE4203@burratino>
 <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojg16-000221-4e
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933978Ab0HLWMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:12:47 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36926 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760920Ab0HLWMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:12:46 -0400
Received: by qyk9 with SMTP id 9so470515qyk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Mt18gny67zxbCEjeo3xuTfCHj9ZnttCBFQ14flQBZ44=;
        b=sim0Vo3sfEhrFTtxTxBSeVYsDKJAbCrBFEQRHR+uwYZWf1jlFvf8rSANvrisu7S+va
         fT8Bcs84vsrGEMAnrZL6G6UShrXm/m1OZnoz6yBg9dzKr9iydhcWuIzduzrH+jP9LRCW
         1mwmnQBRz1CX/lqMgUlfFN6De6z5kdA0Dou0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WXPgFYfuEPTI+FNe9Wt0kkTT5u7Apr1Rw6gEU6wYewB7wYN8MzepBlIAuSrWA7RhQM
         A7RYw2fY6spjKVKtOagaxEQPaotIC57oEviCaRZlOg+yVG4W9N2IZcNGf4j9geIFZD4+
         gHNpuKTEoL1zcmjKBEy16KeLeqOH8fWVE0CMg=
Received: by 10.224.28.71 with SMTP id l7mr394114qac.387.1281651165735;
        Thu, 12 Aug 2010 15:12:45 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id w6sm811767vcj.27.2010.08.12.15.12.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:12:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153429>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +#define trp_left_set(a_base, a_field, a_node, a_left) \
>> +	do { \
>> +		trpn_modify(a_base, a_node); \
>> +		trp_left_get(a_base, a_field, a_node) = (a_left); \
>> +	} while(0)
>
> Need SP after "while" (there are other occurrences).

Here are a few more (but feel free to ignore them).

-- 8< --
Subject: Standardize do { ... } while (0) style

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 base85.c   |    6 +++---
 cache.h    |    2 +-
 diffcore.h |    8 ++++----
 http.h     |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/base85.c b/base85.c
index e459fee..781b575 100644
--- a/base85.c
+++ b/base85.c
@@ -7,9 +7,9 @@
 #define say1(a,b) fprintf(stderr, a, b)
 #define say2(a,b,c) fprintf(stderr, a, b, c)
 #else
-#define say(a) do {} while(0)
-#define say1(a,b) do {} while(0)
-#define say2(a,b,c) do {} while(0)
+#define say(a) do { /* nothing */ } while (0)
+#define say1(a,b) do { /* nothing */ } while (0)
+#define say2(a,b,c) do { /* nothing */ } while (0)
 #endif
 
 static const char en85[] = {
diff --git a/cache.h b/cache.h
index 68258be..37ef9d8 100644
--- a/cache.h
+++ b/cache.h
@@ -449,7 +449,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 				alloc = alloc_nr(alloc); \
 			x = xrealloc((x), alloc * sizeof(*(x))); \
 		} \
-	} while(0)
+	} while (0)
 
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
diff --git a/diffcore.h b/diffcore.h
index fed9b15..05ebc11 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -98,7 +98,7 @@ struct diff_queue_struct {
 		(q)->queue = NULL; \
 		(q)->nr = (q)->alloc = 0; \
 		(q)->run = 0; \
-	} while(0);
+	} while (0)
 
 extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
@@ -118,9 +118,9 @@ void diff_debug_filespec(struct diff_filespec *, int, const char *);
 void diff_debug_filepair(const struct diff_filepair *, int);
 void diff_debug_queue(const char *, struct diff_queue_struct *);
 #else
-#define diff_debug_filespec(a,b,c) do {} while(0)
-#define diff_debug_filepair(a,b) do {} while(0)
-#define diff_debug_queue(a,b) do {} while(0)
+#define diff_debug_filespec(a,b,c) do { /* nothing */ } while (0)
+#define diff_debug_filepair(a,b) do { /* nothing */ } while (0)
+#define diff_debug_queue(a,b) do { /* nothing */ } while (0)
 #endif
 
 extern int diffcore_count_changes(struct diff_filespec *src,
diff --git a/http.h b/http.h
index a0b5901..173f74c 100644
--- a/http.h
+++ b/http.h
@@ -23,10 +23,10 @@
 #endif
 
 #if LIBCURL_VERSION_NUM < 0x070704
-#define curl_global_cleanup() do { /* nothing */ } while(0)
+#define curl_global_cleanup() do { /* nothing */ } while (0)
 #endif
 #if LIBCURL_VERSION_NUM < 0x070800
-#define curl_global_init(a) do { /* nothing */ } while(0)
+#define curl_global_init(a) do { /* nothing */ } while (0)
 #endif
 
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
-- 
1.7.2.1.544.ga752d.dirty
