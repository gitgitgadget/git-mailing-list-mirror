Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665BC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EC161152
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKJLoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:44:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34915 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhKJLoO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Nov 2021 06:44:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 946B05C01F6;
        Wed, 10 Nov 2021 06:41:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 06:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vLnUgeSoTGuUePgu5o/SjOJAMTm
        SUgNbIeT6STEMCOw=; b=GYUKsxe4ca4iTQZHfay0sz0UXHLDjI6AFjE6j2hC6TB
        aaDZ0busr6jUr1Jzecb/Wav+OxI6jmMT1aK7lVSeBLcxWw2H+VHaMYlOGOkakCX/
        mkNV5yVNSBOkPcsmgf6M04hcOT+uFJMBuGygrTS2VZO3TDqHJOmKp6+vUeoYiK38
        AHyjo1Hv0EKc0wsb1hdYVcjgl6oUKxJICMEb3/wY7clH4K+pE4evvgEBuJ3xO89c
        aC9lPQKDa3zSwz/+xH+DUcgTsyYm4zJ575+4fZ8TTDiSQ3FgruYinfIGn+6bAtBT
        +HmrpJiMd/JcaFCNdsk/WgZCslsFk+wLa+Zd1OHoQ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vLnUge
        SoTGuUePgu5o/SjOJAMTmSUgNbIeT6STEMCOw=; b=JngnjlMHMy5QGrISK5VWAK
        7WSnZKkJ5E8mczpr65SOnFI2PJOmvsWDutkhvWtdn6lzJNbayUA887aYjv34hB7d
        fR9KtYWPQriadnNAkuSrueAG65gRS9QFPjayYxjZA2296PB6UFVjVk3hSp+mtKJm
        tlQC3xvGmhiK0393lNTix1w3cUGpEgdZYy8WXHnE6IAhLZLt5Q73MoZcNLJOe1Ud
        Dup8CKzUsWhsFN0N9gVKOSWwvPngll5BB2asGJmFrwGits3rcVkILgLnG2chY60U
        ShNHW6dpVs4bH4WV6/09NzmT2rsHL3IBklCIoImwkZzhJLtXfikTy5p+REOq0Jcg
        ==
X-ME-Sender: <xms:5q-LYSvQGz5JW4e2zRLtpGFbzsA6JnWk-5J9SyltSnOFlT2cANB6RQ>
    <xme:5q-LYXdgeOi-YBiSxlkr2GOnI0xOZgTSRVuf6vANgwWLm0tA4Ax6Bso-lfRR-JzRi
    3V9zsCgnsHDDSa-gw>
X-ME-Received: <xmr:5q-LYdxUADk_ZoDXIWQMZcQ4ANi3POMuHdV6oy0I8cX0Ck93aOrI2Env_cLAkOClx4YiEf95g_cPcpUFTeqU2IjcRo1CZgKI0pSS5A-xucR0Iko_ojDzMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epiedvjeefheeiteekgeejveefffdtvedvudfgvdeuheeffeejfeetudeutdefgfegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5q-LYdM1FdmhFWQpg5a-5-h0_w61ygEXwInBW3rkf7syVY7F5Q4_UA>
    <xmx:5q-LYS9BK1HNZIVPjQHEufOC6HCtPaPzbjAj8j48rV42jNwJ3TVfrg>
    <xmx:5q-LYVWXNcbKtQK3Xlo-mMg382Im0C2iOVGknTOT2fZ8Yja9QZEIAA>
    <xmx:5q-LYZkuirALibvJsqf9Wjj8e7Eur82Wll2qoS_haM58nqzlFeVwLA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 06:41:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c351727d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 Nov 2021 13:26:36 +0000 (UTC)
Date:   Wed, 10 Nov 2021 12:41:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hPa9ID0fcD8QfilT"
Content-Disposition: inline
In-Reply-To: <cover.1636544377.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hPa9ID0fcD8QfilT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing loose refs, we first create a lockfile, write the new ref
into that lockfile, close it and then rename the lockfile into place
such that the actual update is atomic for that single ref. While this
works as intended under normal circumstences, at GitLab we infrequently
encounter corrupt loose refs in repositories after a machine encountered
a hard reset. The corruption is always of the same type: the ref has
been committed into place, but it is completely empty.

