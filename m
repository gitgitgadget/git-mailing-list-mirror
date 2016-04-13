From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 04/16] index-helper: add --strict
Date: Tue, 12 Apr 2016 20:32:57 -0400
Message-ID: <1460507589-25525-5-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kV-0002jC-DB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914AbcDMAd3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:29 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35561 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896AbcDMAd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:26 -0400
Received: by mail-qk0-f171.google.com with SMTP id o6so13626245qkc.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uVeKc5IA77wfMljjkPO5qaDLbC8Yy/Dwu72cKUIivPY=;
        b=iSwyc40qc5CPorpbpownvrMCapao21q0KWtsfaQHg33pd4LNldma01+nrcrUZ0BmsP
         N2xM7Z3wy5alMepaB2sZfK9hNOSc/4wr3rPDcoi/u3duDnr8RfSt7heGQaYrID+nuNLG
         JX7KqkyW8YkziTZcEQyTr2VrIByqif4JLPvTU9WPxN69eyXBwtvCEFQiUihN2S0XhG9V
         QK2KsfIukCrdh62KfOcODpofiuJdgrdXagaX6bkfWS3kM9pR4YV8cS1xw+ZCQnlXcfEB
         P2TFCpO8M+a0q/CjJ7F1fF2awhHVRVB8wJ3S1X9GhBPKyFKKH7MHw3z8l3XUtFJsyuNs
         vJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uVeKc5IA77wfMljjkPO5qaDLbC8Yy/Dwu72cKUIivPY=;
        b=ePz5nnksPxSD9oyuY9KAR29chwAoyg5jTHHrG3/S19cQjGxdp28yROGGmfuAdT+gF1
         9x6ID3KA7XoLcbRr4XzGNPIxi7XZpF3YzX8nakt3JHlNaE1ppjuszpasTstiBPdgef1h
         A6GrTileYyY2CwEVhwZldIH9tK0hpb+zs/q2KGmtkccahFXuf1i3v+PGChjCgBP5nKY3
         +VrFCnhhJIpUVFUnTl8Zcr0Np4n8UCRaOV1aIS3J47bc8aAZe7oC0FNwSlN/f9Qt9RxR
         BiPO013Gg5SE4l1TIrfAE8RVm2rFhUk/VNf2bQnhuO/Ip/yPuiadW7r8xH+ABoJjtUOq
         cScg==
X-Gm-Message-State: AOPr4FWRuurMDzAD+rs2g81i/SmpdjWSMjtPK23rsgNx/MkoRrTZdnTHjppPsCcA1LMCqg==
X-Received: by 10.55.6.23 with SMTP id 23mr7356642qkg.64.1460507605198;
        Tue, 12 Apr 2016 17:33:25 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291341>

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
index 90138ec..2382ba8 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -22,6 +22,15 @@ OPTIONS
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
index 43fb314..4b678e9 100644
--- a/cache.h
+++ b/cache.h
@@ -336,6 +336,7 @@ struct index_state {
 		 keep_mmap : 1,
 		 from_shm : 1,
 		 to_shm : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index b52e568..9a4278f 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -16,6 +16,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify =3D 1;
=20
 static char *my_tmp_dir;
=20
@@ -178,11 +179,56 @@ static void share_index(struct index_state *istat=
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
@@ -314,6 +360,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index 5b351c5..e7d2688 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1721,9 +1721,12 @@ int do_read_index(struct index_state *istate, co=
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
