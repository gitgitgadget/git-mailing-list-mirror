Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB243DEFF0
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487700; cv=none; b=d7mChewh9ydCo6nwFO8OzAVzGvuVXyTAQZQko8h0XQoz2TfD+Y6Z64obsfnOZXiBWld5XP8zOIQ2tOa7Jalng/zxl9cxSDIpiQg2/+ExO12noyB8ZJRNJjsUFHgP0JZ42N//bEKmaNvKI3Vnw9uxB/Jj82n/HZkrYTjhW0Un6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487700; c=relaxed/simple;
	bh=vOW3UThEMb2JeLoJ7G0TriOMWoSBSi3mGwBTKM8fgEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOWq53gfb5R3Y1WfUtI8pPOTCBEALWHMLyDSu7vfwChmv9UVOSCAeCS7o3PhCXkLq8v7m5iPBc0JzbxSa6rWj7LhROzdNKHcQZ0C8xiHxwW0jfhqQSZRdbVooLu5R2YJUidhOsBLPh+kIRpM+wRG9QPbwuMk1DMrzyXK5NKE950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=IqOCAROG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="IqOCAROG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789487677; x=1790092477; i=l.s.r@web.de;
	bh=PEFKxsvogPPm9J9r8feCJBJ4Iy4JhEd1Cd3FTK74ea4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IqOCAROG9kCxc7rsMsvU7sa8Ev1SfoyBt2+Ofridd+YfHPJw/kek1aUo+Q06RGlo
	 D8oLCCSLufui5aJJtazlqs40ZAnjjT0dB9c60ZFHgKXq4h6X9dBL3uZxHdHRsafco
	 I10NyNQZxHyK6i1lXkdLVuInAUh1DpSFvimjEYRYOfXp9GJ/MGKcc7rmneexHGOlA
	 gGVu9k21+bGoMKWg6cje6YN7uzOq1VPsyAMkfsqQOS+FSudGBpfGbpuZ6CK9hpz+/
	 kln2HBlh+cWdchs/mxqk9Pn1uzmgDnRzl/H73k/SgRi3taksllapmUPOnohpqdJI6
	 wvF8PedXJR7q+5ou/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ZZo-1xC1nM3pgq-00CXlE; Tue, 15
 Sep 2026 17:54:36 +0200
Message-ID: <ff9404bc-63e1-43bc-8419-9685f0bfa32d@web.de>
Date: Tue, 15 Sep 2026 17:54:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 'git status --ignored' <pathspec> matches partial names
To: Sean Whitton <spwhitton@spwhitton.name>, git@vger.kernel.org
Cc: 81625@debbugs.gnu.org, Lester Longley <lester@ieee.org>,
 Elijah Newren <newren@gmail.com>
References: <87ld94klhf.fsf@athena.silentflame.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <87ld94klhf.fsf@athena.silentflame.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VurfG5VIPOpkRI/QWOQ7R8OQC1rD/7FFrjdiej26xVu3xBL96Gy
 cXP+mneBGNiqwvnHogxQoag2rkgewSnfQPNVJQ5lU2tTz8S2rzKCH658KfbNy7vGkNgygIG
 mTeMZkp8xDtxhetBqL0tNhSyJwrpHnIoREthvTzkWf3pftXZ0xWhlTxF+WnwbCjhGnRHDhD
 Z0OQueDb01W6ZLtZ6WZ2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gJmfEQsEQPs=;1XRbt1AEsvlR235TYw7+uZDBYsY
 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

On 9/14/26 3:31 PM, Sean Whitton wrote:
> Steps to reproduce:
>=20
> git init foo
> cd foo
> mkdir bar
> echo bar/ >.gitignore
> git init bar/baz
> git init bar/quux
> git status --porcelain --ignored --untracked-files -- ba
>=20
> Expected output:
> none, "ba" doesn't match "bar".
>=20
> Actual output:
> !! bar/baz/
> !! bar/quux/
>=20
> Credits to Lester Longley for the reproduction, in Emacs bug#81625.
>=20

Bisects to 95c11ecc73 (Fix error-prone fill_directory() API; make it
only return matches, 2020-04-01).

I can reproduce the issue using the instructions above, but not in Git's
own repo like this:

   $ git status --porcelain --ignored --untracked-files -- .depend | grep =
-c '^!!'
   266
   $ git status --porcelain --ignored --untracked-files -- .depen | grep -=
c '^!!'
   0

Below is a quick fix, but perhaps this optimization can be repaired
instead of removed.

Ren=C3=A9


diff --git a/dir.c b/dir.c
index 95d8a1cce9..3718301a89 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -1991,11 +1991,9 @@ static enum path_treatment treat_directory(struct d=
ir_struct *dir,
 	/*
 	 * We don't want to descend into paths that don't match the necessary
 	 * patterns.  Clearly, if we don't have a pathspec, then we can't check
-	 * for matching patterns.  Also, if (excluded) then we know we matched
-	 * the exclusion patterns so as an optimization we can skip checking
 	 * for matching patterns.
 	 */
-	if (pathspec && !excluded) {
+	if (pathspec) {
 		matches_how =3D match_pathspec_with_flags(istate, pathspec,
 							dirname, len,
 							0 /* prefix */,

