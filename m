Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B7C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F371661A0A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354496AbhJAO1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:27:41 -0400
Received: from mout.web.de ([212.227.17.12]:39507 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353768AbhJAO1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633098347;
        bh=yTeb8yUR4ZnzDUNetETdhfjfhYiRChxx7O9PEpXkgMs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HhOPlcqsQBADLZHgnRqlBceBJtewBHa3fnwSWp9Zc5arJbXkb78MR3luMD/g+FbGo
         3cNas74SV6beA7mNQXhOIfDOz3qd44AK/IXVI1jY8HsAXruCF9F6xZc1QzyXpye/wI
         hNM7hywW6vaMWOlLlvW7SffQBgOuMUf8hNNWPwMI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LsyZi-1myajB2uny-012Xgh; Fri, 01 Oct 2021 16:25:47 +0200
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
 <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de> <xmqqk0iydns7.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1d26a9f3-dcb5-408a-581e-40411e6a2179@web.de>
Date:   Fri, 1 Oct 2021 16:25:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0iydns7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3DLjvBGV6h/MUt4MUp/QTrLAAVULyEByxCedtR1V+AGEB9tvBJ
 cbxi2IWI+TIBBTMrpWH1rJ6AzGtAJ1/b1muV4+ZpoYVmaysw8nlF4hb41xRjv11ANx3DGSm
 GyUx1LL2Ke71p4Aih/j2xSdGiZfnCxTL80AGriPad1Rz5f09CdhrHGisCCMZpXY7KcDNoXJ
 gKXcGjdHQtJnEVsip/HZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P0j9RLTmLIY=:i861LFS/yd0RGD/PnWAnoY
 Vq/wLxtCm+77brPiBug0eW3C9KLxQbqj0ciG9GRPE6KrxBe0RrcFU5EGaKGAf55+newAuHZoQ
 /ANlYhOAd6aVkI3Z17Ruy5bBxXOuwyfpAV6POfqxvFj1YI2HkCOwekA2IRTDmj8B8wEGgU5Pd
 1iRsuav9/3k7gNu/taFtpPzMQlGd6dMHmVzjMrHSdl7MRTLnsIcQkiCuMxQemNFCWRGgo7W9R
 tFT9syXiz2h0AfKDmdLdJwoPTJzcUIwN0G0OUsu0EWeHj1pJBoQ6t7CJ6AZcZ5Ikv0Xa70eYm
 BoryzOi7n6tdYP+l0/Vv+urhZnXzTPsxfO4Vjz5FTVoQrlF46VqHcAMUcbI9owNyP03EbfWc9
 vJFeB8ZH1u13eHOxvbewEaOwmzKcsxOdrQWPCe8fZHdwMOW1vnrO0aKYyl0d2Snrs4/G3grnK
 6ZN7yk8JKbCa29MAx/L/E/DblfodFWNkdLLyZSq71LX9+/Y4OnNmA6ArwMKbWOVb76wWXbtH2
 VsAjlcBbrx6Wn+Hyck0Ia5RN35UNK0QmDBtkwH6hH7Hx1qQkgpTHqE2aBoLaSPEq8HCuLo5Rb
 4hoEUzbyfVidErOwGsLPIw0KrZMBRX0VxQsaxH4uM9xB+1EFkc5rRJX7RBa2RPkaM2uydwWf2
 4fDfdfMfWpks6Gs/lAJlSObRP/ujj+CfeEhIAQnnWZi8wtSN9nYGGHHKZMvUlZ/OSHVm/iZ7t
 0JxDTxZaENAWeO/2tZTcnuuAvOO0qwarAV8VGknoj2jSLCph/szVEGBtWO8MkpIUcAzGlkSft
 ueY94hImDpnBBcsg1TfkEjwNgy1uC5WycE2chvjjjW+4gq4mIQnEJGZDbwNTgF/6CDthd2+gb
 AcHx7r1gPuaU1cipAzeAcH7US4vOZ25U4nDdRzLg36/G8dcrRd7v9W9W880wozjl0qC5fpigv
 3x8emq9EWc1vA0e8sfcA2NAF1KgmNok4+H9hDKB8r6kFkmrvITX5Ej2cgMWjEIcQcsvazOZg4
 hGs2/duG/DMPC+NaW6XVBcnPfbxLlSyIlMSZypDmIzUEJEXIXn1o5yBKPWQ5dhlZvjFM8cLEv
 714HcSkhhmU9Qc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.21 um 18:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Looping in Stolee as the author of 6e773527b6 (sparse-index: convert
>> from full to sparse, 2021-03-30).
>>
>> Here's a raw patch for that.  Versions before 6e773527b6 pass the
>> included test.
>>
>> The magic return value of 2 is a bit ugly, but allows adding the
>> additional check only to the call-site relevant to the bug report.
>>
>> I don't know if other callers of verify_path() might also need that
>> check, or if it is too narrow.
>
> The callers inside read-cache.c, which I think were the original
> intended audiences of the function, always call verify_path() with
> the pathname suitable to be stored as a cache entry.
>
> The callee never has to assume an extra trailing slash might exist
> at the end.  And verify_path() said "no", if any caller passed an
> extra trailing slash before the commit in question.
>
> I _think_ we defined the new "tree" type entries the sparse index
> stuff added to be the _only_ cache entries whose path always ends
> with a slash?  If so, perhaps we should audit the existing callers
> and move the "paths that come from end-users to be entered to the
> index must never end with a slash" sanity check this function gave
> us, which was broken by 6e773527b6, perhaps?
>
> "git update-index" should never allow to create a "tree" kind of
> cache entry (making it sparse again should be the task of systems
> internal, and should not be done by end-user feeding a pre-shrunk
> "tree" kind of entry to record a sparsely populated state, if I
> understand correctly), so its call to verify_path(), if it ends with
> a directory separator, should say "that's not a good path".
>
> Prehaps we can rename verify_path() to verify_path_internal() that
> is _known_ to be called with names that are already vetted to be
> stored in ce_name and convert callers inside read-cache.c to call
> it, and write verify_path() as a thin wrapper of it to fail when the
> former stops by returning S_ISDIR() at the place your fix touched,
> or something?

Restoring the stricter check for the general case and providing a way
out for the code handling sparse indexes sounds like a good idea.

I don't know which callers are supposed to need that, but the following
patch passes all tests, including the new one.

Ren=C3=A9


=2D--
 read-cache.c                       | 45 ++++++++++++++++++++----------
 t/t3905-stash-include-untracked.sh |  6 ++++
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f5d4385c40..a1da4619c4 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -849,6 +849,19 @@ struct cache_entry *make_empty_transient_cache_entry(=
size_t len,
 	return xcalloc(1, cache_entry_size(len));
 }

+enum verify_path_result {
+	PATH_OK,
+	PATH_INVALID,
+	PATH_DIR_WITH_SEP,
+};
+
+static enum verify_path_result verify_path_internal(const char *, unsigne=
d);
+
+int verify_path(const char *path, unsigned mode)
+{
+	return verify_path_internal(path, mode) =3D=3D PATH_OK;
+}
+
 struct cache_entry *make_cache_entry(struct index_state *istate,
 				     unsigned int mode,
 				     const struct object_id *oid,
@@ -859,7 +872,7 @@ struct cache_entry *make_cache_entry(struct index_stat=
e *istate,
 	struct cache_entry *ce, *ret;
 	int len;

-	if (!verify_path(path, mode)) {
+	if (verify_path_internal(path, mode) =3D=3D PATH_INVALID) {
 		error(_("invalid path '%s'"), path);
 		return NULL;
 	}
@@ -993,60 +1006,62 @@ static int verify_dotfile(const char *rest, unsigne=
d mode)
 	return 1;
 }

-int verify_path(const char *path, unsigned mode)
+static enum verify_path_result verify_path_internal(const char *path,
+						    unsigned mode)
 {
 	char c =3D 0;

 	if (has_dos_drive_prefix(path))
-		return 0;
+		return PATH_INVALID;

 	if (!is_valid_path(path))
-		return 0;
+		return PATH_INVALID;

 	goto inside;
 	for (;;) {
 		if (!c)
-			return 1;
+			return PATH_OK;
 		if (is_dir_sep(c)) {
 inside:
 			if (protect_hfs) {

 				if (is_hfs_dotgit(path))
-					return 0;
+					return PATH_INVALID;
 				if (S_ISLNK(mode)) {
 					if (is_hfs_dotgitmodules(path))
-						return 0;
+						return PATH_INVALID;
 				}
 			}
 			if (protect_ntfs) {
 #if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
 				if (c =3D=3D '\\')
-					return 0;
+					return PATH_INVALID;
 #endif
 				if (is_ntfs_dotgit(path))
-					return 0;
+					return PATH_INVALID;
 				if (S_ISLNK(mode)) {
 					if (is_ntfs_dotgitmodules(path))
-						return 0;
+						return PATH_INVALID;
 				}
 			}

 			c =3D *path++;
 			if ((c =3D=3D '.' && !verify_dotfile(path, mode)) ||
 			    is_dir_sep(c))
-				return 0;
+				return PATH_INVALID;
 			/*
 			 * allow terminating directory separators for
 			 * sparse directory entries.
 			 */
 			if (c =3D=3D '\0')
-				return S_ISDIR(mode);
+				return S_ISDIR(mode) ? PATH_DIR_WITH_SEP :
+						       PATH_INVALID;
 		} else if (c =3D=3D '\\' && protect_ntfs) {
 			if (is_ntfs_dotgit(path))
-				return 0;
+				return PATH_INVALID;
 			if (S_ISLNK(mode)) {
 				if (is_ntfs_dotgitmodules(path))
-					return 0;
+					return PATH_INVALID;
 			}
 		}

@@ -1349,7 +1364,7 @@ static int add_index_entry_with_check(struct index_s=
tate *istate, struct cache_e

 	if (!ok_to_add)
 		return -1;
-	if (!verify_path(ce->name, ce->ce_mode))
+	if (verify_path_internal(ce->name, ce->ce_mode) =3D=3D PATH_INVALID)
 		return error(_("invalid path '%s'"), ce->name);

 	if (!skip_df_check &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-un=
tracked.sh
index dd2cdcc114..5390eec4e3 100755
=2D-- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -422,4 +422,10 @@ test_expect_success 'stash show --{include,only}-untr=
acked on stashes without un
 	test_must_be_empty actual
 '

+test_expect_success 'stash -u ignores sub-repository' '
+	test_when_finished "rm -rf sub-repo" &&
+	git init sub-repo &&
+	git stash -u
+'
+
 test_done
=2D-
2.33.0
