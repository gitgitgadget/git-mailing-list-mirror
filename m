From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/4] mingw: uglify (a, 0) definitions to shut up warnings
Date: Fri, 15 Jan 2016 14:24:45 +0100 (CET)
Message-ID: <717146db7aa98d8f5e5b730b44a6fe2aae5e77a3.1452864241.git.johannes.schindelin@gmx.de>
References: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:25:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4N5-0003ja-42
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbcAONYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:24:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:58900 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161062AbcAONYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:24:50 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LfHs4-1ZmtLb1r3o-00on96; Fri, 15 Jan 2016 14:24:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452864241.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ScR1Guu9SHTvBmRxPhLwyTHOpE5OlNq4j5D4TR32IAMzgkwKm9W
 MPGtVpflFPY3NpGQggTcc30yaa1TqSKvd7snndsvw3RW5jOPU2MkCk0m3tZtx7ircWPY1/Z
 ouGVMJqltNJCGiKyV/KL0RDuo2qPqcKiTXKYAip5LJsoMveo1OCmtwss5dgDs8THzx7hqiE
 FE7bUF7AQ5mlQd2i5s6VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c4gF8p94sYA=:lGZ5OOu2g4Ft02sQUxD6cR
 w1TfMjaG9Ellsl7BbMn9bpIv/jCs9Wjjx1QcRONMquVxls0Wc68NkJ5vIvY6Fug0H9TMSKymY
 hRmmtImRou3TR9OUrIVBc2gNnhyq4qm3f5EcB+bVwd5KF0CyRICK2d1teLJqFbBJiI9q7J69l
 wuI0tJJj5IFO9CdILxnIRGHcMfRwxt26tggsayaYebCRkKPuJONmEKdlFSsT0YejHSiylHlFK
 d/eTC8oziXVisRp2cEkGue+4bMwBhECI1TEIiywpFg/c/Dx5ngc2nN6H+WzTedzCbGwq/S6hc
 NJp/+DOk+8Y4Hsif++eGH3pMs6RxowB9KvExpHpIfUWxjJm3c2zKiGUT6rN5+h0xnV5+MONTt
 +9JoAsPUJ+0iuBPnP+bKN3PkfKSgHDR+XvdIWdsAZHIazXsnuZvFAjSRRY/n2YQ4yjQdbINur
 uDvSp1/oo6+AeNqtT+dk/6ymrbTrrLPGP09F/U/SaDwVQltqRGuLwTtMHlB+Mtqq5kllPJkSS
 txvUKARUQkXV5i7PwfRDlBRkFgs+uPEkrJP4eGlipLMTTVhHqgTy93C+iiwrMdzpvfg2+jiIF
 2kS5r6QUX5oi4VKA513+GaF02iZzA0z+B3syCADQOoCyw038KJw7+QptKBW5emSifCI4hxjTf
 +jmKP9v0mkpUfaZqzakVk1C70iIAKDGbGaB+mAgsyc8qPp6dzVdzoQmQ8eDQryrmcn8t67jCh
 ginYhlyQivWAJq3rQu9Hs4EHi8n08Wg9u5sGz6THzC+x45F60HKSHREfN3/kYgDf+kc+04Ax 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284168>

When the result of a (a, 0) expression is not used, MSys2's GCC version
finds it necessary to complain with a warning:

	right-hand operand of comma expression has no effect

Let's just pretend to use the 0 value and have a peaceful and quiet life
again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/malloc.c.h | 3 ++-
 compat/win32/pthread.h      | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..ac0b7b4 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1798,9 +1798,10 @@ struct win32_mlock_t
   volatile long threadid;
 };
 
+static inline int return_0(int i) { return 0; }
 #define MLOCK_T               struct win32_mlock_t
 #define CURRENT_THREAD        win32_getcurrentthreadid()
-#define INITIAL_LOCK(sl)      (memset(sl, 0, sizeof(MLOCK_T)), 0)
+#define INITIAL_LOCK(sl)      (memset(sl, 0, sizeof(MLOCK_T)), return_0(0))
 #define ACQUIRE_LOCK(sl)      win32_acquire_lock(sl)
 #define RELEASE_LOCK(sl)      win32_release_lock(sl)
 #define TRY_LOCK(sl)          win32_try_lock(sl)
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index d3dd872..20b35a2 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -18,7 +18,10 @@
  */
 #define pthread_mutex_t CRITICAL_SECTION
 
-#define pthread_mutex_init(a,b) (InitializeCriticalSection((a)), 0)
+static inline int return_0(int i) {
+	return 0;
+}
+#define pthread_mutex_init(a,b) return_0((InitializeCriticalSection((a)), 0))
 #define pthread_mutex_destroy(a) DeleteCriticalSection((a))
 #define pthread_mutex_lock EnterCriticalSection
 #define pthread_mutex_unlock LeaveCriticalSection
-- 
2.7.0.windows.1.7.g55a05c8
