Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3925753
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585321; cv=none; b=Wh2ecL3nNzE7hxNVwImdoYIMKKw0hJVmdioStLRyCUIEOeeGNM6E7jksNbtetN69ujTovRdjF/UMmpWZEiJpyz22Cfef9Y7N6w0sWDX+HUhcmH3Z2EHj4l4p7++9RcPII7ZsRjOPlKLlHvV4rnjX0oE+ML8mcrwoO331MOWdIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585321; c=relaxed/simple;
	bh=R0YJSgKQjOWMjKdJ+gSo79AksWdLR2mMIG1LSFfKz/E=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaeyyUudix7ly4PiEhyFL8potm1i498KO+gQGqIcBJxt3iDS2ZYdAWn6qnNsi0fedDf5dhPBlb2737SrE4wroZO0wiNdRN/WXu4v0ab4B2EOCBPk1QXHY7ZZ8kOQppF3CaFai60ibr0jpYMDNSLUdcE2EyLRlkkouzbBU8PMecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EMvxE1Tw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3qdIXbu; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EMvxE1Tw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3qdIXbu"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A673A3200A95
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Jan 2024 08:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705585318; x=1705671718; bh=ZSj8fEqa0I
	uytDY9u6FghVdvkp0PjF+iAJcr3xOal4w=; b=EMvxE1Twn4GdlY/dcXLL+mY+GQ
	6Tj0VI1kxWxTRxePGWIqGg2jt/2WjmSz+sJ5MK63w5udQsMD8vjnzLZlzE9RRNh6
	nWxbN93tyUHh7Rq5l9pUCv3K/YjgdDILqWA7llek7mFnO/9UvGJ+VObzt+dSLXnk
	jdalkOjB7P3ioSVD+CJ6ZhA8k5UBpFfFamb+/lzIRkfFYI3lTePWH5UMn3/FM9DF
	2gWyc49IXvFwsY6lF+nkbIgENmnHLGowlRiKck3/1nN85pv2GAvDj+x9/A2rZcvc
	uL6zebkQToh/uFcTGOu+cyrwQyL+Na4a8PcD1wpxM3VguWsnNq/MsuwVv9XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705585318; x=1705671718; bh=ZSj8fEqa0IuytDY9u6FghVdvkp0P
	jF+iAJcr3xOal4w=; b=X3qdIXburLBIxCp2Yb1HiXpfy3t9VoZr63XoUlnc8Hue
	yWzurplJCH3Kx5JyIcYAMIjBNGpwy6wX3ZAuqlfsxDt4cEYMMFtEyvAEBBEcKSuz
	fZDMhaubtxkXvy+ULdEq+6Cl9c98FMfvLrW2KNtWHRvjHx4IZL9Ng/qveA5a6Fjf
	5mNQZmHrQ3yqf6J4fFFoLopdulqZG3PgMS4fHYupVHfR4rop0TsHiIyLmG6SBncC
	NqO+nwfcxQE2XUiXMEEpAm4j6Ut4Ibcz/n9GV9QQ0TCPDNj/kvzze4/yBZQU1Suj
	TTswO3OK0qi6R8ywKjeMvrX3xrcJN6AGkCsn34fqcQ==
X-ME-Sender: <xms:piqpZQ1WEXvhwqkTpbKov_dfXw4YN5dEn48e7fAm661BzTKmin5Gdw>
    <xme:piqpZbFto9scN-dDayANc2PeSbLMyDof_NbcHlLXxWQQZYpCGOb7tlmQXeeNjKAaL
    moH9uYaKTPVXIEkPw>
