Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA02B9B7
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550987; cv=none; b=pWiwVAFfUSkFoPwZh1VEFwBF3KBZ1fP9mk9xWd80Z0rTrBDPRySMM7OY0K5rMsRDk+MXmJj3uNMv9J3pWJsg+jaQrJFcBgmpx+aSke4I9krVI/90OzcBFzCZwuYtyphDt9eKhwrLFzvIl+2u3cRqyQr45Yl0fR2qP/XgTKsFUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550987; c=relaxed/simple;
	bh=zeBK73pT4F5np74w9oY/Wja1/rgFYyfwxVZqc0Iofks=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=c8lMF8Hq7Po+pBpcWYIxDEIqgISH41XuNpwI0aST4GXDiFLSx7JlqXetKQUOFLvu0Hbs3Qred28LJpfQnGkjZFBHg6xYSzTsBwmr/zedRQ/qHYIaNP4+c8CgtmQDzsqITIcGSupfmBbSqli33nLUb2UgAFpwOC9UwxhHFwBSEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=v3U9CGEg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="v3U9CGEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707550981; x=1708155781; i=l.s.r@web.de;
	bh=zeBK73pT4F5np74w9oY/Wja1/rgFYyfwxVZqc0Iofks=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=v3U9CGEgtpVEme7wJe3aOs6fxlqsEp9PNyOZn6qHun8Wcsso/LuEzKC8sXtsQmiR
	 IuosYvuX9tT8GZmg9bS8+uWgMIAPHpPGnXo7crBG8qfDcrH7/sw6xzUYRJHJZKDlP
	 hEX7vOVzeCzFlOwbcfl0PIgC3z2tdlmTzvHI7XOH+9c351FChuEYyVzfaZggvr3Lz
	 OyvkWzCQKCEwLPQRz5OZ/2sHobJHfLfBL6t4L2954DjYYhp3oEFouN7s2K+IczCag
	 ZstYLOoeZOg9bT7yL5lm6C3RmPjpLjFM++5dNQY6qn2TCzLVYWqUFuImiJQJAP6bo
	 UwK4B2Ok+UqOeLLFuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.17.81]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMAO-1r2QGh2wa6-00fVbu for
 <git@vger.kernel.org>; Sat, 10 Feb 2024 08:43:01 +0100
Message-ID: <954b75d0-1504-4f57-b34e-e770a4b7b3ea@web.de>
Date: Sat, 10 Feb 2024 08:43:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use xstrncmpz()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZsWMDrnkXSy2igW+8WzqrM8l4yzYEPl8rOnBuw8zdQobqdafRG3
 /tlRwZ3jlqnczIWcoG1fkJWY9AWcVJlkIxex8wolptWHInCA+a8eixqXZ8PyvDV1MkRRaKN
 IGm+W7aeCMeUaRxMXzYFvXFfith+fyGbPR9RUz96Glq+fpfeCYaVN5nmpQryHAJg0dPnhk9
 gb6c3vhKpD1bfK+hm5eyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bPQI1fnSlm8=;W5rTFEURD3+sUnSfJqPdQ6rcTkT
 WfZTu47HosKBrEDdUY6b0cWgTHIIG0zv3BRXg/GmrHlLuGiYPed5PJz6Fza8P8j3TQbVFwGhG
 VsB7lu5D1k5Wp84U/JTxMg1rGOns2zbD4rsHn8jzppOWlcgCl7Si6YAsexQ11M+kTwAgxew7m
 5DtQFSH8MT+75uKDFVVecbUFoliaFofV3MuocZLgzGlfoFss7SLFKD2J9uNG6+x1QdaXFJ9Dr
 0U8HDgc5MxDIZOIHKV5REA6yjbyhL9UbF4tjlaFDFPnd/HQa/jhSZKUlHHzwEDmAbIiUYiGWg
 J9PkC+l506zKWatM0uS9pY04SHoT/3w1qw9IaVWIYkoZiAARqnPsY2h4tD7QRhSq9gmBWKq0+
 dLtxjUgbJbEEnoNYq72Qw1Fql4fIcuv15IOsVusXNXR68Lv/a6fU82gHZQ/zlO036swUXkwlY
 540OV2vzQVkadC/lmmR+OSb7drqzW7A2ny28pjleVm24Jv/3h254vVJjB1UrseSBNd1PyYDm8
 c0moshZjjjrdiO14BZLonhsHNz1wjFvNOFpUt5vykkwwIDZHFBDzIoFre/VHLI/wWJOExAQEU
 XZ2a/Ii4IPd3806C9YgXjXs1ekdfOlFfDMQuuSwSFDPVxfsxyyejemYwSjF82+A23R/x7UnD3
 X84FSoh1WbE8m2KB81AoRnfwHzuffSOIMUgPgK2sjPzXIcwxwjGl2ZZ1GdrPFLQcLnf1z/sjF
 J/BPxlJ5L7e6G0iGo7SwxcityEp9yv9wBURCOWXcFZgy7XkGmWyynCAfYSzlwCS8YtJ1I550p
 S4htynscXK7kBikFUVqqfvF3tCVqiPyWIqvd7eOEVMq44=

