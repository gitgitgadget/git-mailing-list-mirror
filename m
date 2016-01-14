From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 09/20] refs: add method to rename refs
Date: Thu, 14 Jan 2016 11:26:06 -0500
Message-ID: <1452788777-24954-10-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjZ-0002BJ-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbcANQ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:45 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35069 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbcANQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:42 -0500
Received: by mail-qk0-f169.google.com with SMTP id y67so42885969qkc.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iaOwzNALJ7eT0FV49rx+T/GZt2F3jQ0mCLFnypdtFi8=;
        b=hf4pj/C9WvtVxsw6DFWH2ThTfEtkLhUa8wL1wvDLvzbdG/0Hr6FTp+T8pnUK/9M5r9
         y7/oZdoQ2vDgXIf8agWqSbIj45DekD31EkvdDyfFVLHFAa36pk79A+rs2UDxYtZzMokI
         SCSAJcEmOtxi4lGQ+kAyydIAnIQ1TJ7utMw1f9G+Z8yLp88fGAYmYPkKR2KpyUxkzsF4
         ykp8RAmMQuWOhGSaIv+pyDxS9oBm2xAiS8g3zJ81DVbp/MDlKZB3edQeslJBasxwfy2l
         NZrgJWV6+EW1/wikIRf1qm8ul1Qon4iLs/Rdc1IUbeg8RXNsyssBzOsm/TwnnYESrdiG
         Xc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iaOwzNALJ7eT0FV49rx+T/GZt2F3jQ0mCLFnypdtFi8=;
        b=h2ByVSViOuRlvVdJj2PEoOzAXVCwrii6dhsgBpfeUZRyawJqfSpJ0T7fYrVddAHnL3
         HPb63nNy2j8tVAH0aNpros+BVMDlEHFVf6GQKyLITwU9rcBja27wEYkByqx47ie3sAyl
         3bLdDW+bcVbUfzd3OZ/riabmUo7RTA18C+hWRKvTJQOSei7qU88p67QOaQWCnE+mIRGk
         hpP4qxfLBAeiFWuHVK/673P+zRfyU8FYcLu6Af4I7zamAkETnuxYVje1jA+acP8zmySx
         GF2KtJZPgKy2dfrR8AFAeJuP26TTaC5NmiHwmgsxXZAaoeB/8uZFWDSxKh8U2hbiYo5C
         KK8g==
X-Gm-Message-State: ALoCoQlhpY1G7V0qZit8CmBEC4HCCiQ/VTuAinNxYtVVkrR2O8RvHjViMp6ldKkICoegKKJalgYIsD12TIvmqCKjmv3MCKjVmg==
X-Received: by 10.55.195.67 with SMTP id a64mr7225647qkj.4.1452788801538;
        Thu, 14 Jan 2016 08:26:41 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284037>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 4 +++-
 refs/refs-internal.h | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b43d9ea..deeb7cf 100644
--- a/refs.c
+++ b/refs.c
@@ -1122,6 +1122,11 @@ int delete_refs(struct string_list *refnames)
 	return the_refs_backend->delete_refs(refnames);
 }
 
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7f8c3d1..f14b6f9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2484,7 +2484,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3575,6 +3576,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1373c02..36a5bf8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -67,6 +67,13 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 each_ref_fn fn, int trim, int flags,
 				 void *cb_data);
 
+/*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
+int rename_ref_available(const char *oldname, const char *newname);
+
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
@@ -246,6 +253,7 @@ typedef const char *resolve_ref_unsafe_fn(const char *ref,
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int rename_ref_fn(const char *oldref, const char *newref, const char *logmsg);
 
 /* iteration methods */
 typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
@@ -284,6 +292,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.749.g730654d-twtrsrc
