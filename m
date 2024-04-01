Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6223AD
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962239; cv=none; b=M8Lk6hMDbvu44/7+YSVnadaAD7/GiyLiLNkJ1XbSw+mq1aZKbFSrWA1Xh9ZHkVVPmQvxN9A1/bSA7wHJ9skUQZZq/y1KBEgLH3ck1HQZDjtYoIDHqET5mq8qxcqBqj8Z04CzbZnm+wWsObdD4D2M2mQj4L8KUMNzO9aw5knOn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962239; c=relaxed/simple;
	bh=RULk3FuWOcXjpjRjWyi//9PdpEVbGX8v1RZeFtgUiQ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmElaIPx5JHQ0GkcSaOEy+8TApdWEn0wKP4WR3kNdg5+0lziNlwQWiNFoyzmPxeN7EMBr+n/Btv6ace3ZWA3xH52wPMPgWycliKq3yqVLYskFUdeVFggllka8IF9dr0D1YWWZS7YTi+3OHvB1szsl9tK0yeGkUbGj31unWwbxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=Ks75bcGG; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="Ks75bcGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962230; x=1712221430;
	bh=EJX6m+m9j7rw3DbT12K6UuCwOLwHBDsscJdzur9bYHs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ks75bcGGQyIIvP38sX93Eyq/nhPoIZ0Z+k0dVoY1cfM7OW4paf3k2ndABaax+WVtX
	 PwJrfg14ypAW2Xn1Pv82+wrulYrxEhxGGijmQmyluvN16yAY9TTbVEsb9JngJoIYiQ
	 0bndT+kv0X5Qct9Zf8efD4/3bKGcctVEtqlJ8yeiJdb8vR+MaRKfc2CJuvwCSSWDkU
	 cQ8pv+ayX/8O31vu0bVcp4mxR3v7L9il/xzOfp+c0P1VrqlbeBZP/3/B6HQt6qhniQ
	 J1VBH+mJ2miSydTqhrrAG8Z6PnOlk4QlaZCqkUXWCO5mTsbKd6QdJYJRJ1wB8fxrMe
	 gPkTfICs0UOZw==
Date: Mon, 01 Apr 2024 09:03:42 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 6/8] fast-import: document C-style escapes for paths
Message-ID: <82a4da68afbc92925ac716a9b098f1a79a3b2ab5.1711960552.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simply saying =E2=80=9CC-style=E2=80=9D string quoting is imprecise, as onl=
y a subset of
C escapes are supported. Document the exact escapes.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt | 12 ++++++++----
 t/t9300-fast-import.sh            | 10 ++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index f26d7a8571..db53b50268 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -640,10 +640,14 @@ quote, it must be written as a quoted string. Additio=
nally, the source
=20
 A `<path>` can use C-style string quoting; this is accepted in all cases
 and mandatory in the cases where the filename cannot be represented as
-an unquoted string. In C-style quoting, the complete name should be surrou=
nded with
-double quotes, and any `LF`, backslash, or double quote characters
-must be escaped by preceding them with a backslash (e.g.,
-`"path/with\n, \\ and \" in it"`).
+an unquoted string. In C-style quoting, the complete filename is
+surrounded with double quote (`"`) and certain characters must be
+escaped by preceding them with a backslash: `LF` is written as `\n`,
+backslash as `\\`, and double quote as `\"`. Some characters may may
+optionally be written with escape sequences: `\a` for bell, `\b` for
+backspace, `\f` for form feed, `\n` for line feed, `\r` for carriage
+return, `\t` for horizontal tab, and `\v` for vertical tab. Any byte can
+be written with 3-digit octal codes (e.g., `\033`).
=20
 A `<path>` must use UNIX-style directory separators (forward slash `/`)
 and must be in canonical form. That is it must not:
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 635b1b9af7..e10962dffe 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3185,8 +3185,9 @@ test_path_eol_success () {
 =09'
 }
=20
-test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello world.=
c '
-test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello world.=
c '
+test_path_eol_success 'quoted spaces'   '" hello world.c "'  ' hello world=
.c '
+test_path_eol_success 'unquoted spaces' ' hello world.c '    ' hello world=
.c '
+test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
=20
 #
 # Valid paths before a space: filecopy (source) and filerename (source).
@@ -3250,8 +3251,9 @@ test_path_space_success () {
 =09'
 }
=20
-test_path_space_success 'quoted spaces'      '" hello world.c "' ' hello w=
orld.c '
-test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello_wo=
rld.c'
+test_path_space_success 'quoted spaces'      '" hello world.c "'  ' hello =
world.c '
+test_path_space_success 'no unquoted spaces' 'hello_world.c'      'hello_w=
orld.c'
+test_path_space_success 'octal escapes'      '"\150\151\056\143"' 'hi.c'
=20
 #
 # Test a single commit change with an invalid path. Run it with all occurr=
ences
--=20
2.44.0