The root cause of this is likely that we don't sync contents of the
lockfile to disk before renaming it into place. As a result, it's not
guaranteed that the contents are properly persisted and one may observe
weird in-between states on hard resets. Quoting ext4 documentation [1]:

    Many broken applications don't use fsync() when replacing existing
    files via patterns such as fd =3D
    open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo"), or
    worse yet, fd =3D open("foo", O_TRUNC)/write(fd,..)/close(fd). If
    auto_da_alloc is enabled, ext4 will detect the replace-via-rename
    and replace-via-truncate patterns and force that any delayed
    allocation blocks are allocated such that at the next journal
    commit, in the default data=3Dordered mode, the data blocks of the new
    file are forced to disk before the rename() operation is committed.
    This provides roughly the same level of guarantees as ext3, and
    avoids the "zero-length" problem that can happen when a system
    crashes before the delayed allocation blocks are forced to disk.

This explicitly points out that one must call fsync(3P) before doing the
rename(3P) call, or otherwise data may not be correctly persisted to
disk.

Fix this by introducing a new configuration "core.fsyncRefFiles". This
config matches behaviour of "core.fsyncObjectFiles" in that it provides
three different modes:

    - "off" disables calling fsync on ref files. This is the default
      behaviour previous to this change and remains the default after
      this change.

    - "on" enables calling fsync on ref files, where each reference is
      flushed to disk before it is being committed. This is the safest
      setting, but may incur significant performance overhead.

    - "batch" will flush the page cache of each file as it is written to
      ensure its data is persisted. After all refs have been written,
      the directories which host refs are flushed.

With this change in place and when "core.fsyncRefFiles" is set to either
"on" or "batch", this kind of corruption shouldn't happen anymore.