Add and apply a semantic patch for calling xstrncmpz() to compare a
NUL-terminated string with a buffer of a known length instead of using
strncmp() and checking the terminating NUL explicitly.  This simplifies
callers by reducing code duplication.

I had to adjust remote.c manually because Coccinelle inexplicably
changed the indent of the else branches.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c                      |  2 +-
 builtin/fast-export.c              |  3 +--
 builtin/merge.c                    |  3 +--
 builtin/reflog.c                   |  3 +--
 contrib/coccinelle/xstrncmpz.cocci | 28 ++++++++++++++++++++++++++++
 convert.c                          |  2 +-
 merge-ll.c                         |  2 +-
 object.c                           |  3 +--
 remote.c                           |  5 ++---
 userdiff.c                         |  3 +--
 10 files changed, 38 insertions(+), 16 deletions(-)
 create mode 100644 contrib/coccinelle/xstrncmpz.cocci

diff --git a/archive-tar.c b/archive-tar.c
index f2a0ed7752..8ae30125f8 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -365,7 +365,7 @@ static struct archiver *find_tar_filter(const char *na=
me, size_t len)
 	int i;
 	for (i =3D 0; i < nr_tar_filters; i++) {
 		struct archiver *ar =3D tar_filters[i];
-		if (!strncmp(ar->name, name, len) && !ar->name[len])
+		if (!xstrncmpz(ar->name, name, len))
 			return ar;
 	}
 	return NULL;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f18f0809f9..4693d18cc9 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -136,8 +136,7 @@ static int anonymized_entry_cmp(const void *cmp_data U=
NUSED,
 	a =3D container_of(eptr, const struct anonymized_entry, hash);
 	if (keydata) {
 		const struct anonymized_entry_key *key =3D keydata;
-		int equal =3D !strncmp(a->orig, key->orig, key->orig_len) &&
-			    !a->orig[key->orig_len];
+		int equal =3D !xstrncmpz(a->orig, key->orig, key->orig_len);
 		return !equal;
 	}

diff --git a/builtin/merge.c b/builtin/merge.c
index 8f819781cc..935c8a57dd 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -192,8 +192,7 @@ static struct strategy *get_strategy(const char *name)
 			int j, found =3D 0;
 			struct cmdname *ent =3D main_cmds.names[i];
 			for (j =3D 0; !found && j < ARRAY_SIZE(all_strategy); j++)
-				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
-						&& !all_strategy[j].name[ent->len])
+				if (!xstrncmpz(all_strategy[j].name, ent->name, ent->len))
 					found =3D 1;
 			if (!found)
 				add_cmdname(&not_strategies, ent->name, ent->len);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a5a4099f61..2c3369fca5 100644
=2D-- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -96,8 +96,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char=
 *pattern, size_t len)
 		reflog_expire_cfg_tail =3D &reflog_expire_cfg;

 	for (ent =3D reflog_expire_cfg; ent; ent =3D ent->next)
-		if (!strncmp(ent->pattern, pattern, len) &&
-		    ent->pattern[len] =3D=3D '\0')
+		if (!xstrncmpz(ent->pattern, pattern, len))
 			return ent;

 	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
