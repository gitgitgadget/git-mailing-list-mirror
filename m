From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] document string_list_clear
Date: Fri,  5 Dec 2014 17:51:18 -0800
Message-ID: <1417830678-16115-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx4Wt-0004fl-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 02:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbaLFBvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 20:51:23 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:46487 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaLFBvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 20:51:22 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so249927igd.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 17:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8LlI7n3eEBsi9TN+cFhCMlKABN39lEcsVP9UnLlsdks=;
        b=ffOAE8BoUOgpKE6jfrjyWkVMqeKapGK2/TdfwcXgRky7cx4teLUlaoVssZZ34cJ6i0
         4zcc36EEV7SNiTrPLdo7aw84+5S8pK0nv6I43WR/D/VBw3PJb3Kty33i4AWEx4dd9Hlc
         5ISZXf1FYauOwtKqcgmRVohBnjZlnA6o7zkV1uBW/khtKGyqnf+20qD7wh1eNu0AglHz
         7aMpYGSyeDpgJPeK1h0Omm7FE31qKnueLokOxiTbB2bc3X0B4954HIQ6EUFjwIm/pfuM
         1gKydPdddwxPhHhz4ReUU4cNaMyVaV63PxLCzUJJsqVet61ie38/zPGks4Fire1Ns0X7
         7kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8LlI7n3eEBsi9TN+cFhCMlKABN39lEcsVP9UnLlsdks=;
        b=iz5++RmzRAniHxGVcVGqNLJJba068vmQWeraFsJ4HvJA9LlXR1F6wtYcCq+Gh5vr0i
         ZNXJ186FvXctki7EfkcJpreRX2P5En++Y/PLLbdroC/hYpDjjeWa94VFQbh0yNlTfbgj
         umg/9vdOcvkyq/HLyGfqSLInHs8RKLavqSPRhncJ89WIlzon87TJs2Uo44fzgkQksrA7
         EbfPno8VMyeZKCtbozUnZWsdm2uGfMTraMLUAdVvOVj1Wpf17jg/zVgmmSIYtnuzeedH
         VihxifYJR6peKPlxzHyyXgX8n34oiyzNODwJdywcREc4NU2JvlEI5qYQn2jxNWuvzI2m
         b3ww==
X-Gm-Message-State: ALoCoQlNJnRyLLlJnweb7jT1KkliseOhYRnlNRZ1pKO3WumsABwk/UFKl5yYx+IA5lluBf1ZZkDb
X-Received: by 10.42.179.1 with SMTP id bo1mr17975580icb.35.1417830681343;
        Fri, 05 Dec 2014 17:51:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id z8sm88564igl.18.2014.12.05.17.51.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 17:51:20 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260922>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Just stumbled accross this one and wasn't sure if it also frees up
 the memory involved.

 string-list.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/string-list.h b/string-list.h
index 494eb5d..99ecc44 100644
--- a/string-list.h
+++ b/string-list.h
@@ -21,6 +21,11 @@ struct string_list {
 void string_list_init(struct string_list *list, int strdup_strings);
 
 void print_string_list(const struct string_list *p, const char *text);
+
+/*
+ * Clears the string list, so it has zero items. All former items are freed.
+ * If free_util is true, all util pointers are also freed.
+ */
 void string_list_clear(struct string_list *list, int free_util);
 
 /* Use this function to call a custom clear function on each util pointer */
-- 
2.2.0
