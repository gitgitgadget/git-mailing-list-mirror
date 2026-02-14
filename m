Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CC2DEA62
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771099229; cv=none; b=ZT5mZhHM2MOTMKnVL7vu+hNKjMzzgOviLCsXbI4v12/9eWLrlPaYdBPn2+wmpk23RnAjqRCJecny9eEafzfk+HPBRLYhaSb9EyPc0r0muP3aaFpVosnoPD8BeRicZ0CPfOUQ40szyU5L2lsNF5HEKvt3fYdZvXYIkMk5XFWl4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771099229; c=relaxed/simple;
	bh=Gbqu3rKmf6r2bMGkyRujMZVmj1p58UbLi2XMjZmAro0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cAhdjWlyj1Pd/jr+pF3tszGhb/2FergxAupXzBnucPnkw/wyZtpHiVy69Zc4V6YH7NLMt64VNKjZMhohg6Ldmrj5um/rWRdJtK3KbdxISxknFQ4njrwF3gBkgoguiK+7HbHIBbSHslMfYkzB4Rhbwed77APg6xwKRJ+RIeUraMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD5smZMf; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD5smZMf"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae5f0777dso1956045d50.3
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 12:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771099226; x=1771704026; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIC1WC8eq7doQ7DzWZlyki0YnndMnzX8rMoW7gdcm0s=;
        b=OD5smZMfL6n1QN+2LJ4R//7cz1lKde7UhXaMt2ryPgysJSNXYqvJaAxET0mkmMI6qi
         VbVQ4dV/Hn1oz7Vw1qiuYYq/uxOdNBvowyTnk6Q3LGwpPFhSN+wIPVdhR2VjwncaTyMh
         pOjF+OdQZpmS4NCA5KUfPpQju1eg6pOOApZoNp+3MrT50seMXodOU+OqJVdAgmYq1Vpv
         GeI+HVc8FTNVAXURmNJq0fC1RyY0KCZXaOGwASsvGAfxQJnVqs/FhW+3Gefmd4GnLr7c
         xwf/F9gzzIJQ4SkYaPtyRfS57a9jk3YFKyuWhSS3tKWeA/rKa5NRP90qEwQ4Phj3Jpx0
         Gzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771099226; x=1771704026;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIC1WC8eq7doQ7DzWZlyki0YnndMnzX8rMoW7gdcm0s=;
        b=fmew1bJOvNbYgCHOaJ75ZRPeGQFuQiikQE3pJuCupT0Y+4bG2sXGF/r7mdP/5CGkKU
         xOG+prJC5Ro/gJPWl7Z3/C04VxWoPxkdyaEZgIt7dW1NheoCJ3d3NrMs7ojKwcJYcaya
         4xPHS6lgBSLy+K6+uBcaxTHmPnvEY4Zf+LqvHohG3OL2V+KRLS69EslSnn3qBF10gPi+
         0wji3vbMv8Ya3Xi2XMZjZuP2os92DURaHGtNt/qM3qN2fyOJJRrdS0/qlwpBSd5eQhpH
         sFH0ldj9egUThNfcv6/Ml9kCwMCemep7CH8PNmn1RCPQ3ivbAadIlHFOFBjnwgQ2jVX/
         /XiA==
X-Gm-Message-State: AOJu0Yw5ipcaJJE1W3JA6FfBU5MYUnPm/U8bSYq6WfS+IYoOIUsG5CXy
	66K4CMw8XSeYdGTUuaEp1KAQLuT5WMZMHLs0E413YkW6mFpdO8xyz0ExLEx8dA==
X-Gm-Gg: AZuq6aJ6cEfNQ936uIOuLdcqqcNanyqJFLRuHRHAeS/xbydRRun8saY75TaHHH6Ka+5
	YHu35DBvHoPOq/rM1dhvcGNvYYfKFMpW6eV+7e+rnhIS4EO4TqNfb6wYrcsBhy3r1DI4kJZebNs
	y1fC46BzC0p6Zybt4lQ3DLkSExMV/FU4nASTpxdZYfpfevSYMAbj1XKa7BMtXjvNgDFVwJsObGz
	r3YOrD7CxfVLr61x+CC6eb6oRZVWE3JAt16DiLG91RSXTKrc1tDTxOYyyTViWm/sqtRiGzi4xHd
	u7r/jSN7VoFC417FjtmXLuiqy3qEBRuNkneGQHLkZ5ro2TeHzptonYJcpIaCDX62WGvPMS72VOH
	sj/0PRyLWmUADiSmk9kqSmE2VyFBGBVqIEy1Bt3VdbzXrdtIz7HPWsX0RHYJTyG7sNTIkBcZamY
	rQbqC6Z/9OBnqK2qPbmLzO+fKFfNEHlRBlzQuR94BCieChgz8RFoeP6vTimNq4PMVxjhJYB/1YD
	N/SVd+rU+DuIm51Ynx9VplKismWaRTFOEUAzFCYY02nmORdfFw+o5ZZUKW4k8QSHJfxXMhEJqjh
	4jgG
X-Received: by 2002:a05:690c:b:b0:794:ecaf:c4b1 with SMTP id 00721157ae682-797a0bfb972mr106383377b3.25.1771099226386;
        Sat, 14 Feb 2026 12:00:26 -0800 (PST)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e5desm82808187b3.11.2026.02.14.12.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 12:00:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] doc: patch-id: explain how to map efficiently