diff --git a/contrib/coccinelle/xstrncmpz.cocci b/contrib/coccinelle/xstrn=
cmpz.cocci
new file mode 100644
index 0000000000..ccb39e2bc0
=2D-- /dev/null
+++ b/contrib/coccinelle/xstrncmpz.cocci
@@ -0,0 +1,28 @@
+@@
+expression S, T, L;
+@@
+(
+- strncmp(S, T, L) || S[L]
++ !!xstrncmpz(S, T, L)
+|
+- strncmp(S, T, L) || S[L] !=3D '\0'
++ !!xstrncmpz(S, T, L)
+|
+- strncmp(S, T, L) || T[L]
++ !!xstrncmpz(T, S, L)
+|
+- strncmp(S, T, L) || T[L] !=3D '\0'
++ !!xstrncmpz(T, S, L)
+|
+- !strncmp(S, T, L) && !S[L]
++ !xstrncmpz(S, T, L)
+|
+- !strncmp(S, T, L) && S[L] =3D=3D '\0'
++ !xstrncmpz(S, T, L)
+|
+- !strncmp(S, T, L) && !T[L]
++ !xstrncmpz(T, S, L)
+|
+- !strncmp(S, T, L) && T[L] =3D=3D '\0'
++ !xstrncmpz(T, S, L)
+)
diff --git a/convert.c b/convert.c
index a8870baff3..35b25eb3cb 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -1028,7 +1028,7 @@ static int read_convert_config(const char *var, cons=
t char *value,
 	if (parse_config_key(var, "filter", &name, &namelen, &key) < 0 || !name)
 		return 0;
 	for (drv =3D user_convert; drv; drv =3D drv->next)
-		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
+		if (!xstrncmpz(drv->name, name, namelen))
 			break;
 	if (!drv) {
 		CALLOC_ARRAY(drv, 1);
diff --git a/merge-ll.c b/merge-ll.c
index 5ffb045efb..61e0ae5398 100644
=2D-- a/merge-ll.c
+++ b/merge-ll.c
@@ -292,7 +292,7 @@ static int read_merge_config(const char *var, const ch=
ar *value,
 	 * after seeing merge.<name>.var1.
 	 */
 	for (fn =3D ll_user_merge; fn; fn =3D fn->next)
-		if (!strncmp(fn->name, name, namelen) && !fn->name[namelen])
+		if (!xstrncmpz(fn->name, name, namelen))
 			break;
 	if (!fn) {
 		CALLOC_ARRAY(fn, 1);
diff --git a/object.c b/object.c
index 2c61e4c862..e6a1c4d905 100644
=2D-- a/object.c
+++ b/object.c
@@ -47,8 +47,7 @@ int type_from_string_gently(const char *str, ssize_t len=
, int gentle)
 		len =3D strlen(str);

 	for (i =3D 1; i < ARRAY_SIZE(object_type_strings); i++)
-		if (!strncmp(str, object_type_strings[i], len) &&
-		    object_type_strings[i][len] =3D=3D '\0')
+		if (!xstrncmpz(object_type_strings[i], str, len))
 			return i;

 	if (gentle)
diff --git a/remote.c b/remote.c
index e07b316eac..9090632e96 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -105,7 +105,7 @@ static int remotes_hash_cmp(const void *cmp_data UNUSE=
D,
 	b =3D container_of(entry_or_key, const struct remote, ent);

 	if (key)
-		return strncmp(a->name, key->str, key->len) || a->name[key->len];
+		return !!xstrncmpz(a->name, key->str, key->len);
 	else
 		return strcmp(a->name, b->name);
 }
@@ -189,8 +189,7 @@ static int branches_hash_cmp(const void *cmp_data UNUS=
ED,
 	b =3D container_of(entry_or_key, const struct branch, ent);

 	if (key)
-		return strncmp(a->name, key->str, key->len) ||
-		       a->name[key->len];
+		return !!xstrncmpz(a->name, key->str, key->len);
 	else
 		return strcmp(a->name, b->name);
 }
diff --git a/userdiff.c b/userdiff.c
index e399543823..2b1dab2649 100644
=2D-- a/userdiff.c
+++ b/userdiff.c
@@ -323,8 +323,7 @@ static int userdiff_find_by_namelen_cb(struct userdiff=
_driver *driver,
 {
 	struct find_by_namelen_data *cb_data =3D priv;

-	if (!strncmp(driver->name, cb_data->name, cb_data->len) &&
-	    !driver->name[cb_data->len]) {
+	if (!xstrncmpz(driver->name, cb_data->name, cb_data->len)) {
 		cb_data->driver =3D driver;
 		return 1; /* tell the caller to stop iterating */
 	}
=2D-
2.43.0
