From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] hashmap.h: Use 'unsigned int' for hash-codes everywhere
Date: Wed, 18 Dec 2013 14:41:27 +0100
Message-ID: <52B1A607.5000509@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>	<52A37D70.3090400@gmail.com> <xmqq7gbd29vw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 14:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtHNf-0006Ct-A7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 14:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab3LRNla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 08:41:30 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:49026 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3LRNl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 08:41:28 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so3578680ead.24
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+A63Dgnf5K/GusmONs4E+6Rw+nTUvZqBro25Xf26+OY=;
        b=rNre14qF7+VKVad7RiFEKcyJFXhySOKkImzHmE+n3Egotdc/Mxu9mf68UAgG1PAlcf
         gyC7s8VcoXTGCX8jP0DB+f+55VXl2a+T8E18avhTpJScKsi5WnXHxswlTEGlSFPWmGAy
         Dmoxk6yUqKsh+qY/gp0teqX7UPZiQPjzKvIsqsDxo00S+8VomPZCXeX8qhdL/hppI7RP
         UT/Ao3zLUV+NB0wHIgu4CuV7QHZ3S52pB1vatJWAajWRCJoaj0MCqBrAhWDGepkCGBzO
         e8MsmMNnVl0Dl5EkWMMRZz54IerdJHTU1WvsNdIo50PaOO/7kkgLr/lzlmOAMJ1bGHcY
         rScg==
X-Received: by 10.14.179.130 with SMTP id h2mr29452202eem.34.1387374086917;
        Wed, 18 Dec 2013 05:41:26 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e3sm162086eeg.11.2013.12.18.05.41.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 05:41:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq7gbd29vw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239432>

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Am 09.12.2013 18:48, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>>> * kb/fast-hashmap (2013-11-18) 14 commits
>>>   (merged to 'next' on 2013-12-06 at f90be3d) 
>>
>> Damn, a day too late :-) I found these two glitches today...is a
>> fixup patch OK or should I do a reroll (or separate patch on top)?
> 
> A separate patch on top would be the most appropriate.

OK, this one's a no-brainer I think. See $gmane/239430 for the latest proposal on the struct packing front.


 Documentation/technical/api-hashmap.txt | 2 +-
 hashmap.h                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index b2280f1..42ca234 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -80,7 +80,7 @@ prevent expensive resizing. If 0, the table is dynamically resized.
 If `free_entries` is true, each hashmap_entry in the map is freed as well
 (using stdlib's free()).
 
-`void hashmap_entry_init(void *entry, int hash)`::
+`void hashmap_entry_init(void *entry, unsigned int hash)`::
 
 	Initializes a hashmap_entry structure.
 +
diff --git a/hashmap.h b/hashmap.h
index f5b3b61..a816ad4 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -43,7 +43,7 @@ extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
 
-static inline void hashmap_entry_init(void *entry, int hash)
+static inline void hashmap_entry_init(void *entry, unsigned int hash)
 {
 	struct hashmap_entry *e = entry;
 	e->hash = hash;
-- 
1.8.5.1.276.g562b27a
