From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 05/20] index-helper: add --strict
Date: Thu, 19 May 2016 17:45:42 -0400
Message-ID: <1463694357-6503-6-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VnB-00079o-1U
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbcESVre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:47:34 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35414 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbcESVqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:44 -0400
Received: by mail-qk0-f170.google.com with SMTP id n62so50133875qkc.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09miKliYICJJgEHiBXKwc/PGvf8+MnDx+s9dD72OEiI=;
        b=oOZYIxO6nx6Tgz+6inhZhm21mXUHGO7ER/LcXg8N8VAupcWRl+S2expu3nDDlw1Dwb
         cNdNu/BEGS94REmorsqUD9XR3P2/HOrydoszIbaWrCx1QsnJZ99dYyBmmPTyVyMHmvID
         9DkB4u9Ww0WGZP1MkRGRva7wg9SfrITHHcCZuR1DVgBnD5uNlJHIH7TFwS1ZG0iEJsxa
         VgTZLpaKnz5iwzAxpO9Reqpmvc90dEmN3V7jYve3Q4W+Z8ihwbdpVpqF2ImuCb1Emgoz
         6wBVgaLzQ3t5UdswhBp4nPIV121mOJBwqR70vhDFbpsAdWfdCh/PYSQClHSdxRb+HRmL
         fAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09miKliYICJJgEHiBXKwc/PGvf8+MnDx+s9dD72OEiI=;
        b=j0g340K+v8gieXNxvfpgtgfXl0qiVe3Gwg791dVISWoops3HX4Icq5awr/dTr2ub65
         YrRjbj6qL6gKMFaNVxa9rwj5cGOgveaUlfFtDNO5P9xKdSMWsaSthSDHCoC+WtzYyAxm
         HbGSz3Zzn0tOzJljk3wHA7AwmiN2pj+a6f2A/5h40FwfSBD/Wc/JDIxumFvNxKHjgPTc
         Ft2D10Rrss/GOY/ondSCxrjPWe/8OCigikEDg0nlYtrm672rzScSOD8n1TEg+5FkgVN6
         31PMzebq7vNueX7HqY9xaOYblXzrbEmt5yiTHS0HMJ/HLfQAsTg3wyjz9/oj4amsh1Dc
         QLiQ==
X-Gm-Message-State: AOPr4FU1WjyBZ/RuMYyKaI3xXOfAQjFbBvzvefSowDpglGBn4o/u2xJhLr0tUAJ7E0QGDw==
X-Received: by 10.55.153.3 with SMTP id b3mr16777274qke.102.1463694403352;
        Thu, 19 May 2016 14:46:43 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295125>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

There are "holes" in the index-helper approach because the shared
memory is not verified again by git. If $USER is compromised, shared
memory could be modified. But anyone who could do this could already
modify $GIT_DIR/index. A more realistic risk is some bugs in
index-helper that produce corrupt shared memory. --strict is added to
avoid that.

Strictly speaking there's still a very small gap where corrupt shared
memory could still be read by git: after we write the trailing SHA-1 in
the shared memory (thus signaling "this shm is ready") and before
verify_shm() detects an error.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  9 +++++++
 cache.h                            |  1 +
 index-helper.c                     | 48 ++++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  9 ++++---
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index f892184..1f92c89 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -25,6 +25,15 @@ OPTIONS
 	Exit if the cached index is not accessed for `<n>`
 	seconds. Specify 0 to wait forever. Default is 600.
=20
+--strict::
+--no-strict::
+	Strict mode makes index-helper verify the shared memory after
+	it's created. If the result does not match what's read from
+	$GIT_DIR/index, the shared memory is destroyed. This makes
+	index-helper take more than double the amount of time required
+	for reading an index, but because it will happen in the
+	background, it's not noticable. `--strict` is enabled by default.
+
 NOTES
 -----
=20
diff --git a/cache.h b/cache.h
index 2d7af6f..6cb0d02 100644
--- a/cache.h
+++ b/cache.h
@@ -345,6 +345,7 @@ struct index_state {
 		  * on it.
 		  */
 		 to_shm : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index 260ef4a..a7f8a42 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,6 +17,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -114,11 +115,56 @@ static void share_index(struct index_state *istat=
e, struct shm *is)
 	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1)=
;
 }
=20
+static int verify_shm(void)
+{
+	int i;
+	struct index_state istate;
+	memset(&istate, 0, sizeof(istate));
+	istate.always_verify_trailing_sha1 =3D 1;
+	istate.to_shm =3D 1;
+	i =3D read_index(&istate);
+	if (i !=3D the_index.cache_nr)
+		goto done;
+	for (; i < the_index.cache_nr; i++) {
+		struct cache_entry *base, *ce;
+		/* namelen is checked separately */
+		const unsigned int ondisk_flags =3D
+			CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
+		unsigned int ce_flags, base_flags, ret;
+		base =3D the_index.cache[i];
+		ce =3D istate.cache[i];
+		if (ce->ce_namelen !=3D base->ce_namelen ||
+		    strcmp(ce->name, base->name)) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+		ce_flags =3D ce->ce_flags;
+		base_flags =3D base->ce_flags;
+		/* only on-disk flags matter */
+		ce->ce_flags   &=3D ondisk_flags;
+		base->ce_flags &=3D ondisk_flags;
+		ret =3D memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+			     offsetof(struct cache_entry, name) -
+			     offsetof(struct cache_entry, ce_stat_data));
+		ce->ce_flags =3D ce_flags;
+		base->ce_flags =3D base_flags;
+		if (ret) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+	}
+done:
+	discard_index(&istate);
+	return i =3D=3D the_index.cache_nr;
+}
+
 static void share_the_index(void)
 {
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
+	if (to_verify && !verify_shm())
+		cleanup_shm();
 	discard_index(&the_index);
 }
=20
@@ -250,6 +296,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index e3c8f3e..41647ea 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1674,9 +1674,12 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
=20
 	istate->mmap =3D mmap;
 	istate->mmap_size =3D mmap_size;
-	if (try_shm(istate) &&
-	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
-		goto unmap;
+	if (try_shm(istate)) {
+		if (verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
+	} else if (istate->always_verify_trailing_sha1 &&
+		   verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
 	hdr =3D mmap =3D istate->mmap;
 	mmap_size =3D istate->mmap_size;
 	if (!istate->keep_mmap)
--=20
2.4.2.767.g62658d5-twtrsrc