X-ME-Received: <xmr:piqpZY4Sr-2-n5Rcjhc2HnS0_WepBcYosPVg8w21sdBgBuAw5melUvJd-j6Hyl5u8ALDHHNou1A3FMiZbxbRhZrLB1KCzvInl4aU2h7GacGt0uU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:piqpZZ3mAQJCVisOurnBcU3yXnTYdokDHgqnWc2WnvuM4es0QReVig>
    <xmx:piqpZTEDAItwzY2gVWzGDtkr3s2vsFPYyi6XJL5zKVh8Eu9Gh5mGjg>
    <xmx:piqpZS_-8SF6s4dMdNxpCUAyPgypKAHfpfefLQzadsdwCeHthX3HMA>
    <xmx:piqpZaxFiwo862HbhKGG5_h9_2xxDYp8yFt1BWETU2Mdjee329PG7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a6ca3f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 18 Jan 2024 13:39:02 +0000 (UTC)
Date: Thu, 18 Jan 2024 14:41:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/2] reftable/stack: fix race in up-to-date check
Message-ID: <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
References: <cover.1705585037.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ot13mJyWNx081rmH"
Content-Disposition: inline
In-Reply-To: <cover.1705585037.git.ps@pks.im>


--Ot13mJyWNx081rmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 6fdfaf15a0 (reftable/stack: use stat info to avoid re-reading stack
list, 2024-01-11) we have introduced a new mechanism to avoid re-reading
the table list in case stat(3P) figures out that the stack didn't change
since the last time we read it.

While this change significantly improved performance when writing many
refs, it can unfortunately lead to false negatives in very specific
scenarios. Given two processes A and B, there is a feasible sequence of
events that cause us to accidentally treat the table list as up-to-date
even though it changed:

  1. A reads the reftable stack and caches its stat info.

  2. B updates the stack, appending a new table to "tables.list". This
     will both use a new inode and result in a different file size, thus
     invalidating A's cache in theory.

  3. B decides to auto-compact the stack and merges two tables. The file
     size now matches what A has cached again. Furthermore, the
     filesystem may decide to recycle the inode number of the file we
     have replaced in (2) because it is not in use anymore.

  4. A reloads the reftable stack. Neither the inode number nor the
     file size changed. If the timestamps did not change either then we
     think the cached copy of our stack is up-to-date.

In fact, the commit introduced three related issues:

  - Non-POSIX compliant systems may not report proper `st_dev` and
    `st_ino` values in stat(3P), which made us rely solely on the
    file's potentially coarse-grained mtime and ctime.

  - `stat_validity_check()` and friends may end up not comparing
    `st_dev` and `st_ino` depending on the "core.checkstat" config,
    again reducing the signal to the mtime and ctime.

  - `st_ino` can be recycled, rendering the check moot even on
    POSIX-compliant systems.

Given that POSIX defines that "The st_ino and st_dev fields taken
together uniquely identify the file within the system", these issues led
to the most important signal to establish file identity to be ignored or
become useless in some cases.

Refactor the code to stop using `stat_validity_check()`. Instead, we
manually stat(3P) the file descriptors to make relevant information
available. On Windows and MSYS2 the result will have both `st_dev` and
`st_ino` set to 0, which allows us to address the first issue by not
using the stat-based cache in that case. It also allows us to make sure
that we always compare `st_dev` and `st_ino`, addressing the second
issue.

The third issue of inode recycling can be addressed by keeping the file
descriptor of "files.list" open during the lifetime of the reftable
stack. As the file will still exist on disk even though it has been
unlinked it is impossible for its inode to be recycled as long as the
file descriptor is still open.

This should address the race in a POSIX-compliant way. The only real
downside is that this mechanism cannot be used on non-POSIX-compliant
systems like Windows. But we at least have the second-level caching
mechanism in place that compares contents of "files.list" with the
currently loaded list of tables.