[1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/core.txt |  7 ++++
 cache.h                       |  7 ++++
 config.c                      | 10 ++++++
 environment.c                 |  1 +
 refs/files-backend.c          | 62 ++++++++++++++++++++++++++++++++++-
 5 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 200b4d9f06..e2fd0d8c90 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -572,6 +572,13 @@ core.fsyncObjectFiles::
   stored on HFS+ or APFS filesystems and on Windows for repos stored on NT=
FS or
   ReFS.
=20
+core.fsyncRefFiles::
+	A value indicating the level of effort Git will expend in trying to make
+	refs added to the repo durable in the event of an unclean system
+	shutdown. This setting currently only controls loose refs in the object
+	store, so updates to packed refs may not be equally durable. Takes the
+	same parameters as `core.fsyncObjectFiles`.
+
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
 +
diff --git a/cache.h b/cache.h
index 6d6e6770ec..14c8fab6b4 100644
--- a/cache.h
+++ b/cache.h
@@ -991,7 +991,14 @@ enum fsync_object_files_mode {
     FSYNC_OBJECT_FILES_BATCH
 };
=20
+enum fsync_ref_files_mode {
+    FSYNC_REF_FILES_OFF,
+    FSYNC_REF_FILES_ON,
+    FSYNC_REF_FILES_BATCH
+};
+
 extern enum fsync_object_files_mode fsync_object_files;
+extern enum fsync_ref_files_mode fsync_ref_files;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index 5eb36ecd77..4cbad5a29d 100644
--- a/config.c
+++ b/config.c
@@ -1500,6 +1500,16 @@ static int git_default_core_config(const char *var, =
const char *value, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.fsyncreffiles")) {
+		if (value && !strcmp(value, "batch"))
+			fsync_ref_files =3D FSYNC_REF_FILES_BATCH;
+		else if (git_config_bool(var, value))
+			fsync_ref_files =3D FSYNC_REF_FILES_ON;
+		else
+			fsync_ref_files =3D FSYNC_REF_FILES_OFF;
+		return 0;
+	}
+
 	if (!strcmp(var, "core.preloadindex")) {
 		core_preload_index =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index aeafe80235..1514ac9384 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 enum fsync_object_files_mode fsync_object_files;
+enum fsync_ref_files_mode fsync_ref_files;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48..31d7456266 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1360,6 +1360,57 @@ static int commit_ref_update(struct files_ref_store =
*refs,
 			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
=20
+static int sync_loose_ref(int fd)
+{
+	switch (fsync_ref_files) {
+	case FSYNC_REF_FILES_OFF:
+		return 0;
+	case FSYNC_REF_FILES_ON:
+		return git_fsync(fd, FSYNC_HARDWARE_FLUSH);
+	case FSYNC_REF_FILES_BATCH:
+		return git_fsync(fd, FSYNC_WRITEOUT_ONLY);
+	default:
+		BUG("invalid fsync mode %d", fsync_ref_files);
+	}
+}
+
+#define SYNC_LOOSE_REF_GITDIR    (1 << 0)
+#define SYNC_LOOSE_REF_COMMONDIR (1 << 1)
+
+static int sync_loose_refs_flags(const char *refname)
+{
+	switch (ref_type(refname)) {
+	case REF_TYPE_PER_WORKTREE:
+	case REF_TYPE_PSEUDOREF:
+		return SYNC_LOOSE_REF_GITDIR;
+	case REF_TYPE_MAIN_PSEUDOREF:
+	case REF_TYPE_OTHER_PSEUDOREF:
+	case REF_TYPE_NORMAL:
+		return SYNC_LOOSE_REF_COMMONDIR;
+	default:
+		BUG("unknown ref type %d of ref %s",
+		    ref_type(refname), refname);
+	}
+}
+
+static int sync_loose_refs(struct files_ref_store *refs,
+			   int flags,
+			   struct strbuf *err)
+{
+	if (fsync_ref_files !=3D FSYNC_REF_FILES_BATCH)
+		return 0;
+
+	if ((flags & SYNC_LOOSE_REF_GITDIR) &&
+	    git_fsync_dir(refs->base.gitdir) < 0)
+		return -1;
+
+	if ((flags & SYNC_LOOSE_REF_COMMONDIR) &&
+	    git_fsync_dir(refs->gitcommondir) < 0)
+		return -1;
+
+	return 0;
+}
+
 /*
  * Emit a better error message than lockfile.c's
  * unable_to_lock_message() would in case there is a D/F conflict with
@@ -1502,6 +1553,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
 	oidcpy(&lock->old_oid, &orig_oid);
=20
 	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	    sync_loose_refs(refs, sync_loose_refs_flags(newrefname), &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1522,6 +1574,7 @@ static int files_copy_or_rename_ref(struct ref_store =
*ref_store,
 	flag =3D log_all_ref_updates;
 	log_all_ref_updates =3D LOG_REFS_NONE;
 	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	    sync_loose_refs(refs, sync_loose_refs_flags(newrefname), &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1781,6 +1834,7 @@ static int write_ref_to_lockfile(struct ref_lock *loc=
k,
 	fd =3D get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
+	    sync_loose_ref(fd) < 0 ||
 	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
@@ -2665,7 +2719,7 @@ static int files_transaction_prepare(struct ref_store=
 *ref_store,
 		files_downcast(ref_store, REF_STORE_WRITE,
 			       "ref_transaction_prepare");
 	size_t i;
-	int ret =3D 0;
+	int ret =3D 0, sync_flags =3D 0;
 	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
 	char *head_ref =3D NULL;
 	int head_type;
@@ -2777,8 +2831,14 @@ static int files_transaction_prepare(struct ref_stor=
e *ref_store,
 					&update->new_oid, NULL,
 					NULL);
 		}
+
+		sync_flags |=3D sync_loose_refs_flags(update->refname);
 	}
=20
+	ret =3D sync_loose_refs(refs, sync_flags, err);
+	if (ret)
+		goto cleanup;
+
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 			ret =3D TRANSACTION_GENERIC_ERROR;
--=20
2.33.1


--hPa9ID0fcD8QfilT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGLr84ACgkQVbJhu7ck
PpRaoQ/+K9hhRZh0FGBsC/SDwlFWyjllXsSHsOXnHACLzQkym6rcTrDnnIefMI7e
NFS92Kty+uTP8WM++2i+kr4SMfmUugvc+19r288XY1s1arxjYMIAVveZ3JT98mxZ
WI1Bo65+gQVHk2yiTedDtMGMOT2epAQiina2t+CIVprCM0fD/zdo2rQVOddbN72y
DwIMInEU0TERZNXNVyPd58hwg0HCXXPrpym0ZxR2eJdhdz14a0uteyHRKmxeySIf
TlVk+o+6cPRoZbQoG/mOeLYgGFftyoBsKVbgO0LJDd7JPIYX0ooC7BosmOyUGUk+
qhlKf7OhaCf+XJUl4TQNuu6Kkv6CUaYFmKa0RcI1UHSt9N//t1I06Swwd/4Z6xvo
k74ZcEMwM0KXBViB3uudXFAXM8K1++jweLvhLeclqrLTpzrSHg91sbapjXotbnfW
arcsLSFJWXu59LET2rhUYSMW/cD7Xy+ysZ74Ur5WeGtSZhQheYZYMUdclM61iLhM
cAdfS6BJ7Mj6VMV2jmm+WxZrD6pce8WInQlUVDEdRZ1deYjtVGwNMn/38DIo2EUf
yt1G+a1QbLJHSDvzSrph32dY3dz11iOAWi5n8cPBZR/QT6sF42UqVeGGXZxWgWlL
yz6cWFhfKFnLsGOCS2lzbyDqHbfP2SeheHWJ89/I1c/87HcFmHg=
=rFbU
-----END PGP SIGNATURE-----

--hPa9ID0fcD8QfilT--