Date: Sat, 14 Feb 2026 15:00:14 -0500
Message-Id: <69F74ACB-93A4-4FB9-AE0D-57C433448981@gmail.com>
References: <V2_CV_doc_patch-id_4.371@msgid.xyz>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <V2_CV_doc_patch-id_4.371@msgid.xyz>
To: kristofferhaugsbakk@fastmail.com
X-Mailer: iPhone Mail (21F90)


> Le 14 f=C3=A9vr. 2026 =C3=A0 06:56, kristofferhaugsbakk@fastmail.com a =C3=
=A9crit :
>=20
> =EF=BB=BFFrom: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> Topic name (applied): kh/doc-patch-id-4
>=20
> Topic summary: Explain and emphasize how to map commits efficiently and
> add an example script.
>=20
> This is the fourth patch series for git-patch-id(1). This one focuses on
> emphasizing how the command is an efficient patch ID=E2=80=93commit mapper=
 and
> how to use the patch IDs to join commits in a script.
>=20
> =C2=A7 Changes in v2
>=20
> =E2=80=A2 Delete temporary files at the end of the script.
> =E2=80=A2 Consistent footnote style: https://lore.kernel.org/git/c70adde6-=
e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com/
>=20
> =C2=A7 Previous patch series
>=20
> =E2=80=A2 Patch series 1:
>  =E2=80=A2 Topic: kh/doc-patch-id-markup-fix
>  =E2=80=A2 https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@=
khaugsbakk.name/
> =E2=80=A2 Patch series 2:
>  =E2=80=A2 Topic: kh/doc-patch-id-1
>  =E2=80=A2 https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@=
khaugsbakk.name/
> =E2=80=A2 Patch series 3:
>  =E2=80=A2 Topic: kh/doc-patch-id
>  =E2=80=A2 https://lore.kernel.org/git/CV_doc_patch-id_3.1ab@msgid.xyz/
>=20
> Link to v1: https://lore.kernel.org/git/CV_doc_patch-id_4.275@msgid.xyz/#t=

>=20
> Kristoffer Haugsbakk (3):
>  doc: patch-id: emphasize multi-patch processing
>  doc: patch-id: add script example
>  doc: patch-id: see also git-cherry(1)
>=20
> Documentation/git-patch-id.adoc | 51 +++++++++++++++++++++++++++++++--
> 1 file changed, 48 insertions(+), 3 deletions(-)
>=20
> Interdiff against v1:
> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.=
adoc
> index fb9ec211bb6..05859990c8e 100644
> --- a/Documentation/git-patch-id.adoc
> +++ b/Documentation/git-patch-id.adoc
> @@ -101,6 +101,8 @@ git rev-list --no-merges $tail_opts |
>     git diff-tree --patch --stdin |
>     git patch-id  --stable | sort >"$for_upstream"
> join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
> +rm "$for_branch"
> +rm "$for_upstream"
> ----
>=20
> Now the first column shows the commit from your branch and the second
> Range-diff against v1:
> 1:  704dc0ada8f ! 1:  e9319039d5e doc: patch-id: emphasize multi-patch pro=
cessing
>    @@ Commit message
>=20
>         Also drop =E2=80=9Cthe=E2=80=9D from =E2=80=9Cstandard input=E2=80=
=9D.
>=20
>    -    [1]: https://stackoverflow.com/a/19758159
>    +    =E2=80=A0 1: https://stackoverflow.com/a/19758159
>         =E2=80=A0 2: This is `master` of this repository on 2025-10-02
>=20
>         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 2:  e37c25aa5fc ! 2:  8ba3e71752c doc: patch-id: add script example
>    @@ Commit message
>         demonstrate generating two lists, sorting them, joining them, and
>         finally discarding the patch ID lookup column with cut(1).
>=20
>    -    [1]: https://lore.kernel.org/workflows/CAHk-=3DwiN+8EUoik4UeAJ-HPS=
U7hczQP+8+_uP3vtAy_=3DYfJ9PQ@mail.gmail.com/
>    +    =E2=80=A0 1: https://lore.kernel.org/workflows/CAHk-=3DwiN+8EUoik4=
UeAJ-HPSU7hczQP+8+_uP3vtAy_=3DYfJ9PQ@mail.gmail.com/
>=20
>         Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
>         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>    @@ Documentation/git-patch-id.adoc: This is the default if `patchid.sta=
ble` is set
>     +    git diff-tree --patch --stdin |
>     +    git patch-id  --stable | sort >"$for_upstream"
>     +join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
>    ++rm "$for_branch"
>    ++rm "$for_upstream"
>     +----
>     +
>     +Now the first column shows the commit from your branch and the second=

> 3:  2a319a43b2e ! 3:  27cad849312 doc: patch-id: see also git-cherry(1)
>    @@ Commit message
>         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
>      ## Documentation/git-patch-id.adoc ##
>    -@@ Documentation/git-patch-id.adoc: join -a1 "$for_branch" "$for_upstr=
eam" | cut -d' ' -f2,3
>    +@@ Documentation/git-patch-id.adoc: rm "$for_upstream"
>      Now the first column shows the commit from your branch and the second=

>      column shows the patch ID equivalent commit, if it exists.
>=20
>=20
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> 2.53.0.26.g2afa8602a26
>=20

Looks like my comments were well-addressed, thanks! Looks good.=20=