This new mechanism performs roughly the same as the previous one that
relied on `stat_validity_check()`:

  Benchmark 1: update-ref: create many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):      4.754 s =C2=B1  0.026 s    [User: 2.204=
 s, System: 2.549 s]
    Range (min =E2=80=A6 max):    4.694 s =E2=80=A6  4.802 s    20 runs

  Benchmark 2: update-ref: create many refs (HEAD)
    Time (mean =C2=B1 =CF=83):      4.721 s =C2=B1  0.020 s    [User: 2.194=
 s, System: 2.527 s]
    Range (min =E2=80=A6 max):    4.691 s =E2=80=A6  4.753 s    20 runs

  Summary
    update-ref: create many refs (HEAD~) ran
      1.01 =C2=B1 0.01 times faster than update-ref: create many refs (HEAD)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 99 +++++++++++++++++++++++++++++++++++++++++++----
 reftable/stack.h  |  4 +-
 reftable/system.h |  1 -
 3 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 705cfb6caa..77a387a86c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -66,6 +66,7 @@ int reftable_new_stack(struct reftable_stack **dest, cons=
t char *dir,
 	strbuf_addstr(&list_file_name, "/tables.list");
=20
 	p->list_file =3D strbuf_detach(&list_file_name, NULL);
+	p->list_fd =3D -1;
 	p->reftable_dir =3D xstrdup(dir);
 	p->config =3D config;
=20
@@ -175,7 +176,12 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		st->readers_len =3D 0;
 		FREE_AND_NULL(st->readers);
 	}
-	stat_validity_clear(&st->list_validity);
+
+	if (st->list_fd >=3D 0) {
+		close(st->list_fd);
+		st->list_fd =3D -1;
+	}
+
 	FREE_AND_NULL(st->list_file);
 	FREE_AND_NULL(st->reftable_dir);
 	reftable_free(st);
@@ -375,11 +381,59 @@ static int reftable_stack_reload_maybe_reuse(struct r=
eftable_stack *st,
 		sleep_millisec(delay);
 	}
=20
-	stat_validity_update(&st->list_validity, fd);
-
 out:
-	if (err)
-		stat_validity_clear(&st->list_validity);
+	/*
+	 * Invalidate the stat cache. It is sufficient to only close the file
+	 * descriptor and keep the cached stat info because we never use the
+	 * latter when the former is negative.
+	 */
+	if (st->list_fd >=3D 0) {
+		close(st->list_fd);
+		st->list_fd =3D -1;
+	}
+
+	/*
+	 * Cache stat information in case it provides a useful signal to us.
+	 * According to POSIX, "The st_ino and st_dev fields taken together
+	 * uniquely identify the file within the system." That being said,
+	 * Windows is not POSIX compliant and we do not have these fields
+	 * available. So the information we have there is insufficient to
+	 * determine whether two file descriptors point to the same file.
+	 *
+	 * While we could fall back to using other signals like the file's
+	 * mtime, those are not sufficient to avoid races. We thus refrain from
+	 * using the stat cache on such systems and fall back to the secondary
+	 * caching mechanism, which is to check whether contents of the file
+	 * have changed.
+	 *
+	 * On other systems which are POSIX compliant we must keep the file
+	 * descriptor open. This is to avoid a race condition where two
+	 * processes access the reftable stack at the same point in time:
+	 *
+	 *   1. A reads the reftable stack and caches its stat info.
+	 *
+	 *   2. B updates the stack, appending a new table to "tables.list".
+	 *      This will both use a new inode and result in a different file
+	 *      size, thus invalidating A's cache in theory.
+	 *
+	 *   3. B decides to auto-compact the stack and merges two tables. The
+	 *      file size now matches what A has cached again. Furthermore, the
+	 *      filesystem may decide to recycle the inode number of the file
+	 *      we have replaced in (2) because it is not in use anymore.
+	 *
+	 *   4. A reloads the reftable stack. Neither the inode number nor the
+	 *      file size changed. If the timestamps did not change either then
+	 *      we think the cached copy of our stack is up-to-date.
+	 *
+	 * By keeping the file descriptor open the inode number cannot be
+	 * recycled, mitigating the race.
+	 */
+	if (!err && fd >=3D 0 && !fstat(fd, &st->list_st) &&
+	    st->list_st.st_dev && st->list_st.st_ino) {
+		st->list_fd =3D fd;
+		fd =3D -1;
+	}
+
 	if (fd >=3D 0)
 		close(fd);
 	free_names(names);
@@ -396,8 +450,39 @@ static int stack_uptodate(struct reftable_stack *st)
 	int err;
 	int i =3D 0;
