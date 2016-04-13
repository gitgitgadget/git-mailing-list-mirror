From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/26] nd/shallow-deepen updates
Date: Wed, 13 Apr 2016 19:54:44 +0700
Message-ID: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKC-0003ql-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965948AbcDMMzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 08:55:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36568 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750AbcDMMzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id q129so4047249pfb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vIU98bRpTpjhuTzpzJZ8yOh33YcYBc9unEXTEAaenY=;
        b=ZF8COIesfPWmLPgGK6ADZb9KAK89deVB9buqkbdU6opEJD8LCh0Awinu6mCQVd1Pq6
         R+7T4eUtwOW2r7mXFgrCXZouZJegCxrLnNYzezcmDHTTFg1pZQdC8sV3sYg/TsXbd8Y6
         P3Ev4gJNbgbfd7jb2i3sDm4r52vdCvMPs6QE9jx5CbZgyD9aKzZMi+E9lQDCvmL1ADDJ
         UxsdeS+zvZvI1kDu0oF8uYfQabggZWOOEh24grUpOY5p5QLk2FgnvXFy8NYpCp11TZu3
         3K95fVXXGeuDMSC/tANBoIfBhM1ovvR1ux+vzm9i+uY9iVBOIHXrOAHCXbTLnUe9J5OY
         vLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vIU98bRpTpjhuTzpzJZ8yOh33YcYBc9unEXTEAaenY=;
        b=OxM6BOIFMXH1H1w6WipG8wL33JL2L+9LifKsm/xfpWhXaXE5OEeksdrCy66Eb80UyE
         KDShQswcG8h5vVlImglJ0UgdZ38IQAEB7PkqzDWAyRTMJFAW4OSrE1Z3nW/MRjwyJILj
         ufPsFOKdA8sVrO0sSSv8qICGEt+LJhFUjdf7t2cM18/Y+9Xprb8YFa9MHZhag0sIgYj9
         ynC+cIvYbRjlSF1hEVwCc8/FGUiGt/rYq/YMBGKF7nLsSxtS73UU8m/WUnBTl23qetvR
         oTrT8/kjT+W9vgDCXs54NqOvv2PJZFu1WmEVKYfrI4C3jI7z70ygEJrQz9JuwK3dcKtz
         Ei9Q==
X-Gm-Message-State: AOPr4FVGzIkDPL2VU99mO1xTGkDyP6VsO2jmzLKHK2lHJFD+NWzcOUG5IuHueBWVgigTjQ==
X-Received: by 10.98.8.91 with SMTP id c88mr12645118pfd.47.1460552107916;
        Wed, 13 Apr 2016 05:55:07 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id f8sm51040968pfj.49.2016.04.13.05.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291394>

Compared to 'pu'

14/26 has a fix from Jeff, about incorrectly sharing variable for
iteration. Interdiff

--- a/shallow.c
+++ b/shallow.c
@@ -188,13 +188,14 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 */
 	for (p = not_shallow_list; p; p = p->next) {
 		struct commit *c = p->item;
+		struct commit_list *parent;
 
 		if (parse_commit(c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
-		for (p = c->parents; p; p = p->next)
-			if (!(p->item->object.flags & not_shallow_flag)) {
+		for (parent = c->parents; parent; parent = parent->next)
+			if (!(parent->item->object.flags & not_shallow_flag)) {
 				c->object.flags |= shallow_flag;
 				commit_list_insert(c, &result);
 				break;

21/26 adds "static" (from Ramsay Jones)

--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -41,7 +41,7 @@ static int max_children = 1;
 static const char *depth;
 static const char *deepen_since;
 static const char *upload_pack;
-struct string_list deepen_not = STRING_LIST_INIT_NODUP;
+static struct string_list deepen_not = STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;

And 12/26 is a new one.

  [01/26] remote-curl.c: convert fetch_git() to use argv_array
  [02/26] transport-helper.c: refactor set_helper_option()
  [03/26] upload-pack: move shallow deepen code out of receive_needs()
  [04/26] upload-pack: move "shallow" sending code out of deepen()
  [05/26] upload-pack: remove unused variable "backup"
  [06/26] upload-pack: move "unshallow" sending code out of deepen()
  [07/26] upload-pack: use skip_prefix() instead of starts_with()
  [08/26] upload-pack: tighten number parsing at "deepen" lines
  [09/26] upload-pack: move rev-list code out of check_non_tip()
  [10/26] fetch-pack: use skip_prefix() instead of starts_with()
  [11/26] fetch-pack: use a common function for verbose printing
  [12/26] fetch-pack.c: mark strings for translating
  [13/26] fetch-pack: use a separate flag for fetch in deepening mode
  [14/26] shallow.c: implement a generic shallow boundary finder based on rev-list
  [15/26] upload-pack: add deepen-since to cut shallow repos based on time
  [16/26] fetch: define shallow boundary with --shallow-since
  [17/26] clone: define shallow clone boundary based on time with --shallow-since
  [18/26] t5500, t5539: tests for shallow depth since a specific date
  [19/26] refs: add expand_ref()
  [20/26] upload-pack: support define shallow boundary by excluding revisions
  [21/26] fetch: define shallow boundary with --shallow-exclude
  [22/26] clone: define shallow clone boundary with --shallow-exclude
  [23/26] t5500, t5539: tests for shallow depth excluding a ref
  [24/26] upload-pack: split check_unreachable() in two, prep for get_reachable_list()
  [25/26] upload-pack: add get_reachable_list()
  [26/26] fetch, upload-pack: --deepen=N extends shallow boundary by N commits

Total 23 files changed, 879 insertions(+), 221 deletions(-)