=20
-	if (stat_validity_check(&st->list_validity, st->list_file))
-		return 0;
+	/*
+	 * When we have cached stat information available then we use it to
+	 * verify whether the file has been rewritten.
+	 *
+	 * Note that we explicitly do not want to use `stat_validity_check()`
+	 * and friends here because they may end up not comparing the `st_dev`
+	 * and `st_ino` fields. These functions thus cannot guarantee that we
+	 * indeed still have the same file.
+	 */
+	if (st->list_fd >=3D 0) {
+		struct stat list_st;
+
+		if (stat(st->list_file, &list_st) < 0) {
+			/*
+			 * It's fine for "tables.list" to not exist. In that
+			 * case, we have to refresh when the loaded stack has
+			 * any readers.
+			 */
+			if (errno =3D=3D ENOENT)
+				return !!st->readers_len;
+			return REFTABLE_IO_ERROR;
+		}
+
+		/*
+		 * When "tables.list" refers to the same file we can assume
+		 * that it didn't change. This is because we always use
+		 * rename(3P) to update the file and never write to it
+		 * directly.
+		 */
+		if (st->list_st.st_dev =3D=3D list_st.st_dev &&
+		    st->list_st.st_ino =3D=3D list_st.st_ino)
+			return 0;
+	}
=20
 	err =3D read_lines(st->list_file, &names);
 	if (err < 0)
diff --git a/reftable/stack.h b/reftable/stack.h
index 3f80cc598a..c1e3efa899 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -14,8 +14,10 @@ license that can be found in the LICENSE file or at
 #include "reftable-stack.h"
=20
 struct reftable_stack {
-	struct stat_validity list_validity;
+	struct stat list_st;
 	char *list_file;
+	int list_fd;
+
 	char *reftable_dir;
 	int disable_auto_compact;
=20
diff --git a/reftable/system.h b/reftable/system.h
index 2cc7adf271..6b74a81514 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -12,7 +12,6 @@ license that can be found in the LICENSE file or at
 /* This header glues the reftable library to the rest of Git */
=20
 #include "git-compat-util.h"
-#include "statinfo.h"
 #include "strbuf.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
--=20
2.43.GIT


--Ot13mJyWNx081rmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpKqMACgkQVbJhu7ck
PpS5qQ/+PIQQGSNgHTtaLVrYsPtl+83/QJW3bhK97mev5Hp1k6xAXPl3adcybMSb
2YVwvPtumjkz9E6RmvFUyJxsgZQslKi6t6kC3bvEpCmQMWThtHVHcm0mui/N33fj
cxF/JgKGgrF+tADqkmt2XpfX8y4eBczAMooHjMsW84ZPc1QdIjgDXUu9ujF8CdbU
SZ+RvSJmHneya3ldVTRlwDWbw9N0OLTE9UjM9srruXGXWApo8lyP/JyfHm8xnC8c
rlfLiA9XsmxcjnAZTHYf91xolBihMvIghBzF9JlNd0DTrEYJ03GgLyW8mcJBv3Os
YP8E28EhbFR0pM0JfPAh4YssiLUNHTs/stYt7SDiLpQxM3I6COR+LgYX2UK91oSc
HUs6jUUuGZFynh+E6wX9BWQKQTF70hbrQ2rGqmg2z6gfVXQYZLvDle2GabUgCToT
8W+MYaKyJA1WHaY7mMtax3DJrYOtWZ7pfbGryhRtk5rvQoEWUIzohp3xfz2qRObH
5kKcWkmcYCpsZBzMZcrQHJvqo+1T832LQEoT2V3rJdcWSyJ0D/xE4ygOwbv2kI//
9FFtCX2vwl2lp0IcsMORt47nOOVDb9UHPIO4EC7BEJXcQHuNWwAtvbxl5DkL4Dmc
z8Y/9ZooT8KkCvoLwQ5LjavO8cguAwutxHOt+lc9F7VwFMXuM5c=
=y6SX
-----END PGP SIGNATURE-----

--Ot13mJyWNx081rmH--
